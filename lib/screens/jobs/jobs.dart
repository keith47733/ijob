import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ijob/screens/search/search_jobs.dart';
import 'package:ijob/widgets/job_tile.dart';

import '../../services/global_variables.dart';
import '../../styles/clr.dart';
import '../../styles/layout.dart';
import '../../styles/txt.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/box_decoration_gradient.dart';

class Jobs extends StatefulWidget {
  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  String? jobCategoryFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationGradient(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              decoration: boxDecorationGradient(),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: jobCategoryFilter != null
                ? Text(
                    jobCategoryFilter.toString(),
                    style: txt.body2Dark,
                  )
                : const Text(
                    "All Jobs",
                    style: txt.body2Dark,
                  ),
            leading: IconButton(
              onPressed: () {
                _showJobCategoriesDialog();
              },
              icon: const Icon(
                Icons.business,
                color: clr.primary,
                size: layout.iconMedium,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SearchJobs())));
                },
                icon: const Icon(Icons.search, color: clr.primary, size: layout.iconMedium),
              ),
            ]),
        bottomNavigationBar: BottomNavBar(navIndex: 0),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('jobs')
              .where('category', isEqualTo: jobCategoryFilter)
              .where('recruiting', isEqualTo: true)
              .orderBy('created_at', descending: false)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data?.docs.isNotEmpty == true) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 0,
                    bottom: layout.padding,
                    left: layout.padding,
                    right: layout.padding,
                  ),
                  child: ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return JobTile(
                          jobID: snapshot.data.docs[index]['job_id'],
                          jobTitle: snapshot.data.docs[index]['title'],
                          jobDesc: snapshot.data.docs[index]['desc'],
                          uploadedBy: snapshot.data.docs[index]['user_id'],
                          contactName: snapshot.data.docs[index]['user_name'],
                          contactImage: snapshot.data.docs[index]['user_image'],
                          contactEmail: snapshot.data.docs[index]['user_email'],
                          jobLocation: snapshot.data.docs[index]['location'],
                          recruiting: snapshot.data.docs[index]['recruiting'],
                        );
                      }),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(layout.padding * 6),
                  child: Center(
                    child: Image.asset('assets/images/empty.png'),
                  ),
                );
              }
            } else {
              return Center(
                child: Text(
                  'FATAL ERROR',
                  style: txt.error,
                ),
              );
            }
          },
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
                      jobCategoryFilter = jobCategories[index];
                    });
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: index != jobCategories.length - 1 ? layout.padding : 0,
                    ),
                    child: Row(children: [
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
                    ]),
                  ),
                );
              }),
            ),
          ),
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              InkWell(
                onTap: () {
                  setState(() {
                    jobCategoryFilter = null;
                  });
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: layout.padding,
                    bottom: layout.padding * 2,
                  ),
                  child: Row(children: [
                    Icon(
                      Icons.clear_all,
                      color: clr.passiveLight,
                      size: layout.iconSmall,
                    ),
                    const Text(
                      ' Clear Filter',
                      style: txt.body1Light,
                    ),
                  ]),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                InkWell(
                  onTap: () {
                    // setState(() {
                    //   jobCategoryFilter = null;
                    // });
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: layout.padding,
                      bottom: layout.padding * 2,
                    ),
                    child: Row(children: [
                      Icon(
                        Icons.close,
                        color: clr.passiveLight,
                        size: layout.iconSmall,
                      ),
                      const Text(
                        ' Close',
                        style: txt.button,
                      ),
                    ]),
                  ),
                ),
              ]),
            ]),
          ],
        );
      },
    );
  }
}
