import 'dart:async';
import 'dart:convert';

import 'package:liveapp/utils/http/error.dart';
import 'package:liveapp/utils/http/http_request.dart';
import 'package:mobx/mobx.dart';

part 'page_http_request.g.dart';

/// 基础分页模型Store
class PageStore = _PageStore with _$PageStore;

abstract class _PageStore with Store {
  /// 服务标志
  String serviceName = 'default';

  /// 服务列表
  Map<String, PageService> services = {};

  /// 所需求和的记录中的键值，不可为内层数据，根据所传condition求和统计 ,在返回值的sum_data中为求和结果
  List<String> sum;

  /// 字段指定获取字段，不传则获取所有
  List<String> fields;

  /// 分组查询 需和聚合联合使用，不支持mongo model
  List<String> group;

  /// 聚合 需和分组联合使用,支持mysql所有聚合方式
  Map<String, String> aggregate;

  /// 指定搜索项，支持表达式方式 fieldAlias:fieldExpression
  Map<String, String> selects;

  /// 当前页
  @observable
  int curpage = 1;

  /// 每页数据数
  @observable
  int perpage = 8;

  /// 查询条件
  @observable
  PageCondition condition;

  /// 排序
  @observable
  PageSort sort;

  /// 全局加载中
  @observable
  bool loading = false;

  /// 上拉加载更多的加载中
  @observable
  bool nextLoading = false;

  /// 错误反馈
  @observable
  MessageError error;

  /// 结果列表
  @observable
  List result = [];

  @observable
  PageHttpSuccessResponse response;

  _PageStore(PageService service,
      {this.curpage,
      this.perpage,
      this.condition,
      this.sort,
      this.sum,
      this.fields,
      this.group,
      this.aggregate,
      this.selects}) {
    services[serviceName] = service;
  }

  /// 当前服务
  PageService get service => services[serviceName];

  void addService(String name, PageService service) {
    services[name] = service;
  }

  /// 下拉重载
  @action
  Future<void> reload() async {
    loading = true;
    curpage = 1;
    try {
      response = await _send();
      result = []..addAll(response.data);
    } catch (err) {
      error = err;
      throw error;
    } finally {
      loading = false;
    }
  }

  /// 上拉加载更多
  @action
  Future<void> queryNext() async {
    nextLoading = true;
    curpage++;
    try {
      PageHttpSuccessResponse response = await _send();
      if (response.data.length == 0) {
        throw MessageError('没有更多数据了', code: 0);
      }
      result = []..addAll(result)..addAll(response.data);
    } catch (err) {
      error = err;
      throw error;
    } finally {
      nextLoading = false;
    }
  }

  Future<PageHttpSuccessResponse> _send() async {
    service
      ..curpage = curpage
      ..perpage = perpage
      ..condition = condition
      ..sort = sort
      ..sum = sum
      ..fields = fields
      ..group = group
      ..aggregate = aggregate
      ..selects = selects;

    try {
      return await service.send();
    } on MessageError catch (err) {
      throw err;
    } on Error catch (err) {
      throw MessageError(err.toString(), code: 0);
    } catch (err) {
      throw MessageError(err.toString(), code: 0);
    }
  }
}

/// 分页成功返回类
abstract class PageHttpSuccessResponse<T> extends HttpSuccessResponse {
  int curpage;

  int perpage;

  int total;

  Map<String, num> sumData;

  List<String> sum;

  Map<String, String> sort;

  Map<String, dynamic> condition;

  List<dynamic> group;

  Map<String, String> aggregate;

  Map<String, String> select;

  List<String> fields;

  List<T> data;

  PageHttpSuccessResponse(Map<String, dynamic> json) {
    curpage = json['curpage'] as int;
    perpage = json['perpage'] as int;
    total = json['total'] as int;
    sumData = (json['sum_data'] is List && _isEmptyList(json['sum_data']))
        ? <String, num>{}
        : Map<String, num>.from(json['sum_data']);
    sum = List<String>.from(json['sum']);
    sort = Map<String, String>.from(json['sort']);
    condition = json['condition'] is List && _isEmptyList(json['condition'])
        ? <String, dynamic>{}
        : json['condition'];
    group = List<String>.from(json['group']);
    aggregate = (json['aggregate'] is List && _isEmptyList(json['aggregate']))
        ? <String, String>{}
        : Map<String, String>.from(json['aggregate']);
    select = (json['select'] is List && _isEmptyList(json['select']))
        ? <String, String>{}
        : Map<String, String>.from(json['select']);
    fields = List<String>.from(json['fields']);
    data = transform(json['data']);
  }

  List<T> transform(dynamic res);
}

/// 分页服务基类
abstract class PageService<T extends PageHttpSuccessResponse>
    extends BasicService<T> {
  PageHttpRequest<T> get request;

  /// 当前页, 默认1
  int curpage;

  /// 查询每页数据量, 默认20
  int perpage;

  /// 需要查询数据，在求和或仅总计时可设为1
  bool noData;

  /// 查询条件
  /// 前缀说明:
  /// * ``__not__`` 若设置，则为不包含什么什么的，如``{__not__group.name:"ceshi"}`` 表示不包含对应组的组名为ceshi的结果，仅支持关联搜索
  /// 后缀说明:
  /// *  ``__gte__`` 同 ``>=``
  /// *  ``__lte__`` 同 ``<=``
  /// *  ``__gt__`` 同 ``>``
  /// *  ``__lt__`` 同 ``<``
  /// *  ``__ne__`` 同 ``<>``
  /// *  ``__in__`` 同 ``IN`` (对于勾选批处理很有用,对多选查询也很有用)
  /// *  ``__nin__`` 同 ``NOT IN``
  /// *  ``__like__`` 同 ``LIKE`` 可用于模糊搜索
  /// *  ``__regexp__`` 同 ``REGEXP`` 正则查询，语法参考mysql正则语法(一般使用LIKE足以)
  /// * ``__both__`` 针对多对多关系的并且条件查询
  PageCondition condition;

  /// 排序, 默认 id 倒序
  PageSort sort;

  /// 所需求和的记录中的键值，不可为内层数据，根据所传condition求和统计 ,在返回值的sum_data中为求和结果
  List<String> sum;

  /// 字段指定获取字段，不传则获取所有
  List<String> fields;

  /// 分组查询 需和聚合联合使用，不支持mongo model
  List<String> group;

  /// 聚合 需和分组联合使用,支持mysql所有聚合方式
  Map<String, String> aggregate;

  /// 指定搜索项，支持表达式方式 fieldAlias:fieldExpression
  Map<String, String> selects;

  PageService({
    this.curpage,
    this.perpage,
    this.noData,
    this.condition,
    this.sort,
    this.sum,
    this.fields,
    this.group,
    this.aggregate,
    this.selects,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {
      "curpage": curpage ?? 1,
      "perpage": perpage ?? 20,
      "no_data": noData == true ? 1 : 0,
      "sort": json.encode(sort?.toJson() ?? {"id": "desc"}),
      "condition": json.encode(condition?.toJson() ?? {})
    };

    if (!_isEmptyList(sum)) result["sum"] = json.encode(sum);
    if (!_isEmptyList(fields)) result["fields"] = json.encode(fields);
    if (!_isEmptyList(group)) result["group"] = json.encode(group);
    if (aggregate != null && aggregate.isNotEmpty)
      result["aggregate"] = json.encode(aggregate);
    if (selects != null && selects.isNotEmpty)
      result["selects"] = json.encode(selects);

    return result;
  }

  @override
  Future<T> send() async {
    return await request.send(data: toJson());
  }
}

class PageCondition = _PageCondition with _$PageCondition;

abstract class _PageCondition with Store {
  /// 内置条件
  @observable
  Map<String, dynamic> _condition = {};

  /// 设置一个相等的字段值
  @action
  void setEqual(String field, value) {
    if (_isEmpty(value)) {
      _condition.remove(field);
    } else {
      _condition[field] = value;
    }
  }

  /// 获取一个相等的字段值
  getEqual(String field) {
    return _condition[field];
  }

  /// 设置一个大于的字段值
  void setGt(String field, value) {
    setEqual('${field}__gt__', value);
  }

  /// 获取一个大于的字段值
  getGt(String field) {
    return getEqual('${field}__gt__');
  }

  /// 设置一个小于的字段值
  void setlt(String field, value) {
    setEqual('${field}__lt__', value);
  }

  /// 获取一个小于的字段值
  getlt(String field) {
    return getEqual('${field}__lt__');
  }

  /// 设置一个大于或等于的字段值
  void setGte(String field, value) {
    setEqual('${field}__gte__', value);
  }

  /// 获取一个大于或等于的字段值
  getGte(String field) {
    return getEqual('${field}__gte__');
  }

  /// 设置一个小于或等于的字段值
  void setlte(String field, value) {
    setEqual('${field}__lte__', value);
  }

  /// 获取一个小于或等于的字段值
  getlte(String field) {
    return getEqual('${field}__lte__');
  }

  /// 设置一个不等于的查询值
  void setNe(String field, value) {
    setEqual('${field}__ne__', value);
  }

  /// 获取一个不等于的查询值
  getNe(String field) {
    return getEqual('${field}__ne__');
  }

  /// 设置一个模糊的查询值
  void setLike(String field, value) {
    setEqual('${field}__like__', '%$value%');
  }

  /// 获取一个模糊的查询值
  getLike(String field) {
    return getEqual('${field}__like__');
  }

  /// 设置一个包含的查询列表
  void setIn(String field, List value) {
    _setList('${field}__in__', value);
  }

  /// 获取一个包含的查询列表
  List getIn(String field) {
    return getEqual('${field}__in__');
  }

  /// 设置一个不包含的查询列表
  void setNin(String field, List value) {
    _setList('${field}__nin__', value);
  }

  /// 获取一个不包含的查询列表
  List getNin(String field) {
    return getEqual('${field}__nin__');
  }

  /// 清除
  @action
  void clear() {
    _condition.clear();
  }

  Map<String, dynamic> toJson() => Map<String, dynamic>.from(_condition);

  @action
  void _setList(String field, List value) {
    if (_isEmptyList(value)) {
      _condition.remove(field);
    } else {
      _condition[field] = value;
    }
  }
}

/// 分页排序类
class PageSort {
  /// 排序的字段
  String field;

  /// 排序的值
  /// true 正序
  /// false 倒序
  bool isAsc;

  PageSort(this.field, this.isAsc) {
    /// 默认倒序
    isAsc ??= false;
  }

  Map<String, String> toJson() => {field: isAsc ? 'asc' : 'desc'};
}

/// 分页请求
class PageHttpRequest<T extends PageHttpSuccessResponse>
    extends HttpRequest<T> {
  PageHttpRequest(String url, RequestOption<T> option)
      : super(url, option: option);
}

bool _isEmpty(value) {
  if (value == null || value == '') {
    return true;
  }
  return false;
}

bool _isEmptyList(List value) {
  return value == null ||
      value.length == 0 ||
      (List.from(value)..removeWhere(_isEmpty)).length == 0;
}
