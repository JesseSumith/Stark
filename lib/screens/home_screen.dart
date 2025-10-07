import 'package:flutter/material.dart';
import 'package:market_advisor/mock_data.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../services/mock_data.dart';
import '../widgets/auto_carousel.dart';
import '../widgets/product_card.dart';
import '../providers/locale_provider.dart';
import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _loader;
  @override
  void initState() {
    super.initState();
    _loader = MockData.getProducts();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final locale = context.watch<LocaleProvider>();
    return AppBar(
      elevation: 2,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFF6D4C41), Color(0xFF8BC34A)]),
        ),
      ),
      title: const Text('Market Pulse'),
      actions: [
        IconButton(
          icon: const Icon(Icons.language),
          onPressed: () {
            final lp = context.read<LocaleProvider>();
            final newLocale =
                lp.locale == AppLocale.en ? AppLocale.te : AppLocale.en;
            lp.switchTo(newLocale);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>();

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: FutureBuilder<List<Product>>(
          future: _loader,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snap.hasError) {
              return Center(child: Text('Failed to load data: ${snap.error}'));
            } else if (!snap.hasData || snap.data!.isEmpty) {
              return const Center(child: Text('No products available.'));
            } else {
              final products = snap.data!;
              final trending = List.of(products);
              trending.sort((a, b) {
                int score(String t) {
                  if (t.toLowerCase() == 'up') return 2;
                  if (t.toLowerCase() == 'neutral') return 1;
                  return 0;
                }

                return score(b.trend).compareTo(score(a.trend));
              });
              final top = trending.take(4).toList();

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    // Carousel
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AutoCarousel(
                        items: products
                            .map((p) => ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    p.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        Container(color: Colors.grey.shade300),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // TRENDING SECTION
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        height: 216,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    locale.translate(
                                      en: 'Trending Products',
                                      te: 'ఇప్పటికే టాపు వస్తువులు',
                                    ),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const MainScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(locale.translate(
                                      en: 'View all', te: 'అన్నిటిని చూడండి')),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: ListView.separated(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                scrollDirection: Axis.horizontal,
                                itemCount: top.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 8),
                                itemBuilder: (context, idx) {
                                  return SizedBox(
                                    width: 140,
                                    child: ProductCardCompact(
                                      product: top[idx],
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  '${top[idx].name} tapped')),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Advisory CTA
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 12,
                            runSpacing: 8,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      locale.translate(
                                        en: 'Need selling advice?',
                                        te: 'అమ్మకానికి సలహా కావాలా?',
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      locale.translate(
                                        en: 'Find the best place and time to sell your produce.',
                                        te: 'మీ ఉత్పత్తిని అమ్మడానికి ఉత్తమ మార్కెట్ మరియు సమయం కనుగొనండి.',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const MainScreen()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6D4C41),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  locale.translate(
                                    en: 'Get Advisory',
                                    te: 'సలహా పొందండి',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
