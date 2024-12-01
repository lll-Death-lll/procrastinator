import 'package:flutter/material.dart';
import 'package:procrastinator/core/util/text_format.dart';
import 'package:procrastinator/features/tasks/presentation/pages/edit_task.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/category_icon.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/priority_icon.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/urgency_icon.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  final Function(bool isCompleted)? onCheck;
  final Function(Task task)? onUpdate;
  final Function()? onDelete;

  final int? maxTextLength;

  const TaskCard(
      {super.key,
      required this.task,
      this.onCheck,
      this.onUpdate,
      this.onDelete,
      this.maxTextLength});

  @override
  Widget build(BuildContext context) {
    const defaultTextLength = 20;
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cutText(task.name, maxTextLength ?? defaultTextLength),
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              cutText(
                  task.description ?? '', maxTextLength ?? defaultTextLength),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        Expanded(child: Container()),
        Row(
          children: [
            Text(getETA(task.eta), style: const TextStyle(color: Colors.white)),
            IntrinsicHeight(
              child: VerticalDivider(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(
              width: 0,
            ),
            CategoryIcon(task: task),
            const SizedBox(
              width: 5,
            ),
            PriorityIcon(task: task),
            const SizedBox(
              width: 5,
            ),
            UrgencyIcon(task: task),
            const SizedBox(
              width: 10,
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
