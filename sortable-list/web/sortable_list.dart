import 'package:polymer/polymer.dart';

@CustomTag('sortable-list')
class SortableList extends PolymerElement {

  @published List<String> externalData = [];
  final List<String> taskList = toObservable([]);
  boolean defaultSort = true;

  SortableList.created() : super.created();

  attached() {
    super.attached();
    taskList.addAll(externalData);
  }

  sortTaskList() {
    if (defaultSort) {
      taskList.sort();
    } else {
      taskList.sort((a, b) => b.compareTo(a));
    }

    defaultSort = !defaultSort;
  }

}
