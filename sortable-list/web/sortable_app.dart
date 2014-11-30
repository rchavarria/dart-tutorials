import 'package:polymer/polymer.dart';

@CustomTag('sortable-app')
class SortableApp extends PolymerElement {
  @observable bool applyAuthorStyles = true;

  List<String> taskSortableList = const [
    'Import polymer dart library',
    'Annotate with @CustomeTag',
    'extends from PolymerElement',
    'observe some variables',
    'Define a named constructor .created()'
    ];

  SortableApp.created() : super.created();
}
