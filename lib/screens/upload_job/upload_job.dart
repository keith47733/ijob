import 'package:flutter/material.dart';

import '../../styles/clr.dart';
import '../../styles/layout.dart';
import '../../styles/txt.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/box_decoration_gradient.dart';
import '../../widgets/main_app_bar.dart';

class UploadJob extends StatefulWidget {
  @override
  State<UploadJob> createState() => _UploadJobState();
}

class _UploadJobState extends State<UploadJob> {
  final _uploadJobFormKey = GlobalKey<FormState>();

  final TextEditingController _jobCategoryController = TextEditingController();
  final FocusNode _jobCategoryFocusNode = FocusNode();
  final TextEditingController _jobTitleController = TextEditingController();
  final FocusNode _jobTitleFocusNode = FocusNode();
  final TextEditingController _jobDescController = TextEditingController();
  final FocusNode _jobDescFocusNode = FocusNode();
  final TextEditingController _jobDeadlineController = TextEditingController();
  final FocusNode _jobDeadlineFocusNode = FocusNode();

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
            child: Card(
              elevation: layout.elevation,
              color: clr.card,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(layout.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: const EdgeInsets.symmetric(vertical: layout.padding),
                        child: Text(
                          'Job Description',
                          style: txt.titleDark,
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
    return TextFormField(
      enabled: true,
      focusNode: _jobCategoryFocusNode,
      autofocus: false,
      controller: _jobCategoryController,
      style: txt.fieldDark,
      maxLines: 1,
      maxLength: 100,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _jobTitleFocusNode.requestFocus(),
      decoration: const InputDecoration(
        labelText: 'Category',
        labelStyle: txt.labelDark,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: txt.floatingLabelDark,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.dark,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
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
      decoration: const InputDecoration(
        labelText: 'Title',
        labelStyle: txt.labelDark,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: txt.floatingLabelDark,
        // filled: true,
        // fillColor: clr.passive,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.dark,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
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
      onEditingComplete: () => _jobDeadlineFocusNode.requestFocus(),
      decoration: const InputDecoration(
        labelText: 'Description',
        labelStyle: txt.labelDark,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: txt.floatingLabelDark,
        // filled: true,
        // fillColor: clr.passive,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.dark,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
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
    return TextFormField(
      enabled: true,
      focusNode: _jobDeadlineFocusNode,
      autofocus: false,
      controller: _jobDeadlineController,
      style: txt.fieldDark,
      maxLines: 1,
      maxLength: 100,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onEditingComplete: () => _jobDeadlineFocusNode.unfocus(),
      decoration: const InputDecoration(
        labelText: 'Deadline',
        labelStyle: txt.labelDark,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: txt.floatingLabelDark,
        // filled: true,
        // fillColor: clr.passive,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: clr.dark,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
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
}
