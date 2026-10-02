import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:icgoogo/models/portfolio_model.dart';

const portfolioApiUrl =
    'https://script.google.com/macros/s/AKfycbwJCV-EE2DvRUba-56aSLQXLThIaEJ5BcYenNHKEJreEtSLsw8z00WSBJDR11mm0efBfw/exec?action=all';
Future<PortfolioResponse> fetchPortfolio() async {
  try {
    final response = await http.get(Uri.parse(portfolioApiUrl));
    if (response.statusCode == 200) {
      return _parsePortfolio(response.body);
    }
  } catch (_) {
    // Use the bundled snapshot when the API is unavailable.
  }

  final localJson = await rootBundle.loadString('assets/data.json');
  return _parsePortfolio(localJson);
}

PortfolioResponse _parsePortfolio(String source) {
  return PortfolioResponse.fromJson(
    jsonDecode(source) as Map<String, dynamic>,
  );
}
