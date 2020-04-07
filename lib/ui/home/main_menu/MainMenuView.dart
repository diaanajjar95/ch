import 'package:ch/base/base_presenter.dart';
import 'package:ch/data/models/Category.dart';

abstract class MainMenuView extends View{

  void renderCategories(List<Category> categories);

  void onNoCategoriesFounded();

}