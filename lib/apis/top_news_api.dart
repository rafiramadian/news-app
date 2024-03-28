import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/http_service.dart';

class TopNewsApi {
  final HttpService httpService;
  TopNewsApi({required this.httpService});

  Future<News> fetchTopNews() async {
    try {
      DateTime now = DateTime.now();
      String today = now.toIso8601String();
      String twoDayBefore =
          now.subtract(const Duration(days: 2)).toIso8601String();

      final Map<String, dynamic> result = await httpService
          .get('everything?q=world&from=$twoDayBefore&to=$today');
      debugPrint('$result');

      final News news = News.fromJson(result);

      return news;
    } catch (e) {
      rethrow;
    }
  }
}
