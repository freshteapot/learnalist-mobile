import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
part 'learnalist.g.dart';

var uuid = new Uuid();

enum ListType {
  v1,
  v2,
}

@JsonSerializable()
class ListInfo {
  String title;

  @JsonKey(name: 'type', nullable: false)
  ListType listType;

  String from = '';

  ListInfo({this.title, this.listType, List listData});

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

  String uuid;
  @JsonKey(name: 'info', nullable: false)
  ListInfo listInfo;

  @JsonKey(name: 'data', nullable: false)
  final dynamic listData;

  Alist({this.uuid, this.listInfo, this.listData});

  factory Alist.fromJson(Map<String, dynamic> json) => _$AlistFromJson(json);

  Map<String, dynamic> toJson() => _$AlistToJson(this);
  Alist toAlist() {}
}

@JsonSerializable()
class AlistV1 extends Alist {
  void addItem(String value) {
    this.listData.add(value);
  }

  void removeItem(int index) {
    this.listData.removeAt(index);
  }

  List<String> getItems() {
    List<String> items = List<String>();
    for (String item in this.listData) {
      items.add(item);
    }
    return items;
  }

  AlistV1({uuid, listInfo, listData})
      : super(uuid: uuid, listInfo: listInfo, listData: listData) {
    assert(this.listInfo.listType == ListType.v1);
    if ((this.listData as List).isEmpty) {
      return;
    }

    if ((this.listData as List).isNotEmpty && (this.listData[0] is String)) {
      return;
    }

    print('Converting to correct format');
    List<String> items = List<String>();

    for (String item in this.listData) {
      items.add(item);
    }
    (this.listData as List).clear();
    (this.listData as List).addAll(items);
  }

  Map<String, dynamic> toJson() => _$AlistV1ToJson(this);
}

AlistV1 newEmptyAlistV1() {
  Alist aList = Alist(
      uuid: uuid.v4(),
      listInfo: ListInfo(title: '', listType: ListType.v1),
      listData: List());
  return newAlistV1(aList);
}

AlistV1 newAlistV1(Alist aList) {
  AlistV1 temp = AlistV1(
      uuid: aList.uuid, listInfo: aList.listInfo, listData: aList.listData);
  return temp;
}

@JsonSerializable()
class AlistV2 extends Alist {
  void addItem(AlistItemTypeV2 value) {
    this.listData.add(value);
  }

  void removeItem(int index) {
    this.listData.removeAt(index);
  }

  List<AlistItemTypeV2> getItems() {
    List<AlistItemTypeV2> items = List<AlistItemTypeV2>();
    for (AlistItemTypeV2 item in this.listData) {
      items.add(item);
    }
    return items;
  }

  AlistV2({uuid, listInfo, listData})
      : super(uuid: uuid, listInfo: listInfo, listData: listData) {
    assert(this.listInfo.listType == ListType.v2);
    if ((this.listData as List).isEmpty) {
      return;
    }

    if ((this.listData as List).isNotEmpty &&
        (this.listData[0] is AlistItemTypeV2)) {
      return;
    }

    print('Converting to correct format');
    List<AlistItemTypeV2> items = List<AlistItemTypeV2>();

    for (Map<String, dynamic> item in this.listData) {
      items.add(AlistItemTypeV2(item['from'] as String, item['to'] as String));
    }
    (this.listData as List).clear();
    (this.listData as List).addAll(items);
  }

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

AlistV2 newEmptyAlistV2() {
  Alist aList = Alist(
      uuid: uuid.v4(),
      listInfo: ListInfo(title: '', listType: ListType.v2),
      listData: List());
  return newAlistV2(aList);
}

AlistV2 newAlistV2(Alist aList) {
  AlistV2 temp = AlistV2(
      uuid: aList.uuid, listInfo: aList.listInfo, listData: aList.listData);
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
