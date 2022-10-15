import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/global_variables.dart';
import '../../styles/clr.dart';
import '../../styles/layout.dart';
import '../../styles/txt.dart';
import '../login/login.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  final TextEditingController _emailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        }
      });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Reset Password',
            style: txt.appBarTitle,
          ),
        ),
        body: Stack(
          children: [
            _forgetPasswordAnimation(),
            Container(
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: layout.appPadding * 1.5),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: layout.appPadding * 2,
                        bottom: layout.appPadding,
                      ),
                      child: _instructions(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: layout.appPadding * 3),
                      child: _emailTextField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: layout.appPadding),
                      child: _resetPasswordButton(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _forgetPasswordAnimation() {
    return CachedNetworkImage(
      placeholder: (context, url) => Image.asset(
        'assets/images/wallpaper.jpg',
        fit: BoxFit.fill,
      ),
      imageUrl: forgetPasswordUrlImage,
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.cover,
      alignment: FractionalOffset(_animation.value, 0),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget _instructions() {
    return const Text(
      'An email with instructions to reset your password will be sent to the email address provided below:',
      style: txt.body2,
    );
  }

  Widget _emailTextField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      style: txt.formField,
      controller: _emailController,
      decoration: InputDecoration(
        hintText: 'Enter your email address',
        hintStyle: txt.formFieldHint,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.passive,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.primary,
          ),
        ),
      ),
    );
  }

  Widget _resetPasswordButton() {
    return MaterialButton(
      onPressed: _resetPasswordSubmit,
      color: clr.primary,
      elevation: layout.appElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(layout.appRadius),
      ),
      child: const Padding(
        padding: EdgeInsets.all(layout.appPadding * 0.75),
        child: Text(
          'Reset Password',
          style: txt.button,
        ),
      ),
    );
  }

  void _resetPasswordSubmit() async {
    try {
      await _auth.sendPasswordResetEmail(
        email: _emailController.text.trim().toLowerCase(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }
}
