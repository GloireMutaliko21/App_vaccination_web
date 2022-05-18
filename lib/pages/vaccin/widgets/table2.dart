import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:v_connect_web/constants/style.dart';
import 'package:v_connect_web/widgets/custom_text.dart';

class TableData2 extends StatefulWidget {
  final List data;
  final titreTable;
  const TableData2({Key? key, this.titreTable, required this.data})
      : super(key: key);

  @override
  _TableData2State createState() => _TableData2State();
}

class _TableData2State extends State<TableData2> {
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
                  label: Text('Période'),
                ),
                DataColumn(
                  label: Text('Durée de protection'),
                ),
                DataColumn(
                  label: Text('Action'),
                ),
              ],
              rows: List<DataRow>.generate(widget.data.length, (index) {
                var data = widget.data[index];
                return DataRow(cells: [
                  DataCell(CustomText(
                    text: data['idVAT'],
                    color: Colors.black,
                    size: 16,
                    weight: FontWeight.normal,
                  )),
                  DataCell(CustomText(
                    text: data['dateAdmin'],
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
                        text: data['dureeProtec'],
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
