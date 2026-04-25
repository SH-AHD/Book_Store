import 'package:bookia/app.dart';
import 'package:bookia/core/services/apis/dio.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
  await SharedPref.init();
  runApp(
    DevicePreview(
      enabled: false,
      // enabled: !kReleaseMode,
      builder: (context) => MainApp(),
    ),
  );
}
