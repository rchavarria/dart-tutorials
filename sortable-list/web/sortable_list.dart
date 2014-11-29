import 'package:polymer/polymer.dart';

@CustomTag('sortable-list')
class SortableList extends PolymerElement {

  @observable List<String> taskList = ['one', 'two', 'three'];

  SortableList .created() : super.created();

}
