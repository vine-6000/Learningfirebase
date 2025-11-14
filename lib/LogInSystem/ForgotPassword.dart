import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {

  bool isSeen = true;

  bool isSeen2 = true;

  final TextEditingController getNameController = TextEditingController();
  final TextEditingController getPasswordController = TextEditingController();
  final TextEditingController getConfirmPasswordController =
      TextEditingController();

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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reset Password',
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
                          controller: getNameController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                       
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            //LoginFunction,
                          },
                          child: Text('SignIn'),
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
