import 'package:flutter/material.dart';
import 'package:gerenciador_gastos_pessoais/screens/home/components/body.dart';
import 'package:gerenciador_gastos_pessoais/screens/home/components/speed_dial.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Body(),
      floatingActionButton: buildSpeedDial(context),
    );
  }
}
