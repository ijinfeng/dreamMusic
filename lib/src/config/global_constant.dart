
// 左侧菜单栏最大宽度
import 'package:flutter/material.dart';

const double kLeftMenuMaxWidth = 200;

// 导航栏高度
const double kWindowNavigationBarHeight = 50;

/// 具有一个返回值的回调函数
typedef OneResultCallback<T> = T Function();
/// 有个参数的回调
typedef OneParamCallback<T> = void Function(T);

/// 页面内间距
const EdgeInsets kPageContentPadding = EdgeInsets.fromLTRB(20, 12, 20, 12);