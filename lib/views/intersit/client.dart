import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcp_chat/core/viewmodel/server_vm.dart';
import 'package:tcp_chat/utils/margin.dart';
import 'package:provider/provider.dart';

class Client extends StatefulWidget {
  Client({Key key}) : super(key: key);

  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  @override
  void initState() {
    context.read<ServerViewModel>().initState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ServerViewModel>();

    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Theme(
        data: ThemeData(
          cursorColor: Colors.white,
          cupertinoOverrideTheme: CupertinoThemeData(
            primaryColor: Colors.white,
          ),
        ),
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                height: screenHeight(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "TCP ",
                          style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "| Chat",
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w300),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Text(
                            " Client",
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                    const YMargin(50),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[900].withOpacity(0.1),
                              offset: Offset(0, 13),
                              blurRadius: 30)
                        ],
                      ),
                      child: Container(
                        width: screenWidth(context, percent: 0.8),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                            decoration: InputDecoration.collapsed(
                              hintText: 'Enter IP Address',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.white60,
                              ),
                            ),
                            controller: provider.ip,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            keyboardAppearance: Brightness.light,
                            autofocus: false),
                      ),
                    ),
                    const YMargin(30),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[900].withOpacity(0.1),
                              offset: Offset(0, 13),
                              blurRadius: 30)
                        ],
                      ),
                      child: Container(
                        width: screenWidth(context, percent: 0.8),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                            decoration: InputDecoration.collapsed(
                              hintText: 'Enter Port',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.white60,
                              ),
                            ),
                            controller: provider.port,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            keyboardAppearance: Brightness.light,
                            autofocus: false),
                      ),
                    ),
                    const YMargin(30),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[900].withOpacity(0.1),
                              offset: Offset(0, 13),
                              blurRadius: 30)
                        ],
                      ),
                      child: Container(
                        width: screenWidth(context, percent: 0.8),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                            decoration: InputDecoration.collapsed(
                              hintText: 'Enter Name',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.white60,
                              ),
                            ),
                            controller: provider.name,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            keyboardAppearance: Brightness.light,
                            autofocus: false),
                      ),
                    ),
                    const YMargin(30),
                    Container(
                      width: screenWidth(context, percent: 0.8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            provider?.errorMessage ?? '',
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    provider.isLoading?
                    Container(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    ):
                    Container(
                      height: 50,
                      width: screenWidth(context, percent: 0.8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[900].withOpacity(0.1),
                              offset: Offset(0, 13),
                              blurRadius: 30)
                        ],
                      ),
                      child: FlatButton(
                        onPressed: () {
                          provider.connectToServer(context, isHost: false);
                        },
                        child: Text(
                          "Connect to Server",
                          style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    const YMargin(40),
                    IconButton(
                      onPressed: () {
                        provider.scan(context);
                      },
                      icon: Icon(
                        Icons.filter_center_focus,
                        color: Colors.white,
                      ),
                    ),
                    const YMargin(100)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
