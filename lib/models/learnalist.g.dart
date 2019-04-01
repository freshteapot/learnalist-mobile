// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learnalist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListInfo _$ListInfoFromJson(Map<String, dynamic> json) {
  return ListInfo(
      json['title'] as String, json['type'] as String, json['from'] as String);
}

Map<String, dynamic> _$ListInfoToJson(ListInfo instance) => <String, dynamic>{
      'title': instance.title,
      'type': instance.listType,
      'from': instance.from
    };

Alist _$AlistFromJson(Map<String, dynamic> json) {
  return Alist(
      uuid: json['uuid'] as String,
      listInfo: ListInfo.fromJson(json['info'] as Map<String, dynamic>),
      listData: json['data']);
}

Map<String, dynamic> _$AlistToJson(Alist instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'info': instance.listInfo,
      'data': instance.listData
    };

// **************************************************************************
// JsonLiteralGenerator
// **************************************************************************

final _$exampleListV2JsonLiteral = {
  'data': [
    {'from': 'appelsinen', 'to': 'the orange'},
    {'from': 'måltidet', 'to': 'the meal'},
    {'from': 'saltet', 'to': 'the salt'},
    {'from': 'ender', 'to': 'ducks'},
    {'from': 'remsen', 'to': 'strip (of paper)'}
  ],
  'info': {'title': 'Norweigan words on Duolingo', 'type': 'v2'},
  'uuid': 'ad573393-4898-5c23-9781-3f0caafd7734'
};

final _$exampleListV1JsonLiteral = {
  'data': ['kiwi', 'ginger'],
  'info': {
    'from': '8e678305-5bf4-4461-9bc8-cc57907e181f',
    'title': 'Kiwi and Ginger smoothie',
    'type': 'v1'
  },
  'uuid': '8b19f084-430d-5dc4-a7a1-f404c85a06b1'
};
