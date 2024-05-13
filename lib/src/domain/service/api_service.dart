import '../../utils/app_log.dart';
import '../models/base_response.dart';
import '../models/image_item.dart';
import '../provider/api_client.dart';
import '../provider/api_constant.dart';

class ApiService {
  ApiService._();

  static Future<List<ImageItem>> getAllImage() async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.wallpaper,
      method: ApiClient.get,
    );

    AppLog.debug("response data: ${response.data}", tag: "Api service");
    AppLog.debug("response message: ${response.message}", tag: "Api service");

    if (response.result == true) {
      List<ImageItem> answer = [];

      for (var item in response.data as List<dynamic>) {
        answer.add(ImageItem.fromJson(item));
      }

      AppLog.debug("Length wallpaper: ${answer.length}", tag: "Api service");

      return answer;
    } else {
      return List.empty();
    }
  }
}
