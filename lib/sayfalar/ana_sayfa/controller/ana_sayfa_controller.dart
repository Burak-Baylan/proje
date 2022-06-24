import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../base/base_view_model.dart';
import '../../../models/film_model.dart';
part 'ana_sayfa_controller.g.dart';

class AnaSayfaController = _AnaSayfaControllerBase with _$AnaSayfaController;

abstract class _AnaSayfaControllerBase extends BaseViewModel with Store {
  @override
  BuildContext? contextt;

  @override
  void setContext(BuildContext context) => contextt = context;

  List<FilmModel> filmModels = [];

  Future<void> getMovies() async {
    var firebase = FirebaseFirestore.instance;
    var data = await firebase.collection('filmler').get();
    for (var element in data.docs) {
      var rawData = element.data();
      var model = FilmModel.fromJson(rawData);
      filmModels.add(model);
    }
  }
}
