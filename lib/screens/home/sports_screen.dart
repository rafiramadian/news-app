import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/news_bloc/news_bloc.dart';
import 'package:news_app/components/list_news.dart';
import 'package:news_app/constants/news_category.dart';

class SportsScreen extends StatefulWidget {
  const SportsScreen({super.key});

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  @override
  void initState() {
    context.read<NewsBloc>().add(
          const FetchNewsByCategory(newsCategory: NewsCategory.sports),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListNews(),
        ),
      ),
    );
  }
}
