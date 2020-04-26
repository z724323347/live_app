// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_http_request.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PageStore on _PageStore, Store {
  final _$curpageAtom = Atom(name: '_PageStore.curpage');

  @override
  int get curpage {
    _$curpageAtom.context.enforceReadPolicy(_$curpageAtom);
    _$curpageAtom.reportObserved();
    return super.curpage;
  }

  @override
  set curpage(int value) {
    _$curpageAtom.context.conditionallyRunInAction(() {
      super.curpage = value;
      _$curpageAtom.reportChanged();
    }, _$curpageAtom, name: '${_$curpageAtom.name}_set');
  }

  final _$perpageAtom = Atom(name: '_PageStore.perpage');

  @override
  int get perpage {
    _$perpageAtom.context.enforceReadPolicy(_$perpageAtom);
    _$perpageAtom.reportObserved();
    return super.perpage;
  }

  @override
  set perpage(int value) {
    _$perpageAtom.context.conditionallyRunInAction(() {
      super.perpage = value;
      _$perpageAtom.reportChanged();
    }, _$perpageAtom, name: '${_$perpageAtom.name}_set');
  }

  final _$conditionAtom = Atom(name: '_PageStore.condition');

  @override
  PageCondition get condition {
    _$conditionAtom.context.enforceReadPolicy(_$conditionAtom);
    _$conditionAtom.reportObserved();
    return super.condition;
  }

  @override
  set condition(PageCondition value) {
    _$conditionAtom.context.conditionallyRunInAction(() {
      super.condition = value;
      _$conditionAtom.reportChanged();
    }, _$conditionAtom, name: '${_$conditionAtom.name}_set');
  }

  final _$sortAtom = Atom(name: '_PageStore.sort');

  @override
  PageSort get sort {
    _$sortAtom.context.enforceReadPolicy(_$sortAtom);
    _$sortAtom.reportObserved();
    return super.sort;
  }

  @override
  set sort(PageSort value) {
    _$sortAtom.context.conditionallyRunInAction(() {
      super.sort = value;
      _$sortAtom.reportChanged();
    }, _$sortAtom, name: '${_$sortAtom.name}_set');
  }

  final _$loadingAtom = Atom(name: '_PageStore.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$nextLoadingAtom = Atom(name: '_PageStore.nextLoading');

  @override
  bool get nextLoading {
    _$nextLoadingAtom.context.enforceReadPolicy(_$nextLoadingAtom);
    _$nextLoadingAtom.reportObserved();
    return super.nextLoading;
  }

  @override
  set nextLoading(bool value) {
    _$nextLoadingAtom.context.conditionallyRunInAction(() {
      super.nextLoading = value;
      _$nextLoadingAtom.reportChanged();
    }, _$nextLoadingAtom, name: '${_$nextLoadingAtom.name}_set');
  }

  final _$errorAtom = Atom(name: '_PageStore.error');

  @override
  MessageError get error {
    _$errorAtom.context.enforceReadPolicy(_$errorAtom);
    _$errorAtom.reportObserved();
    return super.error;
  }

  @override
  set error(MessageError value) {
    _$errorAtom.context.conditionallyRunInAction(() {
      super.error = value;
      _$errorAtom.reportChanged();
    }, _$errorAtom, name: '${_$errorAtom.name}_set');
  }

  final _$resultAtom = Atom(name: '_PageStore.result');

  @override
  List<dynamic> get result {
    _$resultAtom.context.enforceReadPolicy(_$resultAtom);
    _$resultAtom.reportObserved();
    return super.result;
  }

  @override
  set result(List<dynamic> value) {
    _$resultAtom.context.conditionallyRunInAction(() {
      super.result = value;
      _$resultAtom.reportChanged();
    }, _$resultAtom, name: '${_$resultAtom.name}_set');
  }

  final _$responseAtom = Atom(name: '_PageStore.response');

  @override
  PageHttpSuccessResponse<dynamic> get response {
    _$responseAtom.context.enforceReadPolicy(_$responseAtom);
    _$responseAtom.reportObserved();
    return super.response;
  }

  @override
  set response(PageHttpSuccessResponse<dynamic> value) {
    _$responseAtom.context.conditionallyRunInAction(() {
      super.response = value;
      _$responseAtom.reportChanged();
    }, _$responseAtom, name: '${_$responseAtom.name}_set');
  }

  final _$reloadAsyncAction = AsyncAction('reload');

  @override
  Future<void> reload() {
    return _$reloadAsyncAction.run(() => super.reload());
  }

  final _$queryNextAsyncAction = AsyncAction('queryNext');

  @override
  Future<void> queryNext() {
    return _$queryNextAsyncAction.run(() => super.queryNext());
  }

  @override
  String toString() {
    final string =
        'curpage: ${curpage.toString()},perpage: ${perpage.toString()},condition: ${condition.toString()},sort: ${sort.toString()},loading: ${loading.toString()},nextLoading: ${nextLoading.toString()},error: ${error.toString()},result: ${result.toString()},response: ${response.toString()}';
    return '{$string}';
  }
}

mixin _$PageCondition on _PageCondition, Store {
  final _$_conditionAtom = Atom(name: '_PageCondition._condition');

  @override
  Map<String, dynamic> get _condition {
    _$_conditionAtom.context.enforceReadPolicy(_$_conditionAtom);
    _$_conditionAtom.reportObserved();
    return super._condition;
  }

  @override
  set _condition(Map<String, dynamic> value) {
    _$_conditionAtom.context.conditionallyRunInAction(() {
      super._condition = value;
      _$_conditionAtom.reportChanged();
    }, _$_conditionAtom, name: '${_$_conditionAtom.name}_set');
  }

  final _$_PageConditionActionController =
      ActionController(name: '_PageCondition');

  @override
  void setEqual(String field, dynamic value) {
    final _$actionInfo = _$_PageConditionActionController.startAction();
    try {
      return super.setEqual(field, value);
    } finally {
      _$_PageConditionActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_PageConditionActionController.startAction();
    try {
      return super.clear();
    } finally {
      _$_PageConditionActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setList(String field, List<dynamic> value) {
    final _$actionInfo = _$_PageConditionActionController.startAction();
    try {
      return super._setList(field, value);
    } finally {
      _$_PageConditionActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = '';
    return '{$string}';
  }
}
