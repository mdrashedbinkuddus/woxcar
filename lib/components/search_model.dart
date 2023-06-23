import '/components/trade_type_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchModel extends FlutterFlowModel {
  ///  Local state fields for this component.

  String? sellerType;

  ///  State fields for stateful widgets in this component.

  // State field(s) for ChoiceChips widget.
  String? choiceChipsValue;
  FormFieldController<List<String>>? choiceChipsValueController;
  // State field(s) for TextField widget.
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // Model for TradeType component.
  late TradeTypeModel tradeTypeModel;
  // State field(s) for from widget.
  TextEditingController? fromController;
  String? Function(BuildContext, String?)? fromControllerValidator;
  // State field(s) for to widget.
  TextEditingController? toController;
  String? Function(BuildContext, String?)? toControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    tradeTypeModel = createModel(context, () => TradeTypeModel());
  }

  void dispose() {
    textController1?.dispose();
    tradeTypeModel.dispose();
    fromController?.dispose();
    toController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
