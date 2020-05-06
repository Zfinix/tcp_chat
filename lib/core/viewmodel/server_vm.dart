import 'dart:io';
import 'dart:convert' show json, utf8;

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_ip/get_ip.dart';
import 'package:tcp_chat/core/model/message.dart';
import 'package:tcp_chat/core/model/tcpData.dart';
import 'package:tcp_chat/utils/navigation.dart';
import 'package:tcp_chat/views/home.dart';
import 'package:tcp_chat/widgets/qrDialog.dart';

class ServerViewModel extends ChangeNotifier {
  List<Message> _messageList = [];
  List<Message> get messageList => _messageList;
  String errorMessage = '';

  ServerSocket _server;
  ServerSocket get server => _server;

  Socket _socket;
  Socket get socket => _socket;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  final TextEditingController ip = new TextEditingController();
  final TextEditingController port = new TextEditingController();
  final TextEditingController name = new TextEditingController();
  final TextEditingController msg = new TextEditingController();

  set server(ServerSocket val) {
    _server = val;
    notifyListeners();
  }

  set socket(Socket val) {
    _socket = val;
    notifyListeners();
  }

  void initState() async {
    if (!Platform.isMacOS) {
      ip.text = await GetIp.ipAddress;
    } else {
      ip.text = '';
    }

    port.text = "4000";
    errorMessage = '';
  }

  getTCPData() {
    return TCPData(ip: ip.text, port: int.parse(port.text), name: name.text);
  }

  void startServer(context) async {
    if (ip.text == null || ip.text.isEmpty) {
      errorMessage = "IP Address cant be empty!";
      notifyListeners();
    } else if (port.text == null || port.text.isEmpty) {
      errorMessage = "Port cant be empty!";
      notifyListeners();
    } else if (name.text == null || name.text.isEmpty) {
      errorMessage = "Name cant be empty!";
      notifyListeners();
    } else {
      errorMessage = "";
      notifyListeners();
      try {
        _server = await ServerSocket.bind(ip.text, int.parse(port.text),
            shared: true);
        notifyListeners();

        if (_server != null) {
          _server.listen((Socket _) {
            _socket = _;
            _.listen((List<int> data) {
              try {
                String result = new String.fromCharCodes(data);

                if (result.contains('name')) {
                  var message = Message.fromJson(json.decode(result));
                  _messageList.insert(
                      0,
                      Message(
                          message: message.message,
                          name: message.name,
                          user: message.name == getTCPData().name ? 0 : 1));
                  notifyListeners();
                }
                _.add(data);
              } catch (e) {
                print(e.toString());
              }
              notifyListeners();
            });
          });

          print('Started: ${server.address.toString()}');
          connectToServer(context);
          navigateReplace(
            context,
            HomePage(
              tcpData: getTCPData(),
              isHost: true,
            ),
          );
        }
      } catch (e) {
        print(e.toString());
        showErrorDialog(context, error: e.toString());
      }
    }
  }

  connectToServer(context, {bool isHost = true}) async {
    if (ip.text == null || ip.text.isEmpty) {
      errorMessage = "IP Address cant be empty!";
      notifyListeners();
    } else if (port.text == null || port.text.isEmpty) {
      errorMessage = "Port cant be empty!";
      notifyListeners();
    } else if (name.text == null || name.text.isEmpty) {
      errorMessage = "Name cant be empty!";
      notifyListeners();
    } else {
      try {
        _isLoading = true;
        notifyListeners();
        _socket = await Socket.connect(ip.text, int.parse(port.text))
            .timeout(Duration(seconds: 10), onTimeout: () {
          throw "TimeOUt";
        });
        notifyListeners();
        // listen to the received data event stream
        _socket.listen((List<int> data) {
          try {
            String result = new String.fromCharCodes(data);

            if (result.contains('name')) {
              var message = Message.fromJson(json.decode(result));
              _messageList.insert(
                  0,
                  Message(
                      message: message.message,
                      name: message.name,
                      user: message.name == getTCPData().name ? 0 : 1));
              notifyListeners();
            }
          } catch (e) {
            print(e.toString());
          }
        });
        print('connected');
        if (!isHost)
          navigateReplace(
            context,
            HomePage(
              tcpData: TCPData(
                  ip: ip.text, port: int.parse(port.text), name: name.text),
            ),
          );

        _isLoading = false;
        notifyListeners();
      } catch (e) {
        _isLoading = false;
        notifyListeners();
        showErrorDialog(context, error: e.toString());
        print(e.toString());
      }
    }
  }

  closeSocket() async {
    await _socket.close();
  }

  void sendMessage(context, TCPData tcpData, {bool isHost}) {
    /* _messageList.insert(
        0, new Message(message: msg.text, user: 0, userID: null)); */

    var message = utf8.encode(json.encode(
        Message(message: msg.text, name: tcpData?.name ?? '').toJson()));

    if (isHost) {
      _messageList.insert(
        0,
        Message(message: msg.text, name: tcpData?.name, user: 0),
      );
      notifyListeners();
    }

    try {
      _socket.add(message);

      msg.clear();
    } catch (e) {
      showErrorDialog(context, error: e.toString());
      print(e.toString());
    }
    notifyListeners();
  }

  @override
  void dispose() {
    closeSocket();
    _server.close();
    super.dispose();
  }

  void scan(context) async {
    errorMessage = "";
    try {
      var result = await BarcodeScanner.scan();
      notifyListeners();
      if (result != null) {
        var tcpData = TCPData.fromJson(json.decode(result.rawContent));

        ip.text = tcpData.ip;
        port.text = tcpData.port.toString();
        notifyListeners();

        connectToServer(context, isHost: false);
      }
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        result.rawContent = 'The user did not grant the camera permission!';
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      showErrorDialog(context, error: result.rawContent);
    }
  }
}
