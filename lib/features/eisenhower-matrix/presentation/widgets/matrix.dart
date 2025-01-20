import 'dart:math';

import 'package:flutter/material.dart';
import 'package:procrastinator/features/eisenhower-matrix/presentation/widgets/clear_task_list.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';

class Matrix extends StatelessWidget {
  final List<Task> tasksUrgentImportant;
  final List<Task> tasksNotUrgentImportant;
  final List<Task> tasksUrgentUnimportant;
  final List<Task> tasksNotUrgentUnimportant;

  const Matrix(
      {super.key,
      required this.tasksUrgentImportant,
      required this.tasksNotUrgentImportant,
      required this.tasksUrgentUnimportant,
      required this.tasksNotUrgentUnimportant});

  @override
  Widget build(BuildContext context) {
    // todo Add text on the sides or colors/icons
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(builder: (context, constraints) {
        var maxWidth = constraints.maxWidth;
        var maxHeight = constraints.maxHeight;
        return Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: List.generate(9, (index) {
            var labelRows = [0, 1, 2];
            var labelCols = [2, 5, 8];

            bool isLabelRow = labelRows.contains(index);
            bool isLabelCol = labelCols.contains(index);

            var fontSize = min(maxHeight, maxWidth) / 24;

            var labelHeight = fontSize * 2;

            double width =
                (isLabelCol ? labelHeight : ((maxWidth - labelHeight) / 2)) - 4;
            double height =
                (isLabelRow ? labelHeight : ((maxHeight - labelHeight) / 2)) -
                    4;

            List<Widget> widgets = [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Urgent",
                    style: TextStyle(color: Colors.white, fontSize: fontSize),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Important",
                    style: TextStyle(color: Colors.white, fontSize: fontSize),
                  ),
                ],
              ),
              Container(),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                child: ClearTaskList(
                  tasks: tasksUrgentImportant,
                  onCheck: (id, isCompleted) {},
                  onDelete: (id) {},
                  onUpdate: (id, task) {},
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                child: ClearTaskList(
                  tasks: tasksNotUrgentImportant,
                  onCheck: (id, isCompleted) {},
                  onDelete: (id) {},
                  onUpdate: (id, task) {},
                ),
              ),
              RotatedBox(
                quarterTurns: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Non-urgent",
                      style: TextStyle(color: Colors.white, fontSize: fontSize),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                child: ClearTaskList(
                  tasks: tasksUrgentUnimportant,
                  onCheck: (index, isCompleted) {},
                  onDelete: (index) {},
                  onUpdate: (index, task) {},
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                child: ClearTaskList(
                  tasks: tasksNotUrgentUnimportant,
                  onCheck: (index, isCompleted) {},
                  onDelete: (index) {},
                  onUpdate: (index, task) {},
                ),
              ),
              RotatedBox(
                quarterTurns: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Unimportant",
                      style: TextStyle(color: Colors.white, fontSize: fontSize),
                    ),
                  ],
                ),
              ),
            ];

            return SizedBox(
              width: width,
              height: height,
              child: Container(
                child: widgets[index],
              ),
            );
          }),
        );
      }),
    );

    // return AspectRatio(
    //   aspectRatio: 1 / 1,
    //   child: GridView.count(
    //     crossAxisCount: 3,
    //     primary: false,
    //     padding: EdgeInsets.all(16),
    //     shrinkWrap: false,
    //     children: [
    //       Row(
    //         crossAxisAlignment: CrossAxisAlignment.end,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 16.0),
    //             child: Text(
    //               "Urgent",
    //               style: TextStyle(color: Colors.white, fontSize: 32),
    //             ),
    //           ),
    //         ],
    //       ),
    //       Row(
    //         crossAxisAlignment: CrossAxisAlignment.end,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 16.0),
    //             child: Text(
    //               "Important",
    //               style: TextStyle(color: Colors.white, fontSize: 32),
    //             ),
    //           ),
    //         ],
    //       ),
    //       Container(),
    //       Container(
    //         padding: const EdgeInsets.all(8.0),
    //         decoration: BoxDecoration(border: Border.all(color: Colors.white)),
    //         child: ClearTaskList(
    //           tasks: tasksUrgentImportant,
    //           onCheck: (id, isCompleted) {},
    //           onDelete: (id) {},
    //           onUpdate: (id, task) {},
    //         ),
    //       ),
    //       Container(
    //         padding: const EdgeInsets.all(8.0),
    //         decoration: BoxDecoration(border: Border.all(color: Colors.white)),
    //         child: ClearTaskList(
    //           tasks: tasksNotUrgentImportant,
    //           onCheck: (id, isCompleted) {},
    //           onDelete: (id) {},
    //           onUpdate: (id, task) {},
    //         ),
    //       ),
    //       RotatedBox(
    //         quarterTurns: 1,
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.end,
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 16.0),
    //               child: Text(
    //                 "Non-urgent",
    //                 style: TextStyle(color: Colors.white, fontSize: 32),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Container(
    //         padding: const EdgeInsets.all(8.0),
    //         decoration: BoxDecoration(border: Border.all(color: Colors.white)),
    //         child: ClearTaskList(
    //           tasks: tasksUrgentUnimportant,
    //           onCheck: (index, isCompleted) {},
    //           onDelete: (index) {},
    //           onUpdate: (index, task) {},
    //         ),
    //       ),
    //       Container(
    //         padding: const EdgeInsets.all(8.0),
    //         decoration: BoxDecoration(border: Border.all(color: Colors.white)),
    //         child: ClearTaskList(
    //           tasks: tasksNotUrgentUnimportant,
    //           onCheck: (index, isCompleted) {},
    //           onDelete: (index) {},
    //           onUpdate: (index, task) {},
    //         ),
    //       ),
    //       RotatedBox(
    //         quarterTurns: 1,
    //         child: Padding(
    //           padding: EdgeInsets.fromLTRB(32.0, 0, 0, 16.0),
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.end,
    //             children: [
    //               Text(
    //                 "Unimportant",
    //                 style: TextStyle(color: Colors.white, fontSize: 32),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
