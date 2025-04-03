import 'package:dio/dio.dart';
import 'package:go_habit/feature/home/domain/models/quote_model.dart';
import 'package:go_habit/feature/home/domain/repositories/quote_repository.dart';

class QuoteRepositoryImplementation implements QuoteRepository {
  final Dio _dio;

  QuoteRepositoryImplementation(this._dio);

  @override
  Future<QuoteModel> getQuote() async {
    final response = await _dio.get('https://zenquotes.io?api=random');
    return QuoteModel.fromJson((response.data as List).first as Map<String, dynamic>);
  }
}
