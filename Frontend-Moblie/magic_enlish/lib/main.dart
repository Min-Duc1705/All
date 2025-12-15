import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:magic_enlish/providers/auth/auth_provider.dart';
import 'package:magic_enlish/providers/vocabulary/vocabulary_provider.dart';
import 'package:magic_enlish/providers/grammar/grammar_provider.dart';
import 'package:magic_enlish/providers/progress/progress_provider.dart';
import 'package:magic_enlish/providers/home/home_stats_provider.dart';
import 'package:magic_enlish/features/auth/splash_screen.dart';
import 'package:magic_enlish/features/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..loadUser()),
        ChangeNotifierProvider(create: (_) => VocabularyProvider()),
        ChangeNotifierProvider(create: (_) => GrammarProvider()),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
        ChangeNotifierProvider(create: (_) => HomeStatsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('en', 'US'),
        home: const SplashScreen(),
        routes: {'/home': (context) => const HomeScreen()},
      ),
    );
  }
}
