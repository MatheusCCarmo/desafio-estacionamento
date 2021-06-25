import 'package:estacionamento/model/entrada.dart';
import 'package:estacionamento/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class EntradaInfoWidget extends StatelessWidget {
  final Entrada entrada;

  const EntradaInfoWidget({Key? key, required this.entrada}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
