import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/blocs/news_bloc/news_bloc.dart';
import 'package:news_app/components/skeleton_loading.dart';
import 'package:news_app/components/white_radius_container.dart';
import 'package:news_app/screens/detail/detail_news_screen.dart';
import 'package:news_app/utils/time.dart';

class ListNews extends StatelessWidget {
  const ListNews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        final bool isError = state is NewsError;
        final bool isLoaded = state is NewsLoaded;

        if (isLoaded) {
          return Column(
            children: List.generate(
              state.articles.length,
              (index) {
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
                      bottom: ((index + 1) == state.articles.length) ? 0 : 20,
                    ),
                    child: WhiteRadiusContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 180,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
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
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              DateHelper.convertDate(
                                dateString:
                                    state.articles[index].publishedAt ?? '',
                                dateFormat: 'dd MMM yyyy',
                              ),
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.sahitya(
                                fontWeight: FontWeight.w100,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              state.articles[index].title ?? '',
                              maxLines: 2,
                              softWrap: true,
                              style: GoogleFonts.sahitya(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
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
          return Column(
            children: List.generate(
              3,
              (index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: WhiteRadiusContainer(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 180,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: CRectangleSkeletonAnimation(
                              height: double.infinity,
                              width: double.infinity,
                              radius: 10,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: CRectangleSkeletonAnimation(
                            height: 30,
                            width: double.infinity,
                            radius: 10,
                          ),
                        ),
                      ],
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
}
