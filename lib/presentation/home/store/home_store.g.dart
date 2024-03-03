// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  Computed<bool>? _$statusBarRequestLoadingComputed;

  @override
  bool get statusBarRequestLoading => (_$statusBarRequestLoadingComputed ??=
          Computed<bool>(() => super.statusBarRequestLoading,
              name: '_HomeStore.statusBarRequestLoading'))
      .value;

  late final _$fetchStatusBarRequestFutureAtom =
      Atom(name: '_HomeStore.fetchStatusBarRequestFuture', context: context);

  @override
  ObservableFuture<StatusBarRequestList?> get fetchStatusBarRequestFuture {
    _$fetchStatusBarRequestFutureAtom.reportRead();
    return super.fetchStatusBarRequestFuture;
  }

  @override
  set fetchStatusBarRequestFuture(
      ObservableFuture<StatusBarRequestList?> value) {
    _$fetchStatusBarRequestFutureAtom
        .reportWrite(value, super.fetchStatusBarRequestFuture, () {
      super.fetchStatusBarRequestFuture = value;
    });
  }

  late final _$statusBarRequestListAtom =
      Atom(name: '_HomeStore.statusBarRequestList', context: context);

  @override
  StatusBarRequestList? get statusBarRequestList {
    _$statusBarRequestListAtom.reportRead();
    return super.statusBarRequestList;
  }

  @override
  set statusBarRequestList(StatusBarRequestList? value) {
    _$statusBarRequestListAtom.reportWrite(value, super.statusBarRequestList,
        () {
      super.statusBarRequestList = value;
    });
  }

  late final _$getStatusBarRequestsAsyncAction =
      AsyncAction('_HomeStore.getStatusBarRequests', context: context);

  @override
  Future<dynamic> getStatusBarRequests() {
    return _$getStatusBarRequestsAsyncAction
        .run(() => super.getStatusBarRequests());
  }

  @override
  String toString() {
    return '''
fetchStatusBarRequestFuture: ${fetchStatusBarRequestFuture},
statusBarRequestList: ${statusBarRequestList},
statusBarRequestLoading: ${statusBarRequestLoading}
    ''';
  }
}
