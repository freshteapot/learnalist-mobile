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
}

class AlistV1 extends Alist {
  final List<String> listData = List<String>();
  AlistV1(Alist aList) : super(uuid: aList.uuid, listInfo: aList.listInfo);
}

AlistV1 newAlistV1(Alist aList) {
  AlistV1 temp = AlistV1(aList);

  for (String item in aList.listData) {
    temp.listData.add(item);
  }
  return temp;
}

class AlistV2 extends Alist {
  final List<AlistItemTypeV2> listData = List<AlistItemTypeV2>();
  AlistV2(Alist aList) : super(uuid: aList.uuid, listInfo: aList.listInfo);
}

class AlistItemTypeV2 {
  final String from;
  final String to;

  AlistItemTypeV2(this.from, this.to);
}

AlistV2 newAlistV2(Alist aList) {
  AlistV2 temp = AlistV2(aList);

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
