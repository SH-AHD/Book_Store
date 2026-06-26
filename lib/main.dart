import 'package:bookia/app.dart';
import 'package:bookia/core/services/apis/dio.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/utils/bloc_observer.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
  await SharedPref.init();
  Bloc.observer = MyBlocObserver();
  runApp(
    DevicePreview(
      // enabled: false,
      enabled: !kReleaseMode,
      builder: (context) => MainApp(),
    ),
  );
}
