import 'package:go_habit/feature/home/domain/models/quote_model.dart';

abstract interface class QuoteRepository {
  Future<QuoteModel> getQuote();
}
