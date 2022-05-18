import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/API/Sources/session.dart';
import 'package:v_connect_web/rapports/page/pdf_page.dart';

class EnfantsAll extends StatefulWidget {
  const EnfantsAll({Key? key}) : super(key: key);

  @override
  _EnfantsAllState createState() => _EnfantsAllState();
}

class _EnfantsAllState extends State<EnfantsAll> {
  List list = <dynamic>[];

  Future<void> getEnfant() async {
    await DataSource.getInstance.getCurrentData(params: {
      "event": "FIND_ENFANT_TOUT",
      "idHopital": MyPreferences.idHopital,
    }).then((data) {
      if (mounted)
        setState(() {
          list = data;
        });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    super.initState();
    getEnfant();
  }

//SELECT MIN(idVaccin) as idVaccin, GROUP_CONCAT(nomVaccin SEPARATOR '/') as nomVaccin, ageConcerne FROM vaccin GROUP BY ageConcerne ORDER BY idVaccin
  @override
  Widget build(BuildContext context) {
    getEnfant();
    final headers = [
      'IDENTIFIANT',
      'NOM ET POST-NOM',
      'DATE DE NAISSANCE',
      'SEXE',
    ];
    var page;
    final data = list.map((item) {
      return [
        '${item['idEnfant']}',
        '${item['noms']}',
        '${item['dateNaissance']}',
        '${item['sexe']}',
      ];
    }).toList();

    for (var i = 0; i < 20; i++) {
      page = data.sublist(0, 20);
    }

    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        // maxPages: 70,
        build: (pw.Context context) {
          return [
            pw.Wrap(children: <pw.Widget>[
              pw.Text("ENFANTS ENREGISTRES",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Container(color: PdfColors.black, height: 1),
              pw.SizedBox(height: 30),
              pw.Table.fromTextArray(
                data: page,
                headers: headers,
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.normal, fontSize: 10),
                headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
                cellHeight: 30,
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.topCenter,
                  2: pw.Alignment.topCenter,
                  3: pw.Alignment.topCenter,
                  4: pw.Alignment.centerRight,
                },
              ),
            ])
          ];
        }));

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final bytes = await pdf.save();
                final blob = html.Blob([bytes], 'application/pdf');
                final url = html.Url.createObjectUrlFromBlob(blob);
                html.window.open(url, '_blank');
                html.Url.revokeObjectUrl(url);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text('Ouvrir'),
                  SizedBox(
                    width: 109,
                  ),
                  Icon(
                    Icons.file_copy_outlined,
                    color: Colors.amber.shade100,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: () async {
                  final bytes = await pdf.save();
                  final blob = html.Blob([bytes], 'application/pdf');
                  final url = html.Url.createObjectUrlFromBlob(blob);
                  final anchor = html.AnchorElement()
                    ..href = url
                    ..style.display = 'none'
                    ..download =
                        'Rapport_enfant_entre_${ControllersDates.date1.text}_et_${ControllersDates.date2.text}.pdf';
                  html.document.body?.children.add(anchor);
                  anchor.click();
                  html.document.body?.children.remove(anchor);
                  html.Url.revokeObjectUrl(url);
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Text('Télécharger'),
                    SizedBox(
                      width: 75,
                    ),
                    Icon(
                      Icons.download,
                      color: Colors.amber.shade100,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
