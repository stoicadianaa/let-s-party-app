import 'package:lets_party/app/party_invited/party_invited_bloc.dart';
import 'package:lets_party/app/signup/signup_bloc.dart';

mixin StringMixins {
  String formatDate(DateTime date) =>
      "${date.day.toString()}/${date.month.toString()}/${date.year.toString()}";
}