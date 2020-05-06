import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcp_chat/utils/margin.dart';
import 'package:provider/provider.dart';
import 'package:tcp_chat/core/viewmodel/server_vm.dart';

class Serve extends StatefulWidget {
  Serve({Key key}) : super(key: key);

  @override
  _ServeState createState() => _ServeState();
}

class _ServeState extends State<Serve> {
  @override
  void initState() {
    context.read<ServerViewModel>().initState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ServerViewModel>();

    return Scaffold(
      body: Center(
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
                            color: Colors.redAccent,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "| Chat",
                        style: GoogleFonts.lato(
                            color: Colors.grey,
                            fontSize: 30,
                            fontWeight: FontWeight.w300),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          " Server",
                          style: GoogleFonts.lato(
                              color: Colors.grey,
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
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400].withOpacity(0.1),
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
                              color: Colors.grey[300],
                            ),
                          ),
                          controller: provider.ip,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                          keyboardAppearance: Brightness.light,
                          autofocus: false),
                    ),
                  ),
                  const YMargin(30),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400].withOpacity(0.1),
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
                              color: Colors.grey[300],
                            ),
                          ),
                          controller: provider.port,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                          keyboardAppearance: Brightness.light,
                          autofocus: false),
                    ),
                  ),
                  const YMargin(30),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400].withOpacity(0.1),
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
                              color: Colors.grey[300],
                            ),
                          ),
                          controller: provider.name,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
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
                              color: Colors.red,
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: screenWidth(context, percent: 0.8),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[400].withOpacity(0.5),
                                offset: Offset(0, 13),
                                blurRadius: 30)
                          ],
                        ),
                        child: FlatButton(
                          onPressed: () {
                            provider.startServer(context);
                          },
                          child: Text(
                            "Energize",
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const YMargin(150)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
