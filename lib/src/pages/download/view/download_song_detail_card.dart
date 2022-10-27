import 'package:dream_music/src/components/basic/mixin_easy_interface.dart';
import 'package:dream_music/src/components/button/main_button.dart';
import 'package:dream_music/src/components/button/selectable_icon_button.dart';
import 'package:dream_music/src/components/downloder/download_manager.dart';
import 'package:dream_music/src/components/downloder/download_song_model.dart';
import 'package:dream_music/src/components/hover/custom_tool_tip_widget.dart';
import 'package:dream_music/src/components/image/image_view.dart';
import 'package:dream_music/src/components/layoutbox/after_layout.dart';
import 'package:dream_music/src/components/util/utils.dart';
import 'package:dream_music/src/config/global_constant.dart';
import 'package:dream_music/src/config/theme_color_constant.dart';
import 'package:dream_music/src/pages/download/model/download_page_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
      margin: EdgeInsets.zero,
      shape: const SongCardShapeBorder(
        side: BorderSide(
          color: kDividerColor,
          width: 0.5,
        ),
        radius: 8,
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
            _buildDesc(context, '歌曲ID：', "${model.songId}", canCopy: true),
            heightSpace(5),
            _buildDesc(context, '歌名：', model.name, canCopy: true),
            heightSpace(5),
            _buildDesc(context, '专辑：', model.al.name, canCopy: true),
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

  Widget _buildDesc(BuildContext context, String title, String content,
      {bool canCopy = false}) {
    Widget current = RichText(
      text: TextSpan(
        children: [
          TextSpan(text: title),
          TextSpan(text: content, style: const TextStyle(color: kText3Color))
        ],
        style: const TextStyle(
            fontSize: 12, color: kText6Color, fontWeight: FontWeight.w400),
      ),
    );
    if (canCopy) {
      current = Row(
        children: [
          current,
          CustomTooltipWidget(
            message: '复制',
            child: SelectableIconButton(
              selected: true,
              src: 'icon_copy',
              width: 12,
              height: 12,
              color: kHighlightThemeColor,
              onTap: (_) {
                Clipboard.setData(ClipboardData(
                  text: content));
              showToast('已复制到转帖版');
              },
            ),
          )
        ],
      );
    }
    return current;
  }
}

void showSongCard(BuildContext context, bool show, DownloadSongModel model,
    double cellOffsetY, Offset mouseOffset) {
  final cell = context.findRenderObject() as RenderBox;
  final pixels = Scrollable.of(context)?.position.pixels ?? 0;
  final currentOffset = cellOffsetY;
  double right = cell.size.width / 6;
  double top = currentOffset - pixels;

  // 卡片离详情按钮远一点
  right = right + 6;

  final state = context.read<DownloadPageStateModel>();

  // 计算有没有超过下边界
  if (top + state.cardHeight + 5 > state.pageHeight) {
    top = state.pageHeight - state.cardHeight - 5;
  }

  // 计算有没有超过上边界
  if (top < 5) {
    top = 5;
  }

  if (!show) {
    // 表示鼠标移开了详情按钮，如果不在卡片上，那么久需要隐藏卡片
    final mouseExitY = mouseOffset.dy - 151 - 15 + pixels - cellOffsetY;
    final mouseExitX = mouseOffset.dx - kLeftMenuMaxWidth;
    // debugPrint(
    // "[exit]offset=$mouseOffset, mouseExitY=$mouseExitY, mouseExitX=$mouseExitX, card-size=${state.songCardSize}, page-size=${state.pageSize}");
    // 151是上方高度，这个写死还是有问题的
    // 按钮上方有15的间隙
    // 鼠标移出时的位置在按钮的上方或下方，那么就不显示卡片
    if (mouseExitY <= 1 ||
        mouseExitY >= 20 ||
        (state.pageSize!.width - mouseExitX + 10 < right)) {
      state.songCardOverlay?.remove();
      state.songCardOverlay = null;
      return;
    }
  }
  if (state.songCardOverlay != null) return;
  state.songCardOverlay = OverlayEntry(
    builder: (_) {
      Widget entry = DownloadSongDetailCard(
        model: model,
      );
      entry = MouseRegion(
        child: entry,
        onExit: (event) {
          state.songCardOverlay?.remove();
          state.songCardOverlay = null;
        },
      );
      entry = AfterLayout(
        callback: (value) {
          state.songCardSize = value.size;
        },
        child: entry,
      );
      entry = Positioned(
        top: top,
        right: right,
        child: entry,
      );
      return entry;
    },
  );
  Overlay.of(context)?.insert(state.songCardOverlay!);
}

class SongCardShapeBorder extends ShapeBorder {
  const SongCardShapeBorder({
    this.side = BorderSide.none,
    this.radius = 0,
  });

  final BorderSide side;

  final double radius;

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
    }
  }

  @override
  ShapeBorder scale(double t) {
    return SongCardShapeBorder(side: side.scale(t), radius: radius * t);
  }
}
