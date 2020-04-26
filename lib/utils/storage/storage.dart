library flutter_complex_storage;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

part 'manager.dart';

/// App所有的storage都写到该文件中

/// 登录token
final tokenStorage = StorageManager<String>('token');

/// 保存用户信息
final userInfoStorage = StorageManager<Map>('userInfo');

/// 保存登录信息
final StorageManager<Map> cookiesAuthStorage = StorageManager<Map>('_cookiesAuth');

/// 推荐注册码
final StorageManager<String> registerCodeStorage = StorageManager<String>('_registerCode');

/// 本地头像
final StorageManager<int> avatarStorage = StorageManager<int>('avatar');

/// 保存日期
final StorageManager<String> dateStorage = StorageManager<String>('date');

/// 请求基础url
final baseUrlStorage = StorageManager<String>('baseUrl');

final StorageManager<String> gamePlatformSorage = StorageManager<String>('gamePlatform');

/// 站点设置
final siteStorage = StorageManager<Map<String, dynamic>>('site');

/// 默认金额
final StorageManager<String> defaultBetStorage = StorageManager<String>('defaultBetStorage');

/// 保存banners信息
final StorageManager<List> bannersStorage = StorageManager<List>('banners');

/// 服务器时间
final StorageManager<int> dcStorage = StorageManager<int>('_dc');

/// 两面/六合不再显示确认投注弹窗
final StorageManager<bool> betConfirmNoPromptAgainStorage = StorageManager<bool>('betConfirmNoPromptAgainStorage');

/// 搜索记录缓存
final StorageManager<Map> searchStorage = StorageManager<Map>('_searchStorage');

/// 自定义盘口缓存
final StorageManager<Map> sport188CustomStorage = StorageManager<Map>('sport188CustomStorage');

/// 自定义盘口缓存 电竞
final StorageManager<Map> gameCustomStorage = StorageManager<Map>('gameCustomStorage');

/// 默认项目  体育 / 电竞
final StorageManager<String> defaultGamePorject = StorageManager<String>('defaultGamePorject');
final StorageManager<String> defaultSportPorject = StorageManager<String>('defaultSportPorject');

/// 多语言
// final languageStorage = StorageManager<String>('language');

/// 主题色
// final themeStorage = StorageManager<int>('themeIndex');
