import 'package:mobx/mobx.dart';

part 'AnimeDetailsView.g.dart';

enum AnimeDetailsViewFocus { header, content }

class AnimeDetailsView = _AnimeDetailsView with _$AnimeDetailsView;

abstract class _AnimeDetailsView implements Store {
  @observable
  AnimeDetailsViewFocus focus = AnimeDetailsViewFocus.header;

  @action
  setFocus(AnimeDetailsViewFocus focus) => this.focus = focus;

  @action
  void reset() => focus = AnimeDetailsViewFocus.header;
}
