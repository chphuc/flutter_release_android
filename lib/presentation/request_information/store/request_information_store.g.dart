// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_information_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RequestInformationStore on _RequestInformationStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_RequestInformationStore.loading'))
      .value;

  late final _$fetchRequestInformationFutureAtom = Atom(
      name: '_RequestInformationStore.fetchRequestInformationFuture',
      context: context);

  @override
  ObservableFuture<RequestInformation?> get fetchRequestInformationFuture {
    _$fetchRequestInformationFutureAtom.reportRead();
    return super.fetchRequestInformationFuture;
  }

  @override
  set fetchRequestInformationFuture(
      ObservableFuture<RequestInformation?> value) {
    _$fetchRequestInformationFutureAtom
        .reportWrite(value, super.fetchRequestInformationFuture, () {
      super.fetchRequestInformationFuture = value;
    });
  }

  late final _$requestInformationAtom = Atom(
      name: '_RequestInformationStore.requestInformation', context: context);

  @override
  RequestInformation? get requestInformation {
    _$requestInformationAtom.reportRead();
    return super.requestInformation;
  }

  @override
  set requestInformation(RequestInformation? value) {
    _$requestInformationAtom.reportWrite(value, super.requestInformation, () {
      super.requestInformation = value;
    });
  }

  late final _$getRequestInformationAsyncAction = AsyncAction(
      '_RequestInformationStore.getRequestInformation',
      context: context);

  @override
  Future<dynamic> getRequestInformation(int idRequest) {
    return _$getRequestInformationAsyncAction
        .run(() => super.getRequestInformation(idRequest));
  }

  @override
  String toString() {
    return '''
fetchRequestInformationFuture: ${fetchRequestInformationFuture},
requestInformation: ${requestInformation},
loading: ${loading}
    ''';
  }
}
