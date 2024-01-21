import 'package:flutter/material.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

//LOADING STATE(POP UP , FULL SCREEN)

class LoadingState extends FlowState {
  final StateRendererType stateRendererType;
  String? message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  String getMessage() {
    return message!;
  }

  @override
  StateRendererType getStateRendererType() {
    return stateRendererType;
  }
}

// ERROR STATE (POP UP , FULL LOADING)

class ErrorState extends FlowState {
  final StateRendererType stateRendererType;
  String? message;

  ErrorState({required this.stateRendererType, required this.message});

  @override
  String getMessage() {
    return message!;
  }

  @override
  StateRendererType getStateRendererType() {
    return stateRendererType;
  }
}

//CONTENT STATE

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() {
    return EMPTY;
  }

  @override
  StateRendererType getStateRendererType() {
    return StateRendererType.CONTENT_SCREEN_STATE;
  }
}

//EMPTY STATE

class EmptyState extends FlowState {
  String? message;

  EmptyState(this.message);

  @override
  String getMessage() {
    return EMPTY;
  }

  @override
  StateRendererType getStateRendererType() {
    return StateRendererType.EMPTY_SCREEN_STATE;
  }
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    return StateRenderer(
      stateRendererType: getStateRendererType(),
      message: getMessage(),
      retryActionFunction: () {
        switch (this.runtimeType) {
          case LoadingState:
            {
              if (getStateRendererType() ==
                  StateRendererType.POPUP_LOADING_STATE) {
                //Show pop up loading
                ShowPopUp(context, getStateRendererType(), getMessage());

                //Return to content UI of the Screen

                return contentScreenWidget;
              } else {
                return StateRenderer(
                    stateRendererType: getStateRendererType(),
                    message: getMessage(),
                    retryActionFunction: retryActionFunction);
              }
            }

          case EmptyState:
            {
              return StateRenderer(
                  stateRendererType: getStateRendererType(),
                  message: getMessage(),
                  retryActionFunction: retryActionFunction);
            }
          case ContentState:
            {
              dismissDialog(context);
              return contentScreenWidget;
            }
          case ErrorState:
            {
              dismissDialog(context);
              if (getStateRendererType() ==
                  StateRendererType.POPUP_ERROR_STATE) {
                //Show pop up loading
                ShowPopUp(context, getStateRendererType(), getMessage());

                //Return to content UI of the Screen

                return contentScreenWidget;
              } else {
                // FULL SCREEN ERROR STATE
                return StateRenderer(
                    stateRendererType: getStateRendererType(),
                    message: getMessage(),
                    retryActionFunction: retryActionFunction);
              }
            }
          default:
            {
              return contentScreenWidget;
            }
        }
      },
    );
  }

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) {
    ModalRoute.of(context)?.isCurrent != true;
  }

  ShowPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            retryActionFunction: () {}),
      ),
    );
  }
}
