import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

abstract class ImageHelper {
  static Future<img.Image> resizeAndCircularizeImage(
    String url, {
    int size = 120,
    int borderSize = 20,
  }) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw const ServerException('Image url not valid');
    }
    final decodedImage = img.decodeImage(response.bodyBytes);

    if (decodedImage == null) {
      throw img.ImageException('Cannot decode image');
    }

    final resizedImage = img.copyResizeCropSquare(
      decodedImage,
      size: size,
    );

    final circleImage = img.copyCrop(
      resizedImage,
      x: 0,
      y: 0,
      width: size,
      height: size,
      radius: size * 1.1 / 2,
      antialias: false,
    );

    final rgbaImage = circleImage.convert(numChannels: 4);

    for (final pixel in rgbaImage) {
      if (pixel.r == 0 && pixel.g == 0 && pixel.b == 0) {
        pixel.set(img.ColorRgba8(255, 255, 255, 0));
      }
    }
    final circleWhiteImageData = await getBytesFromAsset(
      'assets/map/png/circles/Circle-white.png',
      size + borderSize,
    );

    final whiteCirle = img.decodeImage(circleWhiteImageData);
    if (whiteCirle != null) {
      img.compositeImage(whiteCirle, rgbaImage, center: true);

      return whiteCirle;
    }

    return rgbaImage;
  }

  static Future<img.Image> addBlueCirlce(img.Image overPict) async {
    final circleColorImageData = await getBytesFromAsset(
      'assets/map/png/circles/circle-blue.png',
      220,
    );
    final colorCirle = img.decodeImage(circleColorImageData);
    if (colorCirle.isNotNull) {
      img.compositeImage(colorCirle!, overPict, center: true);

      return colorCirle;
    }

    return overPict;
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    final data = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    final fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static Future<Uint8List> getBytesFromAssetBasic(String path) async {
    final data = await rootBundle.load(path);

    return data.buffer.asUint8List();
  }

  static Future<Uint8List> getBytesFromAssetCached(
    Uint8List data,
    int width,
  ) async {
    final codec = await ui.instantiateImageCodec(data, targetWidth: width);
    final fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
