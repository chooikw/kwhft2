import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OpenTxWidget extends StatefulWidget {
  const OpenTxWidget({
    Key? key,
    this.bot,
    this.portfolio,
    this.date,
    this.size,
  }) : super(key: key);

  final String? bot;
  final String? portfolio;
  final String? date;
  final double? size;

  @override
  _OpenTxWidgetState createState() => _OpenTxWidgetState();
}

class _OpenTxWidgetState extends State<OpenTxWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.bot!,
                    style: FlutterFlowTheme.of(context).subtitle1,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      valueOrDefault<String>(
                        functions.formatDate(widget.date),
                        '-',
                      ),
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatNumber(
                    widget.size! * 2,
                    formatType: FormatType.decimal,
                    decimalType: DecimalType.automatic,
                    currency: '',
                  ),
                  textAlign: TextAlign.end,
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).primaryColor,
                      ),
                ),
                Text(
                  widget.portfolio!,
                  textAlign: TextAlign.end,
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
