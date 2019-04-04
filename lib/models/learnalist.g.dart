// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learnalist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListInfo _$ListInfoFromJson(Map<String, dynamic> json) {
  return ListInfo(json['title'] as String,
      _$enumDecode(_$ListTypeEnumMap, json['type']), json['from'] as String);
}

Map<String, dynamic> _$ListInfoToJson(ListInfo instance) => <String, dynamic>{
      'title': instance.title,
      'type': _$ListTypeEnumMap[instance.listType],
      'from': instance.from
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

const _$ListTypeEnumMap = <ListType, dynamic>{
  ListType.v1: 'v1',
  ListType.v2: 'v2'
};

AlistDatabase _$AlistDatabaseFromJson(Map<String, dynamic> json) {
  return AlistDatabase(
      items: (json['items'] as List)
          .map((e) => Alist.fromJson(e as Map<String, dynamic>))
          .toList());
}

Map<String, dynamic> _$AlistDatabaseToJson(AlistDatabase instance) =>
    <String, dynamic>{'items': instance.items};

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

AlistV1 _$AlistV1FromJson(Map<String, dynamic> json) {
  return AlistV1(
      uuid: json['uuid'], listInfo: json['info'], listData: json['data']);
}

Map<String, dynamic> _$AlistV1ToJson(AlistV1 instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'info': instance.listInfo,
      'data': instance.listData
    };

AlistV2 _$AlistV2FromJson(Map<String, dynamic> json) {
  return AlistV2(
      uuid: json['uuid'], listInfo: json['info'], listData: json['data']);
}

Map<String, dynamic> _$AlistV2ToJson(AlistV2 instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'info': instance.listInfo,
      'data': instance.listData
    };

AlistItemTypeV2 _$AlistItemTypeV2FromJson(Map<String, dynamic> json) {
  return AlistItemTypeV2(json['from'] as String, json['to'] as String);
}

Map<String, dynamic> _$AlistItemTypeV2ToJson(AlistItemTypeV2 instance) =>
    <String, dynamic>{'from': instance.from, 'to': instance.to};

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
