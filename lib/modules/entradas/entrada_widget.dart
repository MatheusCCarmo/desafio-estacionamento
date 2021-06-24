import 'package:estacionamento/model/entrada.dart';
import 'package:estacionamento/shared/store/store.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class EntradaWidget extends StatelessWidget {
  final Entrada entrada;

  const EntradaWidget({
    Key? key,
    required this.entrada,
  }) : super(key: key);

  Future<bool> _deleteDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Atenção!'),
          content: Text('Deseja mesmo excluir essa entrada?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () {
                Store.removeEntrada(entrada);
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(key),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: AppColors.delete,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          margin: EdgeInsets.only(right: 12),
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            size: 40,
            color: AppColors.white,
          ),
        ),
      ),
      confirmDismiss: (direction) {
        return _deleteDialog(context);
      },
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyShadow,
              offset: Offset(1, 1),
              spreadRadius: 1,
              blurRadius: 6,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 6),
                          child: Row(
                            children: [
                              Icon(
                                Icons.place,
                                size: 32,
                              ),
                              Text(
                                entrada.vaga.id,
                                style: AppTextStyles.titleRegular,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(Icons.drive_eta),
                              Text(
                                entrada.veicle,
                                style: AppTextStyles.bodyRegular,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Horário de Chegada',
                          style: AppTextStyles.bodyRegular,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              size: 18,
                            ),
                            Text(entrada.entryTime),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Horário de Saída',
                          style: AppTextStyles.bodyRegular,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              size: 18,
                            ),
                            Text(entrada.exitTime),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 34,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'Editar',
                        style: AppTextStyles.buttonRegularWhite,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _deleteDialog(context);
                    },
                    child: Container(
                      height: 34,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.delete,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'Deletar',
                        style: AppTextStyles.buttonRegularWhite,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
