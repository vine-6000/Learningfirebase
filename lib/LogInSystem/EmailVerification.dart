import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:learningfirebase/LogInSystem/AuthSystems.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Emailverification extends StatefulWidget {
  const Emailverification({super.key});

  @override
  State<Emailverification> createState() => _EmailverificationState();
}

class _EmailverificationState extends State<Emailverification> {
  Future<void> sendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      if (!mounted) return;
      showError(
        "You are already verified, cannot send another verification email",
        context,
        '',
      );
    }
    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        if (!mounted) return;
        showComplete("Verification email sent","The email is most likely in your spam inbox as I am not a well known software developer :>", context, '');
        startTimer();
      } catch (e) {
        if (!mounted) return;
        showwarning("Failed to send email: $e", context, '');
      }
    }
  }

  int secondsLeft = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    sendVerificationEmail();
    startTimer();
  }

  void startTimer() {
    timer?.cancel(); // cancel any old timer first
    setState(() {
      secondsLeft = 30; // reset to 30
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        setState(() {
          secondsLeft--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // stop the timer when page closes
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Email Verification',
              textAlign: TextAlign.center,
              style: GoogleFonts.aboreto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.4,
              color: Colors.transparent,
              child: Text(
                'A verification email has been sent to your email address. Please check your inbox and verify your email to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  backgroundColor: secondsLeft == 0
                      ? Colors.white
                      : Colors.grey,
                  onPressed: () {
                    if (secondsLeft == 0) {
                      sendVerificationEmail();
                    } else {
                      showwarning("Please wait before resending.", context, '');
                      getEmailVerificationStatus();
                    }
                  },
                  label: Text(
                    secondsLeft == 0
                        ? "   Resend Email   "
                        : "Resend Email: $secondsLeft",
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),

                FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  onPressed: () async {
                    bool? verified = await getEmailVerificationStatus();

                    if (!mounted) return;

                    if (verified == true) {
                      // Email is verified

                      showComplete(
                        "Account is verifired!",
                        "Please procede now to the log in page",
                        context,
                        '/LogIn',
                      );
                    } else {
                      // Email not verified or no user
                      showwarning("You are still not verified", context, '');
                    }
                  },

                  // getEmailVerificationStatus();
                  // Navigator.pushNamedAndRemoveUntil(
                  //   context,SS
                  //   '/LogIn',
                  //   (route) => false,
                  // );
                  label: Text("Continue to LogIn"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
