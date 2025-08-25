import 'package:Tourism_app/models/Item/Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../viewmodels/ItemProvider.dart';
import '../Wedget/contact/buildCustomBackButton.dart';
import '../Wedget/contact/buildRatingSection.dart' show buildRatingSection;
import '../Wedget/icons/IconFavorite.dart';
import '../Wedget/contact/buildContactCard.dart';

class CustomDetailsScreen extends StatelessWidget {
  final Category category;

  const CustomDetailsScreen({super.key, required this.category, context});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Header Section
              SliverAppBar(
                automaticallyImplyLeading: false, // ⬅️ تمنع زر الرجوع التلقائي

                expandedHeight: size.height * 0.5,
                collapsedHeight: 100,
                stretch: true,
                pinned: true,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: 'image_${category.id}',
                        child: Image.network(
                          category.imageUrl,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/Image/logo.png');
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Content Section
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              category.name,
                              style: TextStyle(
                                fontSize: 26, // أصغر من 32 عشان يكون أنيق
                                color: Colors.black
                                    .withOpacity(0.75), // أخف من black87
                                fontWeight:
                                    FontWeight.w600, // بدل bold تبقى أخف شوية
                                shadows: const [
                                  Shadow(
                                    blurRadius: 1.5,
                                    color: Colors.black26, // ظل أخف
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.right,
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          ":الوصف",
                          style: TextStyle(
                            fontSize: 24, // بدل 24 تبقى أنعم
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(.7), // درجة أخف
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          category.description,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                                .withOpacity(.7), // نص رمادي أفتح للقراءة
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 32),
                        _buildGallerySection(),
                        const SizedBox(height: 32),
                        _buildContactSection(),
                        const SizedBox(height: 32),
                        buildRatingSection(context),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 12,
            child: BuildFavoriteIcon(
              category: category,
              onPressed: () {
                print('عنصر محذوف يدويًا');
                Provider.of<ItemProvider>(context, listen: false)
                    .addToFavorites(category);
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            right: 12,
            child: buildCustomBackButton(context),
          ),

          // Custom Back Button
        ],
      ),
    );
  }

  Widget _buildGallerySection() {
    if (category.imageUrl == null || category.imageUrl!.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.imageUrl!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    category.imageUrl ?? 'assets/Image/logo.png',
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/Image/logo.png');
                    },
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          "معلومات التواصل",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.8,
          children: [
            if (category.locationLink != null)
              buildContactCard(
                icon: Icons.location_on,
                label: 'الموقع',
                color: Colors.blue,
                onTap: () async {
                  final url = Uri.parse(category.locationLink!);
                  if (!await launchUrl(url,
                      mode: LaunchMode.externalApplication)) {
                    throw Exception('Could not launch $url');
                  }
                },
              ),
            if (category.number != null)
              buildContactCard(
                icon: Icons.call,
                label: 'اتصال',
                color: Colors.green,
                onTap: () {
                  launch('tel://${category.number}');
                },
              ),
            if (category.number != null)
              buildContactCard(
                icon: FontAwesomeIcons.whatsapp,
                label: 'واتساب',
                color: const Color(0xFF25D366),
                onTap: () {
                  launch('https://wa.me/${_formatPhone(category.number!)}');
                },
              ),
            if (category.youtypeLink != null)
              buildContactCard(
                icon: FontAwesomeIcons.instagram,
                label: 'انستجرام',
                color: const Color(0xFFE1306C),
                onTap: () {
                  launch(category.youtypeLink);
                },
              ),
          ],
        ),
      ],
    );
  }

  String _formatPhone(String phone) {
    if (phone.startsWith('0')) {
      return '2${phone.substring(1)}';
    }
    return phone;
  }
}
