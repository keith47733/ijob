import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../services/global_methods.dart';
import '../../services/global_variables.dart';
import '../../styles/clr.dart';
import '../../styles/layout.dart';
import '../../styles/txt.dart';
import '../forget_password/forget_password.dart';
import '../sign_up/sign_up.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  final _loginFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            _loginAnimation(),
            Container(
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.all(layout.padding * 1.5),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(layout.padding * 3),
                      child: _loginBanner(),
                    ),
                    Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: layout.padding),
                            child: _emailFormField(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: layout.padding / 2),
                            child: _passwordFormField(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: layout.padding),
                            child: _forgetPasswordText(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: layout.padding,
                              right: layout.padding,
                              bottom: layout.padding,
                            ),
                            child: _loginButton(),
                          ),
                          _signUpTextButton(),
                        ], // Form items
                      ),
                    ),
                  ], // Listview items
                ),
              ),
            ),
          ], // Stack items
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

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

  Widget _emailFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _passwordFocusNode.requestFocus(),
      // onEditingComplete: () => FocusScope.of(context).requestFocus(_passwordFocusNode),
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Please enter a valid email address';
        } else {
          return null;
        }
      },
      style: txt.formField,
      decoration: InputDecoration(
        hintText: 'Enter your email address',
        hintStyle: txt.formFieldHint,
        errorStyle: txt.error,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: clr.light),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: clr.primary),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: clr.error),
        ),
      ),
    );
  }

  Widget _forgetPasswordText() {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
        },
        child: const Text(
          'Forget Password?',
          style: txt.smallTextButton,
        ),
      ),
    );
  }

  Widget _loginAnimation() {
    return CachedNetworkImage(
      imageUrl: loginUrlImage,
      placeholder: (context, url) => Image.asset(
        'assets/images/wallpaper.jpg',
        fit: BoxFit.fill,
      ),
      fadeOutDuration: const Duration(seconds: 4),
      fadeOutCurve: Curves.easeOut,
      fadeInDuration: const Duration(seconds: 4),
      fadeInCurve: Curves.easeIn,
      errorWidget: (context, url, error) => const Icon(Icons.error),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      alignment: FractionalOffset(_animation.value, 0),
    );
  }

  Widget _loginBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(layout.radius * 3),
      child: Opacity(
        opacity: 0.7,
        child: Image.asset(
          'assets/images/jobs.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _loginButton() {
    return MaterialButton(
      onPressed: _submitFormLogin,
      color: clr.primary,
      elevation: layout.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(layout.radius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.all(layout.padding * 0.75),
            child: Text(
              'Login',
              style: txt.button,
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordFormField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      onEditingComplete: () => _passwordFocusNode.unfocus(),
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      obscureText: !_obscureText,
      validator: (value) {
        if (value!.isEmpty || value.length < 7) {
          return 'Please enter a valid password (min 7 characters)';
        } else {
          return null;
        }
      },
      style: txt.formField,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: clr.light,
          ),
        ),
        hintText: 'Enter your password',
        hintStyle: txt.formFieldHint,
        errorStyle: txt.error,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: clr.light),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: clr.primary),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: clr.error),
        ),
      ),
    );
  }

  Widget _signUpTextButton() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: 'Don\'t have an account?',
              style: txt.body1,
            ),
            const TextSpan(text: '     '),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ),
                    ),
              text: 'Sign up',
              style: txt.mediumTextButton,
            ),
          ],
        ),
      ),
    );
  }

  void _submitFormLogin() async {
    final isValid = _loginFormKey.currentState!.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim().toLowerCase(),
          password: _passwordController.text.trim(),
        );
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        setState(
          () {
            _isLoading = false;
          },
        );
        GlobalMethod.showErrorDialog(
          context: context,
          error: error.toString(),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
  }
}
