/*

void findDateAndVaccMere() {
    setState(() {
      jours = dateNow.difference(selectedDate2).inDays;
      dateformatted = formatter.format(dateNow);
      print(jours);

      if (nbreDoses == 0) {
        datePrevue = formatter.format(dateNow.add(const Duration(days: 2)));
        idVAT = 1;
      } else if (nbreDoses == 1) {
        if (dateformatted == dateLastVat.text) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 30)));
        } else if ((dateNow.difference(selectedDate2).inDays) >= 30) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 2)));
        } else if ((selectedDate2.difference(dateNow).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (30 - jours))));
        }
        idVAT = 2;
      } else if (nbreDoses == 2) {
        if (dateformatted == dateLastVat.text) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 180)));
        } else if ((dateNow.difference(selectedDate2).inDays) >= 180) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 2)));
        } else if ((selectedDate2.difference(dateNow).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (180 - jours))));
        }
        idVAT = 3;
      } else if (nbreDoses == 3) {
        if (dateformatted == dateLastVat.text) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 365)));
        } else if ((dateNow.difference(selectedDate2).inDays) >= 365) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 2)));
        } else if ((selectedDate2.difference(dateNow).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (365 - jours))));
        }
        idVAT = 4;
      } else if (nbreDoses == 4) {
        if (dateformatted == dateLastVat.text) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 365)));
        } else if ((dateNow.difference(selectedDate2).inDays) >= 365) {
          datePrevue = formatter.format(dateNow.add(Duration(days: 2)));
        } else if ((selectedDate2.difference(dateNow).inDays) < 1) {
          datePrevue =
              formatter.format(dateNow.add(Duration(days: (365 - jours))));
        }
        idVAT = 5;
      }
    });
  }





  void initDataMere() async {
    // ignore: await_only_futures
    findDateAndVaccMere();
    await DataInsert.getInstance.addMere(data: {
      "noms": nom.text,
      "dateNaiss": date.text,
      "tel": numT.text,
      "adresse": adress.text,
      "loginM": log.text,
      "pwM": pw2.text,
      "idHopital": idHop2.substring(0, indexOfH),
      "datePrevue": datePrevue,
      "idVAT": idVAT
    }).then((value) {
      print(value);
    });
  }



 */