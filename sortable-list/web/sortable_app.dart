import 'package:polymer/polymer.dart';

@CustomTag('sortable-app')
class SortableApp extends PolymerElement {
  List<String> taskSortableList = const [
    'Import polymer dart library',
    'Annotate with @CustomeTag',
    'Extends from PolymerElement',
    'Observe some variables',
    'Define a named constructor .created()'
    ];

  SortableApp.created() : super.created();
}
