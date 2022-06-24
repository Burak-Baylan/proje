import 'package:flutter/material.dart';
import '../../../../extensions/context_extensions.dart';
import '../../../../main.dart';
import '../../../../models/film_model.dart';
import '../../../film_details/view/film_details_page.dart';

class FilmAfis extends StatefulWidget {
  FilmAfis({
    Key? key,
    required this.filmModel,
  }) : super(key: key);

  FilmModel filmModel;

  @override
  State<FilmAfis> createState() => _FilmAfisState();
}

class _FilmAfisState extends State<FilmAfis> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => navigatoToDetailsPage(context),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildImageSkeleton,
              const SizedBox(height: 15),
              buildNameText,
            ],
          ),
        ),
      ),
    );
  }

  Widget get buildImageSkeleton {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(15)),
      child: buildImage,
    );
  }

  Widget get buildImage {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        widget.filmModel.bannerLink,
        width: context.width / 6,
        height: context.width / 4,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget get buildNameText {
    return Text(
      widget.filmModel.name,
      style: TextStyle(
        fontSize: context.width / 75,
        color: Colors.white,
      ),
    );
  }

  void navigatoToDetailsPage(BuildContext context) {
    globalVm.sendToPage(context, FilmDetailsPage(filmModel: widget.filmModel));
  }
}
