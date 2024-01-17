import 'package:tut_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
