import '../backend/api_requests/api_calls.dart';
import '../components/trade_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AllTradesWidget extends StatefulWidget {
  const AllTradesWidget({Key? key}) : super(key: key);

  @override
  _AllTradesWidgetState createState() => _AllTradesWidgetState();
}

class _AllTradesWidgetState extends State<AllTradesWidget> {
  Completer<ApiCallResponse>? _apiRequestCompleter;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            print('IconButton pressed ...');
          },
        ),
        title: Text(
          'Trades',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: FutureBuilder<ApiCallResponse>(
            future: (_apiRequestCompleter ??= Completer<ApiCallResponse>()
                  ..complete(BeGroup.getTradesCall.call(
                    token: FFAppState().jwt,
                  )))
                .future,
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: FlutterFlowTheme.of(context).primaryColor,
                    ),
                  ),
                );
              }
              final listViewGetTradesResponse = snapshot.data!;
              return Builder(
                builder: (context) {
                  final items = BeGroup.getTradesCall
                          .items(
                            listViewGetTradesResponse.jsonBody,
                          )
                          ?.toList() ??
                      [];
                  return RefreshIndicator(
                    onRefresh: () async {
                      setState(() => _apiRequestCompleter = null);
                      await waitForApiRequestCompleter();
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: items.length,
                      itemBuilder: (context, itemsIndex) {
                        final itemsItem = items[itemsIndex];
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TradeWidget(
                              bot: getJsonField(
                                itemsItem,
                                r'''$.attributes.bot.data.attributes.label''',
                              ).toString(),
                              portfolio: getJsonField(
                                itemsItem,
                                r'''$.attributes.bot.data.attributes.portfolio.data.attributes.label''',
                              ).toString(),
                              date: getJsonField(
                                itemsItem,
                                r'''$.attributes.createdAt''',
                              ).toString(),
                              profits: getJsonField(
                                itemsItem,
                                r'''$.attributes.profits''',
                              ),
                              closedDate: valueOrDefault<String>(
                                getJsonField(
                                  itemsItem,
                                  r'''$.attributes.closedAt''',
                                ).toString(),
                                '-',
                              ),
                              percentage: getJsonField(
                                itemsItem,
                                r'''$.attributes.profitPercentage''',
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future waitForApiRequestCompleter({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = _apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
