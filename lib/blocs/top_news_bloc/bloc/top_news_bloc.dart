import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/apis/top_news_api.dart';
import 'package:news_app/models/news_model.dart';

part 'top_news_event.dart';
part 'top_news_state.dart';

class TopNewsBloc extends Bloc<TopNewsEvent, TopNewsState> {
  final TopNewsApi topNewsApi;
  TopNewsBloc({required this.topNewsApi}) : super(TopNewsInitial()) {
    on<FetchTopNewsEvent>(fetchTopNews);
  }

  Future<void> fetchTopNews(FetchTopNewsEvent event, emit) async {
    emit(TopNewsLoading());
    try {
      final News news = await topNewsApi.fetchTopNews();
      final List<Article> articles = news.articles;

      // Remove data that the title/desc/content/url image is null
      articles.removeWhere(
        (element) =>
            (element.title?.toLowerCase().contains('removed') ?? false) ||
            (element.description?.toLowerCase().contains('removed') ?? false) ||
            (element.content?.toLowerCase().contains('removed') ?? false) ||
            (element.urlToImage == null),
      );

      emit(
        TopNewsLoaded(
            (articles.length > 5) ? articles.sublist(0, 5) : articles),
      );
    } catch (e) {
      emit(TopNewsError(e.toString()));
    }
  }
}
