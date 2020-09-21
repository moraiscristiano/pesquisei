import 'package:Pesquisei/view-models/signup.viewmodel.dart';
import 'package:Pesquisei/models/user.model.dart';

class AccountRepository {
  Future<UserModel> createAccount(SignupViewModel model) async {
    await Future.delayed(new Duration(milliseconds: 1500));
    return new UserModel(
      id: "1",
      name: "admin",
      pass: "admin123",
      email: "administrador@perguntei.com",
      picture: "",
      role: "admin",
      token: "",
    );
  }
}
