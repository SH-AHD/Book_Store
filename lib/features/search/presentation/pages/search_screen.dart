import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/app_text_field.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/book_card.dart';
import 'package:bookia/core/widgets/custom_error_views.dart';
import 'package:bookia/core/widgets/shimmer/shimmer_grid_view.dart';
import 'package:bookia/features/search/presentation/cubit/search_cubit.dart';
import 'package:bookia/features/search/presentation/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SearchCubit>();

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Search For books')),
      body: BodyView(
        child: Column(
          children: [
            AppTextField(
              controller: cubit.searchController,
              hintText: "Search Products",
              onChanged: (value) {
                  cubit.search(); 
                },
                isSearch: true,
            ),
            Gap(30),
        
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  var books = cubit.products;
                  if (state is SearchLoadingState) {
                    return SingleChildScrollView(
                      child: ShimmerGridView(
                         itemCount: 6,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemHeight: MediaQuery.of(context).size.height * 0.2,
                  crossAxisCount: 2,
                  childAspectRatio: .62,
                      ),
                    );
                  } else if (state is SearchSuccessState || (state is SearchInitState && cubit.products.isNotEmpty)) {
                    if (books.isEmpty) {
                        return  Center(
                          child: Text("No books found! Try to search again..", style: TextStyles.font15.copyWith(color: AppColors.grayColor),),
                        );
                      }

                    return SingleChildScrollView(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: books.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.55,
                        ),
                        itemBuilder: (context, index) =>
                            BookCard(book: books[index]),
                      ),
                    );
                  } else if (state is SearchErrorState) {
                    return errorMsgView(); 
                  }
                  
                  return Center(
                    child: 
                        Text("Start searching for your favorite books!",
                        style: TextStyles.font15.copyWith(color: AppColors.grayColor),
                        textAlign: TextAlign.center,),
                  );
              
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
