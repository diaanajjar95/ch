import 'package:ch/base/base_presenter.dart';
import 'package:ch/data/models/MenuItem.dart';

abstract class menuItemListView extends View{

  void renderMenuItems(List<MenuItem> menuItemsList);

  void onNoMenuItemsFounded();

}