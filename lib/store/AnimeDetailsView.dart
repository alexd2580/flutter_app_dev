import 'package:mobx/mobx.dart';

part 'AnimeDetailsView.g.dart';

class AnimeDetailsView = _AnimeDetailsView with _$AnimeDetailsView;

abstract class _AnimeDetailsView implements Store {
  @observable
  int focus;

  @action
  setFocus(int focus) => this.focus = this.focus == focus ? null : focus;

  @action
  void reset() => focus = null;
}
