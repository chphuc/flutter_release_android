// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_information_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccountInformationStore on _AccountInformationStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_AccountInformationStore.loading'))
      .value;

  late final _$fetchUserInformationsFutureAtom = Atom(
      name: '_AccountInformationStore.fetchUserInformationsFuture',
      context: context);

  @override
  ObservableFuture<UserInformation?> get fetchUserInformationsFuture {
    _$fetchUserInformationsFutureAtom.reportRead();
    return super.fetchUserInformationsFuture;
  }

  @override
  set fetchUserInformationsFuture(ObservableFuture<UserInformation?> value) {
    _$fetchUserInformationsFutureAtom
        .reportWrite(value, super.fetchUserInformationsFuture, () {
      super.fetchUserInformationsFuture = value;
    });
  }

  late final _$userInformationAtom =
      Atom(name: '_AccountInformationStore.userInformation', context: context);

  @override
  UserInformation? get userInformation {
    _$userInformationAtom.reportRead();
    return super.userInformation;
  }

  @override
  set userInformation(UserInformation? value) {
    _$userInformationAtom.reportWrite(value, super.userInformation, () {
      super.userInformation = value;
    });
  }

  late final _$getUserInformationAsyncAction = AsyncAction(
      '_AccountInformationStore.getUserInformation',
      context: context);

  @override
  Future<dynamic> getUserInformation() {
    return _$getUserInformationAsyncAction
        .run(() => super.getUserInformation());
  }

  @override
  String toString() {
    return '''
fetchUserInformationsFuture: ${fetchUserInformationsFuture},
userInformation: ${userInformation},
loading: ${loading}
    ''';
  }
}
