import 'package:flutter/material.dart';

import '../../widgets/box_decoration_gradient.dart';
import '../../styles/clr.dart';
import '../../styles/layout.dart';
import '../../styles/txt.dart';

class SearchJobs extends StatefulWidget {
  @override
  State<SearchJobs> createState() => _SearchJobsState();
}

class _SearchJobsState extends State<SearchJobs> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: BoxDecorationGradient(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: layout.elevation,
            flexibleSpace: Container(
              decoration: BoxDecorationGradient(),
            ),
            title: const Text(
              'Search Jobs',
              style: txt.appBarTitle,
            ),
          ),
        ),
      ),
    );
  }
}
