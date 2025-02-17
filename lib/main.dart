import 'package:flutter/material.dart';
import 'package:nagarathar/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nagarathar/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nagarathar/globals.dart' as globals;
bool showMainPage = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  prefs.getString('cookie').then((value) {
    if (value == null) {
      showMainPage = false;
    } else {
      globals.token = value;
      debugPrint(globals.token);
    }
  });
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: SplashScreen(
        showMainPage: showMainPage,
      ),
    );
  }
}
