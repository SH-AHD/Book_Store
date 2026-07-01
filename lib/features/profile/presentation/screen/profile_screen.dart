import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/custom_cached_network_image.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/auth/data/models/auth_response/user.dart';
import 'package:bookia/features/profile/presentation/cubit/delete_account_cubit.dart';
import 'package:bookia/features/profile/presentation/widgets/delete_account_button.dart';
import 'package:bookia/features/profile/presentation/widgets/profile_settings_item.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? userInfo;
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void _loadUserData() {
    setState(() {
      userInfo = SharedPref.getUsrInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.profile.tr()),
        actions: [
          IconButton(
            onPressed: () {
              showLogoutConfirmDialog(context, () async {
                await SharedPref.saveToken(null);
                if (context.mounted) {
                  pushAndRemoveUntilPage(context, Routes.welcome);
                }
              });
            },
            icon: SvgPic(path: AppAssets.logOutSvg),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BodyView(
          child: Column(
            children: [
              Row(
                children: [
                  CustomCachedNetworkImage(
                    url: userInfo?.image ?? "",
                    imgprof: true,
                    width: 80,
                    height: 80,
                  ),
                  const Gap(13),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userInfo?.name ?? "", style: TextStyles.font20),
                      Text(
                        userInfo?.email ?? "",
                        style: TextStyles.font14.copyWith(
                          color: AppColors.grayColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Gap(25),

              ProfileSettingsItem(
                title: LocaleKeys.my_orders_nav.tr(),
                onTap: () => pushPage(context, Routes.myOrders),
              ),
              const Gap(10),
              ProfileSettingsItem(
                title: LocaleKeys.edit_profile.tr(),
                onTap: () async {
                  await pushPage(context, Routes.editProfile);
                  _loadUserData();
                },
              ),
              const Gap(10),
              ProfileSettingsItem(
                title: LocaleKeys.update_password.tr(),
                onTap: () => pushPage(context, Routes.updatePassword),
              ),
              const Gap(10),
              ProfileSettingsItem(
                title: LocaleKeys.faq.tr(),
                onTap: () => pushPage(context, Routes.fAq),
              ),
              const Gap(10),
              ProfileSettingsItem(
                title: LocaleKeys.contact_us.tr(),
                onTap: () => pushPage(context, Routes.contactUs),
              ),
              const Gap(10),
              ProfileSettingsItem(
                title: LocaleKeys.privacy_and_terms.tr(),
                onTap: () => pushPage(context, Routes.privacyAndTerms),
              ),

              const Gap(32),
              BlocProvider(
                create: (_) => DeleteAccountCubit(),
                child: DeleteAccountButton(
                  onTap: (ctx) =>
                      showDeleteConfirmDialog(ctx, passwordController),
                ),
              ),

              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
