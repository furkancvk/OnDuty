import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_duty/design/app_colors.dart';
import 'package:on_duty/design/app_text.dart';
import 'package:on_duty/models/task_model.dart';
import 'package:on_duty/widgets/buttons/custom_popup_menu_button.dart';
import 'package:on_duty/widgets/cards/info_card.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    Key? key,
    required this.task,
    required this.data,
    this.margin,
  }) : super(key: key);

  final TaskModel task;
  final List<Map<String, dynamic>> data;
  final EdgeInsetsGeometry? margin;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: widget.margin,
      decoration: BoxDecoration(
        color: AppColors.lightPrimary.withOpacity(0.04),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: setColor(widget.task.importance!),
                      radius: 9,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.task.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.contextSemiBold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(widget.task.description!, style: AppText.context),
                const SizedBox(height: 20),
                Row(
                  children: [
                    InfoCard(
                      icon: FluentIcons.calendar_ltr_24_regular,
                      text: DateFormat.yMd("tr").format(widget.task.dueDate!.toDate()),
                    ),
                    const SizedBox(width: 16),
                    InfoCard(
                      icon: FluentIcons.person_24_regular,
                      text: "${widget.task.user?.firstName} ${widget.task.user?.lastName}",
                    ),
                  ],
                ),
              ],
            ),
          ),
          CustomPopupMenuButton(
            data: widget.data,
            child: const Icon(
              FluentIcons.more_vertical_24_regular,
              color: AppColors.lightBlack,
            ),
          ),
        ],
      ),
    );
  }

  Color setColor(int level) {
    switch (level) {
      case 1:
        return AppColors.lightError;
      case 2:
        return AppColors.lightWarning;
      default:
        return AppColors.lightSuccess;
    }
  }

}
