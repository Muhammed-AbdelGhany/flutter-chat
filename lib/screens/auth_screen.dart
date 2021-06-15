import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/theme/theme.dart';
import 'package:chat_app/widgets/auth_form_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading = false;

  void onSubmit(String email, String username, String password, bool isLogin,
      BuildContext ctx) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (isLogin) {
        await Provider.of<AuthProvider>(context, listen: false)
            .signInWithEmailAndPassword(email, password);
      } else {
        await Provider.of<AuthProvider>(context, listen: false)
            .signUpWithEmailAndPassword(email, password, username);
      }
      // if (errorMsg != null) {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text(errorMsg)));
      //   setState(() {
      //     isLoading = false;
      //   });
      // }
    } on PlatformException catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pColor,
      body: AuthForm(onSubmit, isLoading),
    );
  }
}
