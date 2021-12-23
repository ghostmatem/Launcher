import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    Key? key,
    required this.text, required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
       alignment: Alignment.center,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
            Text(text,
            textAlign: TextAlign.center, 
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            IconButton(icon: const Icon(Icons.replay_outlined, 
            size: 50, color: Color.fromRGBO(48, 48, 48, 1)),
            onPressed: onPressed),
         ],
       ));
  }
}