import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'trade_type_model.dart';
export 'trade_type_model.dart';

class TradeTypeWidget extends StatefulWidget {
  const TradeTypeWidget({Key? key}) : super(key: key);

  @override
  _TradeTypeWidgetState createState() => _TradeTypeWidgetState();
}

class _TradeTypeWidgetState extends State<TradeTypeWidget> {
  late TradeTypeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TradeTypeModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
      child: Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(
            color: Color(0xFFE6EFFE),
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      setState(() {
                        _model.tradeType = 'buying';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _model.tradeType == 'buying'
                            ? FlutterFlowTheme.of(context).primary
                            : Color(0xFFE6EFFE),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        'Buying',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Noto Sans',
                              color: _model.tradeType == 'buying'
                                  ? Colors.white
                                  : FlutterFlowTheme.of(context).primaryText,
                              fontSize: 13.0,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      setState(() {
                        _model.tradeType = 'trade';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _model.tradeType == 'trade'
                            ? FlutterFlowTheme.of(context).primary
                            : Color(0xFFE6EFFE),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        'Trade',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Noto Sans',
                              color: _model.tradeType == 'trade'
                                  ? Colors.white
                                  : FlutterFlowTheme.of(context).primaryText,
                              fontSize: 13.0,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    setState(() {
                      _model.tradeType = 'selling';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _model.tradeType == 'selling'
                          ? FlutterFlowTheme.of(context).primary
                          : Color(0xFFE6EFFE),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      'Selling',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Noto Sans',
                            color: _model.tradeType == 'selling'
                                ? Colors.white
                                : FlutterFlowTheme.of(context).primaryText,
                            fontSize: 13.0,
                          ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      setState(() {
                        _model.tradeType = 'rent';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _model.tradeType == 'rent'
                            ? FlutterFlowTheme.of(context).primary
                            : Color(0xFFE6EFFE),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        'Rent',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Noto Sans',
                              color: _model.tradeType == 'rent'
                                  ? Colors.white
                                  : FlutterFlowTheme.of(context).primaryText,
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
      ),
    );
  }
}
