import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/app_back_btn.dart';
import 'package:bookia/core/widgets/app_text_field.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      setState(() => _submitted = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading:Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppBackBtn(),
            ),
        centerTitle: true,
        title: Text(LocaleKeys.contact_us_title.tr()),
      ),
      body: _submitted ? _buildSuccessView() : _buildFormView(),
    );
  }

  Widget _buildSuccessView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline_rounded,
                size: 48,
                color: AppColors.primaryColor,
              ),
            ),
            const Gap(24),
            Text(
              LocaleKeys.message_sent.tr(),
              style: TextStyles.font16.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.darkColor,
                fontSize: 20,
              ),
            ),
            const Gap(10),
            Text(
              LocaleKeys.message_sent_subtitle.tr(),
              style: TextStyles.font14.copyWith(
                color: AppColors.grayColor,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(32),
            MainButton(
              text: LocaleKeys.send_another_message.tr(),
              onPressed: () {
                _nameController.clear();
                _emailController.clear();
                _subjectController.clear();
                _messageController.clear();
                setState(() => _submitted = false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.latteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.support_agent_rounded,
                      color: AppColors.primaryColor,
                      size: 28,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.hear_from_you.tr(),
                          style: TextStyles.font14.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkColor,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          LocaleKeys.fill_form_below.tr(),
                          style: TextStyles.font14.copyWith(
                            color: AppColors.darkGrayColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),

            // Contact info row
            Row(
              children: [
                _ContactInfoChip(
                  icon: Icons.email_outlined,
                  label: "support@bookia.com",
                ),
                const Gap(8),
                _ContactInfoChip(
                  icon: Icons.phone_outlined,
                  label: "+20 100 123 4567",
                ),
              ],
            ),
            const Gap(24),

            _buildLabel(LocaleKeys.full_name_label.tr()),
            const Gap(8),
            AppTextField(
              controller: _nameController,
              hintText: LocaleKeys.name_hint.tr(),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? LocaleKeys.validate_name_required.tr() : null,
            ),
            const Gap(14),

            _buildLabel(LocaleKeys.email_address_label.tr()),
            const Gap(8),
            AppTextField(
              controller: _emailController,
              hintText: LocaleKeys.email_hint.tr(),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return LocaleKeys.validate_email_empty.tr();
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                  return LocaleKeys.validate_email_invalid.tr();
                }
                return null;
              },
            ),
            const Gap(14),

            _buildLabel(LocaleKeys.subject_label.tr()),
            const Gap(8),
            AppTextField(
              controller: _subjectController,
              hintText: LocaleKeys.subject_hint.tr(),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? LocaleKeys.validate_subject_required.tr()
                  : null,
            ),
            const Gap(14),

            _buildLabel(LocaleKeys.message_label.tr()),
            const Gap(8),
            TextFormField(
              controller: _messageController,
              minLines: 5,
              maxLines: 8,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return LocaleKeys.validate_message_required.tr();
                if (v.trim().length < 20) {
                  return LocaleKeys.validate_message_short.tr();
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: LocaleKeys.message_hint.tr(),
                filled: true,
                fillColor: AppColors.whiteColor,
                alignLabelWithHint: true,
              ),
            ),
            const Gap(28),

            MainButton(text: LocaleKeys.send_message_btn.tr(), onPressed: _submit),
            const Gap(16),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: TextStyles.font14.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.darkColor,
      ),
    );
  }
}

class _ContactInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ContactInfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.semiWhiteBorderColor),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: AppColors.primaryColor),
            const Gap(6),
            Expanded(
              child: Text(
                label,
                style: TextStyles.font14.copyWith(
                  fontSize: 11,
                  color: AppColors.darkGrayColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
