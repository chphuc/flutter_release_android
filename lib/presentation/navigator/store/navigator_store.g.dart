// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigator_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NavigatorStore on _NavigatorStore, Store {
  late final _$currentIndexScreenAtom =
      Atom(name: '_NavigatorStore.currentIndexScreen', context: context);

  @override
  int get currentIndexScreen {
    _$currentIndexScreenAtom.reportRead();
    return super.currentIndexScreen;
  }

  @override
  set currentIndexScreen(int value) {
    _$currentIndexScreenAtom.reportWrite(value, super.currentIndexScreen, () {
      super.currentIndexScreen = value;
    });
  }

  late final _$_NavigatorStoreActionController =
      ActionController(name: '_NavigatorStore', context: context);

  @override
  void setCurrentIndexScreen(int index) {
    final _$actionInfo = _$_NavigatorStoreActionController.startAction(
        name: '_NavigatorStore.setCurrentIndexScreen');
    try {
      return super.setCurrentIndexScreen(index);
    } finally {
      _$_NavigatorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentIndexScreen: ${currentIndexScreen}
    ''';
  }
}
