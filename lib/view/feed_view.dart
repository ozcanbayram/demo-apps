import 'package:delivery_app/core/const/project_colors.dart';
import 'package:delivery_app/core/const/project_texts.dart';
import 'package:delivery_app/product/custom/widgets/custom_padding.dart';
import 'package:delivery_app/product/custom/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Menü butonuna tıklanınca yapılacak işlemler
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: ProjectColors.textSecondary,
            ),
            onPressed: () {
              // Sepet butonuna tıklanınca yapılacak işlemler
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: CustomPadding.all(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ProjectTexts.feedTitle,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(),
              ),
              CustomSearchField(),
            ],
          ),
        ),
      ),
    );
  }
}
