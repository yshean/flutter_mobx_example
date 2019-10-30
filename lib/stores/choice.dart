// import 'package:mobx/mobx.dart';
import 'package:json_annotation/json_annotation.dart';

part 'choice.g.dart';

@JsonSerializable()
class Choice {
  final String id;
  final String category;
  final String answer;

  Choice({this.id, this.category, this.answer});

  // /// A necessary factory constructor for creating a new User instance
  // /// from a map. Pass the map to the generated `_$UserFromMappedJson()` constructor.
  // /// The constructor is named after the source class, in this case, User.
  // factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);

  // /// `toJson` is the convention for a class to declare support for serialization
  // /// to JSON. The implementation simply calls the private, generated
  // /// helper method `_$UserToJson`.
  // Map<String, dynamic> toJson() => _$ChoiceToJson(this);

  static Choice fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);
  static Map<String, dynamic> toJson(Choice choice) => _$ChoiceToJson(choice);
}
