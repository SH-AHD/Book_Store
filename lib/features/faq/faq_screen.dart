import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/helpers/navigation.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/app_back_btn.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<_FAQItem> _faqs = [
    _FAQItem(
      question: "How do I place an order?",
      answer:
          "Browse our catalog, add your desired books to the cart, and proceed to checkout. Fill in your shipping details and confirm your order. You'll receive a confirmation email shortly after.",
    ),
    _FAQItem(
      question: "What payment methods are accepted?",
      answer:
          "We accept cash on delivery (COD) as well as major credit and debit cards. More payment options may be available depending on your region.",
    ),
    _FAQItem(
      question: "How long does delivery take?",
      answer:
          "Standard delivery takes 3–7 business days depending on your location. Express delivery (1–2 business days) is available in select areas at an additional charge.",
    ),
    _FAQItem(
      question: "Can I cancel or modify my order?",
      answer:
          "You can cancel or modify your order within 24 hours of placing it, as long as it hasn't been shipped yet. Contact our support team to request a change.",
    ),
    _FAQItem(
      question: "What is your return policy?",
      answer:
          "We accept returns within 14 days of delivery for books that are in their original condition — unopened and undamaged. Digital products are non-refundable.",
    ),
    _FAQItem(
      question: "How do I track my order?",
      answer:
          "Once your order is shipped, you'll receive an SMS and email with a tracking number. You can also view your order status anytime in the 'My Orders' section of the app.",
    ),
    _FAQItem(
      question: "Do you offer discounts or promotions?",
      answer:
          "Yes! We regularly run seasonal sales and offer exclusive discounts to our registered users. Make sure to enable notifications so you never miss a deal.",
    ),
    _FAQItem(
      question: "Is my personal data safe?",
      answer:
          "Absolutely. We follow strict data protection practices and never share your personal information with third parties without your consent. See our Privacy Policy for full details.",
    ),
  ];

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
        title: const Text('FAQs'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          Text(
            "Frequently Asked Questions",
            style: TextStyles.font16.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkColor,
            ),
          ),
          const Gap(4),
          Text(
            "Find answers to the most common questions below.",
            style: TextStyles.font14.copyWith(color: AppColors.grayColor),
          ),
          const Gap(16),
          ..._faqs.map((faq) => _FAQTile(item: faq)),
        ],
      ),
    );
  }
}

class _FAQItem {
  final String question;
  final String answer;
  bool isExpanded=false;

  _FAQItem({
    required this.question,
    required this.answer,
  });
}

class _FAQTile extends StatefulWidget {
  final _FAQItem item;

  const _FAQTile({required this.item});

  @override
  State<_FAQTile> createState() => _FAQTileState();
}

class _FAQTileState extends State<_FAQTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _iconTurn = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      widget.item.isExpanded = !widget.item.isExpanded;
      widget.item.isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: widget.item.isExpanded
              ? AppColors.primaryColor.withValues(alpha: 0.4)
              : AppColors.semiWhiteBorderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: _toggle,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.item.question,
                      style: TextStyles.font14.copyWith(
                        fontWeight: FontWeight.w600,
                        color: widget.item.isExpanded
                            ? AppColors.primaryColor
                            : AppColors.darkColor,
                      ),
                    ),
                  ),
                  RotationTransition(
                    turns: _iconTurn,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: widget.item.isExpanded
                          ? AppColors.primaryColor
                          : AppColors.grayColor,
                    ),
                  ),
                ],
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    widget.item.answer,
                    style: TextStyles.font14.copyWith(
                      color: AppColors.darkGrayColor,
                      height: 1.6,
                    ),
                  ),
                ),
                crossFadeState: widget.item.isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
