import 'package:flutter/material.dart';

class MyDatePicker extends StatefulWidget {
  final void Function(DateTime) onDateSelected;

  const MyDatePicker({super.key, required this.onDateSelected});

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';

    return ElevatedButton(
      onPressed: () => _selectDate(context),
      child: Text(formattedDate),
    );
  }
}
