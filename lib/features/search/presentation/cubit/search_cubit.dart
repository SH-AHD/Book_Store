import 'dart:async';

import 'package:bookia/features/home/data/models/all_products_response/product.dart';
import 'package:bookia/features/search/data/repository/search_repo.dart';
import 'package:bookia/features/search/presentation/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;

  SearchCubit(this.searchRepo) : super(SearchInitState());

  final searchController = TextEditingController();

  List<Product> products = [];

  Timer? _debounce;



  Future<void> search() async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      if (searchController.text.trim().isEmpty) {
        products = [];
        emit(SearchInitState());
        return;
      }

      emit(SearchLoadingState());

      try {
        var results = await searchRepo.search(name: searchController.text);
        if (results != null) {
          final List<Product> fetchedProducts = (results.data?.products as List?)?.cast<Product>() ?? [];
          products = fetchedProducts;
          emit(SearchSuccessState(results.message, products));
        } else {
          emit(SearchErrorState("No data found"));
        }
      } catch (e) {
        emit(SearchErrorState(e.toString()));
      }
    });
  }


void clearSearch() {
  searchController.clear();
  products = []; 
  emit(SearchInitState());
}

    @override
  Future<void> close() {
    _debounce?.cancel();
    searchController.dispose();
    return super.close();
  }


}
