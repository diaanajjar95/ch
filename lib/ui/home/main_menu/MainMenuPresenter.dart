import 'package:ch/base/base_presenter.dart';
import 'package:ch/data/network/api_helper.dart';
import 'package:ch/ui/home/main_menu/MainMenuView.dart';

class MainMenuPresenter extends BasePresenter<MainMenuView> {

  void getCategories()async{
    isViewAttached ? getView().showProgress() : null;
    try{
      var categories = await ApiHelper().getCategories();
      if(categories != null && categories.isNotEmpty){
        isViewAttached ? getView().hideProgress() : null;
        isViewAttached ? getView().renderCategories(categories) : null;
      }else{
        isViewAttached ? getView().hideProgress() : null;
        isViewAttached ? getView().onNoCategoriesFounded() : null;
      }
    }catch(e){
      isViewAttached ? getView().hideProgress() : null;
      isViewAttached ? getView().onNoCategoriesFounded() : null;
    }
  }

}
