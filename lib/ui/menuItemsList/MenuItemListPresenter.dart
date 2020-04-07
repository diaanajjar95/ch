import 'package:ch/base/base_presenter.dart';
import 'package:ch/data/network/api_helper.dart';
import 'package:ch/ui/menuItemsList/menuItemListView.dart';

class MenuItemListPresenter extends BasePresenter<menuItemListView> {
  // const
  static const TAG = 'MenuItemListPresenter';

  void getMenuItemsByCategoryId(int categoryId) async {
    print("$TAG , getMenuItemsByCategoryId Fired");
    isViewAttached ? getView().showProgress() : null;
    try {
      var menuItems = await ApiHelper().getMenuItemsByCategoryId(categoryId);
      if (menuItems != null && menuItems.isNotEmpty) {
        print(
            "$TAG , getMenuItemsByCategoryId menuItems : ${menuItems.toString()}");
        isViewAttached ? getView().hideProgress() : null;
        isViewAttached ? getView().renderMenuItems(menuItems) : null;
      } else {
        print("$TAG , getMenuItemsByCategoryId menuItems are null or empty");
        isViewAttached ? getView().hideProgress() : null;
        isViewAttached ? getView().onNoMenuItemsFounded() : null;
      }
    } catch (e) {
      print(
          "$TAG , getMenuItemsByCategoryId casued an exception ${e.toString()}");
      isViewAttached ? getView().hideProgress() : null;
      isViewAttached ? getView().onNoMenuItemsFounded() : null;
    }
  }
}
