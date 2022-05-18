import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

class TableDataAgent extends StatefulWidget {
  final List data;
  const TableDataAgent({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _TableDataAgentState createState() => _TableDataAgentState();
}

class _TableDataAgentState extends State<TableDataAgent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 30),
      child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          columns: [
            DataColumn2(
              label: Text("Noms"),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: Text('Numéro de téléphone'),
            ),
            DataColumn(
              label: Text('Adreese'),
            ),
            DataColumn(
              label: Text('Hôpital'),
            ),
          ],
          rows: List<DataRow>.generate(widget.data.length, (index) {
            var data = widget.data[index];
            return DataRow(cells: [
              DataCell(CustomText(
                text: data['nomsAgent'],
                color: Colors.black,
                size: 16,
                weight: FontWeight.normal,
              )),
              DataCell(CustomText(
                text: data['numTel'],
                color: Colors.black,
                size: 16,
                weight: FontWeight.normal,
              )),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.deepOrange,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomText(
                    text: data['adresse'],
                    color: Colors.black,
                    size: 16,
                    weight: FontWeight.normal,
                  )
                ],
              )),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.deepOrange,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomText(
                    text: data['denomination'],
                    color: Colors.black,
                    size: 16,
                    weight: FontWeight.normal,
                  )
                ],
              )),
            ]);
          }).toList()),
    );
  }
}
