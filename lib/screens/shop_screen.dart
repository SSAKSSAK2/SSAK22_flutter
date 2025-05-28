import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({super.key});

  final List<Product> justForYou = [
    Product(
      name: '상추씨앗',
      image: 'assets/images/lettuce.jpg',
      detail: ProductDetail(
        harvestPeriod: '약 30~40일',
        difficulty: '매우 쉬움',
        sunlight: '하루 4시간 이상 직사광선 또는 밝은 곳',
      ),
    ),
    Product(
      name: '방울토마토씨앗',
      image: 'assets/images/tomato_fruit.png',
      detail: ProductDetail(
        harvestPeriod: '약 60~70일',
        difficulty: '쉬움',
        sunlight: '하루 6시간 이상 직사광선',
      ),
    ),
    Product(name: '바질씨앗', image: 'assets/images/basil.jpg'),
    Product(name: '모종삽', image: 'assets/images/shovel.png'),
  ];

  final List<Product> popular = [
    Product(
      name: '방울토마토모종',
      image: 'assets/images/tomato_tree.jpg',
      detail: ProductDetail(
        harvestPeriod: '약 40~50일',
        difficulty: '쉬움',
        sunlight: '하루 6시간 이상 직사광선',
      ),
    ),
    Product(name: '분갈이흙', image: 'assets/images/potting_soil.png'),
    Product(name: '맞춤배합흙', image: 'assets/images/custom_soil.png'),
    Product(name: '미니화분', image: 'assets/images/pot.png'),
    Product(name: '영양제', image: 'assets/images/fertilizor.png'),
    Product(name: '분무기', image: 'assets/images/sprayer.png'),
  ];

  void _showProductDetail(BuildContext context, Product product) {
    if (product.detail == null) return;

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder:
          (context) => Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 340,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.13),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.black87),
                        onPressed: () => Navigator.of(context).pop(),
                        splashRadius: 22,
                      ),
                    ),
                    if (product.image != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Image.asset(
                          product.image!,
                          height: 140,
                          fit: BoxFit.contain,
                        ),
                      ),
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              size: 18,
                              color: Colors.white,
                            ),
                            label: const Text(
                              '장바구니 담기',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8B6F5C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 10,
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 18,
                              color: Color(0xFF6B7A1A),
                            ),
                            label: const Text(
                              '구매하기',
                              style: TextStyle(color: Color(0xFF6B7A1A)),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE9EDC9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 10,
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    _infoRow('수확까지 기간', product.detail!.harvestPeriod),
                    _infoRow('키우는 난이도', product.detail!.difficulty),
                    _infoRow('햇빛 조건', product.detail!.sunlight),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  static Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: const TextStyle(color: Colors.black54)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalProductList(
    List<Product> products,
    BuildContext context,
  ) {
    return SizedBox(
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (context, index) => const SizedBox(width: 18),
        itemBuilder: (context, index) {
          final product = products[index];
          final canShowDetail =
              product.name == '상추씨앗' || product.name == '방울토마토씨앗';
          return GestureDetector(
            onTap:
                canShowDetail
                    ? () => _showProductDetail(context, product)
                    : null,
            child: SizedBox(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child:
                          product.image != null
                              ? Image.asset(product.image!, fit: BoxFit.cover)
                              : Container(color: Colors.grey[200]),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 인기 상품 그리드 → Wrap으로 변경
  Widget _buildProductGrid(List<Product> products, BuildContext context) {
    // 한 줄에 3개씩 배치
    double itemWidth = (MediaQuery.of(context).size.width - 40 - 32) / 3;
    // 40: 좌우 패딩, 32: 16*2(열 사이 간격 두 번)
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: List.generate(products.length, (index) {
        final product = products[index];
        final canShowDetail = product.name == '방울토마토모종';
        return SizedBox(
          width: itemWidth,
          child: GestureDetector(
            onTap:
                canShowDetail
                    ? () => _showProductDetail(context, product)
                    : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child:
                        product.image != null
                            ? Image.asset(product.image!, fit: BoxFit.cover)
                            : Container(color: Colors.grey[200]),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6EDD9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6EDD9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_grocery_store, color: Colors.black),
            const SizedBox(width: 8),
            const Text(
              '상점',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Image.asset('assets/images/point.png', width: 60, height: 60),
              const SizedBox(width: 4),
              const Text(
                '130p',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                '추천 상품',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),
              _buildHorizontalProductList(justForYou, context),
              const SizedBox(height: 24),
              const Text(
                '인기 상품',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),
              _buildProductGrid(popular, context),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String? image;
  final ProductDetail? detail;

  Product({required this.name, this.image, this.detail});
}

class ProductDetail {
  final String harvestPeriod;
  final String difficulty;
  final String sunlight;

  ProductDetail({
    required this.harvestPeriod,
    required this.difficulty,
    required this.sunlight,
  });
}
