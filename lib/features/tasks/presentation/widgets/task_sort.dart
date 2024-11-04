import 'package:flutter/material.dart';
import 'package:procrastinator/features/tasks/domain/sort_tasks_by.dart';

class TaskSort extends StatefulWidget {
  final Widget? icon;
  final Function(SortTasksBy sorting)? onChanged;
  const TaskSort({super.key, this.onChanged, this.icon});

  @override
  State<TaskSort> createState() => _TaskSortState();
}

class _TaskSortState extends State<TaskSort> {
  SortTasksBy sorting = SortTasksBy.id;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<SortTasksBy>(
        icon: widget.icon,
        items: const [
          DropdownMenuItem<SortTasksBy>(
              value: SortTasksBy.id, child: Text("id")),
          DropdownMenuItem<SortTasksBy>(
              value: SortTasksBy.name, child: Text("name")),
          DropdownMenuItem<SortTasksBy>(
              value: SortTasksBy.priority, child: Text("priority")),
          DropdownMenuItem<SortTasksBy>(
              value: SortTasksBy.urgency, child: Text("urgency")),
          DropdownMenuItem<SortTasksBy>(
              value: SortTasksBy.eta, child: Text("eta")),
        ],
        onChanged: (value) {
          setState(() {
            if (value != null && sorting != value) {
              sorting = value;
              if (widget.onChanged != null) {
                widget.onChanged!(sorting);
              }
            }
          });
        });
  }
}
