import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../../services/global_methods.dart';
import '../../services/global_variables.dart';
import '../../styles/clr.dart';
import '../../styles/layout.dart';
import '../../styles/txt.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/box_decoration_gradient.dart';
import '../../widgets/main_app_bar.dart';

class Upload extends StatefulWidget {
  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final _uploadJobFormKey = GlobalKey<FormState>();

  final TextEditingController _jobCategoryController = TextEditingController();
  final FocusNode _jobCategoryFocusNode = FocusNode();

  final TextEditingController _jobTitleController = TextEditingController();
  final FocusNode _jobTitleFocusNode = FocusNode();

  final TextEditingController _jobDescController = TextEditingController();
  final FocusNode _jobDescFocusNode = FocusNode();

  final TextEditingController _jobDeadlineController = TextEditingController();
  final FocusNode _jobDeadlineFocusNode = FocusNode();
  DateTime? selectedDeadline;
  Timestamp? deadlineDateTimeStamp;

  bool _isLoading = false;

  @override
  void dispose() {
    _jobCategoryController.dispose();
    _jobCategoryFocusNode.dispose();
    _jobTitleController.dispose();
    _jobTitleFocusNode.dispose();
    _jobDescController.dispose();
    _jobDescFocusNode.dispose();
    _jobDeadlineController.dispose();
    _jobDeadlineFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: BoxDecorationGradient(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: MainAppBar('Upload Job'),
          bottomNavigationBar: BottomNavBar(navIndex: 2),
          body: Padding(
            padding: const EdgeInsets.all(layout.padding),
            child: SingleChildScrollView(
              child: Card(
                elevation: layout.elevation,
                color: clr.card,
                child: Padding(
                  padding: const EdgeInsets.all(layout.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: layout.padding),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Job Description',
                            style: txt.titleDark,
                          ),
                        ),
                      ),
                      Form(
                        key: _uploadJobFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _jobCategoryFormField(),
                            _jobTitleFormField(),
                            _jobDescFormField(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: layout.padding),
                              child: _jobDeadlineFormField(),
                            ),
                          ],
                        ),
                      ),
                      _isLoading
                          ? const Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                top: 0,
                                bottom: layout.padding,
                                left: layout.padding,
                                right: layout.padding,
                              ),
                              child: _uploadJobButton(),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _jobCategoryFormField() {
    return GestureDetector(
      onTap: () {
        _showJobCategoriesDialog();
      },
      child: TextFormField(
        enabled: false,
        focusNode: _jobCategoryFocusNode,
        autofocus: false,
        controller: _jobCategoryController,
        style: txt.fieldDark,
        maxLines: 1,
        maxLength: 100,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => _jobTitleFocusNode.requestFocus(),
        decoration: InputDecoration(
          labelText: 'Select job category',
          labelStyle: txt.labelDark,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: txt.floatingLabelDark,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: clr.dark,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: clr.dark,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: clr.error,
            ),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Value is missing';
          }
          return null;
        },
      ),
    );
  }

  Widget _jobTitleFormField() {
    return TextFormField(
      enabled: true,
      focusNode: _jobTitleFocusNode,
      autofocus: false,
      controller: _jobTitleController,
      style: txt.fieldDark,
      maxLines: 1,
      maxLength: 100,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _jobDescFocusNode.requestFocus(),
      decoration: InputDecoration(
        labelText: 'Title',
        labelStyle: txt.labelDark,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: txt.floatingLabelDark,
        // filled: true,
        // fillColor: clr.passive,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.dark,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.dark,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.error,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Value is missing';
        }
        return null;
      },
    );
  }

  Widget _jobDescFormField() {
    return TextFormField(
      enabled: true,
      focusNode: _jobDescFocusNode,
      autofocus: false,
      controller: _jobDescController,
      style: txt.fieldDark,
      maxLines: 3,
      maxLength: 300,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _jobDescFocusNode.unfocus(),
      decoration: InputDecoration(
        labelText: 'Description',
        labelStyle: txt.labelDark,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: txt.floatingLabelDark,
        // filled: true,
        // fillColor: clr.passive,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.dark,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.dark,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.error,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Value is missing';
        }
        return null;
      },
    );
  }

  Widget _jobDeadlineFormField() {
    return GestureDetector(
      onTap: () {
        _selectDeadlineDialog();
      },
      child: TextFormField(
        enabled: false,
        focusNode: _jobDeadlineFocusNode,
        autofocus: false,
        controller: _jobDeadlineController,
        style: txt.fieldDark,
        maxLines: 1,
        maxLength: 100,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onEditingComplete: () => _jobDeadlineFocusNode.unfocus(),
        decoration: InputDecoration(
          labelText: 'Select deadline date',
          labelStyle: txt.labelDark,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: txt.floatingLabelDark,
          // filled: true,
          // fillColor: clr.passive,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: clr.dark,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: clr.dark,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: clr.error,
            ),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Value is missing';
          }
          return null;
        },
      ),
    );
  }

  Widget _uploadJobButton() {
    return MaterialButton(
      onPressed: () {
        _uploadJob();
      },
      elevation: layout.elevation,
      color: clr.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(layout.radius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(layout.padding * 0.75),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Upload Job   ',
              style: txt.button,
            ),
            Icon(
              Icons.upload_file,
              color: Colors.white,
              size: layout.iconMedium,
            ),
          ],
        ),
      ),
    );
  }

  _showJobCategoriesDialog() {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: Padding(
            padding: const EdgeInsets.only(
              top: layout.padding,
              bottom: layout.padding,
            ),
            child: Text(
              'Job Categories',
              textAlign: TextAlign.center,
              style: txt.titleLight.copyWith(color: clr.passiveLight),
            ),
          ),
          content: SizedBox(
            width: size.width * 0.9,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: jobCategories.length,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _jobCategoryController.text = jobCategories[index];
                      Navigator.pop(context);
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: index != jobCategories.length - 1 ? layout.padding : 0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.business,
                          color: clr.passiveLight,
                          size: 25.0,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: layout.padding * 1.25,
                            ),
                            child: Text(
                              jobCategories[index],
                              style: txt.body2Light.copyWith(color: clr.passiveLight),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    _jobCategoryController.text = '';
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: layout.padding,
                      bottom: layout.padding * 2,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.cancel,
                          color: clr.passiveLight,
                          size: layout.iconSmall,
                        ),
                        const Text(
                          ' Cancel',
                          style: txt.button,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _selectDeadlineDialog() async {
    selectedDeadline = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (selectedDeadline != null) {
      setState(
        () {
          _jobDeadlineController.text =
              '${selectedDeadline!.year} - ${selectedDeadline!.month} - ${selectedDeadline!.day}';
          deadlineDateTimeStamp = Timestamp.fromMicrosecondsSinceEpoch(selectedDeadline!.microsecondsSinceEpoch);
        },
      );
    } else {
      _jobDeadlineController.text = '';
      deadlineDateTimeStamp = null;
    }
  }

  void _uploadJob() async {
    final jobID = const Uuid().v4();
    User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    //final isValid = _uploadJobFormKey.currentState!.validate();

    // if (isValid) {
    if (_jobCategoryController.text == '' ||
        _jobTitleController.text == '' ||
        _jobDescController.text == '' ||
        _jobDeadlineController.text == '') {
      GlobalMethod.showErrorDialog(
        context: context,
        icon: Icons.error,
        iconColor: clr.error,
        title: 'Missing Information',
        body: 'Please enter all information about job.',
        buttonText: 'OK',
      );
      return;
      // }
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseFirestore.instance.collection('jobs').doc(jobID).set({
        'job_id': jobID,
        'created_at': Timestamp.now(),
        'user_id': uid,
        'user_image': userImage,
        'user_name': userName,
        'user_email': user.email,
        'location': userLocation,
        'category': _jobCategoryController.text,
        'title': _jobTitleController.text,
        'desc': _jobDescController.text,
        'deadline_date': _jobDeadlineController.text,
        'deadline_timestamp': deadlineDateTimeStamp,
        'recruiting': true,
        'applicants': 0,
        'comments': [],
      });
      await Fluttertoast.showToast(
        msg: 'The job has been successfully uploaded.',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black54,
        fontSize: txt.textSizeDefault,
      );

      setState(() {
        _jobCategoryController.clear();
        _jobTitleController.clear();
        _jobDescController.clear();
        _jobDeadlineController.clear();
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethod.showErrorDialog(
          context: context,
          icon: Icons.error,
          iconColor: clr.error,
          title: 'Error',
          body: error.toString(),
          buttonText: 'OK');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
