import 'package:clockapp/ui/style.dart';
import 'package:clockapp/utils/time_model.dart';
import 'package:clockapp/widget/clock_widget.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            //upgrading clock value each seconds
            TimerBuilder.periodic(Duration(seconds: 1), builder: (context){
              var currentTime =DateTime.now();
              // lets set the digital clock string
              String seconds = currentTime.second < 10? "0${currentTime.second}":"${currentTime.second}";
              String minute = currentTime.minute < 10? "0${currentTime.minute}":"${currentTime.minute}";
              String hour = currentTime.hour < 10? "0${currentTime.hour}":"${currentTime.hour}";

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Today",style: AppStyle.mainTextThin ,),
                      Text("$hour:$minute:$seconds", style: AppStyle.mainText,),
                    ],),
                  Center(child: ClockWidget(TimeModel(currentTime.second, currentTime.minute,currentTime.hour,))),
                ],
              );
            }),
            SizedBox(height: 60,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select another time zone",
                  style: TextStyle(fontSize: 18),
                  ),
                  Divider(
                    color: Colors.black45,
                  )
              ],
            ),
             Expanded(
              child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  //margin: EdgeInsets.only(right: 24),
                  width: MediaQuery.of(context).size.width-52,
                  height: 100,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppStyle.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Enugu", style: AppStyle.mainTextWhite,),
                          Text("${DateTime.now().hour}:${DateTime.now().minute}",style: AppStyle.mainTextWhite,)
                        ],
                        ),
                      SizedBox(height: 8,),
                      Text("Today", style: AppStyle.mainTextThinWhite,)
                    ],
                  ),
                ),
              ],
             ),
             ),
          ],
        ),
      )),
    );
  }
}


