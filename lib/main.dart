import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:liveapp/configs/public.dart';
import 'package:liveapp/generated/l10n.dart';
import 'package:liveapp/pages/splash.dart';
import 'package:liveapp/store/public/locale_store.dart';
import 'package:liveapp/utils/locale/cupertino_localizations_delegate.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final LocaleStore localeStore = LocaleStore();
  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => MaterialApp(
              title: 'app',
              navigatorKey: GlobalNavigator.navigatorKey,
              theme: ThemeData(platform: TargetPlatform.iOS),
              locale: localeStore.locale,
              localizationsDelegates: [
                S.delegate,
                CupertinoLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                print('deviceLocale: $deviceLocale');
              },
              home: Splash(),
              routes: Routes.routes,
              onGenerateRoute: Routes.onGenerateRoute,
            ));
  }
}
