import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

Future<String?> createAccount(
  String email,
  String username,
  String password,
) async {
  try {
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // Update display name after signup
    await userCredential.user!.updateDisplayName(username);
    return null;
    // Send email verification
    // Check if context is still valid
    // Success dialog
  } on FirebaseAuthException catch (e) {
    // These come from Firebase's built-in error codes

    if (e.code == 'email-already-in-use') {
      return 'This email is already registered.';
    } else if (e.code == 'invalid-email') {
      return 'Please enter a valid email address.';
    } else if (e.code == 'weak-password') {
      return 'Password must be at least 6 characters.';
    } else {
      return 'Something went wrong: ${e.message}';
    }
  } catch (e) {
    // For any other unexpected errors
    return 'Unexpected error: $e';
  }
}

Future<bool?> checkEmailVerificationStatus(
  String email,
  String password,
) async {
  try {
    // Try signing in with the provided credentials
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;

    if (user != null) {
      bool isVerified = user.emailVerified;
      await FirebaseAuth.instance.signOut(); // sign out again, optional
      return isVerified; // true or false depending on user status
    } else {
      return null; // no user found
    }
  } on FirebaseAuthException catch (e) {
    // Handle specific errors
    if (e.code == 'user-not-found') {
      return null; // account doesn’t exist
    } else if (e.code == 'wrong-password') {
      return false; // password is wrong, can’t check verification safely
    } else {
      return null;
    }
  } catch (e) {
    print('Error checking verification: $e');
    return null;
  }
}

Future<bool?> getEmailVerificationStatus() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    // No user is logged in
    return null; // or false if you prefer
  }

  // Reload to get latest info
  await user.reload();
  user = FirebaseAuth.instance.currentUser;

  return user?.emailVerified; // safe access with null check
}



void showComplete(String title, String message, BuildContext context, String routeName) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    width: 400,
    dismissOnTouchOutside: false,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: title,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 28,
      color: Colors.green,
    ),
    desc: message,
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
        Navigator.pushNamed(context, routeName);
      } else if (width > 600) {
        Navigator.pushNamed(context, routeName);
      }
    },
  ).show();
}

void showError(String message, BuildContext context, String routeName) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    width: 400,
    dismissOnTouchOutside: false,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: "Error",
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 28,
      color: Colors.redAccent,
    ),
    desc: message,
    descTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.redAccent,
    ),
    borderSide: const BorderSide(color: Colors.redAccent, width: 3),
    btnOkText: "OK",
    btnOkOnPress: () {
      final width = MediaQuery.of(context).size.width;
      if (width < 600) {
        Navigator.pushNamed(context, routeName);
      } else if (width > 600) {
        Navigator.pushNamed(context, routeName);
      }
    },
  ).show();
}

void showwarning(String message, BuildContext context, String routeName) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    width: 400,
    dismissOnTouchOutside: false,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: "Warning!",
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 28,
      color: Colors.orangeAccent,
    ),
    desc: message,
    descTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.orangeAccent,
    ),
    borderSide: const BorderSide(color: Colors.orangeAccent, width: 3),
    btnOkText: "OK",
    btnOkOnPress: () {
      final width = MediaQuery.of(context).size.width;
      if (width < 600) {
        Navigator.pushNamed(context, routeName);
      } else if (width > 600) {
        Navigator.pushNamed(context, routeName);
      }
    },
  ).show();
}
