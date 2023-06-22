import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'options_model.dart';
export 'options_model.dart';

class OptionsWidget extends StatefulWidget {
  const OptionsWidget({Key? key}) : super(key: key);

  @override
  _OptionsWidgetState createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  late OptionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OptionsModel());
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
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 10.0),
      child: FlutterFlowChoiceChips(
        options: [
          ChipData('All'),
          ChipData('Automobile'),
          ChipData('Bus Company'),
          ChipData('Autre'),
          ChipData('Immobilier')
        ],
        onChanged: (val) =>
            setState(() => _model.choiceChipsValue = val?.first),
        selectedChipStyle: ChipStyle(
          backgroundColor: FlutterFlowTheme.of(context).accent1,
          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Noto Sans',
                color: FlutterFlowTheme.of(context).primaryText,
              ),
          iconColor: FlutterFlowTheme.of(context).primaryText,
          iconSize: 18.0,
          labelPadding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 15.0, 5.0),
          elevation: 0.0,
          borderRadius: BorderRadius.circular(20.0),
        ),
        unselectedChipStyle: ChipStyle(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Noto Sans',
                color: Colors.white,
              ),
          iconColor: FlutterFlowTheme.of(context).secondaryText,
          iconSize: 18.0,
          labelPadding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 15.0, 5.0),
          elevation: 0.0,
          borderRadius: BorderRadius.circular(20.0),
        ),
        chipSpacing: 12.0,
        rowSpacing: 12.0,
        multiselect: false,
        initialized: _model.choiceChipsValue != null,
        alignment: WrapAlignment.start,
        controller: _model.choiceChipsValueController ??=
            FormFieldController<List<String>>(
          ['All'],
        ),
      ),
    );
  }
}
