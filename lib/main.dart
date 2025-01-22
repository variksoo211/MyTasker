import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mytasker/screens/home_screen.dart';
import 'package:mytasker/providers/task_provider.dart';

void main() {
  runApp(MyTaskerApp());
}

class MyTaskerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyTasker',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
