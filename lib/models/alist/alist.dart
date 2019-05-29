import 'v1.dart';
import 'v2.dart';
import 'v3.dart';
import 'v4.dart';

class ListType {
  static const v1 = "v1";
  static const v2 = "v2";
  static const v3 = "v3";
  static const v4 = "v4";
}

class Alist {
  String uuid;
  Info info;
  dynamic data;

  Alist({this.uuid, this.info, this.data});

  Alist.fromJson(Map<String, dynamic> json) {
    this.uuid = json['uuid'];
    this.info = Info.fromJson(json['info']);
    switch (this.info.listType) {
      case ListType.v1:
        List<String> items = List<String>.from(json['data']);
        this.data = items;
        break;
      case ListType.v2:
        List<TypeV2Item> items = new List();
        json['data'].forEach((n) {
          items.add(TypeV2Item.fromJson(n));
        });
        this.data = items;
        break;
      case ListType.v3:
        List<TypeV3Item> items = new List();
        json['data'].forEach((n) {
          items.add(TypeV3Item.fromJson(n));
        });
        this.data = items;
        break;
      case ListType.v4:
        List<TypeV4Item> items = new List();
        json['data'].forEach((n) {
          items.add(TypeV4Item.fromJson(n));
        });
        this.data = items;
        break;
      default:
        throw Exception(
            'List type not supported: ' + this.info.listType.toString());
        break;
    }
  }

  Map<String, dynamic> toJson() {
    return {'uuid': uuid, 'info': info, 'data': data};
  }

  @override
  String toString() {
    return 'Alist{uuid: $uuid, info: $info, data: $data}';
  }
}

class Info {
  String title;
  final String listType;
  List<String> labels;

  Info({this.title, this.listType, this.labels});

  Info.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        listType = json['type'],
        labels = List<String>.from(json['labels']);

  Map<String, dynamic> toJson() {
    assert(labels != null);

    if (labels == null) {
      labels = List<String>(0);
    }
    return {'title': title, 'type': listType, 'labels': labels};
  }

  @override
  String toString() {
    return 'Info{title: $title, type: $listType, labels: $labels}';
  }
}
