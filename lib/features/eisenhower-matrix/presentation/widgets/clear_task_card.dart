import 'package:flutter/material.dart';
import 'package:procrastinator/core/util/text_format.dart';
import 'package:procrastinator/features/tasks/presentation/pages/edit_task.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/category_icon.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/priority_icon.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/urgency_icon.dart';

class ClearTaskCard extends StatelessWidget {
  final Task task;

  final Function(bool isCompleted)? onCheck;
  final Function(Task task)? onUpdate;
  final Function()? onDelete;

  final int? maxTextLength;

  const ClearTaskCard(
      {super.key,
      required this.task,
      this.onCheck,
      this.onUpdate,
      this.onDelete,
      this.maxTextLength});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
            value: task.completedAt != null,
            side: const BorderSide(color: Colors.white),
            onChanged: (value) {
              if (value != null && onCheck != null) {
                onCheck!(value);
              }
            }),
        Expanded(
          flex: 9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                getETA(task.eta),
                style: const TextStyle(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Row(
          children: [
            IntrinsicHeight(
              child: VerticalDivider(
                color: Colors.grey[600],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              color: Colors.grey[800],
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditTask(
                              onEdit: (task) {
                                if (onUpdate != null) {
                                  onUpdate!(task);
                                }
                              },
                              editTask: task,
                              onDelete: () {
                                if (onDelete != null) {
                                  onDelete!();
                                }
                              },
                            )));
              },
            ),
          ],
        ),
      ],
    );
  }
}
