import 'package:cloud_firestore/cloud_firestore.dart';
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

  UserModel.fromQueryDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc, String email) {
    this.email = email;
    birthday = doc['birthday'] as String;
    name = doc['name'] as String;
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
