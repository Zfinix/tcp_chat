import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tcp_chat/views/intersit/intersit.dart';

import 'core/services/providerRegistrar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: registerProviders,
      child: MaterialApp(
        title: 'TCP|Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: Colors.red,
          primaryColor: Colors.red[800],
        ),
        home: Intersit(),
      ),
    );
  }
}
