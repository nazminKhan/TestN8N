import 'package:flutter/material.dart';
import 'package:mvvm_demo/modals/user_list.dart';
import 'package:mvvm_demo/repository/repository.dart';
import 'package:mvvm_demo/service/api_response.dart';
import 'package:mvvm_demo/utils/common_toast.dart';
import 'package:xml/xml.dart';

import '../../modals/rss_feed_data.dart';
import '../../repository/repository_news.dart';

class NewsProvider with ChangeNotifier{
  final _appRepository =AppRepositoryNews();

  ApiResponse<List<RssFeedData>> news = ApiResponse.loading();
  setUserList(ApiResponse<List<RssFeedData>> response){
    news=response;
    notifyListeners();
  }

   Future<void> fetchNews()async{
    setUserList(ApiResponse.loading());
    _appRepository.newsList("technology","en-US","US").then((value)
    {

    // dynamic list=_parseRssFeed(value);
    //  setUserList(ApiResponse.complete(value));

    // final document = XmlDocument.parse(value);
        final list = _parseRssFeed(value);
        commonToast("list${list!.length}");
        setUserList(ApiResponse.complete(list));

    }).onError((error,stackTrace){
      commonToast("Something went wrong$error.toString()");
      setUserList(ApiResponse.error(error.toString()));
      print(error);
    });
  }


 List<RssFeedData>? _parseRssFeed(XmlDocument document) {
    try {
      final items = document.findAllElements('item');

      return items.map((item) {
        final title = item.getElement('title')?.text?.trim() ?? "No Title";
        final link = item.getElement('link')?.text?.trim() ?? "";
        final description = item.getElement('description')?.text?.trim() ?? "No Description";
        final pubDate = item.getElement('pubDate')?.text?.trim() ?? "Unknown Date";

        // Extract image URL from description if available
        String? imgUrl;
        if (description.contains('img src')) {
          try {
            final regex = RegExp(r'img src=\"(.*?)\"');
            imgUrl = regex.firstMatch(description)?.group(1)?.trim();
          } catch (e) {
            print("Image extraction failed: $e");
          }
        }

        return RssFeedData(
          title: title.isNotEmpty ? title : "No Title",
          link: link.isNotEmpty ? link : null,
          description: description,
          pubDate: pubDate,
          imgUrl: imgUrl ?? null,
        );
      }).where((rssItem) => rssItem.title != null && rssItem.link != null).toList();
    } catch (e) {
      print("Error parsing XML: $e");
      return [];
    }
  }
}