import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class RequestDetailsInfoCard extends StatelessWidget {
  const RequestDetailsInfoCard({
    Key? key,
    required this.empname,
    required this.reqtype,
    required this.applicationtimeanddate,
    required this.description,
    required this.startdate,
    required this.enddate,
    required this.status,
  }) : super(key: key);

  final String empname, reqtype, description, startdate, enddate, status;
  final Timestamp applicationtimeanddate;

  @override
  Widget build(BuildContext context) {
    Timestamp t = applicationtimeanddate;
    DateTime date = t.toDate();
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          // SizedBox(
          //   height: 20,
          //   width: 20,
          //   child: SvgPicture.asset(svgSrc),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Employee Name  :    $empname",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Request Type :    $reqtype",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Application Time  :    ${DateFormat('yyyy-MM-dd   KK:mm:ss a').format(date)}  ",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Description  :    $description",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Text(
                  //   "Description :  $description",
                  //   // "$numOfFiles Requestssdkfalskjdlf",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .caption!
                  //       .copyWith(color: Colors.white70),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Start Date :    $startdate"),
                  SizedBox(
                    height: 15,
                  ),
                  Text("End Date  :      $enddate"),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Request Status :  $status"),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
