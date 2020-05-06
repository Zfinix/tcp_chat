import 'package:flutter/material.dart';
import 'package:tcp_chat/core/model/message.dart';
import 'package:tcp_chat/utils/margin.dart';

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
          textDirection: message.user != null && message.user == 0
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const YMargin(20),
              Container(
                //   width: screenWidth(context, percent: 0.6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: message.user != null && message.user == 0
                        ? Colors.redAccent
                        : Colors.grey[200]),
                padding: EdgeInsets.all(14),
                child: message?.isBold ?? false
                    ? Column(
                        children: <Widget>[
                          Container(
                              height: 7,
                              width: 30,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator()))
                        ],
                      )
                    : Text(
                        message.message ?? '',
                        style: TextStyle(
                            color: message.user != null && message.user == 0
                                ? Colors.white
                                : Colors.grey[600]),
                      ),
              ),
              const YMargin(5),
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                  message.user != null && message.user == 0
                      ? "You"
                      : message.name ?? '',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 11,
                      fontWeight: FontWeight.w200),
                ),
              )
            ],
          )),
    );
  }
}
