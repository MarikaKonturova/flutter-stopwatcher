import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        useMaterial3: true,
      ),
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = '00';
      digitMinutes = '00';
      digitHours = '00';

      started = false;
    });
  }

  void addLaps() {
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  //start timer func

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
        }
        localSeconds = 0;
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(202, 184, 145, 1),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Text("StopWatch App",
                          style: TextStyle(
                            color: Color.fromRGBO(112, 104, 59, 1),
                            fontSize: 28.0,
                            fontWeight: FontWeight.w300,
                          ))),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text(
                      "$digitHours:$digitMinutes:$digitSeconds",
                      style: TextStyle(
                        color: Color.fromRGBO(112, 104, 59, 1),
                        fontSize: 82.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Container(
                    height: 400.0,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(235, 220, 190, 1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListView.builder(
                        itemCount: laps.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Lap n°${index + 1}",
                                  style: TextStyle(
                                    color: Color.fromRGBO(112, 104, 59, 1),
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  "${laps[index]}",
                                  style: TextStyle(
                                    color: Color.fromRGBO(112, 104, 59, 1),
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RawMaterialButton(
                          onPressed: () {
                            (!started) ? start() : stop();
                          },
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: Color.fromRGBO(235, 220, 190, 1),
                            ),
                          ),
                          child: Text(
                            !(started) ? "Start" : "Stop",
                            style: TextStyle(
                              color: Color.fromRGBO(112, 104, 59, 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      IconButton(
                        color: Color.fromRGBO(129, 35, 30, 1),
                        onPressed: () {
                          addLaps();
                        },
                        icon: Icon(Icons.flag),
                      ),
                      Expanded(
                        child: RawMaterialButton(
                          onPressed: () {
                            reset();
                          },
                          fillColor: Color.fromRGBO(235, 220, 190, 1),
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: Color.fromRGBO(235, 220, 190, 1),
                            ),
                          ),
                          child: Text(
                            "Reset",
                            style: TextStyle(
                              color: Color.fromRGBO(112, 104, 59, 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ));
  }
}
