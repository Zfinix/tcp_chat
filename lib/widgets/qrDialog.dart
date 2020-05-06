import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tcp_chat/core/model/tcpData.dart';
import 'package:tcp_chat/utils/margin.dart';

showQRDialog(BuildContext context, {TCPData tcpData}) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Container(
          width: screenWidth(context, percent: 0.6),
          height: screenHeight(context, percent: 0.43),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Scan to Connect",
                style: GoogleFonts.nunito(
                    color: Colors.grey[500],
                    fontSize: 20,
                    fontWeight: FontWeight.w100),
              ),
              const YMargin(40),
              QrImage(
                data: json.encode(TCPData(
                  ip: tcpData?.ip ?? "192.168.10.101",
                  port: tcpData?.port ?? 4000,
                ).toJson()),
                padding: EdgeInsets.zero,
                version: QrVersions.auto,
                foregroundColor: Colors.redAccent,
                size: 180.0,
              ),
              const YMargin(20),
            ],
          ),
        ),
      );
    });

showErrorDialog(BuildContext context, {String error}) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Container(
          width: screenWidth(context, percent: 0.6),
          height: screenHeight(context, percent: 0.3),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Error",
                  style: GoogleFonts.nunito(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                const YMargin(10),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    error ?? ' ',
                    style: GoogleFonts.nunito(
                        color: Colors.grey[500],
                        fontSize: 13,
                        fontWeight: FontWeight.w100),
                  ),
                ),
                const YMargin(20),
              ],
            ),
          ),
        ),
      );
    });
