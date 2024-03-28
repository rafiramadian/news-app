part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

final class FetchNewsByCategory extends NewsEvent {
  final NewsCategory newsCategory;

  const FetchNewsByCategory({required this.newsCategory});

  @override
  List<Object> get props => [newsCategory];
}
