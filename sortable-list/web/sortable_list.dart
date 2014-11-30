import 'package:polymer/polymer.dart';

@CustomTag('sortable-list')
class SortableList extends PolymerElement {

  @published List<String> externalData = [];
  final List<String> taskList = toObservable([]);

  SortableList.created() : super.created();

  attached() {
    super.attached();
    taskList.addAll(externalData);
  }
}
