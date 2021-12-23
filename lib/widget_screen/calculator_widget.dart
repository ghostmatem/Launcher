import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';


class CalculatorWidget extends StatelessWidget {
  const CalculatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[100],
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: 350,
        height: 250,
        child:                  
            Stack(
              alignment: Alignment.center,
              children: [
                 Icon(Icons.calculate_rounded, size: 100, color: Colors.grey[800]),                                            
                 const Calculator(),                 
              ],
            )));
  }
}


class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double _currentValue = 0;
  @override
  Widget build(context) {
    var calc = SimpleCalculator(
      value: _currentValue,
      hideExpression: false,
      hideSurroundingBorder: true,
      onChanged: (key, value, expression) {
        setState(() {
          _currentValue = value ?? 0;
        });
        print("$key\t$value\t$expression");
      },
      onTappedDisplay: (value, details) {
        print("$value\t${details.globalPosition}");
      },
      theme: const CalculatorThemeData(
        borderColor: Colors.black,
        borderWidth: 1,
        displayColor: Colors.white30,
        displayStyle: TextStyle(fontSize: 80, color: Colors.black87),
        expressionColor: Colors.white10,
        expressionStyle: TextStyle(fontSize: 25, color: Color.fromRGBO(80, 83, 87, 1)),
        operatorColor: Color.fromRGBO(250, 119, 47, 1),
        operatorStyle: TextStyle(fontSize: 35, color: Colors.white70),
        commandColor: Color.fromRGBO(201, 201, 201, 1),
        commandStyle: TextStyle(fontSize: 35, color: Color.fromRGBO(80, 83, 87, 1)),
        numColor: Colors.white30,
        numStyle: TextStyle(fontSize: 35, color: Color.fromRGBO(80, 83, 87, 1)),
      ),
    );
    return TextButton (
      child: const SizedBox(
        height: double.infinity,
        width: double.infinity,
      ),
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: calc                   
                  );
            });
      },
    );
  }
}