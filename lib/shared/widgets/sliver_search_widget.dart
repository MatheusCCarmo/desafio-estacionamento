import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class SliverSearchWidget extends StatelessWidget {
  final Function searchCallback;
  const SliverSearchWidget({Key? key, required this.searchCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 1,
      toolbarHeight: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      flexibleSpace: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            onChanged: (value) {
              searchCallback(value);
            },
            style: AppTextStyles.body2RegularWhite,
            decoration: InputDecoration(
              prefixIconConstraints: BoxConstraints.tight(
                Size(35, 30),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.white,
                size: 22,
              ),
              hintText: 'Procurar',
              hintStyle: TextStyle(
                color: AppColors.white,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
