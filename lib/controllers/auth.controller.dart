import 'package:Pesquisei/models/token.return.dart';
import 'package:Pesquisei/repositories/auth.repository.dart';

class AuthController {
  AuthRepository repository;

  AuthController() {
    repository = new AuthRepository();
  }

  Future<TokenReturn> authenticate(String pUser, String pPass) async {
    var token = await repository.authenticate(pUser, pPass);
    return token;
  }
}
