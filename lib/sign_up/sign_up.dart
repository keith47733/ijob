import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ijob/services/global_variables.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../services/layout.dart';
import '../services/text_style.dart';

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
  final FocusNode _locationFocusNode = FocusNode();

  final TextEditingController _locationController = TextEditingController();

  bool _isLoading = false;

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
    return Scaffold(
      body: Stack(
        children: [
          _signUpAnimation(),
          Container(
            color: Colors.black54,
            child: Padding(
              padding: const EdgeInsets.all(Layout.appPadding),
              child: ListView(
                children: [
                  _signUpAvatar(),
                  Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: Layout.appPadding),
                          child: _nameFormField(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: Layout.appPadding),
                          child: _emailFormField(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: Layout.appPadding),
                          child: _passwordFormField(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: Layout.appPadding),
                          child: _phoneFormField(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: Layout.appPadding * 2),
                          child: _locationFormField(),
                        ),
                        _isLoading
                            ? _progressIndicator()
                            : Padding(
                                padding: const EdgeInsets.all(Layout.appPadding),
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
    return Padding(
      padding: const EdgeInsets.all(Layout.appPadding * 2),
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
                color: Style.lightPrimaryColor.withOpacity(0.3),
                border: Border.all(width: 2, color: Style.passiveColor),
                borderRadius: BorderRadius.circular(Layout.appRadius * 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Layout.appRadius * 2),
                child: imageFile == null
                    ? const Icon(Icons.camera_enhance_sharp, color: Style.passiveColor, size: 50)
                    : Image.file(imageFile!, fit: BoxFit.fill),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onEditingComplete: () => FocusScope.of(context).requestFocus(_emailFocusNode),
      keyboardType: TextInputType.name,
      controller: _nameController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid name or company';
        } else {
          return null;
        }
      },
      style: Style.textFormField,
      decoration: const InputDecoration(
        hintText: 'Name or company',
        hintStyle: Style.textFormFieldHint,
        errorStyle: Style.textError,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.defaultColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Style.defaultColor),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.errorColor),
        ),
      ),
    );
  }

  Widget _emailFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onEditingComplete: () => FocusScope.of(context).requestFocus(_passwordFocusNode),
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Please enter a valid email address';
        } else {
          return null;
        }
      },
      style: Style.textFormField,
      decoration: const InputDecoration(
        hintText: 'Email',
        hintStyle: Style.textFormFieldHint,
        errorStyle: Style.textError,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.defaultColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.defaultColor),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.errorColor),
        ),
      ),
    );
  }

  Widget _passwordFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onEditingComplete: () => FocusScope.of(context).requestFocus(_passwordFocusNode),
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordController,
      obscureText: !_obscureText,
      validator: (value) {
        if (value!.isEmpty || value.length < 7) {
          return 'Please enter a valid password (min 7 characters)';
        } else {
          return null;
        }
      },
      style: Style.textFormField,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color:  Style.defaultColor,
          ),
        ),
        hintText: 'Password',
        hintStyle: Style.textFormFieldHint,
        errorStyle: Style.textError,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Style.defaultColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Style.defaultColor),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color:Style.errorColor),
        ),
      ),
    );
  }

  Widget _phoneFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onEditingComplete: () => FocusScope.of(context).requestFocus(_locationFocusNode),
      keyboardType: TextInputType.phone,
      controller: _phoneController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid phone nubmer';
        } else {
          return null;
        }
      },
      style: Style.textFormField,
      decoration: const InputDecoration(
        hintText: 'Phone number',
        hintStyle: Style.textFormFieldHint,
        errorStyle: Style.textError,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.defaultColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.defaultColor),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.errorColor),
        ),
      ),
    );
  }

  Widget _locationFormField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onEditingComplete: () => FocusScope.of(context).requestFocus(_locationFocusNode),
      keyboardType: TextInputType.text,
      controller: _locationController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid address';
        } else {
          return null;
        }
      },
      style: Style.textFormField,
      decoration: const InputDecoration(
        hintText: 'Personal or company address',
        hintStyle: Style.textFormFieldHint,
        errorStyle: Style.textError,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.defaultColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Style.defaultColor),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Style.errorColor),
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

  Widget _signUpButton() {
    return MaterialButton(
      onPressed: () {}, // CREATE SUBMIT FORM ON SIGNUP
      elevation: Layout.appElevation,
      color: Style.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Layout.appRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.all(Layout.appPadding),
            child: Text(
              'Sign up',
              style: Style.button,
            ),
          ),
        ],
      ),
    );
  }

  Widget _haveAccount() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: 'Already have an account?',
              style: Style.textDefault,
            ),
            const TextSpan(text: '     '),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.canPop(context) ? Navigator.pop(context) : null,
              text: 'Login',
              style: Style.textButtonLarge,
            ),
          ],
        ),
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
                      padding: EdgeInsets.all(Layout.appPadding / 2),
                      child: Icon(
                        Icons.camera,
                        color: Style.primaryColor,
                      ),
                    ),
                    Text(
                      '  Camera',
                      style: Style.textDialog,
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
                      padding: EdgeInsets.all(Layout.appPadding / 2),
                      child: Icon(
                        Icons.image,
                        color: Style.primaryColor,
                      ),
                    ),
                    Text(
                      '  Gallery',
                      style: Style.textDialog,
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
}
