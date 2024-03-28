import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/blocs/news_bloc/news_bloc.dart';
import 'package:news_app/blocs/top_news_bloc/bloc/top_news_bloc.dart';
import 'package:news_app/components/list_news.dart';
import 'package:news_app/components/skeleton_loading.dart';
import 'package:news_app/components/white_radius_container.dart';
import 'package:news_app/constants/news_category.dart';
import 'package:news_app/screens/detail/detail_news_screen.dart';
import 'package:news_app/utils/time.dart';

class ForYouScreen extends StatefulWidget {
  const ForYouScreen({super.key});

  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  @override
  void initState() {
    context.read<TopNewsBloc>().add(
          FetchTopNewsEvent(),
        );
    context.read<NewsBloc>().add(
          const FetchNewsByCategory(newsCategory: NewsCategory.general),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(title: 'Top recent'),
              const SizedBox(height: 16),
              _buildTopRecentList(),
              const SizedBox(height: 16),
              _buildTitle(title: 'Recomendation for you'),
              const SizedBox(height: 16),
              const ListNews(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTitle({required String title}) {
  return Text(
    title,
    style: GoogleFonts.sahitya(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  );
}

Widget _buildTopRecentList() {
  return BlocBuilder<TopNewsBloc, TopNewsState>(
    builder: (context, state) {
      final bool isError = state is TopNewsError;
      final bool isLoaded = state is TopNewsLoaded;

      if (isLoaded) {
        return SizedBox(
          width: double.infinity,
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.articles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailNewsScreen(
                      article: state.articles[index],
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    right: ((index + 1) == state.articles.length) ? 8 : 16,
                    left: ((index == 0) ? 8 : 0),
                    top: 12,
                    bottom: 12,
                  ),
                  child: WhiteRadiusContainer(
                    child: SizedBox(
                      width: 320,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 100,
                              height: double.infinity,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                child: Image.network(
                                  state.articles[index].urlToImage ?? '',
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return const CRectangleSkeletonAnimation(
                                      height: 180,
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/placeholder.png',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.articles[index].title ?? '',
                                  maxLines: 2,
                                  softWrap: true,
                                  style: GoogleFonts.sahitya(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateHelper.convertDate(
                                    dateString:
                                        state.articles[index].publishedAt ?? '',
                                    dateFormat: 'dd MMM yyyy',
                                  ),
                                  maxLines: 2,
                                  softWrap: true,
                                  style: GoogleFonts.sahitya(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      } else if (isError) {
        return Center(
          child: Text(state.message),
        );
      } else {
        return SizedBox(
          width: double.infinity,
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: ((index + 1) == 3) ? 8 : 16,
                  left: ((index == 0) ? 8 : 0),
                  top: 12,
                  bottom: 12,
                ),
                child: const WhiteRadiusContainer(
                  child: SizedBox(
                    width: 320,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 100,
                            height: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              child: CRectangleSkeletonAnimation(
                                height: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 12),
                              CRectangleSkeletonAnimation(
                                height: 20,
                                radius: 10,
                              ),
                              SizedBox(height: 12),
                              CRectangleSkeletonAnimation(
                                height: 20,
                                radius: 10,
                              ),
                              SizedBox(height: 12),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    },
  );
}
