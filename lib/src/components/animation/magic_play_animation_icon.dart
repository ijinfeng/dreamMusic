import 'package:flutter/material.dart';

class MagicPlayAnimationIcon extends StatefulWidget {
  const MagicPlayAnimationIcon({
    Key? key,
    this.width = 25,
    this.height = 25,
    this.color,
    this.playing = true,
    this.stripeSpace,
  }) : super(key: key);

  final double width;

  final double height;

  final Color? color;

  final bool playing;

  final double? stripeSpace;

  @override
  State<StatefulWidget> createState() {
    return _MagicPlayAnimationIconState();
  }
}

class _MagicPlayAnimationIconState extends State<MagicPlayAnimationIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.width, widget.height),
      painter: MagicPlayAnimationPainter(
          playing: widget.playing,
          color: widget.color,
          stripeSapce: widget.stripeSpace,
          factor: _animation),
    );
  }
}

class MagicPlayAnimationPainter extends CustomPainter {
  MagicPlayAnimationPainter(
      {required this.playing,
      required this.factor,
      this.color,
      this.stripeSapce})
      : super(repaint: factor);

  final bool playing;

  /// 0～1动画因子
  final Animation<double> factor;

  /// 条纹颜色
  final Color? color;

  final double? stripeSapce;

  double _calcueValue(double scale) {
    double ret = scale;
    if (playing) {
      ret = 1.0 - factor.value - scale;
    }
    return ret;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color ?? Colors.black;
    // 0 | 1 | 2 | 3 | 4
    // 0=4, 1=3, 2
    double space = stripeSapce ?? 2.0;
    double stripeWidth = (size.width - 4 * space) / 5;

    // 0,4
    double h04 = size.height * _calcueValue(1.0 / 3);

    // 1,3
    double h13 = size.height * _calcueValue(1.0 / 2);

    // 2
    double h2 = size.height * _calcueValue(1.0);

    double offsetx = 0;
    Radius radius = Radius.zero;
    // 0
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Offset(offsetx, (size.height - h04) / 2) & Size(stripeWidth, h04),
            radius),
        paint);

    offsetx += stripeWidth + space;
    // 1
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Offset(offsetx, (size.height - h13) / 2) & Size(stripeWidth, h13),
            radius),
        paint);

    offsetx += stripeWidth + space;
    // 2
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Offset(offsetx, (size.height - h2) / 2) & Size(stripeWidth, h2),
            radius),
        paint);

    offsetx += stripeWidth + space;
    // 3
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Offset(offsetx, (size.height - h13) / 2) & Size(stripeWidth, h13),
            radius),
        paint);

    offsetx += stripeWidth + space;
    // 4
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Offset(offsetx, (size.height - h04) / 2) & Size(stripeWidth, h04),
            radius),
        paint);
  }

  @override
  bool shouldRepaint(covariant MagicPlayAnimationPainter oldDelegate) {
    return oldDelegate.factor != factor ||
        oldDelegate.playing != playing ||
        oldDelegate.color != color ||
        oldDelegate.stripeSapce != stripeSapce;
  }
}
