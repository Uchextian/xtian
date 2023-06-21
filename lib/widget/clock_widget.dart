import 'dart:math';

import 'package:clockapp/ui/style.dart';
import 'package:clockapp/utils/time_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';

// ignore: must_be_immutable
class ClockWidget extends StatefulWidget {
   ClockWidget(this.time,{super.key});

  TimeModel time;

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // adding decoration to the contianer
      decoration: BoxDecoration(shape: BoxShape.circle,
      // adding some effects
      boxShadow: [
        BoxShadow(
           color: AppStyle.primaryColor.withAlpha(80), blurRadius: 38.0 ) 
           ] ),
      height: 300,
      width: 300,
      child: CustomPaint(
        painter: ClockPainter(widget.time),
      ),
    
    );
  }
}

class ClockPainter extends CustomPainter{

  TimeModel? time;
  ClockPainter(this.time);

  @override
  void paint(Canvas canvas, Size size) {
    // lets calculate the time position
      double secRad = ((pi / 2)-(pi / 30) * this.time!.sec!) % (2 * pi);
      double minRad = ((pi / 2)-(pi / 30) * this.time!.min!)% (2 * pi);
      double hourRad = ((pi / 2)-(pi / 6) * this.time!.hour!)% (2 * pi);

    // lets set some important points cordinate
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    //setting the clock coordinate
    var secHeight = radius / 2;
    var minHeight = radius / 2-10;
    var hourHeight = radius / 2-25;

    var seconds = Offset(centerX + secHeight*cos(secRad), centerY - secHeight*sin(secRad));
    var mintues = Offset(centerX + minHeight*cos(minRad), centerY - minHeight*sin(minRad));
    var hours = Offset(centerX + hourHeight*cos(hourRad), centerY - hourHeight*sin(hourRad));

    // setting the brush
    var fillBrush = Paint()
    ..color = AppStyle.primaryColorDark
    ..strokeCap = StrokeCap.round;

    var centerDotBrush = Paint()..color = Color(0xFFEAECFF);

    // setting the hand brush
      var secBrush = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 2
    ..strokeJoin = StrokeJoin.round;

      var minBrush = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 3
    ..strokeJoin = StrokeJoin.round;

      var hourBrush = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 4
    ..strokeJoin = StrokeJoin.round;

    // drawing the body of the clock
    canvas.drawCircle(center, radius-40, fillBrush);

    // drawing the hands of the clock
      canvas.drawLine(center,seconds, secBrush);
      canvas.drawLine(center,mintues, minBrush);
      canvas.drawLine(center,hours, hourBrush);

    // drawing the center dot
    canvas.drawCircle(center, 16, centerDotBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}