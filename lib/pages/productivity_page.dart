import 'package:flutter/material.dart';

class ProductivityPage extends StatelessWidget {
  const ProductivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> tips = [
      {
        'title': '1.Tetapkan Kriteria Seleksi yang Jelas',
        'description': 'Tentukan kriteria yang spesifik dan relevan dengan kebutuhan pekerjaan sebelum proses seleksi dimulai.',
      },
      {
        'title': '2.Gunakan Wawancara Berstruktur',
        'description': 'Wawancara yang memiliki format dan pertanyaan baku akan membantu menilai kandidat secara lebih objektif.',
      },
      {
        'title': '3.Lakukan Tes Keterampilan',
        'description': 'Berikan tes praktis yang sesuai dengan tugas pekerjaan untuk mengukur kemampuan kandidat secara langsung.',
      },
      {
        'title': '4.Periksa Referensi Kerja',
        'description': 'Menghubungi referensi dari tempat kerja sebelumnya bisa memberi wawasan tambahan mengenai perilaku dan kinerja kandidat.',
      },
      {
        'title': '5.Gunakan Tes Psikologi',
        'description': 'Tes psikologi membantu menilai karakter dan kecocokan kepribadian kandidat dengan budaya perusahaan.',
      },
      {
        'title': '6.Evaluasi Pengalaman Kerja',
        'description': 'Tinjau pengalaman kerja kandidat dan kaitkan dengan tantangan yang akan mereka hadapi di posisi yang dilamar.',
      },
      {
        'title': '7.Cek Portofolio atau Hasil Kerja',
        'description': 'Untuk posisi kreatif atau teknis, portofolio memberi gambaran nyata tentang kualitas kerja kandidat.',
      },
      {
        'title': '8.Simulasi Situasi Kerja',
        'description': 'Melakukan simulasi kerja membantu melihat bagaimana kandidat menangani tugas-tugas dalam kondisi nyata.',
      },
      {
        'title': '9.Lakukan Diskusi Kelompok',
        'description': 'Diskusi kelompok atau sesi brainstorming menunjukkan kemampuan kerja sama dan kepemimpinan kandidat.',
      },
      {
        'title': '10.Uji Kemampuan Komunikasi',
        'description': 'Pastikan kandidat memiliki kemampuan komunikasi yang baik, baik lisan maupun tulisan.',
      },
      {
        'title': '11.Perhatikan Bahasa Tubuh',
        'description': 'Bahasa tubuh dapat memberi sinyal tentang kepercayaan diri, kejujuran, dan tingkat kenyamanan kandidat.',
      },
      {
        'title': '12.Berikan Kesempatan Tanya Jawab',
        'description': 'Dengan memberikan kesempatan bertanya, Anda bisa menilai minat dan pemahaman kandidat tentang perusahaan.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('12 Tips Seleksi Pekerja'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          const Text(
            '12 Tips Seleksi Pekerja',
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
              'assets/seleksi.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          ...tips.map((tip) {
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
