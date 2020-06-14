import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText _speechToText = SpeechToText();
  bool _isRecording = false;

  @override
  void initState() {
    _speechToText.initialize(
      onError: (error) => print("Error: ${error.toString()}"),
      onStatus: (status) => print("Status: $status"),
      debugLogging: true,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speech to text"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(child: Text("Start"), onPressed: () => _startRecording()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(child: Text("Stop"), onPressed: () => _stopRecording()),
            ),
            Text("${_speechToText.lastRecognizedWords}"),
          ],
        ),
      ),
    );
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
      _speechToText.cancel();
    });
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _speechToText.listen(
        listenFor: Duration(seconds: 60),
        onResult: (result) => print("Result: ${result.toString()}"),
      );
    });
  }
}
