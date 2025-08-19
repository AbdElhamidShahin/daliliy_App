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
  bool isLoading = false;
  String? selectedSubCategory;

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
    setState(() => isLoading = true);
    try {
      final subCategory = requestData['subCategory'];
      final tableName = categoryStorageMap[subCategory];

      if (tableName == null) {
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
        const SnackBar(content: Text('تمت الموافقة على الطلب بنجاح')),
      );
    } catch (e) {
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
      appBar: AppBar(
        title: const Text('الطلبات الجديدة'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : requests.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'لا توجد طلبات جديدة',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          final subCategory = request['subCategory'] ?? 'غير محدد';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ExpansionTile(
              leading: request['imageUrl'] != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  request['imageUrl'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              )
                  : Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.image, size: 30, color: Colors.grey[500]),
              ),
              title: Text(
                request['name'] ?? 'بدون اسم',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    request['description'] ?? 'بدون وصف',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'سيضاف في: $subCategory',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('📍 الموقع:', request['location']),
                      _buildInfoRow('📞 الهاتف:', request['phoneLink']),
                      _buildInfoRow('📱 واتساب:', request['whatsAppLink']),
                      _buildInfoRow('📺 يوتيوب:', request['youtypeLink']),
                      _buildInfoRow('🔗 لينك الموقع:', request['locationLink']),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.info_outline, size: 20),
                              label: const Text("التفاصيل"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[700],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              onPressed: () {
                                final category = Category(
                                  id: request['id'],
                                  name: request['name'] ?? '',
                                  description: request['description'] ?? '',
                                  imageUrl: request['imageUrl'] ?? '',
                                  facebookLink: request['facebookLink'] ?? '',
                                  youtypeLink: request['youtypeLink'] ?? '',
                                  whatsAppLink: request['whatsAppLink'] ?? '',
                                  locationLink: request['locationLink'] ?? '',
                                  phoneLink: request['phoneLink'] ?? '',
                                  location: request['location'] ?? '',
                                  number: request['number'] ?? '',
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CustomDetailsScreen(
                                      category: category,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.check_circle,
                                color: Colors.green, size: 32),
                            onPressed: () async {
                              await approveRequest(request);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel,
                                color: Colors.red, size: 32),
                            onPressed: () async {
                              await updateStatus(request['id'], 'rejected');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value ?? 'غير متوفر',
              style: TextStyle(
                fontSize: 14,
                color: value != null ? Colors.grey[800] : Colors.grey[500],
              ),
            ),
          ),
        ],
      ),
    );
  }
}