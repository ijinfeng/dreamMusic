import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';

class CommentPageStateModel extends BaseChangeNotifier {

  CommentPageStateModel({
    SingleSongModel? model,
  }) : _model = model;

  SingleSongModel? _model;
  SingleSongModel? get model => _model;
  set model(SingleSongModel? value) {
    if (model?.track?.id == value?.track?.id) {
      return;
    }
    _model = value;
    notifyListeners();
  }
}