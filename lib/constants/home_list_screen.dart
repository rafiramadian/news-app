import 'package:flutter/material.dart';
import 'package:news_app/screens/home/business_screen.dart';
import 'package:news_app/screens/home/entertainment_screen.dart';
import 'package:news_app/screens/home/for_you_screen.dart';
import 'package:news_app/screens/home/health_screen.dart';
import 'package:news_app/screens/home/science_screen.dart';
import 'package:news_app/screens/home/sports_screen.dart';
import 'package:news_app/screens/home/technology_screen.dart';

const List<Widget> homeListScreen = [
  ForYouScreen(),
  BusinessScreen(),
  EntertainmentScreen(),
  HealthScreen(),
  ScienceScreen(),
  SportsScreen(),
  TechnologyScreen(),
];

const List<String> homeListTabTitle = [
  'For You',
  'Business',
  'Entertainment',
  'Health',
  'Science',
  'Sports',
  'Technology',
];
