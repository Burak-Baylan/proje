import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proje/extensions/context_extensions.dart';
import 'package:proje/sayfalar/film_details/helpers/date_selector_dialog/sub_views/ticket_count_selector.dart';
import 'package:web_date_picker/web_date_picker.dart';

var _selectedDate = DateTime.now().toUtc();
int _ticketCount = 2;
late Function(DateTime, int) _onSave;

Future<void> dateSelectorDialog(
  BuildContext context, {
  required Function(DateTime, int) onSave,
}) async {
  _selectedDate = DateTime.now().toUtc();
  _ticketCount = 2;
  _onSave = onSave;
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: _getText(
          context,
          'Bilet Tarihinizi Seçin',
          divideThatNumber: 70,
          isBold: true,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _getText(
              context,
              'En fazla 20 gün sonrası için bilet alabilirisiniz.',
              divideThatNumber: 65,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _getText(context, 'Bilet Sayısı:'),
                SizedBox(width: 10),
                TicketCountSelector(onChanged: (value) => _ticketCount = value),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: context.width / 3,
              child: WebDatePicker(
                initialDate: _selectedDate,
                firstDate: _selectedDate,
                dateformat: 'dd/MM/yyyy',
                lastDate: DateTime(
                  _selectedDate.year,
                  _selectedDate.month,
                  _selectedDate.day + 20,
                ),
                onChange: (value) {
                  if (value != null) {
                    _selectedDate = value;
                  }
                },
              ),
            ),
          ],
        ),
        actions: _getButtons(context),
      );
    },
  );
}

List<Widget> _getButtons(BuildContext context) {
  return [
    TextButton(
      onPressed: () => context.pop,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: _getText(context, 'İptal', divideThatNumber: 65),
      ),
    ),
    TextButton(
      onPressed: () {
        _onSave(_selectedDate, _ticketCount);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: _getText(context, 'Bileti Al', divideThatNumber: 65),
      ),
    ),
  ];
}

Widget _getText(
  BuildContext context,
  String text, {
  double? divideThatNumber,
  bool isBold = false,
}) {
  return Text(
    text,
    style: GoogleFonts.ubuntuCondensed(
      fontSize: context.width / (divideThatNumber ?? 65),
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    ),
  );
}
