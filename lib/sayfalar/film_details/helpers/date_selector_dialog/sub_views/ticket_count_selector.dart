import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketCountSelector extends StatefulWidget {
  TicketCountSelector({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  Function(int) onChanged;

  @override
  State<TicketCountSelector> createState() => _TicketCountSelectorState();
}

class _TicketCountSelectorState extends State<TicketCountSelector> {
  String selectedValue = '1';

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: Container(),
      value: selectedValue,
      items: _getMenuItems(),
      onChanged: (s) {
        setState(() {
          selectedValue = s as String;
        });
        widget.onChanged(int.parse(s as String));
      },
    );
  }

  List<String> countList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];

  List<DropdownMenuItem<String>> _getMenuItems() {
    return countList
        .map((e) => DropdownMenuItem(value: e, child: _getText(e)))
        .toList();
  }

  Widget _getText(
    String text, {
    double? divideThatNumber,
    bool isBold = false,
  }) {
    return Text(
      text,
      style: GoogleFonts.ubuntuCondensed(
        fontSize: context.width / (divideThatNumber ?? 70),
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
