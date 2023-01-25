import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start BE Group Code

class BeGroup {
  static String baseUrl = 'https://tv2.crowdbranding.biz.my/api';
  static Map<String, String> headers = {};
  static LoginCall loginCall = LoginCall();
  static GetPortfoliosCall getPortfoliosCall = GetPortfoliosCall();
  static GetOpenTradesCall getOpenTradesCall = GetOpenTradesCall();
  static GetTradesCall getTradesCall = GetTradesCall();
}

class LoginCall {
  Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
  }) {
    final body = '''
{
  "identifier": "${username}",
  "password": "${password}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'login',
      apiUrl: '${BeGroup.baseUrl}/auth/local',
      callType: ApiCallType.POST,
      headers: {
        ...BeGroup.headers,
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic user(dynamic response) => getJsonField(
        response,
        r'''$.user''',
      );
  dynamic jwt(dynamic response) => getJsonField(
        response,
        r'''$.jwt''',
      );
}

class GetPortfoliosCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getPortfolios',
      apiUrl: '${BeGroup.baseUrl}/portfolios?populate=broker',
      callType: ApiCallType.GET,
      headers: {
        ...BeGroup.headers,
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic items(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      );
}

class GetOpenTradesCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getOpenTrades',
      apiUrl: '${BeGroup.baseUrl}/trades',
      callType: ApiCallType.GET,
      headers: {
        ...BeGroup.headers,
        'Authorization': 'Bearer ${token}',
      },
      params: {
        'filters[profits]': "0",
        'populate': "bot.portfolio",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic items(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      );
}

class GetTradesCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getTrades',
      apiUrl: '${BeGroup.baseUrl}/trades',
      callType: ApiCallType.GET,
      headers: {
        ...BeGroup.headers,
        'Authorization': 'Bearer ${token}',
      },
      params: {
        'populate': "bot.portfolio",
        'sort[0]': "createdAt:desc",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic items(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      );
}

/// End BE Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar) {
  jsonVar ??= {};
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return '{}';
  }
}
