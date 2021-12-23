import 'package:flutter/material.dart';
import 'package:quds_ui_kit/viewers/quds_digital_clock_viewer.dart';

class MyClock extends StatelessWidget {
  const MyClock({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const QudsDigitalClockViewer(
      style: TextStyle(fontSize: 60, fontFamily: 'Roboto',fontWeight: FontWeight.w300),
      showTimePeriod: false,
      backgroundColor: Colors.transparent,
    );
  }
}