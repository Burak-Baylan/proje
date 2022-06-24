import 'package:flutter/material.dart';
import '../controller/ana_sayfa_controller.dart';
import 'sub_views/film_afis.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  AnaSayfaController controller = AnaSayfaController();

  @override
  void initState() {
    controller.setContext(context);
    filmFuture = controller.getMovies();
    super.initState();
  }

  late Future filmFuture;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 38, 47, 63),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: FutureBuilder(
          future: filmFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Text('Error');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (controller.filmModels.isNotEmpty) {
                return gelecekFilmler();
              }
              return Text('Error 2');
            }
            return buildProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget buildProgressIndicator() {
    return const Center(child: CircularProgressIndicator(color: Colors.white));
  }

  Widget gelecekFilmler() {
    List<Widget> filmWidget = [];
    for (var element in controller.filmModels) {
      filmWidget.add(FilmAfis(filmModel: element));
    }
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: filmWidget,
    );
  }
}
