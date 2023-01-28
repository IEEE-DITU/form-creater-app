import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:ieee_forms/widgets/custom_scaffold.dart';
import 'package:ieee_forms/widgets/snack_bar.dart';
import 'package:path_provider/path_provider.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen({Key? key, required this.imageUrl, this.responseIndex}) : super(key: key);
  final String imageUrl;
  final String? responseIndex;
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: (responseIndex != null) ? Text(responseIndex!) : const Text(''),
        actions: [
          IconButton(onPressed: () async {
            Directory tempDir = await getTemporaryDirectory();
            String tempPath = tempDir.path;
            final ts = DateTime.now().millisecondsSinceEpoch.toString();
            String path = '$tempPath/$ts.png';

            RenderRepaintBoundary boundary = _globalKey.currentContext
                ?.findRenderObject() as RenderRepaintBoundary;
            var image = await boundary.toImage();

            final picData = await image.toByteData(
                format: ui.ImageByteFormat.png);
            await writeToFile(picData!, path);

            final success = await GallerySaver.saveImage(path);

            //ignore:use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
                defaultSnackBar((success!)
                    ? 'File saved successfully'
                    : 'Error!! Please try again later'));
          }, icon: const Icon(
              Icons.download
          ))
        ],
      ),
        child: RepaintBoundary(
          key: _globalKey,
          child: Center(
            child: Image.network(
              imageUrl,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null && loadingProgress.cumulativeBytesLoaded > (loadingProgress.expectedTotalBytes! / 2)
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
        ));
  }
}

Future<void> writeToFile(ByteData data, String path) async {
  final buffer = data.buffer;
  await File(path)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}