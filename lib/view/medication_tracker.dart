import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder/bloc/tracker_bloc.dart';
import 'package:medicine_reminder/config/color_palette.dart';
import 'package:medicine_reminder/config/text_styles.dart';
import 'package:medicine_reminder/config/util.dart';
import 'package:medicine_reminder/widget/tracker_card.dart';

class MedicationTrackerScreen extends StatefulWidget {
  const MedicationTrackerScreen({super.key});

  @override
  State<MedicationTrackerScreen> createState() =>
      _MedicationTrackerScreenState();
}

class _MedicationTrackerScreenState extends State<MedicationTrackerScreen> {
  DateTime selectedDate = DateTime.now();
  late TrackerBloc trackerBloc;
  
  @override
  void initState() {
    super.initState();
    trackerBloc = BlocProvider.of<TrackerBloc>(context)..add(GetAllTrackerEvent());
  }

  @override
  Widget build(BuildContext context) {
    print('build nef');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitleCard(),
              buildDateTracker(),
              BlocBuilder<TrackerBloc, TrackerState>(
                builder: (context, state) {
                  final list = state.list;
                  final status = state.status;
                  print('build nua nef');
                  return Flexible(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list?.length ?? 0,
                        itemBuilder: (context, index) {
                          final item = list?[index];
                          if (status == TrackerStatus.success) {
                            print('true');
                            return TrackerCard(medicationReminder: item!);
                          } else {
                            print('false');
                            return const Center(child: CircularProgressIndicator());
                          }
                        }),
                  );
                },
              )
              // builderDetailDate(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitleCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
        daysCount: 30,
        onDateChange: (date) {
          setState(() {
            selectedDate = date;
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
          BlocProvider<TrackerBloc>(
            create: (context) => TrackerBloc(),
            child: BlocBuilder<TrackerBloc, TrackerState>(
              builder: (context, state) {
                final list = state.list;
                final status = state.status;
                return Flexible(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemBuilder: (context, index) {
                    final item = list?[index];
                    if (status == TrackerStatus.success) {
                      return TrackerCard(medicationReminder: item!);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildDateCard() {
    return Container();
  }
}
