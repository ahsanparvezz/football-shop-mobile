## Tugas 7
 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
    Widget tree seperti struktur keluarga di Flutter. Widget parent punya anak, anak bisa punya cucu. Parent ngatur layout dan sifat anak-anaknya, anak nurut parent-nya. Hubungan parent-child (induk-anak) berarti sebuah widget (parent) berisi dan mengontrol tampilan atau posisi widget lain (child).

 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
    MaterialApp: Root aplikasi, mengatur tema (theme) dan halaman utama (home).

    ShopHomePage (Custom): Widget yang menjadi halaman utama.

    Scaffold: Struktur dasar halaman (menyediakan AppBar dan body).

    AppBar: header atas.

    Text: Menampilkan teks (seperti di judul AppBar atau nama produk).

    Padding: Mengatur Jarak.

    Column: Menyusun children (widget di dalamnya) secara vertikal.

    Row: Menyusun children secara horizontal (digunakan untuk InfoCard).

    InfoCard (Custom): Widget untuk menampilkan NPM, Nama, dan Kelas.

    Card: Kotak dengan bayangan (dipakai di dalam InfoCard).

    SizedBox: Mengatur Jarak.

    Center: Menempatkan child-nya di tengah.

    GridView: Menampilkan daftar item dalam format grid (untuk 3 tombol menu).

    ShopItemCard (Custom): Widget untuk tombol menu.

    Material: Memberi properti visual seperti warna latar dan bentuk (borderRadius).

    InkWell: Membuat child-nya (tombol) bisa diklik (onTap) dan memberi efek riak.

    Icon: Menampilkan ikon (misal Icons.store).

 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
    MaterialApp sebagai widget root karena meng setting  tema, navigasi, dan struktur dasar aplikasi Material Design. Seperti ibaratnya fondasi bangunan.
    Fungsinya adalah menyediakan semua fitur dasar yang diperlukan untuk aplikasi bergaya Material Design, seperti:

        Mengatur Tema (theme): Memberi skema warna dan font default ke seluruh aplikasi.

        Mengatur Navigasi (home atau routes): Mengelola tumpukan layar (halaman).

        Menyediakan Konteks: Dibutuhkan oleh widget Material lain seperti Scaffold, Dialog, dan SnackBar agar bisa berfungsi.

 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
    StatelessWidget (Widget Statis)

    Apa itu: Widget yang tampilannya tidak bisa berubah setelah dibuat. Datanya (properti) bersifat immutable (final).

    Kapan pilih: Untuk UI yang statis, yang tampilannya hanya bergantung pada data yang diterima dari parent-nya. Semua widget di kode kita (ShopHomePage, InfoCard, ShopItemCard) adalah StatelessWidget.

    StatefulWidget (Widget Dinamis)

    Apa itu: Widget yang memiliki State (data internal) yang bisa berubah selama aplikasi berjalan.

    Kapan pilih: Saat UI perlu merespons interaksi pengguna (misal form input, checkbox) atau data yang berubah. Kita memanggil setState() untuk memberi tahu Flutter agar membangun ulang UI-nya.

 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
    BuildContext kayak KTP widget. Penting buat ngakses data theme, navigasi, atau parent widget. Di metode build, Flutter kasih context secara otomatis.

    Sederhananya, ini adalah "alamat" atau "lokasi" dari sebuah widget di dalam widget tree.

    Ini penting karena BuildContext digunakan untuk menemukan widget "leluhur" (di atasnya). Di kode kita, kita menggunakannya untuk:

    ScaffoldMessenger.of(context).showSnackBar(...)

    Ini artinya: "Cari ScaffoldMessenger terdekat dari lokasi (context) ini, dan gunakan itu untuk menampilkan SnackBar."

 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
    Hot Reload (Lebih Cepat) Menyuntikkan kode baru ke aplikasi yang sedang berjalan tanpa me-reset state (data). Sangat cepat dan bagus untuk mengubah tampilan UI (misal ganti warna atau teks).

    Hot Restart (Lebih Lambat) Membangun ulang seluruh aplikasi dari awal. Ini akan me-reset semua state aplikasi (kembali ke halaman awal).

 7. Jelaskan bagaimana kamu menambahkan navigasi untuk berpindah antar layar di aplikasi Flutter.
    Navigasi pake Navigator.push() buka halaman baru, Navigator.pop() tutup halaman. Kaya buka-tutup pintu antar layar.
    

## Tugas 8
1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
Navigator.push() digunakan saat Anda ingin menumpuk halaman baru di atas halaman saat ini, seperti saat membuka detail produk dari daftar, sehingga pengguna bisa menekan tombol "kembali" untuk kembali ke daftar tersebut. Sebaliknya, Navigator.pushReplacement() mengganti halaman saat ini dengan yang baru dan menghapus halaman lama dari riwayat, contohnya seperti setelah pengguna berhasil login atau logout agar mereka tidak bisa kembali ke halaman sebelumnya. Singkatnya, push() dipakai untuk alur yang bisa "kembali" (seperti melihat detail), sedangkan pushReplacement() dipakai untuk alur yang "satu arah" (seperti mengubah status login).

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
aya memanfaatkan Scaffold sebagai "kerangka" atau cetakan dasar di setiap halaman, baik di menu.dart maupun product_form.dart. Scaffold ini praktis karena sudah menyediakan slot standar untuk AppBar di bagian atas dan Drawer untuk menu samping. Kunci konsistensinya adalah saya membuat LeftDrawer menjadi satu widget terpisah (left_drawer.dart). Widget ini kemudian saya "pasang" di properti drawer pada Scaffold di setiap halaman. Hasilnya, menu navigasi di seluruh aplikasi saya jadi identik dan terkelola dari satu file saja.

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
Kelebihan utamanya adalah untuk mengatur kerapian visual dan, yang terpenting, menghindari error "overflow". Di file product_form.dart saya, setiap TextFormField (seperti Nama dan Harga) saya bungkus dengan Padding untuk memberi "ruang napas" agar form tidak menempel ke pinggir layar. Nah, widget yang paling krusial adalah SingleChildScrollView. Saya membungkus seluruh Column yang berisi elemen form saya dengan widget ini. Tujuannya jelas: saat keyboard HP muncul, layar 'kan jadi sempit. Tanpa SingleChildScrollView, field di bagian bawah atau tombol "Simpan" tidak akan bisa diakses dan aplikasi akan error. Dengan widget ini, form saya jadi bisa di-scroll dengan aman.

4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
Saya mengaturnya secara terpusat di file main.dart, tepat di dalam widget MaterialApp. Di situ ada properti theme, yang saya isi dengan ThemeData. Dengan menentukan colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue), saya memberi tahu Flutter bahwa biru adalah warna utama brand saya. Secara otomatis, AppBar di semua halaman menjadi biru, dan ElevatedButton (tombol "Simpan") di halaman form juga menggunakan warna biru yang sama. Ini adalah cara yang efisien untuk memastikan identitas visual toko saya konsisten tanpa harus mengatur warna di tiap widget satu per satu.

## Tugas 9
1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?
   Membuat model Dart itu penting karena memberikan type safety dan struktur data yang jelas saat bekerja dengan JSON. Kalau langsung pakai Map<String, dynamic>, kita gak ada jaminan tipe data yang benar, bisa aja field-nya null atau typo, dan kodenya jadi lebih sulit dibaca dan di-maintain karena harus ingat struktur manual setiap kali akses data.

2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.
   Package http bertugas melakukan HTTP request dasar seperti GET/POST, sedangkan CookieRequest dari pbp_django_auth khusus menangani autentikasi dengan menyimpan dan mengirim cookie session secara otomatis ke Django. Jadi http hanya komunikasi biasa, sementara CookieRequest sudah built-in untuk urusan login/logout dan maintain session.

3. Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
   Instance CookieRequest perlu dibagikan ke semua komponen agar seluruh bagian aplikasi dapat mengakses status login dan data autentikasi pengguna yang sama. Dengan cara ini, setiap halaman bisa melakukan permintaan ke backend tanpa perlu login ulang atau membuat koneksi baru. Jika setiap komponen memiliki instance CookieRequest sendiri, maka cookie dan sesi pengguna tidak akan sinkron, sehingga autentikasi bisa gagal atau data pengguna tidak konsisten di antara halaman.

4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
   Kita perlu konfigurasi ini karena Flutter di emulator/device berjalan di environment terisolasi. 10.0.2.2 adalah alias localhost di emulator Android, CORS diperlukan karena Flutter dan Django beda origin, SameSite agar cookie bisa dikirim cross-origin, dan izin internet untuk permission Android. Tanpa konfigurasi ini, request akan gagal total karena blocked oleh CORS policy, cookie tidak tersimpan, atau koneksi ditolak.

5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
   Data diinput user di form Flutter, divalidasi, lalu dikirim via HTTP POST request ke endpoint Django yang sesuai. Django memproses data, menyimpannya ke database, dan mengembalikan response JSON. Flutter menerima response, mem-parsing JSON menjadi model Dart, lalu menampilkannya di UI menggunakan Widget seperti ListView atau Card.

6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
   User input credentials di Flutter yang dikirim ke endpoint auth Django. Django memverifikasi data, membuat session dan mengirim cookie session kembali. Flutter menyimpan cookie via CookieRequest, dan status loggedIn menjadi true sehingga menu utama bisa diakses. Untuk logout, Flutter mengirim request logout ke Django yang menghapus session, dan cookie dihapus sehingga user kembali ke halaman login.

7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).

-- Checklist 1: Memastikan deployment proyek tugas Django kamu telah berjalan dengan baik.
= Dengan cara mengecek web proyek tugas Django dan dari local apakah ada kendala atau tidak

-- Checklist 2 dan 3 dan 4: Mengimplementasikan fitur registrasi akun pada proyek tugas Flutter.
Membuat halaman login pada proyek tugas Flutter.
Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter.
= Pertama tama Mengintegrasikan Integrasi Autentikasi Django-Flutter
Seperti membuat veiwsnya dan melakukan routing di urls
Integrasi sistem autentikasi dengan menginstall package yang diperlukan
flutter pub add provider
Dan flutter pub add pbp_django_auth
Kemudian mengubah main.dart menggunakan provider
Kemudian membuat file baru login di screens
Isi file login.dart tersebut
Ubah menjadi home: const LoginPage() di main.dart
Tambahkan views register di project django authentication dan pathnya
Buat file register.dart di flutter proyek
Import hal hal yang diperlukan di file2 tersebut

-- Checklist 5: Membuat model kustom sesuai dengan proyek aplikasi Django.
Pertama buka json file django
Kemudian copy dan paster ke quickstype disesuaikan dengan dart kemudian masukan ke folder models, dan file product_entry.dart

-- Checklist 6 dan 7: Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy.
Pertama add dlu flutter pub add http
Tambahkan <uses-permission android:name="android.permission.INTERNET" /> di AndroidManifest.xml
Pada proyek djanogo buat function dan import package yang dibutuhkan
Di flutter buat file baru product_entry_card.dart, dan masukan deskripsi product yang disesuaikan dengan json
Tambahakn ke left drawer untuk Product List
Dan tambahklan juga di shop_card untuk product list

-- Checklist 8, 9, 10, 11:
Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item.
 Halaman ini dapat diakses dengan menekan salah satu card item pada halaman daftar Item.
 Tampilkan seluruh atribut pada model item kamu pada halaman ini.
 Tambahkan tombol untuk kembali ke halaman daftar item.
Pertama buat file product_detail.dart dan isi sesuai dengan models
Tambahkan ontap pada product_entry_list.dart
Tombol back akan muncul otomatis di AppBar ketika menggunakan Navigator.push dari halaman daftar produk.

-- Checklist 12: Melakukan filter pada halaman daftar item dengan hanya menampilkan item yang terasosiasi dengan pengguna yang login.
Menambahkan Endpoint Filter di django, Endpoint menerima parameter filter via GET request
Jika filter='my_products' dan user sudah login → tampilkan hanya produk milik user tersebut
Jika filter='all' → tampilkan semua produk
Menambahkan Filter UI di flutter, State currentFilter menyimpan filter aktif ('my_products' atau 'all')
Method fetchProducts() mengirim parameter filter ke backend
Method _changeFilter() mengubah filter dan refresh data
User klik tombol "My Products" atau "All Products"
Trigger _changeFilter() yang akan fetch data dengan filter baru
Menyimpan User saat Create Product
Saat user membuat produk baru, otomatis tersimpan dengan user_id milik user yang login
Produk ini nantinya bisa difilter dengan Product.objects.filter(user=request.user)










