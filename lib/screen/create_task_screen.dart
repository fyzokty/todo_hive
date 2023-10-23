import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:todo/model/app_enum.dart';
import 'package:todo/model/reminder_model.dart';
import 'package:todo/service/photo_picker.dart';
import 'package:todo/widget/date_picker.dart';
import 'package:uuid/v1.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  List<XFile> selectedFiles = [];
  TaskColor taskColor = TaskColor.DEFAULT;

  bool isFavorited = false;
  DateTime? alertDate;

  @override
  Widget build(BuildContext context) {
    return ChildBuilder(
      color: taskColor,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: const Text('Yeni Görev Ekle'),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isFavorited = !isFavorited;
                });
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  Animation<double> d = Tween<double>(begin: 0.6, end: 1).animate(animation);
                  return FadeTransition(opacity: d, child: ScaleTransition(scale: d, child: child));
                },
                child: isFavorited
                    ? const Icon(
                        Icons.star_rounded,
                        key: ValueKey('fav'),
                      )
                    : const Icon(
                        Icons.star_border_rounded,
                        key: ValueKey('unfav'),
                      ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextField(
                    controller: titleController,
                    maxLength: 30,
                    style: Theme.of(context).textTheme.headlineSmall,
                    decoration: const InputDecoration(
                      counter: SizedBox(),
                      helperText: 'Maksimum 30 karakterden oluşmalıdır',
                      border: InputBorder.none,
                      hintText: 'Başlık',
                      contentPadding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                    ),
                  ),
                ),
              ),
              Card(
                child: Column(
                  children: [
                    TextField(
                      controller: noteController,
                      maxLines: 4,
                      minLines: 1,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Not',
                        contentPadding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                      ),
                    ),
                    SizedBox(
                      height: selectedFiles.isNotEmpty ? 160 : 0,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedFiles.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 20),
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 160,
                            width: 160,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Theme.of(context).cardColor,
                                      boxShadow: const [
                                        BoxShadow(offset: Offset(3, 3), blurRadius: 4, spreadRadius: 0),
                                      ],
                                    ),
                                    foregroundDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      image: DecorationImage(
                                          image: FileImage(File(selectedFiles[index].path)), fit: BoxFit.cover, alignment: Alignment.topCenter),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: -5,
                                  top: -5,
                                  child: IconButton.filledTonal(
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                    icon: const Icon(Icons.clear_rounded),
                                    onPressed: () {
                                      selectedFiles.removeAt(index);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () async {
                            selectedFiles = await PhotoPicker.pickMultiImage();
                            setState(() {});
                          },
                          icon: const Icon(Icons.image_outlined),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: datePickerOnTap,
                  child: alertDate != null
                      ? ListTile(
                          title: Text(DateFormat('dd MMMM yyyy HH:mm').format(alertDate!)),
                          leading: const Icon(Icons.calendar_today),
                          trailing: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () {
                              alertDate = null;
                              setState(() {});
                            },
                            child: const Icon(Icons.clear_rounded),
                          ),
                        )
                      : const ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text('Süre Ekle'),
                        ),
                ),
              ),
              Card(
                child: SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: TaskColor.values
                          .map((item) => GestureDetector(
                                onTap: () {
                                  if (taskColor != item) {
                                    setState(() {
                                      taskColor = item;
                                    });
                                  }
                                },
                                child: AnimatedContainer(
                                  height: 20,
                                  width: 20,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.fastOutSlowIn,
                                  decoration: BoxDecoration(
                                    color: item.color,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.outlineVariant,
                                      width: taskColor == item ? 2 : 0,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Center(child: Text('Kaydet')),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> datePickerOnTap() async {
    final now = DateTime.now();
    final firstDate = now;
    final lastDate = now.add(const Duration(days: 365));
    await showAdaptiveDatePicker(context, firstDate: firstDate, lastDate: lastDate, initialDate: alertDate ?? now).then((value) {
      if (value != null) {
        alertDate = value;
        setState(() {});
      }
    });
  }

  Future<void> saveOnTap() async {
    ReminderModel model;
    model = ReminderModel(
      id: const UuidV1().generate(),
      title: titleController.text,
      text: noteController.text,
      imgPaths: selectedFiles.map((e) => e.path).toList(),
      createDate: DateTime.now(),
      isFavorited: isFavorited,
      alertDate: alertDate,
      color: taskColor,
    );
  }
}

class ChildBuilder extends StatelessWidget {
  final Widget child;
  final TaskColor color;
  const ChildBuilder({super.key, required this.child, this.color = TaskColor.DEFAULT});

  @override
  Widget build(BuildContext context) {
    if (TaskColor.DEFAULT == color) {
      return child;
    } else {
      return AnimatedTheme(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        data: ThemeData.from(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: color.color, brightness: MediaQuery.of(context).platformBrightness),
        ),
        child: child,
      );
    }
  }
}
