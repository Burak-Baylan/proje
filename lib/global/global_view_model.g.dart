// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GlobalViewModel on _GlobalViewModelBase, Store {
  late final _$isLoggedInAtom =
      Atom(name: '_GlobalViewModelBase.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$_GlobalViewModelBaseActionController =
      ActionController(name: '_GlobalViewModelBase', context: context);

  @override
  void changeLoggedInState(bool state) {
    final _$actionInfo = _$_GlobalViewModelBaseActionController.startAction(
        name: '_GlobalViewModelBase.changeLoggedInState');
    try {
      return super.changeLoggedInState(state);
    } finally {
      _$_GlobalViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
