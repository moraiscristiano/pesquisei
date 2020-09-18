import 'package:mobx/mobx.dart';
part 'app.store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  String name = "";

  @observable
  String pass = "";

  @observable
  String email = "";

  @observable
  String picture = "";

  @observable
  String token = "";

  @action
  void setUser(
    String pName,
    String pPass,
    String pEmail,
    String pPicture,
    String pToken,
  ) {
    name = pName;
    pass = pPass;
    email = pEmail;
    picture = pPicture;
    token = pToken;
  }
}
