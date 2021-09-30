import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'image_picker_web.dart';

class ImagePickerPage extends StatelessWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImagePickerModel>(
        create: (context) => ImagePickerModel(),
        builder: (context, child) {
          return Consumer<ImagePickerModel>(builder: (context, model, child) {
            return Scaffold(
              body: Container(
                color: Colors.black12,
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("テスト！!"),
                    model.imageURL == null
                        ? SizedBox()
                        : Container(
                            width: 100,
                            height: 100,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(model.imageURL.toString())),
                            ),
                          ),
                    ElevatedButton(
                      onPressed: () {model.imagePicker();},
                      child: const Text(
                        "画像を選択する",
                        style: TextStyle(color: Colors.yellow),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                    ),
                    ElevatedButton(
                      onPressed: () {model.downloadURL();},
                      child: const Text(
                        "新たな画像の取得",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
