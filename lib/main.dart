import 'package:bryant/pages/bryant.dart';
import 'package:flutter/material.dart';
import 'package:bryant/providers/gyroscope_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GyroScopeProvider(),
      child: MaterialApp(
        title: 'Grafpix 3D Demo',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => Bryant(),
        },
      ),
    );
  }
}
