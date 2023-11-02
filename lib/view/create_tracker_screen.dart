import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder/bloc/auth/auth_bloc.dart';
import 'package:medicine_reminder/bloc/event_calendar/event_calendar_bloc.dart';
import 'package:medicine_reminder/bloc/tracker/tracker_bloc.dart';
import 'package:medicine_reminder/config/color_palette.dart';
import 'package:medicine_reminder/config/common_enum.dart';
import 'package:medicine_reminder/config/util.dart';

class CreateTrackerScreen extends StatefulWidget {
  const CreateTrackerScreen({super.key});

  @override
  State<CreateTrackerScreen> createState() => _CreateTrackerScreenState();
}

class _CreateTrackerScreenState extends State<CreateTrackerScreen> {
  MedicineType selectedMedicineType = MedicineType.Tablet;
  DoseType selectedDoseType = DoseType.pills;
  TextEditingController medicineName = TextEditingController();
  TextEditingController doseAmount = TextEditingController();
  TextEditingController note = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  bool isCheckbox = false;

  @override
  void dispose() {
    medicineName.dispose();
    super.dispose();
  }

  void onCreateClick() {
    BlocProvider.of<EventCalendarBloc>(context).add(CreateEventCalendarEvent(
      medicationName: medicineName.text,
      startDate: startDate ?? DateTime.now(),
      startTime: startTime ?? TimeOfDay.now(),
      endDate: endDate ?? DateTime.now(),
      endTime: endTime ?? TimeOfDay.now(),
      accessToken: context.read<AuthBloc>().state.accessToken ?? '',
    ));
    BlocProvider.of<TrackerBloc>(context).add(CreateMedicationEvent(
      medicationName: medicineName.text,
      startDate: startDate ?? DateTime.now(),
      endDate: endDate ?? DateTime.now(),
      medicineType: selectedMedicineType,
      doseType: selectedDoseType,
      doseAmount: int.parse(doseAmount.text),
      note: note.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Medicine Reminder'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Medicine Name'),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: medicineName,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: ColorPalette.grayLight,
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Card(
                  color: ColorPalette.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: MedicineType.values.length,
                              itemBuilder: (context, index) {
                                List<MedicineType> medicineType =
                                    MedicineType.values;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ChoiceChip(
                                    backgroundColor: ColorPalette.blueLight,
                                    selectedColor: ColorPalette.blueBase,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide.none),
                                    label: Text(
                                      medicineTypeToString(medicineType[index]),
                                    ),
                                    selected: selectedMedicineType ==
                                        medicineType[index],
                                    onSelected: (bool selected) {
                                      if (selected) {
                                        setState(() {
                                          selectedMedicineType =
                                              medicineType[index];
                                        });
                                      } else {}
                                    },
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Text("Dose"),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextField(
                                controller: doseAmount,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      left: 16, top: 8, bottom: 8),
                                  hintText: "Amount",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: ColorPalette.grayLight,
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: ColorPalette.grayDark,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: selectedDoseType,
                                    items: [
                                      DropdownMenuItem(
                                        value: DoseType.pills,
                                        child: Text(
                                          doseTypeToString(DoseType.pills),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: DoseType.mg,
                                        child: Text(
                                          doseTypeToString(DoseType.mg),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: DoseType.ml,
                                        child: Text(
                                          doseTypeToString(DoseType.ml),
                                        ),
                                      ),
                                    ],
                                    onChanged: (DoseType? selectedValue) {
                                      setState(() {
                                        selectedDoseType =
                                            selectedValue ?? DoseType.pills;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Text("Note"),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: note,
                          decoration: InputDecoration(
                            contentPadding:
                            const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: ColorPalette.grayLight,
                                width: 1.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Start Date'),
                            const Expanded(child: SizedBox()),
                            buildSelectDateTime(
                                date: startDate,
                                time: startTime,
                                onDateTimeSelected: (date, time) {
                                  setState(() {
                                    startDate = date;
                                    startTime = time;
                                  });
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('End Date'),
                            const Expanded(child: SizedBox()),
                            buildSelectDateTime(
                                date: endDate,
                                time: endTime,
                                onDateTimeSelected: (date, time) {
                                  setState(() {
                                    endDate = date;
                                    endTime = time;
                                  });
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Repeat daily for 5 days'),
                            const SizedBox(width: 18,),
                            Checkbox(value: isCheckbox, onChanged: (bool? value) {
                              setState(() {
                                isCheckbox = value ?? false;
                              });
                            },)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  decoration: BoxDecoration(
                    color: ColorPalette.blueBase,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: onCreateClick,
                    child: const Text(
                      "Create",
                      style: TextStyle(
                          color: ColorPalette.blueLight, fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSelectDateTime({
    DateTime? date,
    TimeOfDay? time,
    void Function(DateTime, TimeOfDay)? onDateTimeSelected,
  }) {
    return InkWell(
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime(DateTime.now().year - 1),
          lastDate: DateTime(DateTime.now().year + 1),
        );

        final selectedTime = await showTimePicker(
          context: context,
          initialTime: time ?? TimeOfDay.now(),
        );

        if (selectedDate != null &&
            selectedTime != null &&
            onDateTimeSelected != null) {
          onDateTimeSelected(selectedDate, selectedTime);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: ColorPalette.grayDark,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.access_time_outlined),
            const SizedBox(
              width: 8,
            ),
            Text(
              MedicineUtil.formatDateTimeOfDay(
                date ?? DateTime.now(),
                time ?? TimeOfDay.now(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
