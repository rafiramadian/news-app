import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/apis/news_api.dart';
import 'package:news_app/constants/news_category.dart';
import 'package:news_app/models/news_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsApi newsApi;
  NewsBloc({required this.newsApi}) : super(NewsInitial()) {
    on<FetchNewsByCategory>(fetchNewsByCategory);
  }

  Future<void> fetchNewsByCategory(FetchNewsByCategory event, emit) async {
    emit(NewsLoading());
    try {
      final News news =
          await newsApi.fetchNewsByCategory(newsCategory: event.newsCategory);
      final List<Article> articles = news.articles;

      // Remove data that the title/desc/content/url image is null
      articles.removeWhere(
        (element) =>
            (element.title?.toLowerCase().contains('removed') ?? false) ||
            (element.description?.toLowerCase().contains('removed') ?? false) ||
            (element.content?.toLowerCase().contains('removed') ?? false) ||
            (element.urlToImage == null),
      );

      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
