

import 'package:flutter_crud/view-models/signup.viewmodel.dart';
import 'package:flutter_crud/views/user.model.dart';

class AccountRepository {
  Future<UserModel> createAccount(SignupViewModel model) async {
    await Future.delayed(new Duration(milliseconds: 1500));
    return new UserModel(
      id: "1",
      name: "Administrador",
      email: "administrador@perguntei.com",
      picture: "https://picsum.photos/200/200",
      role: "admin",
      token: "123456789",
    );
  }
}
