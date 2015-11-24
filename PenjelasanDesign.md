Penjelasan design

Game ular tangga ini kami design menggunakan 3 jenis design yaitu, Model View Control (MVC) dan Open Closed Principle. Kedua design yang kami buat itu akan kami jelaskan sebagai berikut ini :

1.) Model View Control (MVC).
MVC merupakan design program yang memisahkan antara model, view, dan controller. 
Pada program ular tangga yang kami buat, kami menerapkan prinsip MVC. 
Model-model yang berupa kelas Player(dan turunanya), Teleporter(dan turunanya), Board, dan Tile terpisah 
implementasinya dengan viewnya yaitu CSS(Style) dan HTML(Struktur). 
Controller pada program ini adalah main methodnya, dimana main method tersebut menghubungkan model dengan viewnya sehingga view 
tidak mengakses model secara langsung. Dengan menggunakan method querySelector() yang didapat dengan mengimport dart:html, 
kita dapat menghubungkan model dengan view dengan cara mendapatkan element yang ingin diubah. 

2.) Open Closed-Principle (OCP).
Selain menggunakan desain MCV, kami juga menggunakan design Open Closed Principle, karena OCP didefinisikan dengan “open for extention, closed for modification” maka design pada game ini kami buat seperti itu, contohnya kita dapat mengextention kelas – kelas yang bersifat interface atau abstrak, sehingga jika kita mau menambahkan fitur baru, kita tidak perlu memodifikasi code yang sudah ada, contohnya seperti kelas abstrak Player pada gambar dibawah ini. 

![alt text] (http://imageshack.com/a/img633/295/vRGUvd.png "Kelas")

Pada kelas tersebut kita mempunyai method – method yang menangani beberapa perintah, kemudian ada HumanPlayer 
dan ComputerPlayer yang mana mengextends kelas Player pasti kelas HumanPlayer dan ComputerPlayer menangani masalahnya 
dengan cara yang berbeda, sehingga HumanPlayer dan ComputerPlayer juga harus mengoverride method – method yang berbentuk 
abstract, jadi jika kita ingin menambahkan jenis pemain lain kita tidak perlu memodifikasi kelas Player, hanya tinggal 
membuat kelas baru yang akan mengextends kelas Player dan meng-override method abstrak yang ada pada kelas Player tersebut. 
Karena dengan tertutupnya code yang sudah ada dari modifikasi maka kemungkinan terjadinya bug karena kita melakukan suatu 
perubahan terhadap code yang sudah ada pun dapat dihindari. Dengan sifatnya yang “open for extention”, maka code yang kita 
buat dapat digunakan berulang. Melakukan extends atau implements pada kelas lalu meng-override methodnya merupakan 
salah satu bentuk OCP.

