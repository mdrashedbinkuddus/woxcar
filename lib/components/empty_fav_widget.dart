import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'empty_fav_model.dart';
export 'empty_fav_model.dart';

class EmptyFavWidget extends StatefulWidget {
  const EmptyFavWidget({Key? key}) : super(key: key);

  @override
  _EmptyFavWidgetState createState() => _EmptyFavWidgetState();
}

class _EmptyFavWidgetState extends State<EmptyFavWidget> {
  late EmptyFavModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyFavModel());
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
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/urban-passenger-car-station-wagon-side-view.png',
              width: 300.0,
              height: 200.0,
              fit: BoxFit.contain,
            ),
          ),
          Text(
            'Add Your Favourites Here',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).titleLarge,
          ),
        ],
      ),
    );
  }
}
