import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package

class DateRangePickerWidget extends StatefulWidget {
  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
    );

    if (picked != null &&
        (picked.start != _startDate || picked.end != _endDate)) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        // Menggunakan Center untuk membuat judul berada di tengah
        child: Text(
          'Select Date Range',
          textAlign: TextAlign.center, // Pusatkan teks judul
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Start Date : ${DateFormat('dd-MM-yyyy').format(_startDate)}'),
          Text('End Date   : ${DateFormat('dd-MM-yyyy').format(_endDate)}'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _selectDateRange(context);
            },
            child: Text('Filter Date'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            print('Start Date: $_startDate, End Date: $_endDate');
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
