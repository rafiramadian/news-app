import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/components/skeleton_loading.dart';
import 'package:news_app/models/news_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailNewsScreen extends StatelessWidget {
  final Article article;
  const DetailNewsScreen({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, article),
            _builBody(article),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader(BuildContext context, Article article) {
  return Stack(
    children: [
      SizedBox(
        width: double.infinity,
        height: 300,
        child: Image.network(
          article.urlToImage ?? '',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }

            return const CRectangleSkeletonAnimation(height: 300);
          },
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/placeholder.png',
              fit: BoxFit.cover,
            );
          },
        ),
      ),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 12.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.6),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _builBody(Article article) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.title ?? '',
          style: GoogleFonts.sahitya(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 4,
        ),
        const SizedBox(height: 12),
        Text(
          article.author ?? '',
          style: GoogleFonts.sahitya(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: article.content?.replaceAll(RegExp(r'\[.*?\]'), '') ?? '',
                style: GoogleFonts.sahitya(
                    fontSize: 16, color: Colors.black.withOpacity(0.75)),
              ),
              if (article.url != null) ...[
                TextSpan(
                  text: 'read more',
                  style: GoogleFonts.sahitya(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launchUrlString(
                        article.url!,
                        mode: LaunchMode.platformDefault,
                      );
                    },
                ),
              ]
            ],
          ),
        ),
      ],
    ),
  );
}
