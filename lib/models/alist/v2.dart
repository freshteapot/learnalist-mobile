import 'alist.dart';
import 'package:uuid/uuid.dart';

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

AlistV2 newEmptyAlistV2() {
  var uuid = new Uuid();
  Alist aList = Alist(
      uuid: uuid.v4(),
      info: Info(title: '', listType: ListType.v2, labels: []),
      data: List<TypeV2Item>());
  return newAlistV2(aList);
}

AlistV2 newAlistV2(Alist aList) {
  AlistV2 temp = AlistV2(aList);
  return temp;
}
