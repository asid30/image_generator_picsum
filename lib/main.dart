import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      home: const MyHomePage(title: 'Random Image'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _idPics = Random().nextInt(30);
  final List<int> _savedPics = [];

  @override
  void initState() {
    super.initState();
    _savedPics.add(_idPics);
  }

  void _randomIdPics() {
    setState(() {
      _idPics = Random().nextInt(30);
      if (!_savedPics.contains(_idPics)) {
        if (_savedPics.length >= 5) {
          _savedPics.removeAt(0);
        }
        _savedPics.add(_idPics);
      }
    });
  }

  void _previousIdPics() {
    setState(() {
      if (_savedPics.length > 1) {
        _savedPics.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Text("Saved Pics: $_savedPics"),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue.shade900),
                        ),
                        child: Image.network(
                          'https://picsum.photos/id/${_savedPics.last}/250',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${_savedPics.last}",
                          style: TextStyle(
                            fontSize: 20,
                            backgroundColor: Colors.black,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: _randomIdPics,
                            icon: Icon(Icons.casino, size: 18),
                            label: Text("Random"),
                          ),
                          ElevatedButton.icon(
                            onPressed: _previousIdPics,
                            icon: Icon(Icons.skip_previous, size: 18),
                            label: Text("Previous"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        width: 250,
        child: Text(
          "Developed by: @asid30",
          style: TextStyle(
            backgroundColor: Colors.transparent,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
