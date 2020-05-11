import 'package:dev_util/dev_util.dart';
import 'package:flutter/material.dart';
import 'package:liveapp/generated/l10n.dart';

class Language {
  static BuildContext context = GlobalNavigator.navigatorKey.currentState.overlay.context;
  static S of() => S.of(context);
}