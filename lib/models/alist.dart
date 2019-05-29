import 'package:uuid/uuid.dart';

var uuid = new Uuid();

class ListType {
  static const v1 = "v1";
  static const v2 = "v2";
  static const v3 = "v3";
  static const v4 = "v4";
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

class TypeV2Item {
  String from;
  String to;
  TypeV2Item(this.from, this.to);

  TypeV2Item.fromJson(Map<String, dynamic> json)
      : from = json['from'],
        to = json['to'];

  Map<String, dynamic> toJson() => {'from': from, 'to': to};

  @override
  String toString() {
    return 'TypeV2Item{from: $from, to: $to}';
  }
}

class TypeV3Item {
  String when;
  V3Split overall;
  List<V3Split> splits;

  TypeV3Item.fromJson(Map<String, dynamic> json) {
    this.when = json['when'];
    this.overall = V3Split.fromJson(json['overall']);
    List<V3Split> _splits = new List();
    json['splits'].forEach((n) {
      _splits.add(V3Split.fromJson(n));
    });
    this.splits = _splits;
  }

  Map<String, dynamic> toJson() =>
      {'when': when, 'overall': overall, 'splits': splits};

  @override
  String toString() {
    return 'TypeV3Item{when: $when, overall: $overall, splits: $splits}';
  }
}

class V3Split {
  String time;
  int distance;
  int spm;
  String p500;

  V3Split.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        distance = json['distance'],
        spm = json['spm'],
        p500 = json['p500'];

  Map<String, dynamic> toJson() =>
      {'time': time, 'distance': distance, 'spm': spm, 'p500': p500};

  @override
  String toString() {
    return 'V3Split{time: $time, distance: $distance, spm: $spm, p500: $p500}';
  }
}

class TypeV4Item {
  String content;
  String url;
  TypeV4Item(this.content, this.url);

  TypeV4Item.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        url = json['url'];

  Map<String, dynamic> toJson() => {'content': content, 'url': url};

  @override
  String toString() {
    return 'TypeV4Item{content: $content, url: $url}';
  }
}

class Alist {
  String uuid;
  String userUUID;
  Info info;
  dynamic data;

  //Alist(this.uuid, this.info, this.data);
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

class AlistV4 extends Alist {
  void addItem(TypeV4Item value) {
    this.data.add(value);
  }

  void removeItem(int index) {
    this.data.removeAt(index);
  }

  List<TypeV4Item> getItems() {
    List<TypeV4Item> items = List<TypeV4Item>();
    for (TypeV4Item item in this.data) {
      items.add(item);
    }
    return items;
  }

  AlistV4(Alist alist)
      : super(uuid: alist.uuid, info: alist.info, data: alist.data) {
    assert(this.info.listType == ListType.v4);
  }
}

class AlistV3 extends Alist {
  void addItem(TypeV3Item value) {
    this.data.add(value);
  }

  void removeItem(int index) {
    this.data.removeAt(index);
  }

  List<TypeV3Item> getItems() {
    List<TypeV3Item> items = List<TypeV3Item>();
    for (TypeV3Item item in this.data) {
      items.add(item);
    }
    return items;
  }

  AlistV3(Alist alist)
      : super(uuid: alist.uuid, info: alist.info, data: alist.data) {
    assert(this.info.listType == ListType.v3);
  }
}

class AlistV2 extends Alist {
  void addItem(TypeV2Item value) {
    this.data.add(value);
  }

  void removeItem(int index) {
    this.data.removeAt(index);
  }

  List<TypeV2Item> getItems() {
    List<TypeV2Item> items = List<TypeV2Item>();
    for (TypeV2Item item in this.data) {
      items.add(item);
    }
    return items;
  }

  AlistV2(Alist alist)
      : super(uuid: alist.uuid, info: alist.info, data: alist.data) {
    assert(this.info.listType == ListType.v2);
  }
}

class AlistV1 extends Alist {
  void addItem(String value) {
    this.data.add(value);
  }

  void removeItem(int index) {
    this.data.removeAt(index);
  }

  List<String> getItems() {
    List<String> items = List<String>();
    for (String item in this.data) {
      items.add(item);
    }
    return items;
  }

  AlistV1(Alist alist)
      : super(uuid: alist.uuid, info: alist.info, data: alist.data) {
    assert(this.info.listType == ListType.v1);
  }
}

AlistV1 newEmptyAlistV1() {
  Alist aList = Alist(
      uuid: uuid.v4(),
      info: Info(title: '', listType: ListType.v1),
      data: List<String>());
  return newAlistV1(aList);
}

AlistV1 newAlistV1(Alist aList) {
  AlistV1 temp = AlistV1(aList);
  return temp;
}

AlistV2 newEmptyAlistV2() {
  Alist aList = Alist(
      uuid: uuid.v4(),
      info: Info(title: '', listType: ListType.v2),
      data: List<TypeV2Item>());
  return newAlistV2(aList);
}

AlistV2 newAlistV2(Alist aList) {
  AlistV2 temp = AlistV2(aList);
  return temp;
}
