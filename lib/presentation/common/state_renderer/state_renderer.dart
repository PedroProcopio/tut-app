import 'package:flutter/material.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';

enum StateRendererType {
  //popup states
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,

  //full screen states
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,

  CONTENT_SCREEN_STATE, //LA UI
  EMPTY_SCREEN_STATE, // UI CUANDO NO RECIBIMOS DATA DESDE LA API
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  Failure? failure;
  String? message;
  String? title;
  final Function retryActionFunction;

  StateRenderer(
      {super.key,
      required this.stateRendererType,
      Failure? failure,
      String? message,
      String? title,
      required this.retryActionFunction})
      : message = message ?? AppStrings.loading,
        title = title ?? EMPTY,
        failure = failure ?? DefaultFailure();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget _getStateWidget() {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
      // TODO: Handle this case.
      case StateRendererType.POPUP_ERROR_STATE:
      // TODO: Handle this case.
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        _getItemsInColumn(items);
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
      // TODO: Handle this case.
      case StateRendererType.CONTENT_SCREEN_STATE:
      // TODO: Handle this case.
      case StateRendererType.EMPTY_SCREEN_STATE:
      // TODO: Handle this case.

      default:
        Container();
    }
  }

  Widget _getItemsInColumn(List<Widget> items) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items);
  }
}
