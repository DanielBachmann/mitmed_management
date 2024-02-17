import 'dart:convert';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:mitmed_uploader/state/simple_state.dart';
import 'package:mitmed_uploader/widgets/emotion_grid.dart';
import 'package:mitmed_uploader/widgets/file_drop.dart';
import 'package:requests/requests.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*await DesktopWindow.setMinWindowSize(const Size(500, 500));
  await DesktopWindow.setMaxWindowSize(Size.infinite);
  await DesktopWindow.setWindowSize(const Size(800, 600));
  await DesktopWindow.;*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upload Pattern',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  // text controller
  final _textController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upload Pattern',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Upload Pattern'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 500,
              padding: EdgeInsets.all(10),
              child: EmotionGrid(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Textfield for the name of the pattern
                Container(
                  width: 300,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 50),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name des Patterns',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await _sendPattern(
                          patterns: SimpleState.patterns,
                          // name is set from the textfield
                          name: _textController.text,
                        );
                        // show a alert dialog "Muster wurde hochgeladen"
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Muster wurde hochgeladen"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Hochladen'),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          SimpleState.patterns = {};
                        });
                      },
                      child: Text('Zurücksetzen'),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _sendPattern({
    required Map<int, List<int>> patterns,
    required String name,
  }) async {
    // ! delete stored Cookies for DOMAIN not(!) URL
    await Requests.clearStoredCookies(MITMED_DOMAIN);

    final response = await Requests.post(
      MITMED_URL + "/wp-json/jwt-auth/v1/token",
      body: {
        "username": "s",
        "password": "s",
        "device": "BLE-App",
      },
    );

    final data = json.decode(response.body);
    // todo: this already throws an exception if the credentials are wrong,
    // todo: but of course this should be solved much cleaner
    final accessToken = data['data']['token'];

    // Convert the int keys to string keys
    Map<String, List<int>> convertedMap = {};
    patterns.forEach((key, value) {
      convertedMap[key.toString()] = value;
    });

    // Convert the Map to a JSON string
    String jsonString = json.encode(convertedMap);

    final patterns_response = await Requests.post(
      "${MITMED_URL}/wp-json/mitmed/v1/pattern",
      headers: {
        'Authorization': "Bearer ${accessToken}",
      },
      body: {
        "titel": name,
        "pattern": jsonString,
      },
    );

    final stop = "Hammertime!";
  }
}
