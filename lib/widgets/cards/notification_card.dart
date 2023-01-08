import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_duty/design/app_colors.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({Key? key, required this.notification}) : super(key: key);
  final Map<String, dynamic> notification;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  final _notifications = FirebaseFirestore.instance.collection('notifications');
  bool _isExpanded = false;

  void makeRead() async {
    Future.delayed(const Duration(seconds: 3), () => {
      _notifications.doc(widget.notification["uid"]).update({"isRead": true}),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 24),
      child: ExpansionPanelList(
        elevation: 1,
        animationDuration: const Duration(milliseconds: 500),
        expandedHeaderPadding: const EdgeInsets.all(0),
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            _isExpanded = !isExpanded;
          });
          if(_isExpanded) {
            makeRead();
          }
        },
        children: <ExpansionPanel>[
          ExpansionPanel(
            backgroundColor: widget.notification["isRead"] ? AppColors.lightSecondary : AppColors.lightGrey,
            headerBuilder: (context, isExpanded) {
              return ListTile(
                leading: const Icon(Icons.task_alt_outlined),
                title: Text(widget.notification["title"]),
                subtitle: Text("${widget.notification["senderUser"]["firstName"]} ${widget.notification["senderUser"]["lastName"]}"),
              );
            },
            body: Container(
              // color: Colors.red,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.notification["description"],
                    style: TextStyle(color: ThemeData.light().textTheme.bodySmall?.color),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "${DateFormat.yMd("tr").format(widget.notification["createdAt"].toDate())} tarihinde görev tamamlanmıştır",
                    style: TextStyle(color: ThemeData.light().textTheme.bodySmall?.color?.withOpacity(0.3)),
                  )
                ],
              ),
            ),
            isExpanded: _isExpanded,
            canTapOnHeader: true,
          ),
        ],
      ),
    );
  }
}