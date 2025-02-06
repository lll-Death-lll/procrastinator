import 'package:flutter/material.dart';
import 'package:procrastinator/features/tasks/presentation/pages/edit_task.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';

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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: task.completedAt != null,
                side: const BorderSide(color: Colors.white),
                onChanged: (value) {
                  if (value != null && onCheck != null) {
                    onCheck!(value);
                  }
                }),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                task.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
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
    );
  }
}
