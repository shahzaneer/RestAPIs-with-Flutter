import "dart:io";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import 'package:http/http.dart' as http;

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedImage =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedImage != null) {
      image = File(pickedImage.path);
      setState(() {});
    } else {
      print("No Image Selected");
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    var url = Uri.parse("https://fakestoreapi.com/products");

    var request = http.MultipartRequest("POST", url);
    request.fields["title"] = "static filed";

    var multiport = http.MultipartFile("image", stream, length);

    request.files.add(multiport);

    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print("Done");
    } else {
      print("failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Image"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: image == null
                ? GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: const Center(
                      child: Text("pick Image"),
                    ),
                  )
                : Center(
                    child: Image.file(
                      File(image!.path).absolute,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              uploadImage();
            },
            child: Center(
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12)),
                child: const Text("Upload"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
