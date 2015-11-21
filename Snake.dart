/// Kelas Snake yang merupakan turunan kelas Teleporter.
/// Kelas yang digunakan sebagai ular pada Game Ular Tangga.
class Snake extends Teleporter{
    
    /// Constructor dari kelas Snake.
    /// COnstructor kelas Snake memanggil Constructor Kelas Teleporter(Super Classnya).
    /// [from] merupakan nilai awal atau Kepala Ular.
    /// [to] merupakan nilai akhir atau Ekor Ular.
    Snake(int from, int to,int identifier) : super(from, to,identifier);
}
