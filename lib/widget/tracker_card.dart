import 'package:flutter/material.dart';
import 'package:medicine_reminder/config/text_styles.dart';
import 'package:medicine_reminder/model/event_calendar.dart';
import 'package:medicine_reminder/model/medication_reminder.dart';

class TrackerCard extends StatefulWidget {
  final MedicationReminder medicationReminder;
  const TrackerCard({super.key, required this.medicationReminder});

  @override
  State<TrackerCard> createState() => _TrackerCardState();
}

class _TrackerCardState extends State<TrackerCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(widget.medicationReminder.imageUrl ?? ''),
        title: Text(
          widget.medicationReminder.medicationName,
          style: TextStyles.medium,
        ),
        subtitle: Text(widget.medicationReminder.note ?? ''),
        trailing: widget.medicationReminder.isDone ?? false
            ? IconButton(
                onPressed: () {},
                icon: const Icon(Icons.check_box),
              )
            : IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.check_box_outline_blank,
                ),
              ),
      ),
    );
  }
}
