import 'dart:async';

class GlobalEvents {
  const GlobalEvents._();

  static final onLogin = StreamController<LoginEvent>.broadcast();

  static final onLogout = StreamController.broadcast();

  static final onWebDirect = StreamController<WebEvent>.broadcast();

  static final onSearchEvent = StreamController<SearchEvent>.broadcast();

  static final onWebToExtra = StreamController<SearchEvent>.broadcast();

  static final StreamController<RecommendEvent> onGetRecommend = StreamController<RecommendEvent>.broadcast();
  

  static void destory() {
    onLogin?.close();
    onLogout?.close();
    onWebDirect?.close();
    onSearchEvent?.close();
    onWebToExtra?.close();
    onGetRecommend?.close();
  }
}

class LoginEvent {
  // 是否展开投注列表
  final bool visitor;

  LoginEvent({this.visitor});
}

class WebEvent {
  ///
  final String url;

  WebEvent({this.url});
}

class SearchEvent {
  /// 搜索 tag
  final String tag;

  /// 输入内容
  final String inputText;

  /// 是否提交搜索
  final bool submit;

  /// 是否绝对匹配
  final bool strictMatch;

  SearchEvent({this.tag, this.inputText, this.submit, this.strictMatch = false});
}

class RecommendEvent {
  // 是否展开投注列表
  final String action;

  final Map<String, dynamic> params;

  RecommendEvent({this.action, this.params});
}
