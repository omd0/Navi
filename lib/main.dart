import 'package:flutter/material.dart';
import 'package:navi/Screens/BusLine.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Location',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const Start(),
    );
  }
}

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BusLine(),
    );
  }
}



// const ServiceEnabledWidget(),
// const GetLocationWidget(),
// const ListenLocationWidget(),
// const ChangeSettings(),
// const EnableInBackgroundWidget(),
// const ChangeNotificationWidget()
