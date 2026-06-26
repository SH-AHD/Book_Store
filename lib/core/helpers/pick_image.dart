import 'package:image_picker/image_picker.dart';

String? selectedImagePath;
final ImagePicker picker = ImagePicker();

Future<String?> pickProfileImage() async {
  final XFile? pickedFile = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 70,
  );
  if (pickedFile != null) {
    return pickedFile.path;
  }
  return null;
}
