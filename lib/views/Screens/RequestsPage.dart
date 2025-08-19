import 'package:Dalily_App_Owner/models/Item/Item.dart';
import 'package:Dalily_App_Owner/views/Screens/CustomDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/constants/categoryStorageMap.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  List<Map<String, dynamic>> requests = [];
  bool isLoading = false; // أضف هذا المتغير
  String? selectedSubCategory;
late Category category;
  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    setState(() => isLoading = true);
    try {
      final data = await Supabase.instance.client
          .from('requests')
          .select()
          .eq('status', 'pending');
      setState(() {
        requests = (data as List).cast<Map<String, dynamic>>();
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> updateStatus(String id, String newStatus) async {
    setState(() => isLoading = true);
    try {
      await Supabase.instance.client
          .from('requests')
          .update({'status': newStatus}).eq('id', id);
      await fetchRequests();
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> approveRequest(Map<String, dynamic> requestData) async {
    print('👉 الموافقة على الطلب: ${requestData['id']}');
    print('👉 الفئة الفرعية: ${requestData['subCategory']}');

    setState(() => isLoading = true);
    try {
      final subCategory = requestData['subCategory'];
      final tableName = categoryStorageMap[subCategory];

      print('👉 اسم الجدول المستهدف: $tableName');

      if (tableName == null) {
        print('❌ الفئة غير موجودة في الخريطة');
        throw Exception('الفئة ($subCategory) غير موجودة في الخريطة');
      }

      await Supabase.instance.client.from(tableName).insert({
        'name': requestData['name'],
        'description': requestData['description'],
        'facebookLink': requestData['facebookLink'],
        'youtypeLink': requestData['youtypeLink'],
        'whatsAppLink': requestData['whatsAppLink'],
        'locationLink': requestData['locationLink'],
        'phoneLink': requestData['phoneLink'],
        'location': requestData['location'],
        'number': requestData['number'],
        'imageUrl': requestData['imageUrl'],
      });

      await Supabase.instance.client
          .from('requests')
          .update({'status': 'approved'})
          .eq('id', requestData['id']);

      await fetchRequests();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تمت الموافقة على الطلب بنجاح')),
      );
    } catch (e) {
      print('❌ خطأ تفصيلي: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: ${e.toString()}')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('طلبات جديدة')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : requests.isEmpty
          ? const Center(child: Text('لا توجد طلبات جديدة'))
          : ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return Card(
            child: ListTile(
              leading: request['imageUrl'] != null
                  ? Image.network(request['imageUrl'], width: 50)
                  : null,
              title: Text(request['name'] ?? ''),
              subtitle: Text(request['description'] ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () async {
                      final confirmed = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('تأكيد الموافقة'),
                          content: const Text(
                              'هل أنت متأكد من الموافقة على هذا الطلب؟'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, false),
                              child: const Text('إلغاء'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, true),
                              child: const Text('تأكيد'),
                            ),
                          ],
                        ),
                      );

                      if (confirmed == true) {
                        await approveRequest(request);
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () async {
                      final confirmed = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('تأكيد الرفض'),
                          content: const Text(
                              'هل أنت متأكد من رفض هذا الطلب؟'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, false),
                              child: const Text('إلغاء'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, true),
                              child: const Text('تأكيد'),
                            ),
                          ],
                        ),
                      );

                      if (confirmed == true) {
                        await updateStatus(request['id'], 'rejected');
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}