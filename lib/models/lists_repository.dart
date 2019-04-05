import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:learnalist/storage/file.dart';
import 'learnalist.dart';

class ListsRepository extends Model {
  FileStorage storage;
  ListsRepository(this.storage);

  Set<Alist> _allLists = Set<Alist>();
  AlistDatabase _fromTheDatabase = AlistDatabase();

  void _addFakeData() {
    Alist a = Alist.fromJson(exampleListV1);
    Alist b = Alist.fromJson(exampleListV2);
    _allLists.add(a);
    _allLists.add(a);
    _allLists.add(b);
  }

  Future<bool> loadLists() async {
    try {
      storage.readDatabaseAsString().then((jsonAsString) {
        // Handles if there is no data.
        // TODO maybe it is better to write the file.
        if (jsonAsString == '{}') {
          jsonAsString = '{"items":[]}';
        }
        print(jsonAsString);
        Map databaseMap = jsonDecode(jsonAsString);
        _fromTheDatabase = AlistDatabase.fromJson(databaseMap);
        _fromTheDatabase.items.forEach((aList) {
          // Maybe in here I need to conver things.
          print(aList.listInfo.listType.toString());
          print('Total items is ${aList.listData.length}');
          _allLists.add(aList);
        });
        // print('Adding fake.');
        // _addFakeData();
        print('loaded');
        print(_allLists.length);
      });
    } catch (e) {
      _addFakeData();
      return false;
    }
    return true;
  }

  // Currently ordered by sort.
  List<Alist> get aLists {
    var temp = _allLists.toList();
    temp.sort((Alist a, Alist b) => a.listInfo.title
        .toLowerCase()
        .compareTo(b.listInfo.title.toLowerCase()));
    return temp;
  }

  Alist getByUuid(String uuid) {
    return _allLists.singleWhere((current) => uuid == current.uuid,
        orElse: () => null);
  }

  void addList() {
    print('addList');
  }

  void updateAlist(Alist aList) {
    Alist current = _allLists.singleWhere(
        (current) => aList.uuid == current.uuid,
        orElse: () => null);
    _allLists.remove(current);
    _allLists.add(aList);
    notifyListeners();
    _save();
  }

  void removeAlist(Alist aList) {
    _allLists.remove(aList);
    notifyListeners();
    _save();
  }

  void _save() {
    _fromTheDatabase.items = _allLists.toList();

    String json = jsonEncode(_fromTheDatabase);
    //print(json);
    storage.saveDatabaseAsString(json).then((success) {
      print('Database updated.');
    });
  }
}
