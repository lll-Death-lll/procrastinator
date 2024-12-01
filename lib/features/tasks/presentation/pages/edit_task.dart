import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:procrastinator/core/widgets/dropdown_select.dart';
import 'package:procrastinator/core/widgets/hovered_text_field.dart';
import 'package:procrastinator/features/tasks/domain/task_category.dart';
import 'package:procrastinator/features/tasks/domain/task_priority.dart';
import 'package:procrastinator/features/tasks/domain/task_urgency.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';

class EditTask extends StatefulWidget {
  final Function(Task task) onEdit;
  final Function() onDelete;
  final Task editTask;
  const EditTask(
      {super.key,
      required this.onEdit,
      required this.editTask,
      required this.onDelete});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final etaController = TextEditingController();
  String? taskName;
  late Priority taskPriority;
  late Urgency taskUrgency;
  late Category taskCategory;
  String? taskDescription;
  int? taskETA;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.editTask.name;
    descriptionController.text = widget.editTask.description ?? '';
    etaController.text = widget.editTask.eta.toString() != 'null'
        ? widget.editTask.eta.toString()
        : '';
    taskPriority = widget.editTask.priority;
    taskUrgency = widget.editTask.urgency;
    taskCategory = widget.editTask.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit task',
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

          Task newTask = widget.editTask;
          newTask.name = nameController.text;
          newTask.description = descriptionController.text.isNotEmpty
              ? descriptionController.text
              : null;
          newTask.category = taskCategory;
          newTask.priority = taskPriority;
          newTask.urgency = taskUrgency;
          newTask.eta = etaController.text.isNotEmpty
              ? int.parse(etaController.text.trim())
              : null;

          widget.onEdit(newTask);

          Navigator.pop(context);
        },
        label: const Text(
          'Save',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.save,
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
                const SizedBox(height: 20),
                IconButton(
                    onPressed: () {
                      widget.onDelete();

                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
