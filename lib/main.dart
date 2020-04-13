import 'package:flutter/material.dart';
import 'package:news/pages/tabs_page.dart';
import 'package:news/services/news_service.dart';
import 'package:news/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService())
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        home: TabsPage(),
      ),
    );
  }
}
