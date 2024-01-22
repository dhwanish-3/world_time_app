import 'package:flutter/material.dart';

import 'package:world_app/pages/app_home.dart';
import 'package:world_app/pages/loading.dart';
import 'package:world_app/pages/location.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const Loading(),
      '/home': (context) => const AppHome(),
      '/location': (context) => const Location(),
    },
  ));
}
