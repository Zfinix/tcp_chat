import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcp_chat/utils/margin.dart';
import 'package:tcp_chat/utils/navigation.dart';
import 'package:tcp_chat/views/intersit/client.dart';
import 'package:tcp_chat/views/intersit/serve.dart';

class Intersit extends StatefulWidget {
  Intersit({Key key}) : super(key: key);

  @override
  _IntersitState createState() => _IntersitState();
}

class _IntersitState extends State<Intersit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      fontWeight: FontWeight.w200),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: screenWidth(context, percent: 0.4),
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
                    onPressed: () => navigate(context, Client()),
                    child: Text(
                      "Connect",
                      style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const XMargin(20),
                Container(
                  height: 50,
                  width: screenWidth(context, percent: 0.4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[400].withOpacity(0.3),
                          offset: Offset(0, 13),
                          blurRadius: 30)
                    ],
                  ),
                  child: FlatButton(
                    onPressed: () => navigate(context, Serve()),
                    color: Colors.white,
                    child: Text(
                      "Start Server",
                      style: GoogleFonts.nunito(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
            const YMargin(50)
          ],
        ),
      ),
    );
  }
}
