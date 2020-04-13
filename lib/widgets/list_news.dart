import 'package:flutter/material.dart';
import 'package:news/models/news.models.dart';
import 'package:news/pages/detail_page.dart';
import 'package:news/theme/theme.dart';

class ListNews extends StatelessWidget {
  const ListNews(this.news);
  final List<Article> news;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.news.length,
        itemBuilder: (BuildContext context, int index) {
          return _Notice(
            notice: this.news[index],
            index: index,
          );
        });
  }
}

class _Notice extends StatelessWidget {
  final Article notice;
  final int index;

  const _Notice({@required this.notice, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _CardTop(
          notice: notice,
          index: index,
        ),
        _CardTitle(notice: notice),
        _CardImage(notice: notice),
        _CardBody(notice: notice),
        SizedBox(
          height: 10,
        ),
        Divider()
      ],
    );
  }
}

class _CardBody extends StatelessWidget {
  final Article notice;

  const _CardBody({this.notice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text((notice.description != null) ? notice.description : ''),
    );
  }
}

class _CardImage extends StatelessWidget {
  final Article notice;
  const _CardImage({this.notice});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailPage(notice)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Hero(
          tag: notice.title,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
            child: Container(
                child: (notice.urlToImage != null)
                    ? FadeInImage(
                        placeholder: AssetImage('assets/img/giphy.gif'),
                        image: NetworkImage(notice.urlToImage),
                      )
                    : Image(image: AssetImage('assets/img/no-image.png'))),
          ),
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article notice;

  const _CardTitle({@required this.notice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        notice.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _CardTop extends StatelessWidget {
  final Article notice;
  final int index;

  const _CardTop({@required this.notice, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text(
            '${index + 1}',
            style: TextStyle(color: myTheme.accentColor),
          ),
          Text('${notice.source.name}')
        ],
      ),
    );
  }
}
