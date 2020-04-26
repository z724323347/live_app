import 'dart:async';

import 'package:liveapp/utils/http/error.dart';
import 'package:liveapp/utils/http/http_request.dart';

class BulkHttpSucessResponse extends HttpSuccessResponse {
  List result;
  BulkHttpSucessResponse(this.result);
}

class BulkRequest {
  /// 请求列表
  List<BulkRequestItem> _list = <BulkRequestItem>[];

  /// 内置并发请求
  HttpRequest _request = HttpRequest<BulkHttpSucessResponse>('/bulk',
      method: RequestMethod.POST,
      option: RequestOption(
          transform: (json) => BulkHttpSucessResponse(json as List)));

  /// 添加请求
  void add<T extends HttpSuccessResponse>(BulkRequestItem<T> item) {
    _list.add(item);
  }

  /// 并发
  ///
  /// @param ignoreError 是否忽略错误，如果为false，任何一个子请求失败，就会直接抛出错误
  ///
  Future<BulkHttpSucessResponse> send({bool ignoreError = true}) async {
    if (_list.length == 0) {
      return null;
    }
    List<Map<String, dynamic>> requests = [];
    List<MessageError> errors = [];
    for (BulkRequestItem item in _list) {
      requests.add({
        "method": item.request.method.toString(),
        "uri": item.request.url,
        "parameters": <String, dynamic>{"token": await item.request.getToken()}
          ..addAll(item.data)
      });
    }
    try {
      BulkHttpSucessResponse response =
          await _request.send(data: {"sub_requests": requests});
      int index = 0;
      List _result = [];
      for (var d in response.result) {
        BulkRequestItem item = _list[index];
        try {
          if (d['data'] == '') {
            throw MessageError(d['message'], code: d['code']);
          }
          var res = item.request.handleResponse(d);
          var transformResponse = item.request.option.transform(res);
          if (item.success != null) item.success(transformResponse);
          _result.add(transformResponse);
        } on MessageError catch (err) {
          if (item.error != null) item.error(err);
          errors.add(err);
        } catch (err) {
          MessageError msg = MessageError(err.toString(), code: 0);
          if (item.error != null) item.error(msg);
          errors.add(msg);
        }
        index++;
      }

      /// 如果准备忽略错误, 则直接报错
      if (errors.length > 0 && !ignoreError) {
        throw MessageError(errors[0].message, code: errors[0].code);
      }
      return BulkHttpSucessResponse(_result);
    } catch (err) {
      throw err;
    }
  }
}

class BulkRequestItem<T extends HttpSuccessResponse> {
  final HttpRequest<T> request;
  final Map<String, dynamic> data;
  final void Function(T response) success;
  final void Function(MessageError msg) error;

  BulkRequestItem(this.request,
      {this.data = const <String, dynamic>{}, this.success, this.error});
}
