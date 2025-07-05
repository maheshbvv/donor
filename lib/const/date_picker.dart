import 'package:flutter/material.dart';

class StyledDatePicker extends StatefulWidget {
  final Function(DateTime?)? onDateSelected;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const StyledDatePicker({
    super.key,
    this.onDateSelected,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<StyledDatePicker> createState() => _StyledDatePickerState();
}

class _StyledDatePickerState extends State<StyledDatePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: widget.lastDate ?? DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected?.call(picked);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController(text: _formatDate(selectedDate)),
      decoration: InputDecoration(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(width: 8),
            const Text('Date'),
          ],
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      onTap: () => _selectDate(context),
    );
  }
}

// Usage example:
class DatePickerExample extends StatefulWidget {
  const DatePickerExample({super.key});

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Date Picker Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StyledDatePicker(
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
            const SizedBox(height: 20),
            if (selectedDate != null)
              Text(
                'Selected Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
          ],
        ),
      ),
    );
  }
}
