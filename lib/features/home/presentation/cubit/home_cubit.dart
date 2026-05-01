import 'package:bookia/features/home/data/models/all_products_response/product.dart';
import 'package:bookia/features/home/data/models/best_seller_response/best_seller_response.dart';
import 'package:bookia/features/home/data/models/silder_response/silder_response.dart';
import 'package:bookia/features/home/data/models/silder_response/slider.dart';
import 'package:bookia/features/home/data/repository/home_repo.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitState());

  List<Slider> sliders = [];
  List<Product> bestSellerProducts = [];

  Future<void> getInitData() async {
    emit(HomeLoadingState());
    try {
      var results = await Future.wait([
        HomeRepo.getSlider(),
        HomeRepo.getBestSeller(),
      ]);

      var slidersRes = results[0] as SilderResponse?;
      var bestSellersRes = results[1] as BestSellerResponse?;

      if (slidersRes != null || bestSellersRes != null) {
        sliders = slidersRes?.data?.sliders ?? [];
        bestSellerProducts = bestSellersRes?.data?.products ?? [];

        emit(HomeSuccessState());
      }
    } catch (error) {
      emit(HomeErrorState(error.toString()));
    }
  }
}
