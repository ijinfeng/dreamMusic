import 'package:dream_music/src/components/basic/base_change_notifier.dart';
import 'package:dream_music/src/pages/song_detail/model/song_lyric_model.dart';
import 'package:dream_music/src/pages/song_detail/model/song_lyric_row_model.dart';
import 'package:dream_music/src/pages/song_detail/request/song_detail_request.dart';
import 'package:dream_music/src/pages/song_detail/view/song_lyric_view.dart';
import 'package:flutter/material.dart';

class SongLyricStateModel extends BaseChangeNotifier {
  SongLyricStateModel() {
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  late final ScrollController scrollController;

  /// 当前播放的音乐
  int? id;

  /// 歌词模型
  SongLyricModel? lyric;

  List<SongLyricRowModel>? rows;

  /// 上一条选中的歌词
  SongLyricRowModel? lastSelectedRow;

  bool checkNeedToRebuild(Duration duration) {
    // 距离下次选中歌词之前，上一句歌词都将保持选中状态
    // 也就是每次只有选中新歌词的时候，才会有歌词选中态的变化
    // 这里有个问题，如果选中给每个cell添加Selector则无法保证先确认选中的row，再去更新旧的选中的row
    // 因此索性再每次变化时直接刷新整个列表
    final playTime = duration.inSeconds;
    if (rows != null) {
      // 这里可以做个算法优化，减少遍历次数
      if (lastSelectedRow != null) {
        // 优先去比较下当前选中index和下一个index的播放时间是否和playTime一致
        final row = rows![lastSelectedRow!.index];
        if (row.getSecond == playTime) {
          return false;
        }
        if (lastSelectedRow!.index < rows!.length - 1) {
          final nextRow = rows![lastSelectedRow!.index + 1];
          if (nextRow.getSecond == playTime) {
            lastSelectedRow = nextRow;
            scrollToRow(nextRow);
            return true;
          }
        }
      }
      for (int i = 0; i < rows!.length; i++) {
        final row = rows![i];
        if (row.getSecond == playTime && lastSelectedRow != row) {
          lastSelectedRow = row;
          scrollToRow(row);
          return true;
        }
      }
    }
    return false;
  }

  Duration _duration = Duration.zero;
  set duration(Duration value) {
    _duration = value;
    notifyListeners();
  }

  Duration get duration => _duration;

  void reset() {
    lyric = null;
    rows = null;
    id = null;
    lastSelectedRow = null;
  }

  /// 请求歌词
  void requestLyric(int? id) async {
    if (this.id == id || id == null) return;
    reset();
    this.id = id;
    debugPrint("开始请求歌曲[$id]的歌词...");
    final res = await SongDetailRequest.lyric(id);
    if (res.success) {
      debugPrint("歌曲[$id]的歌词请求成功");
      lyric = res.data;
      rows = lyric?.parseLyricToRows();
    }
    notifyListeners();
  }

  void scrollToRow(SongLyricRowModel? row) {
    if (row == null || scrolling || !autoScrollToPlayingLyric) return;
    if (rows != null && rows!.length > row.index) {
      double offsety = 0;
      for (int i = 0; i < row.index; i++) {
        offsety += rows![i].size?.height ?? rows![0].size?.height ?? 0;
      }
      double fixOffety = 200;
      if (offsety >= fixOffety) {
        offsety -= fixOffety;
        // 获取歌词列表的动态高度
        final ob = kLyricListGlobalkey.currentContext?.findRenderObject();
        double? lyricListHeight;
        if (ob != null && ob is RenderBox) {
          lyricListHeight = ob.size.height;
        }
        if (lyricListHeight != null && _scrollMetrics != null) {
          // 如果剩下的高度小于最大高度，那么不滚动
          if (lyricListHeight - 2.5 * fixOffety + offsety >= _scrollMetrics!.maxScrollExtent) {
            offsety = _scrollMetrics!.maxScrollExtent;
          }
        }
        debugPrint("scroll to index-${row.index}, offsety-$offsety");
        scrollController.animateTo(offsety,
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
      }
    }
  }

  /// 歌词列表是否正在滚动
  bool _scrolling = false;
  bool get scrolling => _scrolling;

  ScrollMetrics? _scrollMetrics;
  // 当前列表滚动的距离
  double get scrollOffsetY => _scrollMetrics?.pixels ?? 0;

  void handleScrollNotification(ScrollNotification notification) {
    _scrollMetrics = notification.metrics;
    switch (notification.runtimeType) {
      case ScrollStartNotification:
        _scrolling = true;
        break;
      case ScrollUpdateNotification:
        {
          _scrolling = true;
        }
        break;
      case ScrollEndNotification:
        _scrolling = false;
        break;
    }
  }

  ///  自动滚动到播放中的歌词
  bool _autoScrollToPlayingLyric = true;
  bool get autoScrollToPlayingLyric => _autoScrollToPlayingLyric;
  set autoScrollToPlayingLyric(bool value) {
    if (_autoScrollToPlayingLyric != value) {
      _autoScrollToPlayingLyric = value;
      notifyListeners();
    }
  }
}
