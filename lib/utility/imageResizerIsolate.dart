import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';

import 'package:image/image.dart';

class ImageResizerData {
  final SendPort sendPort;
  final File image;
  final int size;
  final int quality;

  ImageResizerData({
    @required this.sendPort,
    @required this.image,
    @required this.size,
    @required this.quality,
  });
}

void imageResizerIsolate(ImageResizerData data) {
  final imageDecode = decodeImage(data.image.readAsBytesSync());
  final imageResized = copyResizeCropSquare(imageDecode, data.size);
  final imageEncodeJpg = encodeJpg(imageResized, quality: data.quality);

  data.sendPort.send(imageEncodeJpg);
}
