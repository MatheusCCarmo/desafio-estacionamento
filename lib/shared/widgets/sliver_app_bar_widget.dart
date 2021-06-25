import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class SliverAppBarWidget extends StatelessWidget {
  final String title;
  const SliverAppBarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        'Vagas',
        style: AppTextStyles.titleRegularWhite,
      ),
    );
  }
}
