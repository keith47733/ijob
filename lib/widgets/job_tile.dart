import 'package:flutter/material.dart';

import '../styles/clr.dart';
import '../styles/layout.dart';
import "../styles/txt.dart";

class JobTile extends StatefulWidget {
  final String jobID;
  final String jobTitle;
  final String jobDesc;
  final String uploadedBy;
  final String contactName;
  final String contactImage;
  final String contactEmail;
  final String jobLocation;
  final bool recruiting;

  const JobTile({
    required this.jobID,
    required this.jobTitle,
    required this.jobDesc,
    required this.uploadedBy,
    required this.contactName,
    required this.contactImage,
    required this.contactEmail,
    required this.jobLocation,
    required this.recruiting,
  });

  @override
  State<JobTile> createState() => _JobTileState();
}

class _JobTileState extends State<JobTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: layout.padding / 2,
        bottom: layout.padding / 2,
        left: 0,
        right: 0,
      ),
      child: Card(
        elevation: layout.elevation,
        color: clr.card,
        child: ListTile(
          onTap: () {},
          onLongPress: () {},
          contentPadding: const EdgeInsets.all(layout.padding / 2),
          leading: Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(width: 1),
              ),
            ),
            child: Image.network(
              widget.contactImage,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: layout.padding / 4),
            child: Text(
              widget.jobTitle,
              style: txt.subTitleDark,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: layout.padding / 4),
                child: Text(
                  widget.contactName,
                  style: txt.body2Dark,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: layout.padding / 4),
                child: Text(
                  widget.jobDesc,
                  style: txt.body1Dark,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: clr.dark,
            size: layout.iconMedium,
          ),
        ),
      ),
    );
  }
}
