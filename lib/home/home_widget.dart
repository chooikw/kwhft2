import '../backend/api_requests/api_calls.dart';
import '../components/open_tx_widget.dart';
import '../components/portfolio_card_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  PageController? pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Welcome,',
                                    style: FlutterFlowTheme.of(context).title3,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4, 0, 0, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        context.pushNamed('Profile');
                                      },
                                      child: Text(
                                        getJsonField(
                                          FFAppState().user,
                                          r'''$.username''',
                                        ).toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'Poppins',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                            child: FutureBuilder<ApiCallResponse>(
                              future: BeGroup.getPortfoliosCall.call(
                                token: FFAppState().jwt,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                      ),
                                    ),
                                  );
                                }
                                final pageViewGetPortfoliosResponse =
                                    snapshot.data!;
                                return Builder(
                                  builder: (context) {
                                    final portfolios = BeGroup.getPortfoliosCall
                                            .items(
                                              pageViewGetPortfoliosResponse
                                                  .jsonBody,
                                            )
                                            ?.toList() ??
                                        [];
                                    return Container(
                                      width: double.infinity,
                                      height: 228,
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 50),
                                            child: PageView.builder(
                                              controller: pageViewController ??=
                                                  PageController(
                                                      initialPage: min(
                                                          0,
                                                          portfolios.length -
                                                              1)),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: portfolios.length,
                                              itemBuilder:
                                                  (context, portfoliosIndex) {
                                                final portfoliosItem =
                                                    portfolios[portfoliosIndex];
                                                return PortfolioCardWidget(
                                                  label: getJsonField(
                                                    portfoliosItem,
                                                    r'''$.attributes.label''',
                                                  ).toString(),
                                                  broker: getJsonField(
                                                    portfoliosItem,
                                                    r'''$.attributes.broker.data.attributes.name''',
                                                  ).toString(),
                                                  profits: getJsonField(
                                                    portfoliosItem,
                                                    r'''$.attributes.profits''',
                                                  ),
                                                  trades: getJsonField(
                                                    portfoliosItem,
                                                    r'''$.attributes.trades''',
                                                  ),
                                                  success: getJsonField(
                                                    portfoliosItem,
                                                    r'''$.attributes.successfulTrades''',
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 1),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 10),
                                              child: smooth_page_indicator
                                                  .SmoothPageIndicator(
                                                controller:
                                                    pageViewController ??=
                                                        PageController(
                                                            initialPage: min(
                                                                0,
                                                                portfolios
                                                                        .length -
                                                                    1)),
                                                count: portfolios.length,
                                                axisDirection: Axis.horizontal,
                                                onDotClicked: (i) {
                                                  pageViewController!
                                                      .animateToPage(
                                                    i,
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.ease,
                                                  );
                                                },
                                                effect: smooth_page_indicator
                                                    .ExpandingDotsEffect(
                                                  expansionFactor: 2,
                                                  spacing: 8,
                                                  radius: 16,
                                                  dotWidth: 16,
                                                  dotHeight: 16,
                                                  dotColor: Color(0xFF9E9E9E),
                                                  activeDotColor:
                                                      Color(0xFF3F51B5),
                                                  paintStyle:
                                                      PaintingStyle.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x39000000),
                            offset: Offset(0, -1),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Quick Service',
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    context.pushNamed('AllTrades');
                                  },
                                  child: Container(
                                    width: 110,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Color(0x3B000000),
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4, 4, 4, 4),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.swap_horiz_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 40,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 8, 0, 0),
                                            child: Text(
                                              'All Trades',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        color: Color(0x39000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4, 4, 4, 4),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.account_balance_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 40,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0, 0),
                                          child: Text(
                                            'New Portfolio',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 12, 20, 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Open Trades',
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ],
                            ),
                          ),
                          FutureBuilder<ApiCallResponse>(
                            future: BeGroup.getOpenTradesCall.call(
                              token: FFAppState().jwt,
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                    ),
                                  ),
                                );
                              }
                              final listViewGetOpenTradesResponse =
                                  snapshot.data!;
                              return Builder(
                                builder: (context) {
                                  final openTrades = BeGroup.getOpenTradesCall
                                          .items(
                                            listViewGetOpenTradesResponse
                                                .jsonBody,
                                          )
                                          ?.toList() ??
                                      [];
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: openTrades.length,
                                    itemBuilder: (context, openTradesIndex) {
                                      final openTradesItem =
                                          openTrades[openTradesIndex];
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          OpenTxWidget(
                                            bot: valueOrDefault<String>(
                                              getJsonField(
                                                openTradesItem,
                                                r'''$.attributes.bot.data.attributes.label''',
                                              ).toString(),
                                              '-',
                                            ),
                                            portfolio: valueOrDefault<String>(
                                              getJsonField(
                                                openTradesItem,
                                                r'''$.attributes.bot.data.attributes.portfolio.data.attributes.label''',
                                              ).toString(),
                                              '-',
                                            ),
                                            date: valueOrDefault<String>(
                                              getJsonField(
                                                openTradesItem,
                                                r'''$.attributes.createdAt''',
                                              ).toString(),
                                              '-',
                                            ),
                                            size: valueOrDefault<double>(
                                              getJsonField(
                                                openTradesItem,
                                                r'''$.attributes.bot.data.attributes.orderSize''',
                                              ),
                                              0.0,
                                            ),
                                          ),
                                          Divider(
                                            thickness: 1,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
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
    );
  }
}
