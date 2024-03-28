import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/constants/home_list_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: homeListScreen.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'News',
            style: GoogleFonts.sahitya(fontSize: 35),
          ),
          centerTitle: false,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            labelStyle:
                GoogleFonts.sahitya(fontWeight: FontWeight.bold, fontSize: 16),
            unselectedLabelColor: Colors.black.withOpacity(0.7),
            unselectedLabelStyle:
                GoogleFonts.sahitya(fontWeight: FontWeight.w400, fontSize: 16),
            tabs: List.generate(
              homeListScreen.length,
              (index) => Tab(
                text: homeListTabTitle[index],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: List.generate(
            homeListScreen.length,
            (index) => homeListScreen[index],
          ),
        ),
      ),
    );
  }
}
