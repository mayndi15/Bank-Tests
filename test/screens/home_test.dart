import 'package:estilizacao_componentes/components/box_card.dart';
import 'package:estilizacao_componentes/data/bank_http.dart';
import 'package:estilizacao_componentes/data/bank_http.mocks.dart';
import 'package:estilizacao_componentes/data/bank_inherited.dart';
import 'package:estilizacao_componentes/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  final BankHttp httpMock = MockBankHttp();

  testWidgets("My widget has text 'spent' ", (widgetTester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5'));
    await widgetTester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: httpMock.dolarToReal()),
      ),
    ));

    final spentFinder = find.text('Spent');
    expect(spentFinder, findsOneWidget);
  });

  testWidgets("Finds a LinearProgressIndicator", (widgetTester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5'));
    await widgetTester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: httpMock.dolarToReal()),
      ),
    ));

    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets("Finds a AccountStatus", (widgetTester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5'));
    await widgetTester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: httpMock.dolarToReal()),
      ),
    ));

    expect(find.byKey(const Key('testKey')), findsOneWidget);
  });

  testWidgets("Finds 5 BoxCard", (widgetTester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5'));
    await widgetTester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: httpMock.dolarToReal()),
      ),
    ));

    expect(find.byWidgetPredicate((widget) {
      if (widget is BoxCard) {
        return true;
      } else {
        return false;
      }
    }), findsNWidgets(5));
  });

  testWidgets("When tap Deposit should upload earned in 10",
      (widgetTester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5'));
    await widgetTester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(
          api: httpMock.dolarToReal(),
        ),
      ),
    ));

    await widgetTester.tap(find.text("Deposit"));
    await widgetTester.tap(find.text("Earned"));

    await widgetTester.pumpAndSettle();

    expect(find.text('\$10.0'), findsOneWidget);
  });

  testWidgets("When tap Transfer should upload earned in 10",
      (widgetTester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5'));
    await widgetTester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: httpMock.dolarToReal()),
      ),
    ));

    await widgetTester.tap(find.text("Deposit"));
    await widgetTester.tap(find.text("Transfer"));
    await widgetTester.tap(find.text("Spent"));

    await widgetTester.pumpAndSettle();

    expect(find.text('\$10.0'), findsNWidgets(2));
  });

  testWidgets("Testing MockHttp dolarToReal", (widgetTester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => ('5'));
    await widgetTester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(api: httpMock.dolarToReal()),
      ),
    ));

    verify(httpMock.dolarToReal()).called(7);
  });
}
