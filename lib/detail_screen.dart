import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
class AppDetail extends StatefulWidget {
  const AppDetail({ Key? key, required this.appTitle }) : super(key: key);
  final String appTitle;
  @override
  _AppDetailState createState() => _AppDetailState();
}

class _AppDetailState extends State<AppDetail> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text(widget.appTitle),
          centerTitle: true),
      body: getTmpBody('https://st2.depositphotos.com/1643295/7439/i/950/depositphotos_74390345-stock-photo-pensive-indian-programmer.jpg', 
      'Индусы только начинают писать приложение'),
      );
  
}