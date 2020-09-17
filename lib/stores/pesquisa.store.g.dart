// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pesquisa.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PesquisaStore on _PesquisaStore, Store {
  final _$idAtom = Atom(name: '_PesquisaStore.id');

  @override
  int get id {
    _$idAtom.context.enforceReadPolicy(_$idAtom);
    _$idAtom.reportObserved();
    return super.id;
  }

  @override
  set id(int value) {
    _$idAtom.context.conditionallyRunInAction(() {
      super.id = value;
      _$idAtom.reportChanged();
    }, _$idAtom, name: '${_$idAtom.name}_set');
  }

  final _$nomeAtom = Atom(name: '_PesquisaStore.nome');

  @override
  String get nome {
    _$nomeAtom.context.enforceReadPolicy(_$nomeAtom);
    _$nomeAtom.reportObserved();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.context.conditionallyRunInAction(() {
      super.nome = value;
      _$nomeAtom.reportChanged();
    }, _$nomeAtom, name: '${_$nomeAtom.name}_set');
  }

  final _$descricaoAtom = Atom(name: '_PesquisaStore.descricao');

  @override
  String get descricao {
    _$descricaoAtom.context.enforceReadPolicy(_$descricaoAtom);
    _$descricaoAtom.reportObserved();
    return super.descricao;
  }

  @override
  set descricao(String value) {
    _$descricaoAtom.context.conditionallyRunInAction(() {
      super.descricao = value;
      _$descricaoAtom.reportChanged();
    }, _$descricaoAtom, name: '${_$descricaoAtom.name}_set');
  }

  final _$idbairroAtom = Atom(name: '_PesquisaStore.idbairro');

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

  final _$idcidadeAtom = Atom(name: '_PesquisaStore.idcidade');

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

  final _$perguntasAtom = Atom(name: '_PesquisaStore.perguntas');

  @override
  List<PerguntaQuiz> get perguntas {
    _$perguntasAtom.context.enforceReadPolicy(_$perguntasAtom);
    _$perguntasAtom.reportObserved();
    return super.perguntas;
  }

  @override
  set perguntas(List<PerguntaQuiz> value) {
    _$perguntasAtom.context.conditionallyRunInAction(() {
      super.perguntas = value;
      _$perguntasAtom.reportChanged();
    }, _$perguntasAtom, name: '${_$perguntasAtom.name}_set');
  }

  final _$setPerguntasAsyncAction = AsyncAction('setPerguntas');

  @override
  Future<void> setPerguntas(int pId) {
    return _$setPerguntasAsyncAction.run(() => super.setPerguntas(pId));
  }

  final _$_PesquisaStoreActionController =
      ActionController(name: '_PesquisaStore');

  @override
  void setPesquisa(
      int pId, String pNome, String pDescricao, int pIdBairro, int pIdCidade) {
    final _$actionInfo = _$_PesquisaStoreActionController.startAction();
    try {
      return super.setPesquisa(pId, pNome, pDescricao, pIdBairro, pIdCidade);
    } finally {
      _$_PesquisaStoreActionController.endAction(_$actionInfo);
    }
  }
}
