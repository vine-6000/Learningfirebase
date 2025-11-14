import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:learningfirebase/LogInSystem/AuthSystems.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isSeen = true;

  bool isSeen2 = true;

  final TextEditingController getNameController = TextEditingController();
  final TextEditingController getEmailController = TextEditingController();
  final TextEditingController getPasswordController = TextEditingController();
  final TextEditingController getConfirmPasswordController =
      TextEditingController();

  void checkDetails() async {
    String name = getNameController.text.trim();
    String email = getEmailController.text.trim();
    String createPassword = getPasswordController.text.trim();
    String confirmPassword = getConfirmPasswordController.text.trim();
    // Basic email format validation

    // String name = "Yes";
    // String email = "orvine@gmail.com";
    // String createPassword = "000000";
    // String confirmPassword = createPassword;

    if (name.isEmpty ||
        email.isEmpty ||
        createPassword.isEmpty ||
        confirmPassword.isEmpty) {
      showError("Please fill in all fields.", context, "");
      return; // Stop execution
    }
    // Check if passwords match
    else if (createPassword != confirmPassword) {
      showError("Passwords do not match.", context, "");
      return; // Stop execution
    }

    String? errorMessage = await createAccount(email, name, createPassword);
    if (!mounted) return;

    if (errorMessage == null) {
      // Account created successfully
     
      showComplete("Account created Succesfuly", context, '/Emailverification');
      
    } else if (errorMessage == 'This email is already registered.') {
      // If the email already exists, check if it's verified
      bool? isVerified = await checkEmailVerificationStatus(
        email,
        createPassword,
      );
      if (!mounted) return;

      if (isVerified == true) {
        showError(
          "This account is already verified. Please sign in.",
          context,
          "/LogIn",
        );
      } else if (isVerified == false) {
        showwarning(
          "This account exist but is not yet verified. Please verify the account.",
          context,
          '/Emailverification',
        ); // unverified -> verification page
      } else {
        showwarning(
          "Account exists but could not verify its status.",
          context,
          "",
        );
      }
    } else {
      showError(errorMessage, context, '');
    }
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
              'SignUp Page',
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
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/LogIn',
              (route) => false,
            );
          },
        ),
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                'Please Fill in your Details',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                minFontSize: 20,
                maxFontSize: 60,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.07),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 200,
                  maxWidth: 700,
                  minHeight: 400,
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextField(
                          controller: getEmailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextField(
                          obscureText: isSeen,
                          controller: getPasswordController,
                          decoration: InputDecoration(
                            labelText: 'Create Password',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isSeen = !isSeen;
                                });
                              },
                              icon: Icon(
                                isSeen
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextField(
                          obscureText: isSeen2,
                          controller: getConfirmPasswordController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isSeen2 = !isSeen2;
                                });
                              },
                              icon: Icon(
                                isSeen2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            checkDetails();
                            // CheckIfCreateorVerifyAccount();
                          },
                          child: Text('Create Account'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
