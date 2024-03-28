import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/apis/news_api.dart';
import 'package:news_app/blocs/news_bloc/news_bloc.dart';
import 'package:news_app/constants/news_category.dart';
import 'package:news_app/models/news_model.dart';

void main() {
  group('NewsBloc', () {
    late NewsBloc newsBloc;
    late MockNewsApi mockNewsApi;

    setUp(() {
      mockNewsApi = MockNewsApi();
      newsBloc = NewsBloc(newsApi: mockNewsApi);
    });

    test('Initial state is NewsInitial', () {
      expect(newsBloc.state, equals(NewsInitial()));
    });

    test('Emits NewsLoading and NewsLoaded states on successful fetch',
        () async {
      // Arrange
      final articles = [
        Article(
          source: Source('source_id', 'Source Name'),
          author: 'Author',
          title: 'Title',
          description: 'Description',
          url: 'url',
          urlToImage: 'image_url',
          publishedAt: '2022-01-01T00:00:00Z',
          content: 'Content',
        ),
      ];
      final news = News('ok', 1, articles);
      when(mockNewsApi.fetchNewsByCategory(newsCategory: NewsCategory.business))
          .thenAnswer((_) => Future.value(news));

      // Act
      newsBloc
          .add(const FetchNewsByCategory(newsCategory: NewsCategory.business));

      // Assert
      await expectLater(
        newsBloc,
        emitsInOrder([NewsLoading(), NewsLoaded(articles)]),
      );
    });

    test('Emits NewsLoading and NewsError states on fetch error', () async {
      // Arrange
      const errorMessage = 'Error message';
      when(mockNewsApi.fetchNewsByCategory(newsCategory: NewsCategory.business))
          .thenThrow(errorMessage);

      // Act
      newsBloc
          .add(const FetchNewsByCategory(newsCategory: NewsCategory.business));

      // Assert
      await expectLater(
        newsBloc,
        emitsInOrder([NewsLoading(), const NewsError(errorMessage)]),
      );
    });

    test('Filters out articles with null or "removed" data', () async {
      // Arrange
      final articles = [
        Article(
          source: Source('source_id', 'Source Name'),
          author: 'Author',
          title: 'Removed Title',
          description: 'Description',
          url: 'url',
          urlToImage: null,
          publishedAt: '2022-01-01T00:00:00Z',
          content: 'Removed Content',
        ),
      ];
      final news = News('ok', 1, articles);
      when(mockNewsApi.fetchNewsByCategory(newsCategory: NewsCategory.business))
          .thenAnswer((_) => Future.value(news));

      // Act
      newsBloc
          .add(const FetchNewsByCategory(newsCategory: NewsCategory.business));

      // Assert
      await expectLater(
        newsBloc,
        emitsInOrder([
          NewsLoading(),
          const NewsLoaded([])
        ]), // Expect empty list after filtering
      );
    });
  });
}

class MockNewsApi extends Mock implements NewsApi {}
