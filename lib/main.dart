import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'app_list.dart';
import 'widget_screen.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => 
    MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: _getMainTitle(),
              centerTitle: true,
              leading: _widgetButton(context)), 
          body: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) =>
                  AppList(appTitle: "Приложение $index"))));



  Widget _getMainTitle() => 
  const Text('A\$ap Launch Zone',
      style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.yellow,
          fontFamily: 'Comic Sans MS'));

  Widget _widgetButton(context) => 
    Builder(
      builder: (context) => IconButton(
        icon: const Icon(Icons.widgets_rounded, size: 35),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const WidgetScreen()))));
}

  Widget getTmpBody(imageUri, text) =>
       Center(
        child: Column(
          children: [
            Image.network(imageUri,
            height: 400,
            width: 400,),
            Text(text)]));


