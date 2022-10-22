import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/downloder/download_manager.dart';
import 'package:dream_music/src/components/downloder/download_song_model.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/download/model/download_page_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/// 歌曲详情卡片
class DownloadSongDetailCard extends StatelessWidget with EasyInterface {
  const DownloadSongDetailCard({Key? key, required this.model})
      : super(key: key);

  final DownloadSongModel model;

  final double kImageWidth = 180;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black12,
      color: kPageBackgroundColor,
      elevation: 3.0,
      shape: const SongCardShapeBorder(
        side: BorderSide(
          color: kDividerColor,
          width: 0.5,
        ),
        radius: 8,
        yposition: 80,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageView.network(
              src: model.al.picUrl,
              width: kImageWidth,
              height: kImageWidth,
              radius: 8,
            ),
            heightSpace(10),
            _buildDesc(context, '歌曲ID：', "${model.songId}"),
            heightSpace(5),
            _buildDesc(context, '歌名：', model.name),
            heightSpace(5),
            _buildDesc(context, '专辑：', model.al.name),
            heightSpace(5),
            _buildDesc(context, '艺术家：', model.authorNmae),
            heightSpace(5),
            _buildDesc(context, '时长：', Utils.formatSongTime(model.time)),
            heightSpace(5),
            _buildDesc(
                context,
                '创建时间：',
                Utils.getFileCreateTime(
                    DownloadManager().getSaveSongPath(model.songId))),
            heightSpace(5),
            _buildDesc(context, '存储方式：', DownloadManager().cacheModeName),
            heightSpace(5),
            _buildDesc(context, '文件大小：', Utils.formatFileSize(model.size)),
            heightSpace(5),
            _buildSavePath(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSavePath(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '存储路径：',
          style: TextStyle(
              fontSize: 12, color: kText6Color, fontWeight: FontWeight.w400),
        ),
        CustomTooltipWidget(
          message: DownloadManager().getSaveSongPath(model.songId),
          child: MainButton.title(
            title: '复制路径',
            backgroundColor: Colors.transparent,
            textStyle: const TextStyle(
                fontSize: 12,
                color: kHighlightThemeColor,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline),
            onTap: () {
              Clipboard.setData(ClipboardData(
                  text: DownloadManager().getSaveSongPath(model.songId)));
              showToast('已复制到转帖版');
            },
          ),
        )
      ],
    );
  }

  Widget _buildDesc(BuildContext context, String title, String content) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: title),
          TextSpan(text: content, style: const TextStyle(color: kText3Color))
        ],
        style: const TextStyle(
            fontSize: 12, color: kText6Color, fontWeight: FontWeight.w400),
      ),
    );
  }
}

void showSongCard(BuildContext context, bool hover, DownloadSongModel model,
    {double? top, double? left, double? bottom, double? right}) {
  final state = context.read<DownloadPageStateModel>();
  if (!hover) {
    state.songCardOverlay?.remove();
    state.songCardOverlay = null;
    return;
  }
  if (state.songCardOverlay != null) return;
  state.songCardOverlay = OverlayEntry(
    builder: (_) {
      Widget entry = DownloadSongDetailCard(
        model: model,
      );
      if (top != null || left != null || bottom != null || right != null) {
        entry = Positioned(
          top: top,
          left: left,
          bottom: bottom,
          right: right,
          child: entry,
        );
      } else {
        entry = Center(
          child: entry,
        );
      }
      return entry;
    },
  );
  Overlay.of(context)?.insert(state.songCardOverlay!);
}

class SongCardShapeBorder extends ShapeBorder {
  const SongCardShapeBorder({
    this.side = BorderSide.none,
    this.radius = 0,
    this.yposition = 0,
  });

  final BorderSide side;

  final double radius;

  final double yposition;

  double get _triangleHeight => 10;

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(side.width);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        var path = getOuterPath(rect, textDirection: textDirection);
        final paint = Paint()
          ..color = side.color
          ..strokeWidth = side.width
          ..style = PaintingStyle.stroke
          ..strokeJoin = StrokeJoin.round;
        canvas.drawPath(path, paint);

        var triangleFillPath = Path();
        triangleFillPath.moveTo(rect.width, yposition - _triangleHeight * 0.8);
        triangleFillPath.lineTo(rect.width + _triangleHeight, yposition);
        triangleFillPath.lineTo(rect.width, yposition + _triangleHeight * 0.8);
        triangleFillPath.lineTo(rect.width, yposition - _triangleHeight * 0.8);
        canvas.drawPath(
            triangleFillPath,
            paint
              ..style = PaintingStyle.fill
              ..color = kPageBackgroundColor);

        var trianglePath = Path();
        trianglePath.moveTo(rect.width, yposition - _triangleHeight * 0.8);
        trianglePath.lineTo(rect.width + _triangleHeight, yposition);
        trianglePath.lineTo(rect.width, yposition + _triangleHeight * 0.8);
        trianglePath.lineTo(rect.width, yposition - _triangleHeight * 0.8);
        canvas.drawPath(
            trianglePath,
            paint
              ..style = PaintingStyle.stroke
              ..color = side.color);
    }
  }

  @override
  ShapeBorder scale(double t) {
    return SongCardShapeBorder(
        side: side.scale(t), radius: radius * t, yposition: yposition * t);
  }
}
