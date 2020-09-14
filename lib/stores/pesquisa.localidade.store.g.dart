// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pesquisa.localidade.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PesquisaLocalidadeStore on _PesquisaLocaliadeStore, Store {
  final _$idcidadeAtom = Atom(name: '_PesquisaLocaliadeStore.idcidade');

  @override
  int get idcidade {
    _$idcidadeAtom.context.enforceReadPolicy(_$idcidadeAtom);
    _$idcidadeAtom.reportObserved();
    return super.idcidade;
  }

  @override
  set idcidade(int value) {
    _$idcidadeAtom.context.conditionallyRunInAction(() {
      super.idcidade = value;
      _$idcidadeAtom.reportChanged();
    }, _$idcidadeAtom, name: '${_$idcidadeAtom.name}_set');
  }

  final _$idbairroAtom = Atom(name: '_PesquisaLocaliadeStore.idbairro');

  @override
  int get idbairro {
    _$idbairroAtom.context.enforceReadPolicy(_$idbairroAtom);
    _$idbairroAtom.reportObserved();
    return super.idbairro;
  }

  @override
  set idbairro(int value) {
    _$idbairroAtom.context.conditionallyRunInAction(() {
      super.idbairro = value;
      _$idbairroAtom.reportChanged();
    }, _$idbairroAtom, name: '${_$idbairroAtom.name}_set');
  }

  final _$_PesquisaLocaliadeStoreActionController =
      ActionController(name: '_PesquisaLocaliadeStore');

  @override
  void setPesquisaLocalidade(int pIdCidade, int pIdBairro) {
    final _$actionInfo =
        _$_PesquisaLocaliadeStoreActionController.startAction();
    try {
      return super.setPesquisaLocalidade(pIdCidade, pIdBairro);
    } finally {
      _$_PesquisaLocaliadeStoreActionController.endAction(_$actionInfo);
    }
  }
}
