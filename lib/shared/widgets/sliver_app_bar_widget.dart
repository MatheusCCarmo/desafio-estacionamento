import 'package:estacionamento/shared/store/store.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class SliverAppBarWidget extends StatelessWidget {
  final String title;
  final Function cautionHandler;
  final Function sortHandler;
  const SliverAppBarWidget(
      {Key? key,
      required this.title,
      required this.cautionHandler,
      required this.sortHandler})
      : super(key: key);

  _showAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Atenção!'),
          content: Text(
              'Caso esteja tendo problemas, você pode limpar todos os dados do app, incluindo o armazenamento local. Deseja limpar?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Não'),
            ),
            TextButton(
              onPressed: () async {
                await cautionHandler();
                Navigator.of(context).pop(true);
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        title,
        style: AppTextStyles.titleRegularWhite,
      ),
      actions: [
        IconButton(
          onPressed: () {
            sortHandler();
          },
          icon: Icon(
            Icons.filter_list,
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () {
            _showAlertDialog(context);
          },
          icon: Icon(
            Icons.report_problem_outlined,
            size: 30,
          ),
        ),
        SizedBox(
          width: 6,
        )
      ],
    );
  }
}
