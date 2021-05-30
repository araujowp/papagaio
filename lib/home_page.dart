import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final FlutterTts _flutterTts = FlutterTts();
  String language;
  List voices;
  double speechRate;
  double pitch;

  String texto = "";
  bool playing;

  @override
  void initState() {
    super.initState();
    initFlutterTts();
  }

  initFlutterTts() async {
    language = 'pt-BR';
    speechRate = 1.0;
    pitch = 1.0;
    playing = false;
    voices = await _flutterTts.getVoices;
    _flutterTts.setCompletionHandler(() {
      setState(() {
        playing = false;
      });
    });
  }

  _play() async {
    if (texto == null) return;
    var result = await _flutterTts.speak(texto);
    if (result == 1)
      setState(() {
        playing = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Papagaio'),),
      body: Column(
        children: [
          TextField(
            maxLines: 5,
            decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "escreva aqui o que deseja falar"),
            onChanged: (value){
              setState(() {
                texto = value;
              });
            },
          ),
          TextButton(onPressed: _play, child: Text('pressione para falar'))
        ],
      ),
    );
  }
}