import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liveapp/configs/public.dart';
import 'package:liveapp/generated/l10n.dart';
import 'package:liveapp/pages/index.dart';
import 'package:liveapp/pages/splash.dart';
import 'package:liveapp/pages/user/user_center.dart';
import 'package:liveapp/store/public/locale_store.dart';
import 'package:liveapp/utils/locale/cupertino_localizations_delegate.dart';

// void main() => runApp(MyApp());
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // final LocaleStore localeStore = LocaleStore();

  final GlobalKey key = GlobalNavigator.navigatorKey;

  @override
  void initState() {
    super.initState();

    FlutterBoost.singleton.registerPageBuilders(<String, PageBuilder>{
      ///可以在native层通过 getContainerParams 来传递参数
      'flutterPage': (String pageName, Map<dynamic, dynamic> params, String _) {
        print('flutterPage params:$params');
        return Index();
      },
      'testPage': (String pageName, Map<dynamic, dynamic> params, String _) {
        print('flutterPage params:$params');
        return TestPage();
      },
      'flutterFragment': (String pageName, Map<dynamic, dynamic> params, String _) =>
          UserCenter(),
    });
    FlutterBoost.singleton
        .addBoostNavigatorObserver(TestBoostNavigatorObserver());
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => MaterialApp(
              title: 'app',
              navigatorKey: key,
              // theme: ThemeData(platform: TargetPlatform.iOS),
              localizationsDelegates: [
                S.delegate,
                CupertinoLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                print('deviceLocale: $deviceLocale');
                return deviceLocale;
              },
              home: Container(
                color: Colors.white,
              ),
              builder: FlutterBoost.init(postPush: _onRoutePushed),
              routes: Routes.routes,
              onGenerateRoute: Routes.onGenerateRoute,
            ));
  }

  void _onRoutePushed(
    String pageName,
    String uniqueId,
    Map<dynamic, dynamic> params,
    Route<dynamic> route,
    Future<dynamic> _,
  ) {}
}

class TestBoostNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('flutterboost#didPush');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('flutterboost#didPop');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('flutterboost#didRemove');
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    print('flutterboost#didReplace');
  }
}
