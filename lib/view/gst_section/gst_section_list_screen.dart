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
import '../news/news_provider.dart';
import 'section_provider.dart';

class SectionListScreen extends StatefulWidget {
  const SectionListScreen({super.key});

  @override
  State<SectionListScreen> createState() => _SectionListScreenState();
}

class _SectionListScreenState extends State<SectionListScreen> {

SectionProvider sectionProvider=SectionProvider();

@override
  void initState() {
    sectionProvider.fetchSections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
    appBar: const CustomAppBar(title: "GST sections"),
    body: ChangeNotifierProvider(create: (BuildContext context)=>sectionProvider,child: Consumer<SectionProvider>(builder: (context,value,_){
      switch(value.sections.status)
      {
        case Status.loading:
        return Center(child: CircularProgressIndicator(color: primary,),);

        case Status.error:
        return Center(child: Text(value.sections.message.toString(),),);

        case Status.complete:
        return ListView.builder(
          itemCount: value.sections.data?.length,
          itemBuilder: (context,index){

          final data=value.sections.data?[index];

            return Card(
                      margin: const EdgeInsets.all(5),
                      child: ListTile(
                        
                        title: Text(data?.st ?? "No Title"),
                        // subtitle: Text(data?.pubDate ?? "Unknown Date"),
                        onTap: () {
                          Navigator.pushNamed(
                context,
                RoutesName.sectionDetailScreen,
                arguments: {'title': data?.st, 'details': data?.details},
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
