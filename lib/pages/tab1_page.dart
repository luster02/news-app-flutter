import 'package:flutter/material.dart';
import 'package:news/services/news_service.dart';
import 'package:news/widgets/list_news.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body:( newsService.headlines.length == 0 )
          ? Center(child: CircularProgressIndicator())
          : ListNews(newsService.headlines)
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
