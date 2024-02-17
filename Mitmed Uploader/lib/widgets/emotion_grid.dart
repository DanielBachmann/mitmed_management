import 'dart:convert';

import 'package:blur/blur.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:convert/convert.dart';
import 'package:mitmed_uploader/state/simple_state.dart';
import 'package:requests/requests.dart';

const String MITMED_DOMAIN = "mitmed.web-trek.de";
const String MITMED_URL = "https://" + MITMED_DOMAIN;

class EmotionGrid extends StatefulWidget {
  EmotionGrid({super.key});

  List patterns = [];

  @override
  State<EmotionGrid> createState() => _EmotionGridState();
}

class _EmotionGridState extends State<EmotionGrid> {
  Map<int, List<int>> patterns = {};
  bool _dragging = false;

  _onDragEntered(detail) {
    setState(() {
      _dragging = true;
    });
  }

  _onDragExited(detail) {
    setState(() {
      _dragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> emotionList = [];

    String imageFileName = "";
    String imagePath = "assets/emotion_icons/";

    int arousal = 1;
    int valenz = 1;

    patterns = SimpleState.patterns;

    for (int i = 1; i <= 28; i++) {
      imageFileName = "emotion${i}.png";

      if (patterns[i] == null) {
        emotionList.add(
          GestureDetector(
            child: FittedBox(
              fit: BoxFit.contain,
              child: DropTarget(
                onDragDone: (details) async {
                  final patternNumber = i;
                  String dataString = await details.files[0].readAsString();
                  // remove all whitespace from dataString
                  dataString = dataString.replaceAll(new RegExp(r"\s+"), "");
                  try {
                    final result = hex.decode(dataString);
                    setState(() {
                      patterns[i] = result;
                      SimpleState.patterns[i] = result;
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Kein gültiges Muster"),
                    ));
                  }

                  final stop = "Hammertime!";
                },
                onDragEntered: _onDragEntered,
                onDragExited: _onDragExited,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(imagePath + imageFileName).blurred(
                    colorOpacity: 0.8,
                    blur: 5,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    overlay: Text(
                      'Nicht gesetzt',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            onTap: () async {},
          ),
        );
      } else {
        emotionList.add(
          GestureDetector(
            child: FittedBox(
              fit: BoxFit.contain,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.asset(imagePath + imageFileName),
              ),
            ),
            onTap: () async {},
          ),
        );
      }

      if (arousal % 4 == 0) {
        arousal = 1;
      } else {
        arousal++;
      }

      if (valenz % 7 == 0) {
        valenz = 1;
      } else {
        valenz++;
      }
    }

    final gridView = GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 0,
      children: emotionList,
    );

    return gridView;
  }
}
