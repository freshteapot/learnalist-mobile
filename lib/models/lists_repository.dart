// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'package:scoped_model/scoped_model.dart';
import 'learnalist.dart';

class ListsRepository extends Model {
  Set<Alist> _allLists = Set<Alist>();
  void loadLists() {
    Alist a = Alist.fromJson(exampleListV1);
    Alist b = Alist.fromJson(exampleListV2);
    _allLists.add(a);
    _allLists.add(a);
    _allLists.add(b);
    print('loaded');
    print(_allLists.length);
  }

  List<Alist> get aLists {
    // Need a way to order this ;)
    var temp = _allLists.toList();
    temp.sort(
        (Alist a, Alist b) => a.listInfo.title.compareTo(b.listInfo.title));
    return temp;
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
  }
}
