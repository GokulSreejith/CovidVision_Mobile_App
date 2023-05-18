import 'package:flutter/material.dart';

class StatefullWrapper extends StatefulWidget {
  const StatefullWrapper({
    Key? key,
    required this.onInit,
    required this.onDispose,
    required this.child,
  }) : super(key: key);
  final Future<dynamic> onInit;
  final Future<dynamic> onDispose;
  final Widget child;

  @override
  _StatefullWrapperState createState() => _StatefullWrapperState();
}

class _StatefullWrapperState extends State<StatefullWrapper> {
  @override
  void initState() {
    widget.onInit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.onDispose;
    super.dispose();
  }
}
