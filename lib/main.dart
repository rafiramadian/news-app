import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/apis/news_api.dart';
import 'package:news_app/apis/top_news_api.dart';
import 'package:news_app/blocs/news_bloc/news_bloc.dart';
import 'package:news_app/blocs/top_news_bloc/bloc/top_news_bloc.dart';
import 'package:news_app/screens/news_screen.dart';
import 'package:news_app/services/http_service.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsBloc(
            newsApi: NewsApi(
              httpService: HttpService(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => TopNewsBloc(
            topNewsApi: TopNewsApi(
              httpService: HttpService(),
            ),
          ),
        )
      ],
      child: MaterialApp(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NewsScreen(),
      ),
    );
  }
}
