import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/global_methods.dart';
import '../../services/global_variables.dart';
import '../../styles/clr.dart';
import '../../styles/layout.dart';
import '../../styles/txt.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  final _signUpFormKey = GlobalKey<FormState>();

  File? imageFile;

  final TextEditingController _nameController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _passwordController = TextEditingController();
  var _obscureText = false;
  final FocusNode _phoneFocusNode = FocusNode();

  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _addressFocusNode = FocusNode();

  final TextEditingController _addressController = TextEditingController();

  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            _signUpAnimation(),
            Container(
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.all(layout.appPadding * 1.5),
                child: ListView(
                  children: [
                    _signUpAvatar(),
                    Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: layout.appPadding),
                            child: _nameFormField(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: layout.appPadding),
                            child: _emailFormField(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: layout.appPadding),
                            child: _passwordFormField(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: layout.appPadding),
                            child: _phoneFormField(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: layout.appPadding * 2),
                            child: _addressFormField(),
                          ),
                          _isLoading
                              ? _progressIndicator()
                              : Padding(
                                  padding: const EdgeInsets.all(layout.appPadding),
                                  child: _signUpButton(),
                                ),
                          _haveAccount(),
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneFocusNode.dispose();
    _addressFocusNode.dispose();
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

  Widget _addressFormField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      onEditingComplete: () => _addressFocusNode.unfocus(),
      keyboardType: TextInputType.text,
      controller: _addressController,
      focusNode: _addressFocusNode,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid address';
        } else {
          return null;
        }
      },
      style: txt.formField,
      decoration: InputDecoration(
        hintText: 'Enter your name/company address',
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

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    if (croppedImage != null) {
      setState(
        () {
          imageFile = File(croppedImage.path);
        },
      );
    }
  }

  Widget _emailFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _passwordFocusNode.requestFocus(),
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      focusNode: _emailFocusNode,
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

  void _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  Widget _haveAccount() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: 'Already have an account?',
              style: txt.body1,
            ),
            const TextSpan(text: '     '),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.canPop(context) ? Navigator.pop(context) : null,
              text: 'Login',
              style: txt.mediumTextButton,
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emailFocusNode.requestFocus(),
      keyboardType: TextInputType.name,
      controller: _nameController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid name or company';
        } else {
          return null;
        }
      },
      style: txt.formField,
      decoration: InputDecoration(
        hintText: 'Enter your name/company',
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

  Widget _passwordFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _phoneFocusNode.requestFocus(),
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
        hintText: 'Enter a password',
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

  Widget _phoneFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _addressFocusNode.requestFocus(),
      keyboardType: TextInputType.phone,
      controller: _phoneController,
      focusNode: _phoneFocusNode,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid phone nubmer';
        } else {
          return null;
        }
      },
      style: txt.formField,
      decoration: InputDecoration(
        hintText: 'Enter you phone number',
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

  Widget _progressIndicator() {
    return const Center(
      child: SizedBox(
        height: 70,
        width: 70,
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Choose image source:',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  _getFromCamera();
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(layout.appPadding / 2),
                      child: Icon(
                        Icons.camera,
                        color: clr.primary,
                      ),
                    ),
                    Text(
                      '  Camera',
                      style: txt.dialog,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _getFromGallery();
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(layout.appPadding / 2),
                      child: Icon(
                        Icons.image,
                        color: clr.primary,
                      ),
                    ),
                    Text(
                      '  Gallery',
                      style: txt.dialog,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _signUpAnimation() {
    return CachedNetworkImage(
      imageUrl: signUpUrlImage,
      placeholder: (context, url) => Image.asset(
        'assets/images/wallpaper.jpg',
        fit: BoxFit.fill,
      ),
      errorWidget: ((context, url, error) => const Icon(Icons.error)),
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.cover,
      alignment: FractionalOffset(_animation.value, 0),
    );
  }

  Widget _signUpAvatar() {
    Size size = MediaQuery.of(context).size;
    const cameraIconSize = 35.0;
    const cameraIconSpacing = 20.0;

    return Padding(
      padding: const EdgeInsets.all(layout.appPadding * 2),
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            _showImageDialog();
          },
          child: SizedBox(
            child: Container(
              height: size.width * 0.34,
              width: size.width * 0.34,
              decoration: BoxDecoration(
                color: clr.lightPrimary.withOpacity(0.3),
                border: Border.all(width: 2, color: clr.passive),
                borderRadius: BorderRadius.circular(layout.appRadius * 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(layout.appRadius * 2),
                child: imageFile == null
                    ? Stack(
                        children: [
                          Positioned(
                            bottom: cameraIconSpacing,
                            right: cameraIconSpacing,
                            child: Icon(
                              Icons.camera_enhance_sharp,
                              color: clr.light.withOpacity(0.6),
                              size: cameraIconSize,
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          Image.file(imageFile!, fit: BoxFit.fill),
                          Positioned(
                            bottom: cameraIconSpacing,
                            right: cameraIconSpacing,
                            child: Icon(
                              Icons.camera_enhance_sharp,
                              color: clr.light.withOpacity(0.6),
                              size: cameraIconSize,
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return MaterialButton(
      onPressed: _submitSignUpForm,
      elevation: layout.appElevation,
      color: clr.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(layout.appRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.all(layout.appPadding * 0.75),
            child: Text(
              'Sign up',
              style: txt.button,
            ),
          ),
        ],
      ),
    );
  }

  void _submitSignUpForm() async {
    final isValid = _signUpFormKey.currentState!.validate();
    if (isValid) {
      if (imageFile == null) {
        GlobalMethod.showErrorDialog(context: context, error: 'Please provde a user image');
        return;
      }
      setState(
        () {
          _isLoading = true;
        },
      );
      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim().toLowerCase(),
          password: _passwordController.text.trim(),
        );
        final User? user = _auth.currentUser;
        final uID = user!.uid;
        final ref = FirebaseStorage.instance.ref().child('user_images').child('$uID.jpg');
        await ref.putFile(imageFile!);
        imageUrl = await ref.getDownloadURL();
        FirebaseFirestore.instance.collection('users').doc(uID).set(
          {
            'id': uID,
            'user_image': imageUrl,
            'name': _nameController.text,
            'email': _emailController.text,
            'phone_number': _phoneController.text,
            'address': _addressController.text,
            'created': Timestamp.now(),
          },
        );
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        setState(
          () {
            _isLoading = false;
          },
        );
        GlobalMethod.showErrorDialog(context: context, error: error.toString());
      }
    }
    setState(
      () {
        _isLoading = false;
      },
    );
  }
}
