class DisplayDataPage extends StatefulWidget {
  @override
  _DisplayDataPageState createState() => _DisplayDataPageState();
}

class _DisplayDataPageState extends State<DisplayDataPage> {
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = true;

  // الدالة لجلب البيانات من Supabase
  Future<void> _fetchData() async {
    try {
      final response = await Supabase.instance.client
          .from('items') // استبدل بـاسم الجدول الخاص بك في Supabase
          .select()
          .execute();

      // التحقق من حالة الاستجابة
      if (response.status == 200) {
        setState(() {
          _items = List<Map<String, dynamic>>.from(response.data);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('حدث خطأ: ${response.error?.message}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('حدث خطأ')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('عرض البيانات')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _items.length,
        itemBuilder: (ctx, index) {
          final item = _items[index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text(item['description']),
            leading: Image.network(item['imageUrl']), // عرض الصورة
          );
        },
      ),
    );
  }
}
