import 'package:bookia/features/home/data/models/all_products_response/product.dart';

sealed class SearchState {}

class SearchInitState extends SearchState{}

class SearchLoadingState extends SearchState{}


class SearchSuccessState extends SearchState {
  final String? msg;
  final List<Product> products; 
  SearchSuccessState(this.msg, this.products);
}


class SearchErrorState extends SearchState{
final String? error;
SearchErrorState(this.error);

}
