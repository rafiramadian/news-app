part of 'top_news_bloc.dart';

sealed class TopNewsState extends Equatable {
  const TopNewsState();

  @override
  List<Object> get props => [];
}

final class TopNewsInitial extends TopNewsState {}

final class TopNewsLoading extends TopNewsState {}

final class TopNewsLoaded extends TopNewsState {
  final List<Article> articles;

  const TopNewsLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

final class TopNewsError extends TopNewsState {
  final String message;

  const TopNewsError(this.message);

  @override
  List<Object> get props => [message];
}
