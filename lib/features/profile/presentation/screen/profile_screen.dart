import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/app_text_field.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/custom_cached_network_image.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/auth/data/models/auth_response/user.dart';
import 'package:bookia/features/profile/presentation/cubit/delete_account_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/delete_account_state.dart';
import 'package:bookia/features/profile/presentation/widgets/profile_settings_item.dart';
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
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _loadUserData() {
    setState(() {
      userInfo = SharedPref.getUsrInfo();
    });
  }

  void _showDeleteConfirmDialog(BuildContext ctx) {
    _passwordController.clear();
    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.latteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Delete Account",
          style: TextStyles.font16.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.redColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "This action is permanent and cannot be undone. All your data, orders, and saved preferences will be deleted.",
              style: TextStyles.font14.copyWith(
                color: AppColors.darkGrayColor,
                height: 1.5,
              ),
            ),
            const Gap(16),
            Text(
              "Enter your current password to confirm:",
              style: TextStyles.font14.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkColor,
              ),
            ),
            const Gap(8),
            AppTextField(
              controller: _passwordController,
              hintText: "Current Password",
              isPass: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            const Gap(16),
            SizedBox(
              width: MediaQuery.of(dialogCtx).size.width * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainButton(
                    text: "Delete Account",
                    width: MediaQuery.of(dialogCtx).size.width * 0.3,
                    color: AppColors.redColor,
                    onPressed: () {
                      final password = _passwordController.text.trim();
                      if (password.isEmpty) {
                        showMsgDialog(dialogCtx, "Please enter your password.");
                        return;
                      }
                      Navigator.of(dialogCtx).pop();
                      ctx.read<DeleteAccountCubit>().deleteAccount(
                        currentPassword: password,
                      );
                    },
                  ),
                  const Gap(10),
                  MainButton(
                    text: "Cancel",
                    width: MediaQuery.of(dialogCtx).size.width * 0.25,
                    color: AppColors.primaryColor,
                    textColor: AppColors.whiteColor,
                    borderColor: AppColors.semiWhiteBorderColor,
                    onPressed: () => Navigator.of(dialogCtx).pop(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () async {
              await SharedPref.saveToken(null);
              if (context.mounted) {
                pushAndRemoveUntilPage(context, Routes.welcome);
              }
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
                title: "My Orders",
                onTap: () => pushPage(context, Routes.myOrders),
              ),
              const Gap(10),
              ProfileSettingsItem(
                title: "Edit Profile",
                onTap: () async {
                  await pushPage(context, Routes.editProfile);
                  _loadUserData();
                },
              ),
              const Gap(10),
              ProfileSettingsItem(
                title: "Update Password",
                onTap: () => pushPage(context, Routes.updatePassword),
              ),
              const Gap(10),
              ProfileSettingsItem(
                title: "FAQ",
                onTap: () => pushPage(context, Routes.fAq),
              ),
              const Gap(10),
              ProfileSettingsItem(
                title: "Contact Us",
                onTap: () => pushPage(context, Routes.contactUs),
              ),
              const Gap(10),
              ProfileSettingsItem(
                title: "Privacy & Terms",
                onTap: () => pushPage(context, Routes.privacyAndTerms),
              ),

              const Gap(32),

              // ── Delete Account — scoped BlocProvider ──────────────────
              BlocProvider(
                create: (_) => DeleteAccountCubit(),
                child: _DeleteAccountButton(
                  onTap: (ctx) => _showDeleteConfirmDialog(ctx),
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

class _DeleteAccountButton extends StatelessWidget {
  final void Function(BuildContext ctx) onTap;

  const _DeleteAccountButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteAccountCubit, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountLoadingState) {
          showLoadingDialog(context);
        } else if (state is DeleteAccountErrorState) {
          popPage(context); // close loading dialog
          showMsgDialog(context, state.errorMsg);
        } else if (state is DeleteAccountSuccessState) {
          popPage(context); // close loading dialog
          SharedPref.prefs.clear();
          pushAndRemoveUntilPage(context, Routes.welcome);
        }
      },
      child: GestureDetector(
        onTap: () => onTap(context),
        child: Container(
          width: 120,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.redColor.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.redColor.withValues(alpha: 0.3),
            ),
          ),
          child: Center(
            child: Text(
              "Delete Account",
              style: TextStyles.font14.copyWith(
                color: AppColors.redColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
