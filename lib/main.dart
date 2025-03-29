import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_habit/feature/initizialization/widget/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/environment/env_config.dart';
import 'core/observer/app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Загрузка переменных окружения
  await dotenv.load(fileName: ".env");

  Bloc.observer = AppBlocObserver.instance();

  //supabase init
  await Supabase.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseAnonKey,
  );
  runApp(const App());
}
