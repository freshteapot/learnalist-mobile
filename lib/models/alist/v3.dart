import 'alist.dart';
import 'package:uuid/uuid.dart';

class TypeV3Item {
  String when;
  V3Split overall;
  List<V3Split> splits;

  TypeV3Item(this.when, this.overall, this.splits);

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

  V3Split(this.time, this.distance, this.spm, this.p500);

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

AlistV3 newEmptyAlistV3() {
  var uuid = new Uuid();
  Alist aList = Alist(
      uuid: uuid.v4(),
      info: Info(
          title: '', listType: ListType.v3, labels: ['rowing', 'concept2']),
      data: List<TypeV3Item>());
  return newAlistV3(aList);
}

AlistV3 newAlistV3(Alist aList) {
  AlistV3 temp = AlistV3(aList);
  return temp;
}
