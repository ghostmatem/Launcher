import 'package:flutter/material.dart';
import 'main.dart';

class WidgetScreen extends StatefulWidget {
  const WidgetScreen({ Key? key }) : super(key: key);

  @override
  _WidgetScreenState createState() => _WidgetScreenState();
}

class _WidgetScreenState extends State<WidgetScreen> {
  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: const Text('Виджеты покинули чат')),
      body: Center(child: Image.network('https://miro.medium.com/max/1838/1*FzbYvfQZQjm3NuVRmnOaCw.jpeg'))
    );
  
}