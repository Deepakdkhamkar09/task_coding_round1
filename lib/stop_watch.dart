import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1_test/screen_a.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  final Stopwatch stopwatch = Stopwatch();
  late Duration elapsedTime;
  late String elapsedTimeString;
  late Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    stopwatch.start();

    timer = Timer.periodic(const Duration(microseconds: 100), (Timer timer) {
      setState(() {});
    });
    super.initState();
  }

  String formattedTime() {
    final elapsed = stopwatch.elapsed;
    final minutes = elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    final milliseconds = (elapsed.inMilliseconds % 1000 ~/ 100)
        .toString()
        .padLeft(1, '0');
    return '$minutes:$seconds:$milliseconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stop Watch')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 90,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Center(
                child: Text(formattedTime(), style: TextStyle(fontSize: 40)),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                stopwatch.stop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ScreenA()),
                ).then((_) {
                  stopwatch.start();

                  timer = Timer.periodic(const Duration(microseconds: 100), (
                    Timer timer,
                  ) {
                    setState(() {});
                  });
                });
              },
              child: Text('Push Screen A'),
            ),
          ],
        ),
      ),
    );
  }
}
