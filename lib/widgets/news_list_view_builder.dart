import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import '../services/news_service.dart';
import 'news_list_view.dart';


class NewsListViewBuilder extends StatefulWidget {
  const NewsListViewBuilder({super.key, required this.category});

  final String category;


  @override
  State<NewsListViewBuilder> createState() => _NewsListViewBuilderState();
}

class _NewsListViewBuilderState extends State<NewsListViewBuilder> {
  var future;

  @override
  void initState() {
    super.initState();
    future = NewsService(dio: Dio()).getNews(
      category: widget.category
    );
  }

  @override
  Widget build(BuildContext context) {
    // still loading data
    return FutureBuilder <List<ArticleModel>>(
        future: future,
        builder: (context,snapshot){
          if (snapshot.hasData){
            return NewsListView(
                articles: snapshot.data!);
          }else if(snapshot.hasError){
            return const SliverToBoxAdapter(
                child: Center(
                    child: Text('Oops there is an error, Please Try Later'))
            );
          }else {
            return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator(),),);
          }

    });

      /*isLoading == true
        ? const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()))
    //data Loaded Successfully
        : articles.isNotEmpty
              ? NewsListView(
                  articles: articles,)
    //data load failed
              :const SliverToBoxAdapter(
                   child: Center(
                      child: Text('Oops there is an error, Please Try Later'))
              );*/
  }
}