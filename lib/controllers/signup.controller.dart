
import 'package:flutter_crud/repositories/account.repository.dart';
import 'package:flutter_crud/view-models/signup.viewmodel.dart';
import 'package:flutter_crud/views/user.model.dart';

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
