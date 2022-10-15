import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/pages/comment/model/comment_model.dart';
import 'package:dream_music/src/pages/song_detail/model/single_song_model.dart';

class CommentPageStateModel extends BaseChangeNotifier {

  CommentPageStateModel();

  void initialize(SingleSongModel? model) {
    _model = model;
  }

  SingleSongModel? _model;
  SingleSongModel? get model => _model;
  set model(SingleSongModel? value) {
    if (model?.track?.id == value?.track?.id) {
      return;
    }
    _model = value;
    notifyListeners();
  }

  /// 记录新评论而刷新的标志位
  int refreshByNewCommentCode = 0;
  CommentModel? newCommentModel;

  void sendNewComment(CommentModel? model) {
    if (model == null) return;
    newCommentModel = model;
    refreshByNewCommentCode += 1;
    notifyListeners();
  }
 }