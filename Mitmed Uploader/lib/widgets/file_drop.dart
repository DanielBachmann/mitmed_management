import 'dart:io';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_selector/file_selector.dart';

class FileDrop extends StatefulWidget {
  final Widget child;
  final Function(List<XFile> files) onFiles;

  FileDrop({required this.child, required this.onFiles});

  @override
  _FileDropState createState() => _FileDropState();
}

class _FileDropState extends State<FileDrop> {
  bool _dragging = false;
  final List<XFile> _list = [];

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (detail) {
        setState(() {
          _list.addAll(detail.files);
        });
      },
      onDragEntered: (detail) {
        setState(() {
          _dragging = true;
        });
      },
      onDragExited: (detail) {
        setState(() {
          _dragging = false;
        });
      },
      child: Container(
        height: 200,
        width: 200,
        color: _dragging ? Colors.blue.withOpacity(0.4) : Colors.black26,
        child: _list.isEmpty
            ? const Center(child: Text("Drop here"))
            : Text(_list.join("\n")),
      ),
    );
  }
}
