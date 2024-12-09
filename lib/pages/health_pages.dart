import 'package:flutter/material.dart';

class HealthPages extends StatelessWidget {
  const HealthPages({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> cleaners = [
      {
        'title' : '1.Vacum Cleaner',
        'description': 'Alat ini efektif untuk membersihkan debu, kotoran, dan partikel kecil dari lantai dan karpet. Cocok untuk rumah tangga dan kantor.',
      },
      {
        'title': '2. Steam Cleaner',
        'description': 'Menggunakan uap panas untuk membersihkan dan mendisinfeksi permukaan. Sangat baik untuk membersihkan lantai, ubin, dan peralatan dapur.',
      },
      {
        'title': '3. Microfiber Cloth',
        'description': 'Kain serat mikro yang mampu menangkap debu dengan efektif tanpa bahan kimia. Ideal untuk membersihkan permukaan sensitif seperti kaca dan elektronik.',
      },
      {
        'title': '4. Mop Basah dan Kering',
        'description': 'Mop basah untuk membersihkan noda dan kotoran lengket, sedangkan mop kering untuk menyapu debu dan kotoran ringan.',
      },
      {
        'title': '5. Disinfectant Sprayer',
        'description': 'Alat penyemprot disinfektan untuk membunuh bakteri dan virus pada berbagai permukaan. Cocok untuk area dengan kebersihan tinggi.',
      },
      {
        'title': '6. High-Pressure Washer',
        'description': 'Mesin cuci tekanan tinggi yang mampu membersihkan permukaan luar seperti jalan, teras, dan kendaraan.',
      },
      ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pemilihan Alat Cleaner'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          const Text(
            'Pemilihan Alat Cleaner',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.asset(
              'assets/clean.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
        ...cleaners.map((tip){
           return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tip['title']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    tip['description']!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const Divider(),
                ],
              ),
            );
        }).toList(),
        ],
      ),
    );
  }
}
