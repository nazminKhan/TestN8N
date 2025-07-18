import 'package:flutter/material.dart';

import 'package:mvvm_demo/utils/app_color.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mvvm_demo/view/gst_item/item_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../common_widgets/custom_app_bar.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;

import '../../modals/goods_item_code.dart';
import '../../routes/routes_name.dart';
import '../../service/api_response.dart';
class ItemDetailScreen extends StatefulWidget {
  final String type;

  const ItemDetailScreen({super.key, required this.type, });

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
ItemProvider sectionProvider=ItemProvider();

@override
  void initState() {
    sectionProvider.fetchGSTCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.type,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // _shareContent(context);
            },
          ),
        ],
      ),
      body: ChangeNotifierProvider(create: (BuildContext context)=>sectionProvider,child: Consumer<ItemProvider>(builder: (context,value,_){
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
                      child: Stack(
                        children: [
                          ListTile(
                            title: Text(data?.goodsDescription ?? "No Title"),
                            subtitle: Text(data?.goodsHsnCode.toString() ?? "No code"),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(
                                Icons.share,
                                color: AppColor.primary,
                              ),
                              onPressed: () {
                                _shareContent(data);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
          });

        default:

      }
      return const SizedBox();
    }),),
    );
  }

   void _shareContent(GoodsItemCode? data) {
    if (data != null) {
      final String content = '''
Type: ${data.goodsType ?? 'N/A'}
Description: ${data.goodsDescription ?? 'N/A'}
Rate: ${data.goodsRate ?? 'N/A'}
HSN Code: ${data.goodsHsnCode ?? 'N/A'}
''';
      Share.share(content, subject: 'Goods Item Details');
    }
  }
}