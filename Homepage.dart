import 'package:flutter/material.dart';

class HOmePage extends StatefulWidget {
  const HOmePage({Key? key}) : super(key: key);

  @override
  State<HOmePage> createState() => _HOmePageState();
}

class _HOmePageState extends State<HOmePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Homepage"),),);
  }
}
