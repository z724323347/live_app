import 'dart:convert';

import 'package:flutter/services.dart';

class HttpMockRequest {
  static Future<dynamic> get({String action, Map params}) async {
    //模拟虚拟数据
    return HttpMockRequest.mock(action: action, params: params);
  }

  static Future<dynamic> post({String action, Map params}) async {
    //模拟虚拟数据
    return HttpMockRequest.mock(action: action, params: params);
  }

  static Future<dynamic> mock({String action, Map params}) async {
    var responseStr = await rootBundle.loadString('assets/mock/$action.json');
    var responseJson = json.decode(responseStr);
    print(responseJson['data']);
    return responseJson['data'];
  }
}
