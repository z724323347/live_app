import 'package:flutter/material.dart';
import 'package:liveapp/configs/public.dart';
import 'package:mobx/mobx.dart';
part 'locale_store.g.dart';

/// 多语言 store
class LocaleStore extends _LocaleStore with _$LocaleStore {
  static LocaleStore _instance;

  factory LocaleStore() => _instance ??= LocaleStore._();

  LocaleStore._() {
    onInit();
  }
}

abstract class _LocaleStore with Store {
  List<String> localeValueList = ['zh-CN', 'en'];

  @observable
  Locale locale;

  @action
  onInit() {
    String languageKey = StorageManager.pref?.getString(StorageKey.kLanguage);

    if (languageKey != null) {
      localeName(languageKey);
      switchLocale(languageKey);
    } else {
      _syncSystemLanguage();
    }
  }

  // 设置跟随系统的语言 (包括系统默认语言)
  _syncSystemLanguage() {
    switchLocale(localeValueList[0]);
  }

  ///选择语言
  @action
  switchLocale(String language) async {
    // _localeIndex = localeValueList.indexOf(language);

    print('locale 1  ---- ${locale}');
    await Future.wait(
        [StorageManager.pref.setString(StorageKey.kLanguage, language)]);
    print(
        'switchLocale    ${StorageManager.pref.getString(StorageKey.kLanguage)}');
    // locale = _locale;
    getLocale();
    print('locale 2  ---- ${locale}');
  }

  @action
  getLocale() {
    int index = localeValueList
            .indexOf(StorageManager.pref.getString(StorageKey.kLanguage)) ??
        0;
    // if (index > 0) {
    var value = localeValueList[index].split('-');
    locale = Locale(value[0], value.length == 2 ? value[1] : '');
    // }
    //跟随系统
    return locale;
  }

  // 语言类型
  @action
  String localeName(index) {
    switch (index) {
      case 0:
        return '中文';

      case 1:
        return 'English';

      default:
        return '中文';
    }
  }
}
