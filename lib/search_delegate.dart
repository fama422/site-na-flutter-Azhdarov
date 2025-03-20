import 'package:flutter/material.dart';
import 'models.dart';
import 'main.dart'; // Импортируем main.dart, чтобы использовать SupplierDetailPage и ContractorDetailPage

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<Supplier> suppliers;
  final List<Contractor> contractors;

  CustomSearchDelegate({required this.suppliers, required this.contractors});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // Возвращаем пустую строку вместо null
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context); // Передаем context в метод
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context); // Передаем context в метод
  }

  Widget _buildSearchResults(BuildContext context) {
    final supplierResults = suppliers
        .where((supplier) => supplier.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    final contractorResults = contractors
        .where((contractor) => contractor.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: [
        ...supplierResults.map((supplier) => ListTile(
              title: Text(supplier.name),
              onTap: () {
                close(context, ''); // Возвращаем пустую строку вместо null
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SupplierDetailPage(supplier: supplier),
                  ),
                );
              },
            )),
        ...contractorResults.map((contractor) => ListTile(
              title: Text(contractor.name),
              onTap: () {
                close(context, ''); // Возвращаем пустую строку вместо null
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContractorDetailPage(contractor: contractor),
                  ),
                );
              },
            )),
      ],
    );
  }
}