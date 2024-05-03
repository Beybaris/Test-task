import 'package:application/data/model/roles_model.dart';
import 'package:application/data/model/userData_model.dart';

class AuthTokensModel {
  int? id;
  bool? status;
  String? login;
  String? email;
  String? token;
  String? tokenExpired;
  String? refreshToken;
  String? refreshTokenExpired;
  Null? avatar;
  UserData? userData;
  List<Roles>? roles;

  AuthTokensModel(
      {this.id,
      this.status,
      this.login,
      this.email,
      this.token,
      this.tokenExpired,
      this.refreshToken,
      this.refreshTokenExpired,
      this.avatar,
      this.userData,
      this.roles});

  AuthTokensModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    login = json['login'];
    email = json['email'];
    token = json['token'];
    tokenExpired = json['token_expired'];
    refreshToken = json['refresh_token'];
    refreshTokenExpired = json['refresh_token_expired'];
    avatar = json['avatar'];
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['login'] = this.login;
    data['email'] = this.email;
    data['token'] = this.token;
    data['token_expired'] = this.tokenExpired;
    data['refresh_token'] = this.refreshToken;
    data['refresh_token_expired'] = this.refreshTokenExpired;
    data['avatar'] = this.avatar;
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
