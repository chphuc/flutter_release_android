import 'package:mobx/mobx.dart';

part 'navigator_store.g.dart';

class NavigatorStore = _NavigatorStore with _$NavigatorStore;

abstract class _NavigatorStore with Store {
  @observable
  int currentIndexScreen = 0;

  @action
  void setCurrentIndexScreen(int index) {
    currentIndexScreen = index;
  }

  // Additional actions and observables can be added based on your application logic.
}
