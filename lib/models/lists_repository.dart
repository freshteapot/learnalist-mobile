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

import 'learnalist.dart';

class ListsRepository {
  static List<Alist> getLists(ListType listType) {
    List<Alist> allLists = List<Alist>();

    final Alist a = Alist.fromJson(exampleListV1);
    final Alist b = Alist.fromJson(exampleListV2);
    allLists.add(a);
    allLists.add(b);

    if (listType == null) {
      return allLists;
    } else {
      return allLists.where((Alist alist) {
        return alist.listInfo.listType == listType;
      }).toList();
    }
  }
}
