import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
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
          title: const Text('Legal'),
          leading: GestureDetector(
            onTap: () => popPage(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const SvgPic(path: AppAssets.backSvg),
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Privacy Policy"),
              Tab(text: "Terms of Use"),
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
      children: const [
        _LastUpdatedBadge(date: "June 1, 2025"),
        Gap(16),
        _SectionHeader(
          icon: Icons.info_outline_rounded,
          title: "1. Introduction",
        ),
        _SectionBody(
          text:
              "Welcome to Bookia. We are committed to protecting your personal information and your right to privacy. This Privacy Policy explains how we collect, use, and safeguard your data when you use our application.",
        ),
        Gap(14),
        _SectionHeader(
          icon: Icons.data_usage_rounded,
          title: "2. Information We Collect",
        ),
        _SectionBody(
          text:
              "We collect information you provide directly to us, such as your name, email address, phone number, and shipping address when you register or place an order. We also automatically collect certain technical data such as device type, operating system version, and usage patterns to improve your experience.",
        ),
        Gap(14),
        _SectionHeader(
          icon: Icons.settings_applications_outlined,
          title: "3. How We Use Your Information",
        ),
        _BulletList(
          items: [
            "To process and fulfill your orders.",
            "To send order confirmations and shipping updates.",
            "To respond to your support inquiries.",
            "To personalize your browsing and recommendations.",
            "To improve our app's features and performance.",
            "To send promotional offers (only with your consent).",
          ],
        ),
        Gap(14),
        _SectionHeader(
          icon: Icons.share_outlined,
          title: "4. Sharing Your Information",
        ),
        _SectionBody(
          text:
              "We do not sell or rent your personal data. We may share information with trusted third-party service providers (e.g., payment processors, delivery partners) solely to fulfill your orders. All third parties are required to keep your data confidential and use it only for the agreed purpose.",
        ),
        Gap(14),
        _SectionHeader(
          icon: Icons.lock_outline_rounded,
          title: "5. Data Security",
        ),
        _SectionBody(
          text:
              "We implement industry-standard security measures including encryption, secure servers, and access controls to protect your information. However, no method of transmission over the internet is 100% secure, and we cannot guarantee absolute security.",
        ),
        Gap(14),
        _SectionHeader(
          icon: Icons.person_outline_rounded,
          title: "6. Your Rights",
        ),
        _BulletList(
          items: [
            "Access and review the data we hold about you.",
            "Request correction of inaccurate information.",
            "Request deletion of your account and personal data.",
            "Opt out of marketing communications at any time.",
          ],
        ),
        Gap(14),
        _SectionHeader(
          icon: Icons.child_care_outlined,
          title: "7. Children's Privacy",
        ),
        _SectionBody(
          text:
              "Our services are not directed to children under the age of 13. We do not knowingly collect personal information from children. If you believe we have inadvertently collected such data, please contact us immediately.",
        ),
        Gap(14),
        _SectionHeader(
          icon: Icons.update_rounded,
          title: "8. Changes to This Policy",
        ),
        _SectionBody(
          text:
              "We may update this Privacy Policy from time to time. We will notify you of significant changes via email or an in-app notification. Continued use of the app after changes constitutes your acceptance of the updated policy.",
        ),
        Gap(14),
        _SectionHeader(
          icon: Icons.mail_outline_rounded,
          title: "9. Contact Us",
        ),
        _SectionBody(
          text:
              "If you have any questions about this Privacy Policy, please contact us at privacy@bookia.com or visit the Contact Us section in the app.",
        ),
        Gap(24),
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
      children: const [
        _LastUpdatedBadge(date: "June 1, 2025"),
        Gap(16),
        _SectionHeader(
          icon: Icons.gavel_rounded,
          title: "1. Acceptance of Terms",
        ),
        _SectionBody(
          text:
              "By downloading, installing, or using the Bookia application, you agree to be bound by these Terms of Use. If you do not agree with any part of these terms, please do not use our application.",
        ),
        Gap(14),
        _SectionHeader(
          icon: Icons.account_circle_outlined,
          title: "2. User Accounts",
        ),
        _SectionBody(
          text:
              "You must be at least 16 years old to create an account. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. Notify us immediately of any unauthorized use.",
        ),
        Gap(14),
        _SectionHeader(
          icon: Icons.shopping_cart_outlined,
          title: "3. Orders & Payments",
        ),
        _BulletList(
          items: [
            "All prices are displayed in the local currency and are inclusive of applicable taxes.",
            "Orders are confirmed only after payment is successfully processed.",
            "We reserve the right to cancel orders in case of stock unavailability or pricing errors.",
            "Cash on delivery is subject to availability in your area.",
          ],
        ),
        Gap(14),
        _SectionHeader(
          icon: Icons.local_shipping_outlined,
          title: "4. Shipping & Delivery",
        ),
        _SectionBody(
          text:
              "Delivery times are estimates and may vary based on your location and external factors. Bookia is not liable for delays caused by courier services or force majeure events. Risk of loss passes to you upon delivery.",
        ),
        Gap(14),
        _SectionHeader(
          icon: Icons.replay_outlined,
          title: "5. Returns & Refunds",
        ),
        _SectionBody(
          text:
              "Physical books may be returned within 14 days of receipt if they are in their original, unused condition. Refunds are processed within 7–10 business days after we receive the returned item. Digital content and gift cards are non-refundable.",
        ),
        Gap(14),
        _SectionHeader(
          icon: Icons.block_rounded,
          title: "6. Prohibited Activities",
        ),
        _BulletList(
          items: [
            "Using the app for any fraudulent or unlawful purpose.",
            "Attempting to gain unauthorized access to our systems.",
            "Posting or transmitting harmful, offensive, or infringing content.",
            "Creating multiple accounts to abuse promotions or discounts.",
            "Reverse engineering or copying any part of the application.",
          ],
        ),
        Gap(14),
        _SectionHeader(
          icon: Icons.copyright_outlined,
          title: "7. Intellectual Property",
        ),
        _SectionBody(
          text:
              "All content on the Bookia app — including logos, images, text, and software — is the property of Bookia or its licensors and is protected by copyright law. You may not reproduce, distribute, or create derivative works without our explicit written permission.",
        ),
        Gap(14),
        _SectionHeader(
          icon: Icons.warning_amber_outlined,
          title: "8. Limitation of Liability",
        ),
        _SectionBody(
          text:
              "Bookia is provided 'as is' without any warranties. To the fullest extent permitted by law, we are not liable for any indirect, incidental, or consequential damages arising from your use of the app or from any orders placed through it.",
        ),
        Gap(14),
        _SectionHeader(icon: Icons.edit_document, title: "9. Changes to Terms"),
        _SectionBody(
          text:
              "We reserve the right to update these Terms of Use at any time. We will provide notice of material changes via the app or by email. Your continued use of Bookia following any changes means you accept the new terms.",
        ),
        Gap(24),
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
            "Last updated: $date",
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
