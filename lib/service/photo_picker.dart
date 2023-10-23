import 'package:image_picker/image_picker.dart';
import 'package:todo/service/log_service.dart';

class PhotoPicker {
  static final _picker = ImagePicker();

  static Future<XFile?> pickImage() async {
    // String? filePath;
    final file = await _picker.pickImage(source: ImageSource.gallery);
    // if (file != null) {
    //   final dir = await getApplicationDocumentsDirectory();
    //   final mime = lookupMimeType(file.path)?.split('/').last;
    //   final tmpPath = '${dir.path}/${getFileName()}.$mime';
    //   filePath = tmpPath;
    // }
    LogService.logLn(file?.path ?? 'null');
    return file;
  }

  static Future<List<XFile>> pickMultiImage() async {
    final files = await _picker.pickMultiImage();
    return files;
  }
}

String getFileName() {
  final now = DateTime.now();
  return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}-${now.second.toString().padLeft(2, '0')}-${now.millisecond.toString().padLeft(3, '0')}-${now.microsecond.toString().padLeft(3, '0')}';
}
