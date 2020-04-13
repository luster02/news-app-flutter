import 'package:flutter/material.dart';
import 'package:news/models/category_model.dart';
import 'package:news/services/news_service.dart';
import 'package:news/theme/theme.dart';
import 'package:news/widgets/list_news.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          _ListCategories(),
          (newsService.isLoading == true)
              ? Expanded(
                  child: Center(
                  child: CircularProgressIndicator(),
                ))
              : Expanded(
                  child:
                      ListNews(newsService.getArticulosCategoriaSeleccionada),
                ),
        ],
      )),
    );
  }
}

class _ListCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final cName = categories[index].name;
          return Container(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(children: <Widget>[
                _categoryButton(categories[index]),
                SizedBox(height: 5),
                Text('${cName[0].toUpperCase()}${cName.substring(1)}')
              ]),
            ),
          );
        },
      ),
    );
  }
}

class _categoryButton extends StatelessWidget {
  final Category category;
  const _categoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final selectedCategory =
        Provider.of<NewsService>(context, listen: false).selectedCategory;
    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          category.icon,
          color: (selectedCategory == category.name)
              ? myTheme.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
