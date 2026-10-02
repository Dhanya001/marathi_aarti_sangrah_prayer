import 'package:flutter_test/flutter_test.dart';
import 'package:infocontract/core/api/constants/api_constants.dart';
import 'package:infocontract/features/home/domain/model/aarti_model.dart';
import 'package:infocontract/features/home/domain/model/category_model.dart';

void main() {
  group('ApiConstants Tests', () {
    test('endpoints are correctly configured', () {
      expect(ApiConstants.categories, equals('/categories'));
      expect(ApiConstants.categoryById(5), equals('/categories/5'));
      expect(ApiConstants.aartis, equals('/aartis'));
      expect(ApiConstants.aartiById(12), equals('/aartis/12'));
    });

    test('resolveMediaUrl resolves paths correctly', () {
      expect(ApiConstants.resolveMediaUrl(''), equals(''));
      expect(
        ApiConstants.resolveMediaUrl('http://example.com/audio.mp3'),
        equals('http://example.com/audio.mp3'),
      );
    });
  });

  group('CategoryModel Tests', () {
    test('parses from JSON correctly', () {
      final json = {
        'id': 1,
        'name': 'Ganpati',
        'imageUrl': 'http://localhost:3000/images/ganpati.png',
        'isActive': true,
        'sortOrder': 1,
      };

      final category = CategoryModel.fromJson(json);
      expect(category.id, equals('1'));
      expect(category.name, equals('Ganpati'));
      expect(category.imageUrl, equals('http://localhost:3000/images/ganpati.png'));
      expect(category.isActive, isTrue);
      expect(category.sortOrder, equals(1));
    });
  });

  group('AartiModel Tests', () {
    test('parses backend JSON correctly', () {
      final json = {
        'id': 101,
        'title': 'Sukh Karta Dukh Harta',
        'subtitle': 'Ganpati Aarti',
        'lyrics': 'Sukh karta dukh harta varta vighnachi...',
        'categoryId': 1,
        'imageUrl': 'http://localhost:3000/images/ganpati.png',
        'audioUrl': 'http://localhost:3000/audio/ganpati.mp3',
        'duration': '3:30',
        'isPopular': true,
        'isFeatured': false,
        'isActive': true,
      };

      final aarti = AartiModel.fromJson(json);
      expect(aarti.id, equals('101'));
      expect(aarti.title, equals('Sukh Karta Dukh Harta'));
      expect(aarti.titleKey, equals('Sukh Karta Dukh Harta'));
      expect(aarti.categoryId, equals(1));
      expect(aarti.isPopular, isTrue);
      expect(aarti.audioUrl, equals('http://localhost:3000/audio/ganpati.mp3'));
    });
  });
}
