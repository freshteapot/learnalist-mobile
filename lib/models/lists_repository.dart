import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:learnalist/storage/file.dart';
// import 'learnalist.dart';

import 'package:learnalist/models/alist.dart';
import 'package:learnalist/services/api.dart';

class ListsRepository extends Model {
  FileStorage storage;
  ListsRepository(this.storage);

  Set<Alist> _allLists = Set<Alist>();

  Future<bool> loadLists() async {
    try {
      var api = Api();
      var lists = await api.getUsersLists();
      lists.forEach((aList) {
        _allLists.add(aList);
      });
    } catch (e) {
      return false;
    }
    return true;
  }

  // Currently ordered by sort.
  List<Alist> get aLists {
    var temp = _allLists.toList();
    temp.sort((Alist a, Alist b) =>
        a.info.title.toLowerCase().compareTo(b.info.title.toLowerCase()));
    return temp;
  }

  Alist getByUuid(String uuid) {
    return _allLists.singleWhere((current) => uuid == current.uuid,
        orElse: () => null);
  }

  Future<Alist> addAlist(Alist aList) async {
    // TODO how should we handle the exception.
    // Currently letting it bubble up.
    var api = Api();
    var serverAlist = await api.postAlist(aList);
    _allLists.add(serverAlist);
    notifyListeners();
    // Not calling save at the moment.
    // _save();
    return serverAlist;
  }

  Future<Alist> updateAlist(Alist aList) async {
    var api = Api();
    var serverAlist = await api.putAlist(aList);
    print(aList);
    print(serverAlist);

    Alist current = _allLists.singleWhere(
        (current) => aList.uuid == current.uuid,
        orElse: () => null);
    _allLists.remove(current);
    _allLists.add(aList);
    notifyListeners();

    return aList;
    //_save();
  }

  Future<void> removeAlist(Alist aList) async {
    var api = Api();
    await api.removeAlist(aList);

    Alist current = _allLists.singleWhere(
        (current) => aList.uuid == current.uuid,
        orElse: () => null);
    _allLists.remove(current);
    notifyListeners();
    // _save();
  }

  void _save() {
    // TODO
    /*
    _fromTheDatabase.items = _allLists.toList();

    String json = jsonEncode(_fromTheDatabase);
    //print(json);
    storage.saveDatabaseAsString(json).then((success) {
      print('Database updated.');
    });
    */
  }
}
