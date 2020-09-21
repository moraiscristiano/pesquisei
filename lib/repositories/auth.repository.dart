import 'dart:convert';

import 'package:Pesquisei/models/token.dart';
import 'package:Pesquisei/models/token.return.dart';
import 'package:Pesquisei/utils/strings.dart';
import 'package:http/http.dart';

class AuthRepository {
  Future<TokenReturn> authenticate(String pUser, String pPass) async {
    TokenReturn tokenReturn = new TokenReturn();

    String username = pUser;
    String password = pPass;
    String grantType = Strings.GRANT_TYPE_WEB_API;
    String usernameApi = Strings.USER_WEB_API;
    String passwordApi = Strings.PASS_WEB_API;

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameApi:$passwordApi'));

    var r = await post(Strings.BASE_URL_WEB_API + Strings.URL_AUTH_WEB_API,
        body: {
          'grant_type': grantType,
          'username': username,
          'password': password
        },
        headers: <String, String>{
          'authorization': basicAuth
        });

    if (r.statusCode == 200) {
      Map map = json.decode(r.body);

      tokenReturn.token = Token.fromJson(map);
      tokenReturn.statuscode = r.statusCode;
    } else {
      Map map = json.decode(r.body);

      tokenReturn.statuscode = r.statusCode;
      tokenReturn.error = map['error'];
      tokenReturn.error_description = map['error_description'];
    }

    return tokenReturn;
  }
}
