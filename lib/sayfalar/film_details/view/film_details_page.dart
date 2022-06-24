import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../extensions/context_extensions.dart';
import '../../../models/film_model.dart';
import '../controller/film_details_controller.dart';
import '../helpers/date_selector_dialog/date_selector_dialog.dart';

class FilmDetailsPage extends StatefulWidget {
  FilmDetailsPage({
    Key? key,
    required this.filmModel,
  }) : super(key: key);

  FilmModel filmModel;

  @override
  State<FilmDetailsPage> createState() => _FilmDetailsPageState();
}

class _FilmDetailsPageState extends State<FilmDetailsPage> {
  FilmModel get filmModel => widget.filmModel;
  FilmDetailsController filmDetailsVm = FilmDetailsController();

  @override
  Widget build(BuildContext context) {
    filmDetailsVm.setContext(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 38, 47, 63),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 110, 122),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            buildFilmInformations,
            const SizedBox(width: 20),
            buildOtherInformations,
          ],
        ),
      ),
    );
  }

  Widget get buildImage {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          filmModel.bannerLink,
          height: context.width / 5,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget get buildFilmInformations {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildImage,
        const SizedBox(height: 10),
        getTextRow(
          text1: 'Vizyon Tarihi: ',
          text2: filmModel.publishedDate,
        ),
        const SizedBox(height: 10),
        getTextRow(
          text1: 'Süre: ',
          text2: '${filmModel.duration} dakika',
        ),
        const SizedBox(height: 10),
        getTextRow(text1: 'Tür: ', text2: filmModel.type),
      ],
    );
  }

  Widget get buildRateWidget {
    return Row(
      children: [
        Icon(
          Icons.star_rate_rounded,
          size: context.width / 32,
          color: Colors.white,
        ),
        Text(
          filmModel.imdb.toString(),
          style: GoogleFonts.ubuntu(
            fontWeight: FontWeight.bold,
            fontSize: context.width / 35,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget get buildNameAndRate {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          filmModel.name,
          style: GoogleFonts.ubuntu(
            fontWeight: FontWeight.bold,
            fontSize: context.width / 35,
            color: Colors.white,
          ),
        ),
        buildRateWidget,
      ],
    );
  }

  Widget get buildBuyTicketButton {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => buyTicketClicked(),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(0, 50),
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Bilet Satın Al',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget get buildFragmanButton {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => launchUrl(Uri.parse(filmModel.trailerLink)),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(0, 50),
          primary: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.white),
          ),
        ),
        child: const Text(
          'Fragman',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget get buildButtons {
    return Row(
      children: [
        buildBuyTicketButton,
        const SizedBox(width: 20),
        buildFragmanButton
      ],
    );
  }

  Widget get buildOtherInformations {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildNameAndRate,
            const SizedBox(height: 20),
            const Divider(color: Colors.white),
            const SizedBox(height: 20),
            getTextRow(text1: 'Yönetmen: ', text2: filmModel.director),
            const SizedBox(height: 15),
            getTextRow(text1: 'Oyuncular: ', text2: filmModel.cast),
            const SizedBox(height: 15),
            getTextRow(text1: 'Özet: ', text2: filmModel.subject),
            const SizedBox(height: 20),
            const Divider(color: Colors.white),
            const SizedBox(height: 20),
            buildButtons,
          ],
        ),
      ),
    );
  }

  Widget getTextRow({required String text1, required String text2}) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          getText(text: text1, isBold: true),
          getText(text: text2),
        ],
      ),
    );
  }

  TextSpan getText({
    required String text,
    double? fontSize,
    bool isBold = false,
    bool isExpanded = false,
  }) {
    return TextSpan(
      text: text,
      style: GoogleFonts.ubuntuCondensed(
        fontSize: fontSize ?? context.width / 75,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: Colors.white,
      ),
    );
  }

  void buyTicketClicked() {
    filmDetailsVm.ticketCount = 2;
    filmDetailsVm.ticketDate = DateTime.now();
    dateSelectorDialog(
      context,
      onSave: (date, ticketCount) =>
          filmDetailsVm.buyTicked(date, ticketCount, filmModel),
    );
  }
}
