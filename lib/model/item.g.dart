// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Item _$$_ItemFromJson(Map<String, dynamic> json) => _$_Item(
      label: json['label'] as String,
      ranking: json['ranking'] as int,
      score: json['score'] as int,
      link: json['link'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$_ItemToJson(_$_Item instance) => <String, dynamic>{
      'label': instance.label,
      'ranking': instance.ranking,
      'score': instance.score,
      'link': instance.link,
      'description': instance.description,
    };
