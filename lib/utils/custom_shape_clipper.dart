import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;
import 'constants.dart';

class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint_0 = new Paint()

      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
        Offset(0.0,0.0),
        Offset(0.0,size.height*0.8250000),
        [
          kPrimaryColor,
          kPrimaryColor2,
        ],
      )
      ..strokeWidth = 1;


    Path path_0 = Path();
    path_0.moveTo(0,0);
    path_0.lineTo(0,size.height*0.8250000);
    path_0.quadraticBezierTo(size.width*0.0610200,size.height*0.8251500,size.width*0.1420000,size.height*0.8250000);
    path_0.cubicTo(size.width*0.3789200,size.height*0.8242000,size.width*0.2986200,size.height*0.9408250,size.width*0.4000000,size.height*0.9950000);
    path_0.cubicTo(size.width*0.4047800,size.height*0.9983250,size.width*0.6000000,size.height,size.width*0.6000000,size.height*0.9950000);
    path_0.cubicTo(size.width*0.7000000,size.height*0.9375000,size.width*0.6206200,size.height*0.8258250,size.width*0.8560000,size.height*0.8250000);
    path_0.quadraticBezierTo(size.width*0.9643800,size.height*0.8234000,size.width,size.height*0.8250000);
    path_0.lineTo(size.width,0);
    path_0.lineTo(0,0);

    canvas.drawPath(path_0, paint_0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}



