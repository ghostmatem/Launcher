import 'package:flutter/material.dart';

class CityField extends StatelessWidget {
  const CityField({
    Key? key,
    required this.sity,
  }) : super(key: key);

  final String? sity;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
      height: 50,
      width: 300,
      child: Text(sity ?? '-', 
      style: const TextStyle(fontSize: 40, 
      fontWeight: FontWeight.w300),),
      );
  }
}