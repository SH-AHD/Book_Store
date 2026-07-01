import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/app_back_btn.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PrivacyAndTermsScreen extends StatelessWidget {
  const PrivacyAndTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(LocaleKeys.legal_title.tr()),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppBackBtn(),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: LocaleKeys.privacy_policy_tab.tr()),
              Tab(text: LocaleKeys.terms_of_use_tab.tr()),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_PrivacyPolicyTab(), _TermsOfUseTab()],
        ),
      ),
    );
  }
}

// ─── Privacy Policy ───────────────────────────────────────────────────────────

class _PrivacyPolicyTab extends StatelessWidget {
  const _PrivacyPolicyTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _LastUpdatedBadge(date: "June 1, 2025"),
        const Gap(16),
        _SectionHeader(
          icon: Icons.info_outline_rounded,
          title: LocaleKeys.pp_sec1_title.tr(),
        ),
        _SectionBody(text: LocaleKeys.pp_sec1_body.tr()),
        const Gap(14),
        _SectionHeader(
          icon: Icons.data_usage_rounded,
          title: LocaleKeys.pp_sec2_title.tr(),
        ),
        _SectionBody(text: LocaleKeys.pp_sec2_body.tr()),
        const Gap(14),
        _SectionHeader(
          icon: Icons.settings_applications_outlined,
          title: LocaleKeys.pp_sec3_title.tr(),
        ),
        _BulletList(
          items: [
            LocaleKeys.pp_sec3_item1.tr(),
            LocaleKeys.pp_sec3_item2.tr(),
            LocaleKeys.pp_sec3_item3.tr(),
            LocaleKeys.pp_sec3_item4.tr(),
            LocaleKeys.pp_sec3_item5.tr(),
            LocaleKeys.pp_sec3_item6.tr(),
          ],
        ),
        const Gap(14),
        _SectionHeader(
          icon: Icons.share_outlined,
          title: LocaleKeys.pp_sec4_title.tr(),
        ),
        _SectionBody(text: LocaleKeys.pp_sec4_body.tr()),
        const Gap(14),
        _SectionHeader(
          icon: Icons.lock_outline_rounded,
          title: LocaleKeys.pp_sec5_title.tr(),
        ),
        _SectionBody(text: LocaleKeys.pp_sec5_body.tr()),
        const Gap(14),
        _SectionHeader(
          icon: Icons.person_outline_rounded,
          title: LocaleKeys.pp_sec6_title.tr(),
        ),
        _BulletList(
          items: [
            LocaleKeys.pp_sec6_item1.tr(),
            LocaleKeys.pp_sec6_item2.tr(),
            LocaleKeys.pp_sec6_item3.tr(),
            LocaleKeys.pp_sec6_item4.tr(),
          ],
        ),
        const Gap(14),
        _SectionHeader(
          icon: Icons.child_care_outlined,
          title: LocaleKeys.pp_sec7_title.tr(),
        ),
        _SectionBody(text: LocaleKeys.pp_sec7_body.tr()),
        const Gap(14),
        _SectionHeader(
          icon: Icons.update_rounded,
          title: LocaleKeys.pp_sec8_title.tr(),
        ),
        _SectionBody(text: LocaleKeys.pp_sec8_body.tr()),
        const Gap(14),
        _SectionHeader(
          icon: Icons.mail_outline_rounded,
          title: LocaleKeys.pp_sec9_title.tr(),
        ),
        _SectionBody(text: LocaleKeys.pp_sec9_body.tr()),
        const Gap(24),
      ],
    );
  }
}

// ─── Terms of Use ─────────────────────────────────────────────────────────────

class _TermsOfUseTab extends StatelessWidget {
  const _TermsOfUseTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _LastUpdatedBadge(date: "June 1, 2025"),
        Gap(16),
        _SectionHeader(
          icon: Icons.gavel_rounded,
          title: LocaleKeys.tou_sec1_title.tr(),
        ),
        _SectionBody(text: LocaleKeys.tou_sec1_body.tr()),
        const Gap(14),
        _SectionHeader(
          icon: Icons.account_circle_outlined,
          title: LocaleKeys.tou_sec2_title.tr(),
        ),
        _SectionBody(text: LocaleKeys.tou_sec2_body.tr()),
        const Gap(14),
        _SectionHeader(
          icon: Icons.shopping_cart_outlined,
          title: LocaleKeys.tou_sec3_title.tr(),
        ),
        _BulletList(
          items: [
            LocaleKeys.tou_sec3_item1.tr(),
            LocaleKeys.tou_sec3_item2.tr(),
            LocaleKeys.tou_sec3_item3.tr(),
            LocaleKeys.tou_sec3_item4.tr(),
          ],
        ),
        const Gap(14),
        _SectionHeader(
          icon: Icons.local_shipping_outlined,
          title: LocaleKeys.tou_sec4_title.tr(),
        ),
        _SectionBody(text: LocaleKeys.tou_sec4_body.tr()),
        const Gap(14),
        _SectionHeader(
          icon: Icons.replay_outlined,
          title: LocaleKeys.tou_sec5_title.tr(),
        ),
        _SectionBody(text: LocaleKeys.tou_sec5_body.tr()),
        const Gap(14),
        _SectionHeader(
          icon: Icons.block_rounded,
          title: LocaleKeys.tou_sec6_title.tr(),
        ),
        _BulletList(
          items: [
            LocaleKeys.tou_sec6_item1.tr(),
            LocaleKeys.tou_sec6_item2.tr(),
            LocaleKeys.tou_sec6_item3.tr(),
            LocaleKeys.tou_sec6_item4.tr(),
            LocaleKeys.tou_sec6_item5.tr(),
          ],
        ),
        const Gap(14),
        _SectionHeader(
          icon: Icons.copyright_outlined,
          title: LocaleKeys.tou_sec7_title.tr(),
        ),
        _SectionBody(text: LocaleKeys.tou_sec7_body.tr()),
        const Gap(14),
        _SectionHeader(
          icon: Icons.warning_amber_outlined,
          title: LocaleKeys.tou_sec8_title.tr(),
        ),
        _SectionBody(text: LocaleKeys.tou_sec8_body.tr()),
        const Gap(14),
        _SectionHeader(
          icon: Icons.edit_document,
          title: LocaleKeys.tou_sec9_title.tr(),
        ),
        _SectionBody(text: LocaleKeys.tou_sec9_body.tr()),
        const Gap(24),
      ],
    );
  }
}

// ─── Shared reusable widgets ──────────────────────────────────────────────────

class _LastUpdatedBadge extends StatelessWidget {
  final String date;
  const _LastUpdatedBadge({required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.latteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.calendar_today_outlined,
            size: 14,
            color: AppColors.primaryColor,
          ),
          const Gap(6),
          Text(
            LocaleKeys.last_updated.tr(namedArgs: {'date': date}),
            style: TextStyles.font14.copyWith(
              color: AppColors.darkGrayColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primaryColor),
        const Gap(8),
        Expanded(
          child: Text(
            title,
            style: TextStyles.font16.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionBody extends StatelessWidget {
  final String text;
  const _SectionBody({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 4),
      child: Text(
        text,
        style: TextStyles.font14.copyWith(
          color: AppColors.darkGrayColor,
          height: 1.7,
        ),
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;
  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyles.font14.copyWith(
                          color: AppColors.darkGrayColor,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
