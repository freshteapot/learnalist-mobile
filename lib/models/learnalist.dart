import 'package:json_annotation/json_annotation.dart';

part 'learnalist.g.dart';

enum ListType {
  v1,
  v2,
}

@JsonSerializable()
class ListInfo {
  String title;

  @JsonKey(name: 'type', nullable: false)
  final ListType listType;

  final String from;

  ListInfo(this.title, this.listType, this.from);

  factory ListInfo.fromJson(Map<String, dynamic> json) =>
      _$ListInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ListInfoToJson(this);
}

@JsonSerializable()
class AlistDatabase {
  @JsonKey(name: 'items', nullable: false)
  List<Alist> items;

  AlistDatabase({this.items});

  factory AlistDatabase.fromJson(Map<String, dynamic> json) =>
      _$AlistDatabaseFromJson(json);

  Map<String, dynamic> toJson() => _$AlistDatabaseToJson(this);
}

@JsonSerializable()
class Alist {
  @override
  int get hashCode {
    // TODO is this enough?
    return uuid.hashCode;
  }

  @override
  bool operator ==(Object other) {
    bool result = false;
    if (other is Alist && uuid == other.uuid) {
      result = true;
    }
    return result;
  }

  final String uuid;
  @JsonKey(name: 'info', nullable: false)
  final ListInfo listInfo;

  @JsonKey(name: 'data', nullable: false)
  final dynamic listData;

  Alist({this.uuid, this.listInfo, this.listData});

  factory Alist.fromJson(Map<String, dynamic> json) => _$AlistFromJson(json);

  Map<String, dynamic> toJson() => _$AlistToJson(this);
  Alist toAlist() {}
}

@JsonSerializable()
class AlistV1 extends Alist {
  @JsonKey(name: 'data', nullable: false)
  final List<String> listData = List<String>();

  AlistV1({uuid, listInfo, listData}) : super(uuid: uuid, listInfo: listInfo);

  Map<String, dynamic> toJson() => _$AlistV1ToJson(this);
}

AlistV1 newAlistV1(Alist aList) {
  AlistV1 temp = AlistV1(
      uuid: aList.uuid, listInfo: aList.listInfo, listData: aList.listData);

  for (String item in aList.listData) {
    temp.listData.add(item);
  }
  return temp;
}

@JsonSerializable()
class AlistV2 extends Alist {
  @JsonKey(name: 'data', nullable: false)
  List<AlistItemTypeV2> listData = List<AlistItemTypeV2>();
  AlistV2({uuid, listInfo, listData}) : super(uuid: uuid, listInfo: listInfo);
  Map<String, dynamic> toJson() => _$AlistV2ToJson(this);
}

@JsonSerializable()
class AlistItemTypeV2 {
  String from;
  String to;

  AlistItemTypeV2(this.from, this.to);

  factory AlistItemTypeV2.fromJson(Map<String, dynamic> json) =>
      _$AlistItemTypeV2FromJson(json);

  Map<String, dynamic> toJson() => _$AlistItemTypeV2ToJson(this);
}

AlistV2 newAlistV2(Alist aList) {
  AlistV2 temp = AlistV2(
      uuid: aList.uuid, listInfo: aList.listInfo, listData: aList.listData);
  temp.listData = List<AlistItemTypeV2>();
  for (Map<String, dynamic> item in aList.listData) {
    temp.listData
        .add(AlistItemTypeV2(item['from'] as String, item['to'] as String));
  }
  return temp;
}

@JsonLiteral('alist-v2.json')
Map get exampleListV2 => _$exampleListV2JsonLiteral;

@JsonLiteral('alist-v1.json')
Map get exampleListV1 => _$exampleListV1JsonLiteral;

// TODO make this use a database
List<Alist> getLists() {
  List<Alist> temp = List<Alist>();

  final Alist a = Alist.fromJson(exampleListV1);
  final Alist b = Alist.fromJson(exampleListV2);
  temp.add(a);
  temp.add(b);
  return temp;
}
