import 'package:flutter/material.dart';

class FilterPopup extends StatefulWidget {
  final List<String>? selectedFilters; // Tambahkan parameter selectedFilters

  const FilterPopup({Key? key, this.selectedFilters}) : super(key: key);

  @override
  _FilterPopupState createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  bool _option1 = false;
  bool _option2 = false;

  @override
  void initState() {
    super.initState();
    // Periksa apakah 'REGULAR' ada di dalam selectedFilters
    if (widget.selectedFilters != null &&
        widget.selectedFilters!.contains('Regular')) {
      _option2 = true;
    }

    if (widget.selectedFilters != null &&
        widget.selectedFilters!.contains('Urgent')) {
      _option1 = true;
    }
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Status Surat'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            CheckboxListTile(
              title: Text('Urgent'),
              value: _option1,
              onChanged: (value) {
                setState(() {
                  _option1 = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Regular'),
              value: _option2,
              onChanged: (value) {
                setState(() {
                  _option2 = value ?? false;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the filter popup
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            List<String> selectedFilters = [];
            if (_option1) {
              selectedFilters.add('Urgent');
            }
            if (_option2) {
              selectedFilters.add('Regular');
            }

            // Return selected filters
            Navigator.of(context).pop(selectedFilters);
          },
          child: Text('Apply'),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     // Collect selected filters
        //     List<String> selectedFilters = [];
        //     if (_option1) {
        //       selectedFilters.add('Urgent');
        //     }
        //     if (_option2) {
        //       selectedFilters.add('Regular');
        //     }

        //     // Return selected filters
        //     Navigator.of(context).pop(selectedFilters);
        //   },
        //   style: ElevatedButton.styleFrom(
        //     elevation: 0,
        //     padding: EdgeInsets.symmetric(vertical: 16),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //   ),
        //   child: Text('Apply'),
        // ),
      ],
    );
  }
}
