/// Kelas Stair yang merupakan turunan kelas Teleporter.
/// Kelas yang digunakan sebagai Tangga pada Game Ular Tangga.
class Stair extends Teleporter{
    
    /// Constructor dari kelas Stair.
    /// Constructor kelas Stair memanggil Constructor Kelas Teleporter(Super Classnya).
    /// [from] merupakan nilai awal atau titik awal tangga.
    /// [to] merupakan nilai akhir atau titik akhir tangga.
    Stair(int from, int to,int identifier) : super(from, to, identifier);
}
