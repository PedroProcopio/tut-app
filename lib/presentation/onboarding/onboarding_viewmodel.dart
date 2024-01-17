import 'dart:async';

import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/presentation/base/base_viewmodel.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  int _currentIndex = 0;
  late final List<SliderObject> _sliderList;

  //inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _sliderList = _getSliderList();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++; // +1
    if (nextIndex >= _sliderList.length) {
      _currentIndex = 0; // infinite loop to go to first item inside the slider
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--; // -1
    if (previousIndex == -1) {
      _currentIndex = _sliderList.length -
          1; // infinite loop to go to the length of slider list
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((slideViewObject) => slideViewObject);

  //functions

  List<SliderObject> _getSliderList() {
    return [
      SliderObject(
        title: AppStrings.onBoardingTitle1,
        subTitle: AppStrings.onBoardingSubTitle1,
        image: ImageAssets.onBoardingLogo1,
      ),
      SliderObject(
        title: AppStrings.onBoardingTitle2,
        subTitle: AppStrings.onBoardingSubTitle2,
        image: ImageAssets.onBoardingLogo2,
      ),
      SliderObject(
        title: AppStrings.onBoardingTitle3,
        subTitle: AppStrings.onBoardingSubTitle3,
        image: ImageAssets.onBoardingLogo3,
      ),
      SliderObject(
        title: AppStrings.onBoardingTitle4,
        subTitle: AppStrings.onBoardingSubTitle4,
        image: ImageAssets.onBoardingLogo4,
      ),
    ];
  }

  _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
        _sliderList[_currentIndex], _currentIndex, _sliderList.length));
  }
}

mixin OnBoardingViewModelInputs {
  void goNext();
  void goPrevious();
  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

mixin OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  final int currentIndex;
  final int totalItems;

  SliderViewObject(this.sliderObject, this.currentIndex, this.totalItems);
}
