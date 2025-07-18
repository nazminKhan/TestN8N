import 'package:flutter/material.dart';
import 'package:mvvm_demo/app_store/app_store.dart';
import 'package:mvvm_demo/routes/routes_name.dart';
import 'package:mvvm_demo/service/api_response.dart';
import 'package:mvvm_demo/utils/app_color.dart';
import 'package:mvvm_demo/view/gst/gst_screen.dart';
import 'package:mvvm_demo/view/login_screen.dart';
import 'package:mvvm_demo/view/splash_screen.dart';
import 'package:mvvm_demo/view_modal/user_list_provider.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/custom_app_bar.dart';
import '../../utils/strings.dart';
import 'news_provider.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {

NewsProvider newsProvider=NewsProvider();

@override
  void initState() {
    newsProvider.fetchNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
    appBar: const CustomAppBar(title: News_Updates),
    body: ChangeNotifierProvider(create: (BuildContext context)=>newsProvider,child: Consumer<NewsProvider>(builder: (context,value,_){
      switch(value.news.status)
      {
        case Status.loading:
        return Center(child: CircularProgressIndicator(color: primary,),);

        case Status.error:
        return Center(child: Text(value.news.message.toString(),),);

        case Status.complete:
        return ListView.builder(
          itemCount: value.news.data?.length,
          itemBuilder: (context,index){

          final data=value.news.data?[index];

            return Card(
                      margin: const EdgeInsets.all(5),
                      child: ListTile(
                        leading: data?.imgUrl != null && data!.imgUrl!.isNotEmpty
                            ? CircleAvatar(
                                foregroundImage: NetworkImage(data.imgUrl!),
                              )
                            : const CircleAvatar(
                                child: Icon(Icons.article),
                              ),
                        title: Text(data?.title ?? "No Title"),
                        subtitle: Text(data?.pubDate ?? "Unknown Date"),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.newsDetailScreen,
                            arguments: {'url': data?.link},
                          );
                        },
                      ),
                    );
          });

        default:

      }
      return const SizedBox();
    }),),);

  }
}
