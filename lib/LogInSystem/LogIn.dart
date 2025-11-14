import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LoginpageState();
}

class _LoginpageState extends State<LogIn> {
  bool isSeen = true;

  final TextEditingController getNameController = TextEditingController();
  final TextEditingController getPasswordController = TextEditingController();


  void Correctpass() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      width: 400,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: "WELCOME!",
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 28,
        color: Colors.green,
      ),

      desc: "Please note: This app is still under construction Thankyou!",
      descTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.green,
      ),

      borderSide: const BorderSide(color: Colors.green, width: 3),

      btnOkText: "OK",
      btnOkOnPress: () {
        final width = MediaQuery.of(context).size.width;
        if (width < 600) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/PhoneHomepage',
            (route) => false,
          );
        } else if (width > 600) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/TabletHomepage',
            (route) => false,
          );
        }
      },
    ).show();
  }

  void Wrongpass() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      width: 400,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: "Wrong password!!!",
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 28,
        color: Colors.redAccent,
      ),

      desc: "Who ar u huhhh??",
      descTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.redAccent,
      ),

      borderSide: const BorderSide(color: Colors.redAccent, width: 3),

      btnOkText: "OK",
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,

      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              'Welcome, fellow 12 John XXIII',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              minFontSize: 20,
              maxFontSize: 60,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 20, maxHeight: 40),
              child: SizedBox(height: MediaQuery.of(context).size.width * 0.07),
            ),

            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 200,
                maxWidth: 700,
                minHeight: 300,
                maxHeight: 500,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.33,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: getNameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        obscureText: isSeen,
                        controller: getPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              isSeen = !isSeen;
                              setState(() {});
                            },
                            icon: Icon(
                              isSeen ? Icons.visibility : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      ElevatedButton(
                        onPressed: () {
                //          Login();
                        },
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),

                          // Full width button
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SelectableText.rich(
                        TextSpan(
                          text: 'Don\'t have an account? ',
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Sign up!',
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/SignUp',
                                    (route) => false,
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                          SizedBox(
                        height: MediaQuery.of(context).size.height * 0.007,
                      ),
                      SelectableText.rich(
                        TextSpan(
                          text: 'Forgot password? ',
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Reset here!',
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/Forgotpassword',
                                    (route) => false,
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24, width: 100),
            ElevatedButton(
              onPressed: () {
                final width = MediaQuery.of(context).size.width;
                if (width < 600) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/PhoneHomepage',
                    (route) => false,
                  );
                } else if (width > 600) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/TabletHomepage',
                    (route) => false,
                  );
                }
              },
              child: Text('Developer Pass'),
            ),
          ],
        ),
      ),
    );
  }
}
