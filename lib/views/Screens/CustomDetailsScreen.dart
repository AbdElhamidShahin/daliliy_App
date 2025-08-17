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
              SliverAppBar(  automaticallyImplyLeading: false, // ⬅️ تمنع زر الرجوع التلقائي

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
                      Positioned(
                        bottom: 40,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                category.name,
                                style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
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
                        const SizedBox(height: 30),
                        const Text(
                          "الوصف",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          category.description,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.8,
                            color: Colors.black87,
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
                  final url = category.locationLink;
                  if (url != null && await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(
                      Uri.parse(url),
                      mode: LaunchMode.externalApplication,
                    );
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
