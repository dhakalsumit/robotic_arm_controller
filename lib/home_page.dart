import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:robot_slider/api_services.dart';
import 'package:robot_slider/ip_config.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _gripSliderValue = 00;
  double _wristPitchSliderValue = 00;
  double _wristRollSliderValue = 00;
  double _elbowSliderValue = 00;
  double _shoulderSliderValue = 00;
  double _waistSliderValue = 00;
  void sendSliderValues() {
    final sliderValues = {
      'grip': _gripSliderValue,
      'wrist_pitch': _wristPitchSliderValue,
      'wrist_roll': _wristRollSliderValue,
      'elbow': _elbowSliderValue,
      'shoulder': _shoulderSliderValue,
      'waist': _waistSliderValue,
    };

    ApiServices().sendSliderValues(sliderValues);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Robot Slider',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          centerTitle: true,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                print("open");
                Scaffold.of(context).openDrawer();
              },
            );
          })),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(bottom: 0, top: 0),
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.settings),
              title: Text('Ip Configure '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const IPConfigScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text("Grip"),
                Spacer(),
                Slider(
                  value: _gripSliderValue,
                  max: 10,
                  divisions: 100,
                  label: _gripSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _gripSliderValue = value;
                    });
                    sendSliderValues();
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text("Wrist pitch"),
                Spacer(),
                Slider(
                  value: _wristPitchSliderValue,
                  max: 10,
                  divisions: 100,
                  label: _wristPitchSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _wristPitchSliderValue = value;
                    });
                    sendSliderValues();
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text("Wrist roll"),
                Spacer(),
                Slider(
                  value: _wristRollSliderValue,
                  max: 10,
                  divisions: 100,
                  label: _wristRollSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _wristRollSliderValue = value;
                    });
                    sendSliderValues();
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text("Elbow"),
                Spacer(),
                Slider(
                  value: _elbowSliderValue,
                  max: 10,
                  divisions: 100,
                  label: _elbowSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _elbowSliderValue = value;
                    });
                    sendSliderValues();
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text("Shoulder"),
                Spacer(),
                Slider(
                  value: _shoulderSliderValue,
                  max: 10,
                  divisions: 100,
                  label: _shoulderSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _shoulderSliderValue = value;
                    });
                    sendSliderValues();
                  },
                ),
              ],
            ),
            Row(children: [
              Text("waist"),
              Spacer(),
              Slider(
                value: _waistSliderValue,
                max: 10,
                divisions: 100,
                label: _waistSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _waistSliderValue = value;
                  });
                  sendSliderValues();
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
