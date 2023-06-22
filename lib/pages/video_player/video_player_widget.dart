import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/options_widget.dart';
import '/components/search_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'video_player_model.dart';
export 'video_player_model.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VideoPlayerModel());
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
        body: SafeArea(
          top: true,
          child: StreamBuilder<List<PostsRecord>>(
            stream: FFAppState().videoList(
              requestFn: () => queryPostsRecord(),
            ),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      color: FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                );
              }
              List<PostsRecord> pageViewPostsRecordList = snapshot.data!;
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: PageView.builder(
                  controller: _model.pageViewController ??= PageController(
                      initialPage: min(0, pageViewPostsRecordList.length - 1)),
                  onPageChanged: (_) => setState(() {}),
                  scrollDirection: Axis.vertical,
                  itemCount: pageViewPostsRecordList.length,
                  itemBuilder: (context, pageViewIndex) {
                    final pageViewPostsRecord =
                        pageViewPostsRecordList[pageViewIndex];
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onDoubleTap: () async {
                        if (pageViewPostsRecord.likedBy
                            .contains(currentUserReference)) {
                          final postsUpdateData1 = {
                            'liked_by':
                                FieldValue.arrayRemove([currentUserReference]),
                          };
                          await pageViewPostsRecord.reference
                              .update(postsUpdateData1);
                        } else {
                          final postsUpdateData2 = {
                            'liked_by':
                                FieldValue.arrayUnion([currentUserReference]),
                          };
                          await pageViewPostsRecord.reference
                              .update(postsUpdateData2);
                        }
                      },
                      child: Stack(
                        children: [
                          FlutterFlowVideoPlayer(
                            path: pageViewPostsRecord.video,
                            videoType: VideoType.network,
                            aspectRatio: 0.56,
                            autoPlay: true,
                            looping: true,
                            showControls: false,
                            allowFullScreen: false,
                            allowPlaybackSpeedMenu: false,
                            pauseOnNavigate: false,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    OptionsWidget(
                                      key: Key(
                                          'Keyr4k_${pageViewIndex}_of_${pageViewPostsRecordList.length}'),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 0.0, 65.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 10.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    context
                                                        .pushNamed('Profile');
                                                  },
                                                  child: Container(
                                                    width: 50.0,
                                                    height: 50.0,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.network(
                                                      'https://picsum.photos/seed/906/600',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      context.pushNamed(
                                                        'PostDetails',
                                                        queryParameters: {
                                                          'postRef':
                                                              serializeParam(
                                                            pageViewPostsRecord
                                                                .reference,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                    child: Text(
                                                      pageViewPostsRecord.title,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Noto Sans',
                                                                fontSize: 24.0,
                                                              ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color:
                                                            Color(0xFFEA5656),
                                                        size: 24.0,
                                                      ),
                                                      Text(
                                                        pageViewPostsRecord
                                                            .location,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 12.0, 0.0, 20.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFEDFFE8),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 5.0, 12.0, 5.0),
                                                child: Text(
                                                  formatNumber(
                                                    pageViewPostsRecord.price,
                                                    formatType:
                                                        FormatType.decimal,
                                                    decimalType:
                                                        DecimalType.automatic,
                                                    currency: '\$',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'Noto Sans',
                                                        color:
                                                            Color(0xFF369627),
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(1.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 0.0, 100.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    enableDrag: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return GestureDetector(
                                                        onTap: () => FocusScope
                                                                .of(context)
                                                            .requestFocus(_model
                                                                .unfocusNode),
                                                        child: Padding(
                                                          padding:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .viewInsets,
                                                          child: SearchWidget(),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      setState(() {}));
                                                },
                                                child: Icon(
                                                  Icons.search_rounded,
                                                  color: Colors.white,
                                                  size: 30.0,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await launchUrl(Uri(
                                                        scheme: 'tel',
                                                        path:
                                                            pageViewPostsRecord
                                                                .phoneNumber,
                                                      ));
                                                    },
                                                    child: FaIcon(
                                                      FontAwesomeIcons.phone,
                                                      color: Colors.white,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await launchURL(
                                                          'https://api.whatsapp.com/send?phone=${pageViewPostsRecord.whatsappNumber}&text=Hello');
                                                    },
                                                    child: FaIcon(
                                                      FontAwesomeIcons.whatsapp,
                                                      color: Colors.white,
                                                      size: 30.0,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.chat_bubble,
                                                    color: Colors.white,
                                                    size: 30.0,
                                                  ),
                                                  ToggleIcon(
                                                    onPressed: () async {
                                                      final likedByElement =
                                                          currentUserReference;
                                                      final likedByUpdate =
                                                          pageViewPostsRecord
                                                                  .likedBy
                                                                  .contains(
                                                                      likedByElement)
                                                              ? FieldValue
                                                                  .arrayRemove([
                                                                  likedByElement
                                                                ])
                                                              : FieldValue
                                                                  .arrayUnion([
                                                                  likedByElement
                                                                ]);
                                                      final postsUpdateData = {
                                                        'liked_by':
                                                            likedByUpdate,
                                                      };
                                                      await pageViewPostsRecord
                                                          .reference
                                                          .update(
                                                              postsUpdateData);
                                                      if (pageViewPostsRecord
                                                          .likedBy
                                                          .contains(
                                                              currentUserReference)) {
                                                        final postsUpdateData1 =
                                                            {
                                                          'liked_by': FieldValue
                                                              .arrayRemove([
                                                            currentUserReference
                                                          ]),
                                                        };
                                                        await pageViewPostsRecord
                                                            .reference
                                                            .update(
                                                                postsUpdateData1);

                                                        final usersUpdateData1 =
                                                            {
                                                          'fav_list': FieldValue
                                                              .arrayRemove([
                                                            pageViewPostsRecord
                                                                .reference
                                                          ]),
                                                        };
                                                        await currentUserReference!
                                                            .update(
                                                                usersUpdateData1);
                                                      } else {
                                                        final postsUpdateData2 =
                                                            {
                                                          'liked_by': FieldValue
                                                              .arrayUnion([
                                                            currentUserReference
                                                          ]),
                                                        };
                                                        await pageViewPostsRecord
                                                            .reference
                                                            .update(
                                                                postsUpdateData2);

                                                        final usersUpdateData2 =
                                                            {
                                                          'fav_list': FieldValue
                                                              .arrayUnion([
                                                            pageViewPostsRecord
                                                                .reference
                                                          ]),
                                                        };
                                                        await currentUserReference!
                                                            .update(
                                                                usersUpdateData2);
                                                      }
                                                    },
                                                    value: pageViewPostsRecord
                                                        .likedBy
                                                        .contains(
                                                            currentUserReference),
                                                    onIcon: Icon(
                                                      Icons.favorite_rounded,
                                                      color: Color(0xFFFF1818),
                                                      size: 30.0,
                                                    ),
                                                    offIcon: Icon(
                                                      Icons
                                                          .favorite_border_rounded,
                                                      color: Colors.white,
                                                      size: 30.0,
                                                    ),
                                                  ),
                                                  Builder(
                                                    builder: (context) =>
                                                        InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await Share.share(
                                                          '',
                                                          sharePositionOrigin:
                                                              getWidgetBoundingBox(
                                                                  context),
                                                        );
                                                      },
                                                      child: FaIcon(
                                                        FontAwesomeIcons.share,
                                                        color: Colors.white,
                                                        size: 30.0,
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                                    .divide(SizedBox(
                                                      height: 40.0,
                                                    ))
                                                    .around(SizedBox(
                                                      height: 40.0,
                                                    )),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 110.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                    'PostDetails',
                                                    queryParameters: {
                                                      'postRef': serializeParam(
                                                        pageViewPostsRecord
                                                            .reference,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                child: Icon(
                                                  Icons
                                                      .keyboard_control_rounded,
                                                  color: Colors.white,
                                                  size: 30.0,
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
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
