import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:researchcore/providers/article_provider.dart';
import 'package:researchcore/screens/home_screen.dart';
import 'package:researchcore/utils/theme_util.dart';

void main() {
  runApp(MultiProvider(
      providers: [Provider<ArticleProvider>(create: (_) => ArticleProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  final _pages = [
    const HomeScreen(),
    // FavoriteScreen(),
    // DownloadsScreen(),
    // AboutPage(),
  ];

  var _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Research Core',
        theme: ThemeUtil.defaultTheme(),
        home: Scaffold(
          body: SafeArea(
            child: _pages[_selectedPageIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedPageIndex,
            selectedItemColor: ThemeUtil.secondaryColor,
            showUnselectedLabels: true,
            iconSize: 24.0,
            elevation: 16.0,
            onTap: (int index) {
              setState(() {
                _selectedPageIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(
                  Icons.home,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Favorites',
                icon: Icon(
                  Icons.favorite,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Downloads',
                icon: Icon(
                  Icons.file_download,
                ),
              ),
              BottomNavigationBarItem(
                label: 'About',
                icon: Icon(
                  Icons.info,
                ),
              ),
            ],
          ),
        ));
  }
}
