import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:procrastinator/core/widgets/dropdown_select.dart';
import 'package:procrastinator/core/widgets/hovered_text_field.dart';
import 'package:procrastinator/features/tasks/data/data_sources/task.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/domain/task_category.dart';
import 'package:procrastinator/features/tasks/domain/task_priority.dart';
import 'package:procrastinator/features/tasks/domain/task_urgency.dart';

class AddTask extends StatefulWidget {
  final Function(Task task) onAdd;
  const AddTask({super.key, required this.onAdd});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final etaController = TextEditingController();
  String? taskName;
  Priority taskPriority = Priority.medium;
  Urgency taskUrgency = Urgency.medium;
  Category taskCategory = Category.other;
  String? taskDescription;
  int? taskETA;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add task',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.grey[850],
      floatingActionButton: TextButton.icon(
        onPressed: () {
          if (nameController.text.isEmpty) {
            return;
          }

          Task newTask = Task(
              id: getNewId(),
              name: nameController.text,
              description: descriptionController.text.isNotEmpty
                  ? descriptionController.text
                  : null,
              category: taskCategory,
              priority: taskPriority,
              urgency: taskUrgency,
              eta: etaController.text.isNotEmpty
                  ? int.parse(etaController.text.trim())
                  : null,
              createdAt: DateTime.now());

          widget.onAdd(newTask);

          Navigator.pop(context);
        },
        label: const Text(
          'Add',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        style: TextButton.styleFrom(backgroundColor: Colors.deepPurple),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Name', style: TextStyle(color: Colors.white)),
                    HoveredTextField(
                        textField: TextField(
                            controller: nameController,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                hintText: 'Configure VPS server',
                                hintStyle: TextStyle(
                                  color: Colors.grey[700],
                                ))),
                        hoveredBorder: Colors.white),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Priority',
                                style: TextStyle(color: Colors.white)),
                            DropdownSelect(
                              values: Priority.values,
                              onChanged: (value) => {
                                setState(() {
                                  taskPriority = value;
                                })
                              },
                              defaultVariant: taskPriority,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Urgency',
                                style: TextStyle(color: Colors.white)),
                            DropdownSelect(
                              values: Urgency.values,
                              onChanged: (value) => {
                                setState(() {
                                  taskUrgency = value;
                                })
                              },
                              defaultVariant: taskUrgency,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Category',
                                style: TextStyle(color: Colors.white)),
                            DropdownSelect(
                              values: Category.values,
                              onChanged: (value) => {
                                setState(() {
                                  taskCategory = value;
                                })
                              },
                              defaultVariant: taskCategory,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      child: Text(
                        'Description',
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    HoveredTextField(
                        textField: TextField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            controller: descriptionController,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                hintText: 'Do A, B and then C',
                                hintStyle: TextStyle(
                                  color: Colors.grey[700],
                                ))),
                        hoveredBorder: Colors.white)
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Time to complete (minutes)',
                        style: TextStyle(color: Colors.white)),
                    HoveredTextField(
                        textField: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: etaController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              hintText: '30',
                              hintStyle: TextStyle(
                                color: Colors.grey[700],
                              )),
                        ),
                        hoveredBorder: Colors.white)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
