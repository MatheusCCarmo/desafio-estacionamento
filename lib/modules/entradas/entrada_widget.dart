import 'package:estacionamento/model/entrada.dart';
import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class EntradaWidget extends StatefulWidget {
  final Entrada entrada;
  final Function deleteCallback;

  const EntradaWidget({
    Key? key,
    required this.entrada,
    required this.deleteCallback,
  }) : super(key: key);

  @override
  _EntradaWidgetState createState() => _EntradaWidgetState();
}

class _EntradaWidgetState extends State<EntradaWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(widget.key),
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
        return widget.deleteCallback(context, widget.entrada);
      },
      child: Container(
        height: 135,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
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
                                widget.entrada.vaga.id,
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
                                widget.entrada.veicle,
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
                            Text(widget.entrada.entryTime),
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
                            Text(widget.entrada.exitTime),
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
                      width: 130,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'Registrar Saída',
                        style: AppTextStyles.buttonRegularWhite,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.deleteCallback(context, widget.entrada);
                    },
                    child: Container(
                      height: 34,
                      width: 130,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.delete,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'Excluir',
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
