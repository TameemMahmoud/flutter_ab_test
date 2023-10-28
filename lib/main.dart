import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'utils/app/my_app.dart';
import 'utils/bloc_observer/bloc_observer.dart';
import 'utils/di/injection.dart';
import 'utils/helper/hive_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await initAppInjection();
  await Hive.initFlutter();
  await Hive.openBox(HiveHelper.mood);
  await Hive.openBox(HiveHelper.userEmail);
  runApp(const MyApp());
}

