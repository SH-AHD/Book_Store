import 'dart:io';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/app_validator.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/helpers/pick_image.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/widgets/app_text_field.dart';
import 'package:bookia/core/widgets/body_view.dart';
import 'package:bookia/core/widgets/custom_cached_network_image.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/auth/data/models/auth_response/user.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final User? userInfo = SharedPref.getUsrInfo();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingState) {
          showLoadingDialog(context);
        } else if (state is ProfileErrorState) {
          popPage(context);
          showMsgDialog(context, state.errorMsg);
        } else if (state is ProfileSuccessState) {
          popPage(context);
          showMsgDialog(context, state.msg, DialogType.success);
          popPage(context);
        }
      },
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();
        Widget imageWidget;
        if (cubit.imagePath != null &&
            cubit.imagePath!.isNotEmpty &&
            File(cubit.imagePath!).existsSync()) {
          imageWidget = CircleAvatar(
            radius: 62.5,
            backgroundImage: FileImage(File(cubit.imagePath!)),
          );
        } else if (userInfo!.image != null) {
          imageWidget = CustomCachedNetworkImage(
            url: userInfo!.image ?? "",
            imgprof: true,
            width: 125,
            height: 125,
          );
        } else {
          imageWidget = CircleAvatar(
            radius: 62.5,
            backgroundColor: AppColors.latteColor,
            child: SvgPic(
              path: AppAssets.profileSvg,
              color: AppColors.primaryColor,
              w: 125,
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () {
                popPage(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPic(path: AppAssets.backSvg),
              ),
            ),
            centerTitle: true,
            title: const Text('Edit Profile'),
          ),
          body: BodyView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  child: Stack(
                    children: [
                      imageWidget,
                      Positioned(
                        bottom: 0,
                        right: 3,
                        child: GestureDetector(
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.whiteColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPic(path: AppAssets.cameraSvg),
                            ),
                          ),
                          onTap: () async {
                            final path = await pickProfileImage();
                            if (path != null) {
                              cubit.updatePickedImage(path);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                _formBuilder(context),
                Spacer(),
                MainButton(
                  text: "Update Profile",
                  onPressed: () {
                    cubit.updateUserData(
                      name: cubit.fullNameController.text,
                      address: cubit.addressController.text,
                      city: cubit.cityController.text,
                      phone: cubit.phoneController.text,
                      imagePath: cubit.imagePath,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _formBuilder(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();

        return BodyView(
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  controller: cubit.fullNameController,
                  hintText: "Full Name",
                  validator: AppValidators.validateUsername,
                ),
                Gap(12),
                AppTextField(
                  controller: cubit.phoneController,
                  hintText: "Phone Number",
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  validator: AppValidators.validatePhoneNumber,
                ),
                Gap(12),
                AppTextField(
                  controller: cubit.cityController,
                  hintText: "City",
                  keyboardType: TextInputType.streetAddress,
                  validator: AppValidators.validateString,
                ),
                Gap(12),
                AppTextField(
                  controller: cubit.addressController,
                  hintText: "Address",
                  keyboardType: TextInputType.streetAddress,
                  validator: AppValidators.validateString,
                ),
                Gap(12),
              ],
            ),
          ),
        );
      },
    );
  }
}
