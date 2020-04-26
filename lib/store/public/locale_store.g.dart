// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LocaleStore on _LocaleStore, Store {
  final _$localeAtom = Atom(name: '_LocaleStore.locale');

  @override
  Locale get locale {
    _$localeAtom.context.enforceReadPolicy(_$localeAtom);
    _$localeAtom.reportObserved();
    return super.locale;
  }

  @override
  set locale(Locale value) {
    _$localeAtom.context.conditionallyRunInAction(() {
      super.locale = value;
      _$localeAtom.reportChanged();
    }, _$localeAtom, name: '${_$localeAtom.name}_set');
  }

  final _$switchLocaleAsyncAction = AsyncAction('switchLocale');

  @override
  Future switchLocale(String language) {
    return _$switchLocaleAsyncAction.run(() => super.switchLocale(language));
  }

  final _$_LocaleStoreActionController = ActionController(name: '_LocaleStore');

  @override
  dynamic onInit() {
    final _$actionInfo = _$_LocaleStoreActionController.startAction();
    try {
      return super.onInit();
    } finally {
      _$_LocaleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getLocale() {
    final _$actionInfo = _$_LocaleStoreActionController.startAction();
    try {
      return super.getLocale();
    } finally {
      _$_LocaleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String localeName(dynamic index) {
    final _$actionInfo = _$_LocaleStoreActionController.startAction();
    try {
      return super.localeName(index);
    } finally {
      _$_LocaleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'locale: ${locale.toString()}';
    return '{$string}';
  }
}
