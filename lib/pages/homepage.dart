import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoice_genrator/model/customer.dart';
import 'package:invoice_genrator/model/invoice.dart';
import 'package:invoice_genrator/model/supplier.dart';

import '../api/pdf_api.dart';
import '../api/pdf_invoice_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Invoice Generator"),),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Generate you invoices here"),
            ElevatedButton(onPressed: () async {
              final date = DateTime.now();
              final dueDate = date.add(const Duration(days: 7));
              final invoice = Invoice(info: InvoiceInfo(
                  date: date, dueDate: dueDate, description: "My Description", number: '9997764643'),
                  supplier: const Supplier(name: "Amol Dange", address: "Sakharale", paymentInfo: "Cash"),
                  customer: const Customer(name: "Marketingwala CJ", address: "Islmapur"),
                  items: [
                    InvoiceItem(description: "Coffee", date: date, quantity: 3, vat: 5, unitPrice: 20),
                    InvoiceItem(description: "Pizza", date: date, quantity: 6, vat: 5, unitPrice: 80),
                  ]);

              final pdfFile = await PdfInvoiceApi.generate(invoice);
              PdfApi.openFile(pdfFile);
              if (kDebugMode) {
                print(pdfFile.path);
              }
            }, child: const Text("Generate Invoice"))
          ],
        ),
      ),
    );
  }
}
