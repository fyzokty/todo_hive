import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<DateTime?> showAdaptiveDatePicker(BuildContext context,
    {required DateTime firstDate, required DateTime lastDate, required DateTime initialDate}) async {
  DateTime? dateTime;
  if (Platform.isIOS) {
    dateTime = await showCupertinoModalPopup<DateTime?>(
      context: context,
      builder: (context) => IOSDatePicker(
        firstDate: firstDate,
        lastDate: lastDate,
        initialDate: initialDate,
      ),
    );
  } else {
    await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      currentDate: DateTime.now(),
    ).then(
      (tmpDate) async {
        if (tmpDate != null) {
          await showTimePicker(context: context, initialTime: TimeOfDay.now()).then(
            (tmpTime) {
              if (tmpTime != null) {
                dateTime = DateTime(tmpDate.year, tmpDate.month, tmpDate.day, tmpTime.hour, tmpTime.minute);
              }
            },
          );
        }
      },
    );
  }
  return dateTime;
}

class IOSDatePicker extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? initialDate;
  const IOSDatePicker({super.key, required this.firstDate, required this.lastDate, this.initialDate});

  @override
  State<IOSDatePicker> createState() => _IOSDatePickerState();
}

class _IOSDatePickerState extends State<IOSDatePicker> {
  DateTime? selectedDate;
  late DateTime now;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      height: 320,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
                child: const Text('İptal'),
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop(selectedDate);
                },
                child: const Text('Tamam'),
              )
            ],
          ),
          Expanded(
            child: CupertinoDatePicker(
              minimumDate: widget.firstDate,
              maximumDate: widget.lastDate,
              initialDateTime: widget.initialDate,
              mode: CupertinoDatePickerMode.dateAndTime,
              use24hFormat: true,
              dateOrder: DatePickerDateOrder.dmy,
              showDayOfWeek: false,
              onDateTimeChanged: (value) {
                selectedDate = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
