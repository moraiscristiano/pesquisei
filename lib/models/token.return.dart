import 'package:flutter_crud/models/token.dart';

class TokenReturn {
  int statuscode;
  String error = "";
  String error_description = "";
  Token token;

  TokenReturn(
      {this.statuscode, this.error, this.error_description, this.token});

  TokenReturn.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    error = json['error'];
    error_description = json['error_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuscode'] = this.statuscode;
    data['error'] = this.error;
    data['error_description'] = this.error_description;
    return data;
  }
}
