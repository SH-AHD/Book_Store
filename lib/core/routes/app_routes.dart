import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/forget_password/pages/forget_password_screen.dart';
import 'package:bookia/features/auth/presentation/forget_password/pages/otp_screen.dart';
import 'package:bookia/features/auth/presentation/forget_password/pages/password_changed_screen.dart';
import 'package:bookia/features/auth/presentation/forget_password/pages/reset_password_screen.dart';
import 'package:bookia/features/auth/presentation/login_register/pages/login_screen.dart';
import 'package:bookia/features/auth/presentation/login_register/pages/register_screen.dart';
import 'package:bookia/features/contact_us/contact_us.dart';
import 'package:bookia/features/details/presentation/pages/details_screen.dart';
import 'package:bookia/features/faq/faq_screen.dart';
import 'package:bookia/features/home/data/models/all_products_response/product.dart';
import 'package:bookia/features/home/presentation/pages/home_screen.dart';
import 'package:bookia/features/main/main_app_screen.dart';
import 'package:bookia/features/orders_history/presentation/cubit/orders_cubit.dart';
import 'package:bookia/features/orders_history/presentation/pages/my_orders_screen.dart';
import 'package:bookia/features/orders_history/presentation/pages/order_details_screen.dart';
import 'package:bookia/features/place_order/presentation/cubit/place_order_cubit.dart';
import 'package:bookia/features/place_order/presentation/pages/order_success_screen.dart';
import 'package:bookia/features/place_order/presentation/pages/placeorder_screen.dart';
import 'package:bookia/features/privacy_and_terms/privacy_and_terms_screen.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/screen/edit_profile_screen.dart';
import 'package:bookia/features/profile/presentation/screen/update_password_screen.dart';
import 'package:bookia/features/search/data/repository/search_repo.dart';
import 'package:bookia/features/search/presentation/cubit/search_cubit.dart';
import 'package:bookia/features/search/presentation/pages/search_screen.dart';
import 'package:bookia/features/splash/splash_screen.dart';
import 'package:bookia/features/welcome/welocme_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  // routes config
  static final routes = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: Routes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: RegisterScreen(),
        ),
      ),

      GoRoute(
        path: Routes.forgetPass,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: ForgetPasswordScreen(),
        ),
      ),
      GoRoute(
        path: Routes.otp,
        builder: (context, state) {
          final String receivedEmail = state.extra as String;
          return BlocProvider(
            create: (context) => AuthCubit()..updateEmail(receivedEmail),
            child: OtpScreen(),
          );
        },
      ),

      GoRoute(
        path: Routes.resetPass,
        builder: (context, state) {
          final String receivedcode = state.extra as String;
          return BlocProvider(
            create: (context) => AuthCubit()..sendCode(receivedcode),
            child: ResetPasswordScreen(),
          );
        },
      ),

      GoRoute(
        path: Routes.passwordChanged,
        builder: (context, state) => const PasswordChangedScreen(),
      ),

      GoRoute(path: Routes.home, builder: (context, state) => HomeScreen()),

      GoRoute(
        path: Routes.main,
        builder: (context, state) {
          return MainAppScreen(currentIndex: state.extra as int?);
        },
      ),

      GoRoute(
        path: Routes.details,
        builder: (context, state) =>
            DetailsScreen(book: state.extra as Product),
      ),

      GoRoute(
        path: Routes.search,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => SearchCubit(SearchRepo()),
            child: SearchScreen(),
          );
        },
      ),

      GoRoute(
        path: Routes.placeOrder,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => PlaceOrderCubit(),
            child: PlaceOrderScreen(total: state.extra as String),
          );
        },
      ),
      GoRoute(
        path: Routes.orderSuccess,
        builder: (context, state) => const OrderSuccessScreen(),
      ),

      GoRoute(
        path: Routes.myOrders,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => OrdersCubit()..showOrdersHistory(),
            child: MyOrdersScreen(),
          );
        },
      ),
      GoRoute(
        path: Routes.orderDetails,
        builder: (context, state) {
          final orderId = state.extra as int;

          return BlocProvider(
            create: (context) => OrdersCubit()..showSingleOrderHistory(orderId),
            child: const OrderDetailsScreen(),
          );
        },
      ),
      GoRoute(
        path: Routes.editProfile,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ProfileCubit(),
            child: EditProfileScreen(),
          );
        },
      ),
      GoRoute(
        path: Routes.updatePassword,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ProfileCubit(),
            child: UpdatePasswordScreen(),
          );
        },
      ),
      GoRoute(path: Routes.fAq, builder: (context, state) => const FAQScreen()),
      GoRoute(
        path: Routes.contactUs,
        builder: (context, state) => const ContactUsScreen(),
      ),
      GoRoute(
        path: Routes.privacyAndTerms,
        builder: (context, state) => const PrivacyAndTermsScreen(),
      ),
    ],
  );
}
