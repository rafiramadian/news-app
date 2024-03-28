import 'package:flutter/material.dart';
import 'package:news_app/constants/news_category.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/http_service.dart';

class NewsApi {
  final HttpService httpService;
  NewsApi({required this.httpService});

  Future<News> fetchNewsByCategory({required NewsCategory newsCategory}) async {
    try {
      final Map<String, dynamic> result = await httpService
          .get('top-headlines?country=us&category=${newsCategory.name}');
      debugPrint('$result');

      final News news = News.fromJson(result);

      return news;
    } catch (e) {
      rethrow;
    }
  }
}
