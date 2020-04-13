import 'package:flutter/material.dart';
import 'package:news/models/news.models.dart';
import 'package:news/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final Article notice;

  const DetailPage(this.notice);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(notice),
        SliverList(
            delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 10), 
                  NoticeTitle(notice),
                   SizedBox(height: 22), 
                  NoticeDescription(notice),
                  SizedBox(height: 22), 
                  NoticeContent(notice),
                   SizedBox(height: 22), 
                  NoticeButton(notice)
                ]
              )
            )
      ],
    ));
  }
}

class NoticeButton extends StatelessWidget {
  final Article notice;
  const NoticeButton( this.notice ) ;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      margin: EdgeInsets.only(bottom: 20),
      child: RaisedButton(
        onPressed: () => {
          _launchURL(notice)
        } ,
        child: Text('View'),
        color: myTheme.accentColor,
      ) ,
    );
  }

  _launchURL( Article notice ) async {
  if (await canLaunch(notice.url)) {
    await launch(notice.url);
  } else {
    AlertDialog(
      title: Text('Could not launch ${notice.url}'),
    );
    //throw 'Could not launch ${notice.url}';
  }
}
 
}

class NoticeContent extends StatelessWidget {
  final Article notice;
  const NoticeContent( this.notice );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ( notice.content != null ) 
      ? Text(
        notice.content,
        style: TextStyle(fontSize: 18) ,
      )
      : Text('')
    );
  }
}

class NoticeDescription extends StatelessWidget {
  final Article notice;
  
  const NoticeDescription( this.notice );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ( notice.description != null )  
      ? Text(
        notice.description,
        style: TextStyle(fontSize: 18) ,
      )
      : Text('')
    );
  }
}

class NoticeTitle extends StatelessWidget {
  final Article notice;
  const NoticeTitle(this.notice);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        child: Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              notice.title,
              style: TextStyle( fontSize: 25, fontWeight: FontWeight.w700 ),
            )
          ],
        )),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final Article notice;
  const CustomAppBar(this.notice);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 2.0,
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            notice.source.name,
            style: TextStyle(fontSize: 20),
          ),
          background: (notice.urlToImage != null)
              ? Hero(
                  tag: notice.title,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/giphy.gif'),
                    image: NetworkImage(notice.urlToImage),
                  ),
                )
              : Image(image: AssetImage('assets/img/no-image.png'))),
      backgroundColor: myTheme.primaryColor,
    );
  }
}
