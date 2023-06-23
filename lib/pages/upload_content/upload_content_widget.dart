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
import 'upload_content_model.dart';
export 'upload_content_model.dart';

class UploadContentWidget extends StatefulWidget {
  const UploadContentWidget({Key? key}) : super(key: key);

  @override
  _UploadContentWidgetState createState() => _UploadContentWidgetState();
}

class _UploadContentWidgetState extends State<UploadContentWidget> {
  late UploadContentModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UploadContentModel());

    _model.titleController ??= TextEditingController();
    _model.descriptionController ??= TextEditingController();
    _model.phoneNumberController ??= TextEditingController();
    _model.whatsappNumberController ??= TextEditingController();
    _model.keywordsController ??= TextEditingController();
    _model.locationController ??= TextEditingController();
    _model.priceController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: responsiveVisibility(
          context: context,
          tabletLandscape: false,
          desktop: false,
        )
            ? AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                leading: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 65.0,
                  icon: Icon(
                    Icons.chevron_left_rounded,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 35.0,
                  ),
                  onPressed: () async {
                    context.pop();
                  },
                ),
                title: Text(
                  'Create New Post',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Noto Sans',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 22.0,
                      ),
                ),
                actions: [],
                centerTitle: false,
                elevation: 0.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                        child: Container(
                          width: 72.0,
                          height: 72.0,
                          decoration: BoxDecoration(
                            color: Color(0x4B0162F2),
                            borderRadius: BorderRadius.circular(100.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 100.0,
                            borderWidth: 1.0,
                            buttonSize: 72.0,
                            icon: Icon(
                              Icons.add_photo_alternate_outlined,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              if (_model.images.length <= 4) {
                                final selectedMedia = await selectMedia(
                                  mediaSource: MediaSource.photoGallery,
                                  multiImage: false,
                                );
                                if (selectedMedia != null &&
                                    selectedMedia.every((m) =>
                                        validateFileFormat(
                                            m.storagePath, context))) {
                                  setState(
                                      () => _model.isDataUploading1 = true);
                                  var selectedUploadedFiles =
                                      <FFUploadedFile>[];
                                  var downloadUrls = <String>[];
                                  try {
                                    showUploadMessage(
                                      context,
                                      'Uploading file...',
                                      showLoading: true,
                                    );
                                    selectedUploadedFiles = selectedMedia
                                        .map((m) => FFUploadedFile(
                                              name:
                                                  m.storagePath.split('/').last,
                                              bytes: m.bytes,
                                              height: m.dimensions?.height,
                                              width: m.dimensions?.width,
                                              blurHash: m.blurHash,
                                            ))
                                        .toList();

                                    downloadUrls = (await Future.wait(
                                      selectedMedia.map(
                                        (m) async => await uploadData(
                                            m.storagePath, m.bytes),
                                      ),
                                    ))
                                        .where((u) => u != null)
                                        .map((u) => u!)
                                        .toList();
                                  } finally {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    _model.isDataUploading1 = false;
                                  }
                                  if (selectedUploadedFiles.length ==
                                          selectedMedia.length &&
                                      downloadUrls.length ==
                                          selectedMedia.length) {
                                    setState(() {
                                      _model.uploadedLocalFile1 =
                                          selectedUploadedFiles.first;
                                      _model.uploadedFileUrl1 =
                                          downloadUrls.first;
                                    });
                                    showUploadMessage(context, 'Success!');
                                  } else {
                                    setState(() {});
                                    showUploadMessage(
                                        context, 'Failed to upload data');
                                    return;
                                  }
                                }

                                setState(() {
                                  _model.addToImages(_model.uploadedFileUrl1);
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Maximum 5 images',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 2000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Container(
                          width: 72.0,
                          height: 72.0,
                          decoration: BoxDecoration(
                            color: Color(0x4B0162F2),
                            borderRadius: BorderRadius.circular(100.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 50.0,
                            borderWidth: 1.0,
                            buttonSize: 72.0,
                            icon: Icon(
                              Icons.video_call_outlined,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              // uploadVideo
                              final selectedMedia = await selectMedia(
                                isVideo: true,
                                mediaSource: MediaSource.videoGallery,
                                multiImage: false,
                              );
                              if (selectedMedia != null &&
                                  selectedMedia.every((m) => validateFileFormat(
                                      m.storagePath, context))) {
                                setState(() => _model.isDataUploading2 = true);
                                var selectedUploadedFiles = <FFUploadedFile>[];
                                var downloadUrls = <String>[];
                                try {
                                  selectedUploadedFiles = selectedMedia
                                      .map((m) => FFUploadedFile(
                                            name: m.storagePath.split('/').last,
                                            bytes: m.bytes,
                                            height: m.dimensions?.height,
                                            width: m.dimensions?.width,
                                            blurHash: m.blurHash,
                                          ))
                                      .toList();

                                  downloadUrls = (await Future.wait(
                                    selectedMedia.map(
                                      (m) async => await uploadData(
                                          m.storagePath, m.bytes),
                                    ),
                                  ))
                                      .where((u) => u != null)
                                      .map((u) => u!)
                                      .toList();
                                } finally {
                                  _model.isDataUploading2 = false;
                                }
                                if (selectedUploadedFiles.length ==
                                        selectedMedia.length &&
                                    downloadUrls.length ==
                                        selectedMedia.length) {
                                  setState(() {
                                    _model.uploadedLocalFile2 =
                                        selectedUploadedFiles.first;
                                    _model.uploadedFileUrl2 =
                                        downloadUrls.first;
                                  });
                                } else {
                                  setState(() {});
                                  return;
                                }
                              }

                              if (_model.isDataUploading2) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Uploading video...',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                );
                                setState(() {
                                  _model.uploadedvideo =
                                      _model.uploadedFileUrl2;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_model.isDataUploading2)
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                    child: Text(
                      'video uploading...',
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Builder(
                        builder: (context) {
                          final uploadedImage = _model.images.toList();
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(uploadedImage.length,
                                (uploadedImageIndex) {
                              final uploadedImageItem =
                                  uploadedImage[uploadedImageIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 10.0, 0.0),
                                child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    uploadedImageItem,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 15.0),
                  child: FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: 'Background music',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Noto Sans',
                                color: Colors.white,
                              ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            35.0, 0.0, 20.0, 8.0),
                        child: Text(
                          'Title',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Noto Sans',
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 13.0),
                        child: TextFormField(
                          controller: _model.titleController,
                          autofillHints: [AutofillHints.name],
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Enter a title',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Noto Sans',
                                  color: Color(0xFF868686),
                                  fontSize: 16.0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            filled: true,
                            fillColor: Color(0xFFE6EFFE),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                14.0, 16.0, 14.0, 16.0),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 16.0,
                                  ),
                          validator: _model.titleControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            35.0, 0.0, 20.0, 8.0),
                        child: Text(
                          'Description',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Noto Sans',
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 13.0),
                        child: TextFormField(
                          controller: _model.descriptionController,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Write your description...',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Noto Sans',
                                  color: Color(0xFF868686),
                                  fontSize: 16.0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            fillColor: Color(0xFFE6EFFE),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                14.0, 16.0, 14.0, 16.0),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 16.0,
                                  ),
                          maxLines: 6,
                          validator: _model.descriptionControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            35.0, 0.0, 20.0, 8.0),
                        child: Text(
                          'Phone Number',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Noto Sans',
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 13.0),
                        child: TextFormField(
                          controller: _model.phoneNumberController,
                          autofillHints: [
                            AutofillHints.telephoneNumberCountryCode
                          ],
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: '+33',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Noto Sans',
                                  color: Color(0xFF868686),
                                  fontSize: 16.0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            filled: true,
                            fillColor: Color(0xFFE6EFFE),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                14.0, 16.0, 14.0, 16.0),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 16.0,
                                  ),
                          keyboardType: TextInputType.phone,
                          validator: _model.phoneNumberControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            35.0, 0.0, 20.0, 8.0),
                        child: Text(
                          'Whatsapp Number',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Noto Sans',
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 13.0),
                        child: TextFormField(
                          controller: _model.whatsappNumberController,
                          autofillHints: [
                            AutofillHints.telephoneNumberCountryCode
                          ],
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: '+33',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Noto Sans',
                                  color: Color(0xFF868686),
                                  fontSize: 16.0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            filled: true,
                            fillColor: Color(0xFFE6EFFE),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                14.0, 16.0, 14.0, 16.0),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 16.0,
                                  ),
                          keyboardType: TextInputType.phone,
                          validator: _model.whatsappNumberControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            35.0, 0.0, 20.0, 8.0),
                        child: Text(
                          'Keywords',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Noto Sans',
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 13.0),
                        child: TextFormField(
                          controller: _model.keywordsController,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText:
                                'Enter keywords Ex. audi, a6, adsi diesel',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Noto Sans',
                                  color: Color(0xFF868686),
                                  fontSize: 16.0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            filled: true,
                            fillColor: Color(0xFFE6EFFE),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                14.0, 16.0, 14.0, 16.0),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 16.0,
                                  ),
                          validator: _model.keywordsControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            35.0, 0.0, 20.0, 8.0),
                        child: Text(
                          'Location',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Noto Sans',
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 13.0),
                        child: TextFormField(
                          controller: _model.locationController,
                          autofillHints: [AutofillHints.addressCity],
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Example : Timisoara',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Noto Sans',
                                  color: Color(0xFF868686),
                                  fontSize: 16.0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            filled: true,
                            fillColor: Color(0xFFE6EFFE),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                14.0, 16.0, 14.0, 16.0),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 16.0,
                                  ),
                          validator: _model.locationControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            35.0, 0.0, 20.0, 8.0),
                        child: Text(
                          'Price :',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Noto Sans',
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 13.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: _model.priceController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: '2000',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        color: Color(0xFF868686),
                                        fontSize: 16.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 0.0,
                                    ),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 0.0,
                                    ),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 0.0,
                                    ),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 0.0,
                                    ),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFE6EFFE),
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          14.0, 16.0, 14.0, 16.0),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Noto Sans',
                                      fontSize: 16.0,
                                    ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: _model.priceControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: FlutterFlowDropDown<String>(
                                  controller: _model.dropDownValueController ??=
                                      FormFieldController<String>(
                                    _model.dropDownValue ??= '\$',
                                  ),
                                  options: ['\$', '€', '£'],
                                  onChanged: (val) => setState(
                                      () => _model.dropDownValue = val),
                                  width: 300.0,
                                  height: 50.0,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        color: Colors.white,
                                      ),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                  fillColor:
                                      FlutterFlowTheme.of(context).primary,
                                  elevation: 0.0,
                                  borderColor: Colors.transparent,
                                  borderWidth: 0.0,
                                  borderRadius: 50.0,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 4.0, 16.0, 4.0),
                                  hidesUnderline: true,
                                  isSearchable: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: wrapWithModel(
                          model: _model.tradeTypeModel,
                          updateCallback: () => setState(() {}),
                          child: TradeTypeWidget(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 20.0, 0.0),
                                child: Text(
                                  'Negociable ?',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 5.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  if (_model.isNegotiable) {
                                    setState(() {
                                      _model.isNegotiable = false;
                                    });
                                  } else {
                                    setState(() {
                                      _model.isNegotiable = true;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: _model.isNegotiable
                                        ? FlutterFlowTheme.of(context).primary
                                        : Color(0xFFE6EFFE),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30.0, 0.0, 30.0, 0.0),
                                    child: Text(
                                      'Yes',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: _model.isNegotiable
                                                ? Colors.white
                                                : FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            fontSize: 13.0,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 20.0, 20.0, 20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => FocusScope.of(context)
                                                .requestFocus(
                                                    _model.unfocusNode),
                                            child: Padding(
                                              padding: MediaQuery.of(context)
                                                  .viewInsets,
                                              child: Scaffold(
                                                body: GestureDetector(
                                                  onTap: () =>
                                                      Navigator.pop(context),
                                                ),
                                                backgroundColor:
                                                    Colors.transparent,
                                                bottomSheet: BrandListWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => setState(
                                          () => _model.brandName = value));

                                      setState(() {});
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Brand',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Noto Sans',
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            if (_model.brandName != null &&
                                                _model.brandName != '')
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 5.0, 10.0, 5.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFD5DEFD),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(15.0, 5.0,
                                                                15.0, 5.0),
                                                    child: Text(
                                                      _model.brandName!,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Sans',
                                                            fontSize: 13.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Colors.white,
                                              size: 24.0,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (_model.checkAllInput &&
                                      (_model.brandName == null ||
                                          _model.brandName == ''))
                                    Text(
                                      'Brand is required',
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Colors.white,
                                          ),
                                    ),
                                ],
                              ),
                              Divider(
                                height: 40.0,
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).accent4,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () => FocusScope.of(context)
                                                .requestFocus(
                                                    _model.unfocusNode),
                                            child: Padding(
                                              padding: MediaQuery.of(context)
                                                  .viewInsets,
                                              child: Scaffold(
                                                body: GestureDetector(
                                                  onTap: () =>
                                                      Navigator.pop(context),
                                                ),
                                                backgroundColor:
                                                    Colors.transparent,
                                                bottomSheet: GearboxWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => setState(
                                          () => _model.gearBox = value));

                                      setState(() {});
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Gearbox',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Noto Sans',
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            if (_model.gearBox != null &&
                                                _model.gearBox != '')
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 5.0, 10.0, 5.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFD5DEFD),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(15.0, 5.0,
                                                                15.0, 5.0),
                                                    child: Text(
                                                      _model.gearBox!,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Sans',
                                                            fontSize: 13.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Colors.white,
                                              size: 24.0,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (_model.checkAllInput &&
                                      (_model.gearBox == null ||
                                          _model.gearBox == ''))
                                    Text(
                                      'Gearbox is required',
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Colors.white,
                                          ),
                                    ),
                                ],
                              ),
                              Divider(
                                height: 40.0,
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).accent4,
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => FocusScope.of(context)
                                            .requestFocus(_model.unfocusNode),
                                        child: Padding(
                                          padding:
                                              MediaQuery.of(context).viewInsets,
                                          child: Scaffold(
                                            body: GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            bottomSheet: KilometerWidget(),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) =>
                                      setState(() => _model.km = value));

                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Km',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (_model.km != null)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 5.0, 10.0, 5.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFD5DEFD),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 5.0, 15.0, 5.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.km?.toString(),
                                                    '0',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Noto Sans',
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 40.0,
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).accent4,
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => FocusScope.of(context)
                                            .requestFocus(_model.unfocusNode),
                                        child: Padding(
                                          padding:
                                              MediaQuery.of(context).viewInsets,
                                          child: Scaffold(
                                            body: GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            bottomSheet: YearWidget(),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) =>
                                      setState(() => _model.year = value));

                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Year',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (_model.year != null)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 5.0, 10.0, 5.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFD5DEFD),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 5.0, 15.0, 5.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.year?.toString(),
                                                    '2023',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Noto Sans',
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 40.0,
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).accent4,
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => FocusScope.of(context)
                                            .requestFocus(_model.unfocusNode),
                                        child: Padding(
                                          padding:
                                              MediaQuery.of(context).viewInsets,
                                          child: Scaffold(
                                            body: GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            bottomSheet: EngineWidget(),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) =>
                                      setState(() => _model.engine = value));

                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Engine',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (_model.engine != null &&
                                            _model.engine != '')
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 5.0, 10.0, 5.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFD5DEFD),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 5.0, 15.0, 5.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.engine,
                                                    'Engine',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Noto Sans',
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 40.0,
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).accent4,
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => FocusScope.of(context)
                                            .requestFocus(_model.unfocusNode),
                                        child: Padding(
                                          padding:
                                              MediaQuery.of(context).viewInsets,
                                          child: Scaffold(
                                            body: GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            bottomSheet: FuelWidget(),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) =>
                                      setState(() => _model.fuel = value));

                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Fuel',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (_model.fuel != null &&
                                            _model.fuel != '')
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 5.0, 10.0, 5.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFD5DEFD),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 5.0, 15.0, 5.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.fuel,
                                                    'Select Fuel',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Noto Sans',
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 40.0,
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).accent4,
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => FocusScope.of(context)
                                            .requestFocus(_model.unfocusNode),
                                        child: Padding(
                                          padding:
                                              MediaQuery.of(context).viewInsets,
                                          child: Scaffold(
                                            body: GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            bottomSheet: HorsePowerWidget(),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) =>
                                      setState(() => _model.hp = value));

                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Hp',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (_model.hp != null)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 5.0, 10.0, 5.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFD5DEFD),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 5.0, 15.0, 5.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.hp?.toString(),
                                                    '0',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Noto Sans',
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 40.0,
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).accent4,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 40.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () => FocusScope.of(context)
                                              .requestFocus(_model.unfocusNode),
                                          child: Padding(
                                            padding: MediaQuery.of(context)
                                                .viewInsets,
                                            child: Scaffold(
                                              body: GestureDetector(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              bottomSheet: TransmissionWidget(),
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => setState(
                                        () => _model.transmission = value));

                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Transmission',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Noto Sans',
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (_model.transmission != null &&
                                              _model.transmission != '')
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 5.0, 10.0, 5.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFD5DEFD),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          15.0, 5.0, 15.0, 5.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      _model.transmission,
                                                      'Transmission',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Noto Sans',
                                                          fontSize: 13.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.white,
                                            size: 24.0,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 100.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    setState(() {
                                      _model.checkAllInput = true;
                                    });
                                    if (_model.formKey.currentState == null ||
                                        !_model.formKey.currentState!
                                            .validate()) {
                                      return;
                                    }
                                    if ((_model.brandName != null &&
                                            _model.brandName != '') &&
                                        (_model.gearBox != null &&
                                            _model.gearBox != '') &&
                                        (_model.km != null) &&
                                        (_model.year != null) &&
                                        (_model.engine != null &&
                                            _model.engine != '') &&
                                        (_model.fuel != null &&
                                            _model.fuel != '') &&
                                        (_model.hp != null) &&
                                        (_model.transmission != null &&
                                            _model.transmission != '')) {
                                      setState(() {
                                        _model.checkAllInput = false;
                                      });

                                      var postsRecordReference =
                                          PostsRecord.collection.doc();
                                      await postsRecordReference.set({
                                        ...createPostsRecordData(
                                          video: _model.uploadedFileUrl2,
                                          title: _model.titleController.text,
                                          description:
                                              _model.descriptionController.text,
                                          phoneNumber:
                                              _model.phoneNumberController.text,
                                          whatsappNumber: _model
                                              .whatsappNumberController.text,
                                          location:
                                              _model.locationController.text,
                                          details: createProductDetailsStruct(
                                            brand: _model.brandName,
                                            gearbox: _model.gearBox,
                                            km: _model.km,
                                            year: _model.year?.toString(),
                                            engine: _model.engine,
                                            fuel: _model.fuel,
                                            hp: _model.hp?.toString(),
                                            transmission: _model.transmission,
                                            clearUnsetFields: false,
                                            create: true,
                                          ),
                                          negociable: _model.isNegotiable,
                                          postedBy: currentUserReference,
                                          tradeType: _model.tradeType,
                                          price: double.tryParse(
                                              _model.priceController.text),
                                          currency: _model.dropDownValue,
                                        ),
                                        'Keywords': [
                                          _model.keywordsController.text
                                        ],
                                        'images': _model.images,
                                      });
                                      _model.uploadContent =
                                          PostsRecord.getDocumentFromData({
                                        ...createPostsRecordData(
                                          video: _model.uploadedFileUrl2,
                                          title: _model.titleController.text,
                                          description:
                                              _model.descriptionController.text,
                                          phoneNumber:
                                              _model.phoneNumberController.text,
                                          whatsappNumber: _model
                                              .whatsappNumberController.text,
                                          location:
                                              _model.locationController.text,
                                          details: createProductDetailsStruct(
                                            brand: _model.brandName,
                                            gearbox: _model.gearBox,
                                            km: _model.km,
                                            year: _model.year?.toString(),
                                            engine: _model.engine,
                                            fuel: _model.fuel,
                                            hp: _model.hp?.toString(),
                                            transmission: _model.transmission,
                                            clearUnsetFields: false,
                                            create: true,
                                          ),
                                          negociable: _model.isNegotiable,
                                          postedBy: currentUserReference,
                                          tradeType: _model.tradeType,
                                          price: double.tryParse(
                                              _model.priceController.text),
                                          currency: _model.dropDownValue,
                                        ),
                                        'Keywords': [
                                          _model.keywordsController.text
                                        ],
                                        'images': _model.images,
                                      }, postsRecordReference);

                                      context.goNamed('VideoPlayer');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'All fields are required',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 2000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                        ),
                                      );
                                    }

                                    setState(() {});
                                  },
                                  text: 'Apply',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 44.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Colors.white,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Noto Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
