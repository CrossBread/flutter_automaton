import 'package:flutter/material.dart';

import 'main_app_widget.dart';

class App {
  // static Logger log = new Logger();

  static Future<void> appMain() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    runApp(const MainAppWidget());
  }
}
