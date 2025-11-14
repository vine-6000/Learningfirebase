import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:device_preview/device_preview.dart';
import 'package:learningfirebase/LogInSystem/SignUp.dart';
import 'firebase_options.dart';

import 'Homepage.dart';
import 'LogInSystem/LogIn.dart';
import 'LogInSystem/ForgotPassword.dart';
import 'LogInSystem/EmailVerification.dart';
import 'LogInSystem/AuthSystems.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // disabled on release, enabled for dev
      
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LogIn(),
      debugShowCheckedModeBanner: false,

      routes: {
        
        '/LogIn': (context) => const LogIn(),
        '/SignUp': (context) => const SignUp(),
        
        '/Emailverification': (context) => const Emailverification(),
        '/Forgotpassword': (context) => const Forgotpassword(),
        '/Homepage': (context) => const Homepage(),
     
      },
    );
  }
}
