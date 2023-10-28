import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder/bloc/auth/auth_bloc.dart';
import 'package:medicine_reminder/bloc/event_calendar/event_calendar_bloc.dart';
import 'package:medicine_reminder/bloc/tracker/tracker_bloc.dart';
import 'package:medicine_reminder/config/color_palette.dart';
import 'package:medicine_reminder/config/text_styles.dart';
import 'package:medicine_reminder/config/util.dart';
import 'package:medicine_reminder/view/create_tracker_screen.dart';
import 'package:medicine_reminder/widget/tracker_card.dart';

class MedicationTrackerScreen extends StatefulWidget {
  const MedicationTrackerScreen({super.key});

  @override
  State<MedicationTrackerScreen> createState() =>
      _MedicationTrackerScreenState();
}

class _MedicationTrackerScreenState extends State<MedicationTrackerScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminder App"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitleCard(),
              buildDateTracker(),
              builderDetailDate(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateTrackerScreen(),
            ),
          );
        },
        child: const Icon(Icons.add, color: ColorPalette.blueBase,),
        backgroundColor: ColorPalette.blueLight,
      ),
    );
  }

  Widget buildTitleCard() {
    return const Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your medication tracker",
              style: TextStyles.semiBold,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDateTracker() {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(left: 16),
      child: DatePicker(
        DateTime.now().subtract(const Duration(days: 1)),
        initialSelectedDate: DateTime.now(),
        selectionColor: ColorPalette.blueLight,
        selectedTextColor: ColorPalette.blueBase,
        daysCount: 45,
        onDateChange: (date) {
          setState(() {
            selectedDate = date;
            BlocProvider.of<TrackerBloc>(context).add(
              GetTrackerByDateTimeEvent(selectedDate)
            );
          });
        },
      ),
    );
  }

  Widget builderDetailDate() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MedicineUtil.formatDateTime(selectedDate),
            style: TextStyles.semiBold,
          ),
          BlocBuilder<TrackerBloc, TrackerState>(
            builder: (context, state) {
              if (state.status == TrackerStatus.success) {
                final list = state.list ?? [];
                if (list.isEmpty) {
                  return const Text("Don't have reminder");
                }
                return Flexible(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final item = list[index];
                        return TrackerCard(medicationReminder: item);
                      }),
                );
              } else {
                return Text("Error ${state.error}");
              }
            },
          )
        ],
      ),
    );
  }

  Widget buildDateCard() {
    return Container();
  }
}
