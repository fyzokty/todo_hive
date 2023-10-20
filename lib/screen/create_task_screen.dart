import 'package:flutter/material.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  bool isFavorited = false;
  DateTime? alertDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
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
                onTap: () {},
                child: const ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Süre Ekle'),
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
    );
  }
}
