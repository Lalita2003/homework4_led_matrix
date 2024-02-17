import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo[100], // เปลี่ยนสีพื้นหลังของ Scaffold เป็นสีม่วงอ่อน
        appBar: AppBar(
          title: Text(
            'CP-SU LED MATRIX',
            style: TextStyle(color: Colors.white), // เปลี่ยนสีของข้อความเป็นขาว
          ),
          backgroundColor: Colors.deepPurple, // เปลี่ยนสีพื้นหลังของ AppBar เป็นสีม่วง
        ),
        body: Center(
          child: LEDMatrixDisplay(),
        ),
      ),
    );
  }
}

class LEDMatrixDisplay extends StatefulWidget {
  @override
  _LEDMatrixDisplayState createState() => _LEDMatrixDisplayState();
}

class _LEDMatrixDisplayState extends State<LEDMatrixDisplay> {
  late int number;
  int topMargin = 0;

  @override
  void initState() {
    super.initState();
    generateRandomNumber();
  }

  void generateRandomNumber() {
    // Generate a random number between 0 and 99
    setState(() {
      number = Random().nextInt(100);
    });
  }

  void incrementNumber() {
    setState(() {
      if (number < 99) {
        number++;
      }
    });
  }

  void decrementNumber() {
    setState(() {
      if (number > 0) {
        number--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String numberAsString = number.toString().padLeft(2, '0');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Ink(
              decoration: ShapeDecoration(
                color: Colors.white, // กำหนดสีพื้นหลังเป็นสีขาว
                shape: CircleBorder(), // กำหนดรูปร่างของพื้นหลังเป็นวงกลม
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_drop_up), // เปลี่ยนไอคอนเป็น arrow_drop_up
                onPressed: () {
                  incrementNumber(); // Increment number
                },
                color: Colors.black, // เปลี่ยนสีไอคอนเป็นสีดำ
                splashColor: Colors.transparent, // ปิดการแสดงสีเมื่อกด
                highlightColor: Colors.transparent, // ปิดการแสดงสีเมื่อกด
                padding: EdgeInsets.all(25), // ปรับขนาดการคลิก
              ),
            )
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 80), // กำหนดขอบด้านซ้ายและขวา
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30), // Add padding to the LED Matrix container
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white, // Add border color
              width: 10.0, // Set border width
            ), // Add border to the LED Matrix container
            color: Colors.black, // Set background color to black
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numberAsString.split('').map((digit) {
              return Column(
                children: digitToMatrix[digit]!.map((row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: row.split('').map((point) {
                      Widget cell = Container(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: point == '1' ? Colors.lightGreenAccent : Colors.grey[850],
                          shape: BoxShape.circle,
                        ),
                      );


                      if (point == '1') {
                        cell = Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.lightGreenAccent,
                            shape: BoxShape.circle,
                          ),
                        );
                      }

                      return cell;
                    }).toList(),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),

        SizedBox(
          height: 50), // Add space below the LED matrix
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Ink(
              decoration: ShapeDecoration(
                color: Colors.white, // กำหนดสีพื้นหลังเป็นสีขาว
                shape: CircleBorder(), // กำหนดรูปร่างของพื้นหลังเป็นวงกลม
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_drop_down), // Change icon to arrow_drop_down
                onPressed: () {
                  decrementNumber(); // Decrement number
                },
                color: Colors.black, // Change icon color to black
                splashColor: Colors.transparent, // Disable splash color
                highlightColor: Colors.transparent, // Disable highlight color
                padding: EdgeInsets.all(25), // Adjust tap area
              ),
            )
          ],
        ),
      ],
    );
  }
}

final Map<String, List<String>> digitToMatrix = {
  '0': [
    '01110',
    '10001',
    '10001',
    '10001',
    '10001',
    '10001',
    '01110'
  ],
  '1': [
    '00100',
    '01100',
    '00100',
    '00100',
    '00100',
    '00100',
    '01110'
  ],
  '2': [
    '01110',
    '10001',
    '00001',
    '01110',
    '10000',
    '10000',
    '11111'
  ],
  '3': [
    '01110',
    '10001',
    '00001',
    '01110',
    '00001',
    '10001',
    '01110'
  ],
  '4': [
    '00010',
    '00110',
    '01010',
    '10010',
    '11111',
    '00010',
    '00010'
  ],
  '5': [
    '11111',
    '10000',
    '11110',
    '00001',
    '00001',
    '10001',
    '01110'
  ],
  '6': [
    '01110',
    '10001',
    '10000',
    '11110',
    '10001',
    '10001',
    '01110'
  ],
  '7': [
    '11111',
    '00001',
    '00001',
    '00010',
    '00100',
    '00100',
    '00100'
  ],
  '8': [
    '01110',
    '10001',
    '10001',
    '01110',
    '10001',
    '10001',
    '01110'
  ],
  '9': [
    '01110',
    '10001',
    '10001',
    '01111',
    '00001',
    '10001',
    '01110'
  ]
};
