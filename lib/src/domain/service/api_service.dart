import 'package:ar_drawing/src/data/model/data.dart';

import '../../utils/app_log.dart';
import '../models/image_item.dart';

class ApiService {
  ApiService._();

  static Future<List<ImageItem>> getAllImage() async {


    List<ImageItem> answer = [];

    for (var item in allData) {
      answer.add(ImageItem.fromJson(item));
    }

    AppLog.debug("Length wallpaper: ${answer.length}", tag: "Api service");

    return answer;
  }
}
