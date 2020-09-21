
import 'package:Pesquisei/repositories/account.repository.dart';
import 'package:Pesquisei/view-models/signup.viewmodel.dart';
import 'package:Pesquisei/models/user.model.dart';

class SignupController {
  AccountRepository repository;

  SignupController() {
    repository = new AccountRepository();
  }

  Future<UserModel> create(SignupViewModel model) async {
    model.busy = true;
    var user = await repository.createAccount(model);
    model.busy = false;
    return user;
  }
}
