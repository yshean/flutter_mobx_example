// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Choice _$ChoiceFromJson(Map<String, dynamic> json) {
  return Choice(
      id: json['id'] as String,
      category: json['category'] as String,
      answer: json['answer'] as String);
}

Map<String, dynamic> _$ChoiceToJson(Choice instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'answer': instance.answer
    };
