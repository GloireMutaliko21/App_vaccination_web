import 'package:flutter/material.dart';
import 'package:v_connect_web/pages/Comptes/comptes.dart';
import 'package:v_connect_web/pages/avs/avs.dart';
import 'package:v_connect_web/pages/calendars/calendars_cards.dart';
import 'package:v_connect_web/pages/clients/clients.dart';
import 'package:v_connect_web/pages/overview/overview.dart';
import 'package:v_connect_web/rapports/page/pdf_page.dart';
import 'package:v_connect_web/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OverViewPageRoute:
      return _getPageRoute(OverviewPage());
    case ComptesPageRoute:
      return _getPageRoute(ComptesPage());
    case ClientsPageRoute:
      return _getPageRoute(ClientsPage());
    case RapportPageRoute:
      return _getPageRoute(PdfPage());
    case AvsPageRoute:
      return _getPageRoute(AvsPage());
    case CalendriersPageRoute:
      return _getPageRoute(CalendarsCards());
    default:
      return _getPageRoute(OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
