import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  // Opens the device gallery and allows the user to select multiple images.
  Future<List<XFile>> pickMultipleImages() async {
    return await _imagePicker.pickMultiImage();
  }
}