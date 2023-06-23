import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'post_details_model.dart';
export 'post_details_model.dart';

class PostDetailsWidget extends StatefulWidget {
  const PostDetailsWidget({
    Key? key,
    required this.postRef,
  }) : super(key: key);

  final DocumentReference? postRef;

  @override
  _PostDetailsWidgetState createState() => _PostDetailsWidgetState();
}

class _PostDetailsWidgetState extends State<PostDetailsWidget> {
  late PostDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostDetailsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<PostsRecord>(
      stream: FFAppState().postDetails(
        uniqueQueryKey: valueOrDefault<String>(
          widget.postRef?.id,
          'null',
        ),
        requestFn: () => PostsRecord.getDocument(widget.postRef!),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  color: FlutterFlowTheme.of(context).primary,
                ),
              ),
            ),
          );
        }
        final postDetailsPostsRecord = snapshot.data!;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 350.0,
                      child: Stack(
                        children: [
                          Builder(
                            builder: (context) {
                              final images =
                                  postDetailsPostsRecord.images.toList();
                              return Container(
                                width: double.infinity,
                                child: PageView.builder(
                                  controller: _model.pageViewController ??=
                                      PageController(
                                          initialPage:
                                              min(0, images.length - 1)),
                                  onPageChanged: (_) => setState(() {}),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: images.length,
                                  itemBuilder: (context, imagesIndex) {
                                    final imagesItem = images[imagesIndex];
                                    return ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30.0),
                                        bottomRight: Radius.circular(30.0),
                                        topLeft: Radius.circular(0.0),
                                        topRight: Radius.circular(0.0),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: imagesItem,
                                        width: 300.0,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 20.0, 20.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${functions.increaseNumber(_model.pageViewCurrentIndex).toString()}/${postDetailsPostsRecord.images.length.toString()}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                FlutterFlowIconButton(
                                  borderRadius: 50.0,
                                  borderWidth: 1.0,
                                  buttonSize: 52.0,
                                  fillColor: Colors.white,
                                  icon: Icon(
                                    Icons.close_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    context.safePop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            postDetailsPostsRecord.title,
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Noto Sans',
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 5.0, 0.0),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Color(0xFFEA5656),
                                    size: 24.0,
                                  ),
                                ),
                                Text(
                                  postDetailsPostsRecord.location,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        color: Color(0xFF868686),
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 40.0,
                            thickness: 1.0,
                            color: Color(0xFFD9D9D9),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEDFFE8),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 5.0, 10.0, 5.0),
                                    child: Text(
                                      postDetailsPostsRecord.price.toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Color(0xFF369627),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price Negociable :',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE6EFFE),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30.0, 5.0, 30.0, 5.0),
                                    child: Text(
                                      postDetailsPostsRecord.negociable
                                          ? 'Yes'
                                          : 'No',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Listing Type :',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                      color: Color(0xFFE6EFFE),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 5.0, 10.0, 5.0),
                                    child: Text(
                                      postDetailsPostsRecord.tradeType,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Private Seller :',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                      color: Color(0xFFE6EFFE),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30.0, 5.0, 30.0, 5.0),
                                    child: Text(
                                      'Yes',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 40.0,
                            thickness: 1.0,
                            color: Color(0xFFD9D9D9),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Brand',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD5DEFD),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 5.0, 15.0, 5.0),
                                    child: Text(
                                      postDetailsPostsRecord.details.brand,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Color(0xFF0E185F),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Gearbox',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD5DEFD),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 5.0, 15.0, 5.0),
                                    child: Text(
                                      postDetailsPostsRecord.details.gearbox,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Color(0xFF0E185F),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Km',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD5DEFD),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 5.0, 15.0, 5.0),
                                    child: Text(
                                      postDetailsPostsRecord.details.km
                                          .toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Color(0xFF0E185F),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Year',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD5DEFD),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 5.0, 15.0, 5.0),
                                    child: Text(
                                      postDetailsPostsRecord.details.year,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Color(0xFF0E185F),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Engine',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD5DEFD),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 5.0, 15.0, 5.0),
                                    child: Text(
                                      postDetailsPostsRecord.details.engine,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Color(0xFF0E185F),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Fuel',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD5DEFD),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 5.0, 15.0, 5.0),
                                    child: Text(
                                      postDetailsPostsRecord.details.fuel,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Color(0xFF0E185F),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Hp',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD5DEFD),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 5.0, 15.0, 5.0),
                                    child: Text(
                                      postDetailsPostsRecord.details.hp,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Color(0xFF0E185F),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Transmission',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD5DEFD),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 5.0, 15.0, 5.0),
                                    child: Text(
                                      postDetailsPostsRecord
                                          .details.transmission,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'Noto Sans',
                                            color: Color(0xFF0E185F),
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 40.0,
                            thickness: 1.0,
                            color: Color(0xFFD9D9D9),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 12.0),
                            child: Text(
                              'Description :',
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Text(
                            postDetailsPostsRecord.description,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Noto Sans',
                                  color: Color(0xFF868686),
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 30.0, 0.0, 30.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.phone,
                                  color: Color(0xFF0162F2),
                                  size: 34.0,
                                ),
                                FaIcon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Color(0xFF0162F2),
                                  size: 34.0,
                                ),
                                Icon(
                                  Icons.chat_bubble,
                                  color: Color(0xFF0162F2),
                                  size: 34.0,
                                ),
                              ],
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
      },
    );
  }
}
