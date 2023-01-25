import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TradeWidget extends StatefulWidget {
  const TradeWidget({
    Key? key,
    this.bot,
    this.portfolio,
    this.date,
    this.profits,
    this.closedDate,
    this.percentage,
  }) : super(key: key);

  final String? bot;
  final String? portfolio;
  final String? date;
  final double? profits;
  final String? closedDate;
  final double? percentage;

  @override
  _TradeWidgetState createState() => _TradeWidgetState();
}

class _TradeWidgetState extends State<TradeWidget> {
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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        widget.portfolio!,
                        textAlign: TextAlign.end,
                        style: FlutterFlowTheme.of(context).subtitle2.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        child: Text(
                          widget.bot!,
                          style: FlutterFlowTheme.of(context).subtitle1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          ' / ',
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          valueOrDefault<String>(
                            functions.formatDate(widget.closedDate),
                            '-',
                          ),
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ),
                    ],
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
                  valueOrDefault<String>(
                    formatNumber(
                      widget.profits,
                      formatType: FormatType.decimal,
                      decimalType: DecimalType.automatic,
                      currency: '',
                    ),
                    '0',
                  ),
                  textAlign: TextAlign.end,
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).primaryColor,
                      ),
                ),
                Text(
                  valueOrDefault<String>(
                    formatNumber(
                      widget.percentage,
                      formatType: FormatType.custom,
                      format: '##.##%',
                      locale: '',
                    ),
                    '0',
                  ),
                  textAlign: TextAlign.end,
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).secondaryColor,
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
