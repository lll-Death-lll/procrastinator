import 'package:dropdown_button2/dropdown_button2.dart';
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<SortTasksBy>(
            customButton: widget.icon,
            dropdownStyleData: DropdownStyleData(
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey[900],
              ),
            ),
            items: const [
              DropdownMenuItem<SortTasksBy>(
                  value: SortTasksBy.id,
                  child: Text(
                    "id",
                    style: TextStyle(color: Colors.white),
                  )),
              DropdownMenuItem<SortTasksBy>(
                  value: SortTasksBy.name,
                  child: Text(
                    "name",
                    style: TextStyle(color: Colors.white),
                  )),
              DropdownMenuItem<SortTasksBy>(
                  value: SortTasksBy.priority,
                  child: Text(
                    "priority",
                    style: TextStyle(color: Colors.white),
                  )),
              DropdownMenuItem<SortTasksBy>(
                  value: SortTasksBy.urgency,
                  child: Text(
                    "urgency",
                    style: TextStyle(color: Colors.white),
                  )),
              DropdownMenuItem<SortTasksBy>(
                  value: SortTasksBy.eta,
                  child: Text(
                    "eta",
                    style: TextStyle(color: Colors.white),
                  )),
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
            }),
      ),
    );
  }
}
