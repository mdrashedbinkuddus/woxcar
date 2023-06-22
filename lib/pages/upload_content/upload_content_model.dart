import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/trade_type_widget.dart';
import '/components/transmission_widget.dart';
import '/components/year_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/upload_options/brand_list/brand_list_widget.dart';
import '/upload_options/engine/engine_widget.dart';
import '/upload_options/fuel/fuel_widget.dart';
import '/upload_options/gearbox/gearbox_widget.dart';
import '/upload_options/horse_power/horse_power_widget.dart';
import '/upload_options/kilometer/kilometer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UploadContentModel extends FlutterFlowModel {
  ///  Local state fields for this page.

  String tradeType = 'buying';

  String topic = 'automative';

  String? audioFile;

  bool isNegotiable = false;

  List<String> images = [];
  void addToImages(String item) => images.add(item);
  void removeFromImages(String item) => images.remove(item);
  void removeAtIndexFromImages(int index) => images.removeAt(index);
  void updateImagesAtIndex(int index, Function(String) updateFn) =>
      images[index] = updateFn(images[index]);

  String? uploadedvideo;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl1 = '';

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  bool isDataUploading3 = false;
  FFUploadedFile uploadedLocalFile3 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl3 = '';

  // State field(s) for title widget.
  TextEditingController? titleController;
  String? Function(BuildContext, String?)? titleControllerValidator;
  String? _titleControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for description widget.
  TextEditingController? descriptionController;
  String? Function(BuildContext, String?)? descriptionControllerValidator;
  String? _descriptionControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for phoneNumber widget.
  TextEditingController? phoneNumberController;
  String? Function(BuildContext, String?)? phoneNumberControllerValidator;
  String? _phoneNumberControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for whatsappNumber widget.
  TextEditingController? whatsappNumberController;
  String? Function(BuildContext, String?)? whatsappNumberControllerValidator;
  String? _whatsappNumberControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for keywords widget.
  TextEditingController? keywordsController;
  String? Function(BuildContext, String?)? keywordsControllerValidator;
  String? _keywordsControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for location widget.
  TextEditingController? locationController;
  String? Function(BuildContext, String?)? locationControllerValidator;
  String? _locationControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for price widget.
  TextEditingController? priceController;
  String? Function(BuildContext, String?)? priceControllerValidator;
  String? _priceControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for TradeType component.
  late TradeTypeModel tradeTypeModel;
  // Stores action output result for [Bottom Sheet - BrandList] action in Row widget.
  String? brandName;
  // Stores action output result for [Bottom Sheet - Gearbox] action in Row widget.
  String? gearBox;
  // Stores action output result for [Bottom Sheet - Kilometer] action in Row widget.
  double? km;
  // Stores action output result for [Bottom Sheet - Year] action in Row widget.
  int? year;
  // Stores action output result for [Bottom Sheet - Engine] action in Row widget.
  String? engine;
  // Stores action output result for [Bottom Sheet - Fuel] action in Row widget.
  String? fuel;
  // Stores action output result for [Bottom Sheet - HorsePower] action in Row widget.
  double? hp;
  // Stores action output result for [Bottom Sheet - Transmission] action in Row widget.
  String? transmission;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  PostsRecord? uploadContent;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    titleControllerValidator = _titleControllerValidator;
    descriptionControllerValidator = _descriptionControllerValidator;
    phoneNumberControllerValidator = _phoneNumberControllerValidator;
    whatsappNumberControllerValidator = _whatsappNumberControllerValidator;
    keywordsControllerValidator = _keywordsControllerValidator;
    locationControllerValidator = _locationControllerValidator;
    priceControllerValidator = _priceControllerValidator;
    tradeTypeModel = createModel(context, () => TradeTypeModel());
  }

  void dispose() {
    unfocusNode.dispose();
    titleController?.dispose();
    descriptionController?.dispose();
    phoneNumberController?.dispose();
    whatsappNumberController?.dispose();
    keywordsController?.dispose();
    locationController?.dispose();
    priceController?.dispose();
    tradeTypeModel.dispose();
  }

  /// Action blocks are added here.

  Future selectType(BuildContext context) async {}

  /// Additional helper methods are added here.

}
