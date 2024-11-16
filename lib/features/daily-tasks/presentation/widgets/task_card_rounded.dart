import 'package:flutter/material.dart';
import 'package:procrastinator/core/util/text_format.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/category_icon.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/priority_icon.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/urgency_icon.dart';

class TaskCardRounded extends StatelessWidget {
  final Task task;
  final bool isSelected;

  final Function(bool isCompleted)? onCheck;

  final int? maxTextLength;

  const TaskCardRounded(
      {super.key,
      required this.task,
      required this.isSelected,
      this.onCheck,
      this.maxTextLength});

  @override
  Widget build(BuildContext context) {
    const defaultTextLength = 20;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
            value: isSelected,
            shape: const CircleBorder(),
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
          ],
        ),
      ],
    );
  }
}
