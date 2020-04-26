import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:liveapp/configs/public.dart';
import 'package:flutter_user_agent/flutter_user_agent.dart';
import 'package:liveapp/utils/http/aes.dart';
import 'package:liveapp/utils/http/error.dart';

class RequestMethod {
  const RequestMethod._(this.index);

  final index;

  static const RequestMethod GET = RequestMethod._(0);

  static const RequestMethod POST = RequestMethod._(1);

  static const RequestMethod PUT = RequestMethod._(2);

  static const RequestMethod DELETE = RequestMethod._(3);

  static const List<String> _methods = <String>["GET", "POST", "PUT", "DELETE"];

  @override
  String toString() {
    return _methods[index];
  }
}

abstract class BasicService<T extends HttpSuccessResponse> {
  /// 当前请求
  HttpRequest get request;

  /// 发送请求
  Future<T> send() async {
    return request.send();
  }
}

class HttpRequest<D extends HttpSuccessResponse> {
  static Dio _dio;
  final String url;
  final RequestMethod method;
  final RequestOption<D> option;
  // final SiteStore siteStore = new SiteStore();

  HttpRequest(this.url,
      {this.method = RequestMethod.GET, @required this.option}) {
    updateDio();
  }

  void updateDio() {
    _dio = Dio(BaseOptions(
      // baseUrl: siteStore.baseUrl,
      baseUrl: 'http://',
      connectTimeout: 10000,
      receiveTimeout: 10000,
    ));
  }

  Future<D> send(
      {Map<String, dynamic> data = const <String, dynamic>{},
      bool delectCollect}) async {
    Response response;

    try {
      String token = await getToken();
      await FlutterUserAgent.init();
      Map<String, dynamic> headers = {
        "token": token ?? '',
        // "s": Application.SITE,
        "from": "app",
        "Encode": '1',
        "User-Agent": FlutterUserAgent.userAgent,
      };
      if (delectCollect != null && delectCollect == true) {
        headers['X-HTTP-METHOD-OVERRIDE'] = 'DELETE';
      }
      Options options = Options(headers: headers);

      /// 接口加密的配置
      data = {"params": Aes.encrypt(json.encode(data))};
      if (method != RequestMethod.GET)
        options.headers['content-type'] = 'application/x-www-form-urlencoded';
      switch (method) {
        case RequestMethod.GET:
          {
            response =
                await _dio.get(url, queryParameters: data, options: options);
            break;
          }
        case RequestMethod.POST:
          {
            response = await _dio.post(url, data: data, options: options);
            break;
          }
        case RequestMethod.PUT:
          {
            response = await _dio.put(url, data: data, options: options);
            break;
          }
        case RequestMethod.DELETE:
          {
            response = await _dio.delete(url, data: data, options: options);
          }
      }
    } on DioError catch (e) {
      if (e.response == null) {
        throw MessageError('网络连接超时', code: 0);
      }
      var result = e.response.data;

      if (e.response.headers.value(Headers.contentTypeHeader) !=
          'application/json') {
        try {
          result = json.decode(result);
        } catch (e) {
          result = result;
        }
      }
      // print('code ${result}');
      try {
        int _code = result['code'];
         print('http_request   ${_code}');
        if (_code == 2004 || _code == 2005 || _code == 2006) {
          // 重新登录
          // GlobalEvents.onLogout.add(null);
        }
      } catch (e) {
        throw MessageError('网络连接超时', code: 0);
      }

      throw MessageError(result['message'], code: result['code']);
    }

    Map<String, dynamic> responseData;

    if (response.headers
        .value(Headers.contentTypeHeader)
        .contains('application/json')) {
      responseData = response.data;
    } else {
      responseData = json.decode(response.data);
    }

    if (responseData['encoded'] == '1') {
      String t;
      try {
        t = Aes.decrypt(responseData['data']);
        responseData['data'] = json.decode(t);
      } catch (e) {
        if (t != null) {
          responseData['data'] = t;
        }
      }
    }
    var _data = handleResponse(responseData);
    return option.transform(_data);
  }

  handleResponse(Map<String, dynamic> res) {
    return res['data'];
  }

  Future<String> getToken() async {
    if (option.token != null) {
      return option.token;
    } else {
      // return tokenStorage.get();
      return 'token';
    }
  }
}

class RequestOption<D extends HttpSuccessResponse> {
  /// 设置针对当前请求的专用token，如果没设置，则请求不使用该token
  final String token;

  /// 成功时对数据格式的处理
  final D Function(dynamic data) transform;

  RequestOption({this.token, @required this.transform})
      : assert(transform != null);
}

/// 请求错误返回数据格式
// @JsonSerializable(nullable: false)
// class HttpErrorResponse {
//   final int code;
//   final String message;

//   HttpErrorResponse({
//     @required this.code,
//     @required this.message,
//   });

//   factory HttpErrorResponse.fromJson(Map<String, dynamic> json) {
//     return _$HttpErrorResponseFromJson(json);
//   }
// }

// 请求成果返回数据格式
class HttpSuccessResponse {
  // final int code;
  // final T data;

  // HttpSuccessResponse({
  //   this.code,
  //   this.data,
  // });

  // factory HttpSuccessResponse.fromJson(Map<String, dynamic> json) {
  //   return HttpSuccessResponse(
  //     code: json['code'] as int,
  //     data: json['data'] as T
  //   );
  // }
}
