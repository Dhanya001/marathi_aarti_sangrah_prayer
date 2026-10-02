import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as img;

/// Smart background remover optimized for signatures on paper
/// Removes white/light paper background while preserving dark signature ink
Future<Uint8List> removeBackground(File file, {
  int maxSize = 1200,
  int darkThreshold = 180, // Pixels darker than this are kept
}) async {
  final bytes = await file.readAsBytes();
  final originalImage = img.decodeImage(bytes);
  if (originalImage == null) throw Exception("Failed to decode image");


  // Resize if image is too large (for faster processing)
  img.Image workingImage = originalImage;
  double scale = 1.0;

  if (originalImage.width > maxSize || originalImage.height > maxSize) {
    final maxDim = math.max(originalImage.width, originalImage.height);
    scale = maxSize / maxDim;
    final newWidth = (originalImage.width * scale).round();
    final newHeight = (originalImage.height * scale).round();
    workingImage = img.copyResize(originalImage, width: newWidth, height: newHeight);
  }

  // Convert to RGBA format
  final processed = workingImage.convert(numChannels: 4);

  // Enhance contrast to make signature darker
  _enhanceContrast(processed);

  int pixelsRemoved = 0;

  // Process each pixel
  for (int y = 0; y < processed.height; y++) {
    for (int x = 0; x < processed.width; x++) {
      final pixel = processed.getPixel(x, y);
      final r = pixel.r.toInt();
      final g = pixel.g.toInt();
      final b = pixel.b.toInt();

      // Calculate brightness (average of RGB)
      final brightness = (r + g + b) / 3;

      // Remove light pixels (paper background)
      // Keep dark pixels (signature ink)
      if (brightness > darkThreshold) {
        // Light pixel - make it transparent
        processed.setPixel(x, y, img.ColorRgba8(255, 255, 255, 0));
        pixelsRemoved++;
      } else {
        // Dark pixel - keep it but make signature darker for better visibility
        final darkenFactor = 0.8; // Make signature 20% darker
        final newR = (r * darkenFactor).clamp(0, 255).toInt();
        final newG = (g * darkenFactor).clamp(0, 255).toInt();
        final newB = (b * darkenFactor).clamp(0, 255).toInt();

        // Calculate alpha based on how dark the pixel is
        // Darker pixels = more opaque
        final alpha = (255 - brightness).clamp(50, 255).toInt();

        processed.setPixel(x, y, img.ColorRgba8(newR, newG, newB, alpha));
      }
    }
  }

  debugPrint("Pixels removed: $pixelsRemoved");

  // Remove noise (small isolated dark pixels)
  _removeNoise(processed);

  // Resize back to original size if needed
  final result = (scale < 1.0)
      ? img.copyResize(processed, width: originalImage.width, height: originalImage.height)
      : processed;

  // Encode as PNG
  final pngBytes = Uint8List.fromList(img.encodePng(result));
  debugPrint("PNG encoded: ${pngBytes.length} bytes");
  return pngBytes;
}

/// Enhance contrast to make signatures stand out more
void _enhanceContrast(img.Image image) {
  final contrast = 1.5; // Increase contrast by 50%
  final factor = (259 * (contrast + 255)) / (255 * (259 - contrast));

  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      final pixel = image.getPixel(x, y);
      final r = pixel.r.toInt();
      final g = pixel.g.toInt();
      final b = pixel.b.toInt();

      final newR = (factor * (r - 128) + 128).clamp(0, 255).toInt();
      final newG = (factor * (g - 128) + 128).clamp(0, 255).toInt();
      final newB = (factor * (b - 128) + 128).clamp(0, 255).toInt();

      image.setPixel(x, y, img.ColorRgba8(newR, newG, newB, 255));
    }
  }
}

/// Remove noise - small isolated pixels
void _removeNoise(img.Image image) {
  const minNeighbors = 2; // Pixel needs at least 2 dark neighbors to be kept

  for (int y = 1; y < image.height - 1; y++) {
    for (int x = 1; x < image.width - 1; x++) {
      final pixel = image.getPixel(x, y);
      final alpha = pixel.a.toInt();

      // Skip if already transparent
      if (alpha == 0) continue;

      // Count dark neighbors
      int darkNeighbors = 0;

      for (int dy = -1; dy <= 1; dy++) {
        for (int dx = -1; dx <= 1; dx++) {
          if (dx == 0 && dy == 0) continue; // Skip center pixel

          final neighbor = image.getPixel(x + dx, y + dy);
          if (neighbor.a.toInt() > 50) {
            darkNeighbors++;
          }
        }
      }

      // If pixel has too few dark neighbors, it's probably noise
      if (darkNeighbors < minNeighbors) {
        image.setPixel(x, y, img.ColorRgba8(255, 255, 255, 0));
      }
    }
  }
}