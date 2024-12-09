import 'package:flutter/material.dart';

class BusinesPages extends StatelessWidget {
  const BusinesPages({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> scaleUpTips = [
      {
        'title': '1. Permintaan Melebihi Kapasitas',
        'description':
            'Jika permintaan pelanggan terus meningkat dan Anda kesulitan memenuhinya, ini adalah tanda bahwa Anda perlu scale up untuk meningkatkan kapasitas produksi atau layanan.',
      },
      {
        'title': '2. Arus Kas Stabil',
        'description':
            'Pastikan arus kas bisnis stabil dan memiliki pendapatan yang konsisten sebelum memutuskan untuk scale up.',
      },
      {
        'title': '3. Tim yang Siap Berkembang',
        'description':
            'Pastikan tim Anda memiliki keterampilan dan kesiapan untuk menghadapi tantangan yang lebih besar dalam proses scale up.',
      },
      {
        'title': '4. Peluang Pasar yang Jelas',
        'description':
            'Identifikasi peluang pasar yang potensial dan pastikan ada permintaan yang berkelanjutan untuk produk atau layanan Anda.',
      },
      {
        'title': '5. Infrastruktur Mendukung',
        'description':
            'Pastikan teknologi dan infrastruktur bisnis Anda siap untuk menangani peningkatan skala operasional.',
      },
      {
        'title': '6. Kompetitor Mulai Berkembang',
        'description':
            'Jika kompetitor mulai berkembang pesat, pertimbangkan untuk scale up agar tetap kompetitif di pasar.',
      },
      {
        'title': '7. Efisiensi Operasional Maksimal',
        'description':
            'Pastikan proses operasional saat ini sudah berjalan efisien sebelum memperbesar skala bisnis.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Kapan Harus Scale Up'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Kapan Harus Scale Up?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/scaleup.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          ...scaleUpTips.map((tip) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tip['title']!,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    tip['description']!,
                    style: TextStyle(fontSize: 16, 
                      color: Colors.black54,
                    ),
                  textAlign: TextAlign.justify,
                  ),
                  
                  Divider()
                ],
              ),
            );
          }).toList()
        ],
      ),
    );
  }
}
