// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class UserModel {
  @JsonKey()
  String? name;
  String? email;
  @JsonKey()
  String? birthday;

  UserModel.allFields(this.name, this.email, this.birthday);

  UserModel(this.name, this.birthday);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
