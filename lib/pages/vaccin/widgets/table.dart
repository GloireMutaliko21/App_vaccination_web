import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

class TableData extends StatefulWidget {
  final List data2;
  final titreTable;
  const TableData({
    Key? key,
    this.titreTable,
    required this.data2,
  }) : super(key: key);

  @override
  _TableDataState createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 550,
      // alignment: Alignment.topRight,
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
      margin: EdgeInsets.only(
        bottom: 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CustomText(
                text: widget.titreTable,
                color: active,
                weight: FontWeight.bold,
                size: 16,
              ),
            ],
          ),
          DataTable2(
              columnSpacing: 5,
              horizontalMargin: 5,
              minWidth: 300,
              columns: [
                DataColumn2(
                  label: Text("Identifiant"),
                  size: ColumnSize.S,
                ),
                DataColumn(
                  label: Text('Nom'),
                ),
                DataColumn(
                  label: Text('Administration'),
                ),
                DataColumn(
                  label: Text('Action'),
                ),
              ],
              rows: List<DataRow>.generate(widget.data2.length, (index) {
                var data2 = widget.data2[index];
                return DataRow(cells: [
                  DataCell(CustomText(
                    text: data2['idVaccin'],
                    color: Colors.black,
                    size: 16,
                    weight: FontWeight.normal,
                  )),
                  DataCell(CustomText(
                    text: data2['nomVaccin'],
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
                        text: data2['ageConcerne'],
                        color: Colors.black,
                        size: 16,
                        weight: FontWeight.normal,
                      )
                    ],
                  )),
                  DataCell(Container(
                      decoration: BoxDecoration(
                        color: light,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: active, width: .5),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: CustomText(
                        text: "Modifier",
                        color: active.withOpacity(.7),
                        weight: FontWeight.bold,
                        size: 16,
                      ))),
                ]);
              })),
        ],
      ),
    );
  }
}
