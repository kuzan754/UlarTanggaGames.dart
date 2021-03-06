import 'dart:math';
import 'dart:collection';
import 'dart:html';

/// Kelas ini merupakan kelas yang mempresentasikan sebuah tile yang ada pada board permainan
/// ular tangga.
class Tile {

    /// Atribut yang bersifat private ini digunakan untuk index
    int _index;
    
    /// Atribut yang bersifat private ini yang akan dihubungkan ke html(lewat querySelector).
    String _id;
    
    /// Atribut yang bersifat private ini digunakan untuk memindahkan pemain ketika menemukan ular / tangga.
    Teleporter _tele;
    
    /// Constructor dari kelas Tile
    /// Constructor kelas Tile digunakan untuk mendapatkan nilai atribut index dan id yang diisi dari tester
    /// [index] merupakan nilai index
    /// [id] merupakan sebuah String yang akan digunakan pada Html, dipanggil oleh querySelector.
    Tile(int index,String id){
        this._index = index;
      	this._id = id;
    }

    /// Method ini digunakan untuk mendapatkan nilai dari atribut _tele	
    Teleporter getTele() {
        return _tele;
    }

    /// Method ini digunakan untuk memberikan nilai atribut _tele yang diset dari parameter
    void setTele(Teleporter tele) {
        this._tele = tele;
    }
    
    /// Method ini digunakan untuk mendapatkan nilai index 
    int getIndex(){
        return this._index;
    }
  
    /// Method ini digunakan untuk mendapatkan string dari id
    String getId(){
      	return this._id;
    }
  
    /// Method ini digunakan untuk memberikan nilai dari atribut id menjadi seperti nilai id yang ada di parameter.
    /// [id] merupakan id yang diset dari tester
    void setId(String id){
      	this._id = id;
    }
    
    /// Method ini digunakan untuk menteleportasi pemain ketika pemain menemukan
    /// ular / tangga, sehingga pemain menjadi berpindah tempat
    /// return tempat setelah diteleportasi jika atribut _tele bernilai tidak null
    /// return index pemain jika atribut _tele bernilai null
    int teleport(){
        if(this._tele != null){
            return this._tele.getTo();
        }
        else{ 
            return this._index;
        }
    }
}

/// Kelas Dice merupakan dadu yang digunakan pada permainan ular tangga
class Dice {
	
    /// Method ini merupakan method static yang akan menangani nilai random yang keluar ketika dadu dilempar 
    /// dari angka 1 sampai 6 yang digunakan untuk menentukan jumlah langkah pemain.
    static int randomDice(){
        Random rnd = new Random();
        return 1 + rnd.nextInt(6);
    }
}

///Kelas abstract untuk menangani Ular dan Tangga.
abstract class Teleporter {
    
    ///Atribut untuk mengetahui nomor urut pasangan Ular atau Tangga
    int _identifier;
    
    ///Atribut untuk mengetahui posisi awal dari ular atau tangga
    int _from;

    ///Atribut untuk mengetahui posisi akhir ular atau tangga
    int _to;
    
    ///Constructor kelas Teleporter.
    /// [from] merupakan posisi awal dari Ular atau Tangga.
    /// [to] merupakan posisi akhir dari Ular atau Tangga.
    /// [identifier] sebuah integer untuk mengetahui nomor urut pasangan Ular atau Tangga.
    Teleporter(int from,int to,int identifier){
        this._identifier = identifier;
        this._from = from;
        this._to = to;
    }
    
    ///Method getter untuk from.
    int getFrom() {
        return _from;
    }

    ///Method getter untuk to.
    int getTo() {
        return _to;
    }
    
    ///Method getter untuk identifier.
    int getIdentifier(){
        return _identifier;
    }
}

/// Kelas Snake yang merupakan turunan kelas Teleporter.
/// Kelas yang digunakan sebagai ular pada Game Ular Tangga.
class Snake extends Teleporter{
    
    /// Constructor dari kelas Snake.
    /// COnstructor kelas Snake memanggil Constructor Kelas Teleporter(Super Classnya).
    /// [from] merupakan posisi awal Kepala Ular.
    /// [to] merupakan posisi akhir Ular.
    /// [identifier] sebuah integer untuk mengetahui nomor urut pasangan Ular.
    Snake(int from, int to,int identifier) : super(from, to,identifier);
}

/// Kelas Stair yang merupakan turunan kelas Teleporter.
/// Kelas yang digunakan sebagai Tangga pada Game Ular Tangga.
class Stair extends Teleporter{
    
    /// Constructor dari kelas Stair.
    /// Constructor kelas Stair memanggil Constructor Kelas Teleporter(Super Classnya).
    /// [from] merupakan posisi awal tangga.
    /// [to] merupakan posisi akhir tangga.
    /// [identifier] sebuah integer untuk mengetahui nomor urut pasangan Tangga.
    Stair(int from, int to,int identifier) : super(from, to, identifier);
}

/// Kelas Player mendefinisikan pemain.
/// Kelas Player merupakan induk dari kelas HumanPlayer dan ComputerPlayer.
/// Kelas Player merupakan kelas absract.
abstract class Player {
	
    /// Atribut curPosition tipe integer bersifat private.	
    int _curPosition;
    /// Atribut name tipe String bersifat private.
    String _name;
    /// Atribut symbol tipe String bersifat private.
    String _symbol;

    /// Constructor kelas Player memiliki parameter String name dan String symbol.
    /// Constructor kelas Player berfungsi untuk mengisi value baru kepada atribut-atributnya.
    Player(String name,String symbol) {
        this._curPosition = 0;
        this._name = name;
        this._symbol = symbol;
    }

    /// Method getSymbol tipe String tidak memiliki parameter.
    /// Method getSymbol memiliki return value String.
    /// Method berfungsi untuk mengembalikan value player berupa simbol/icon.
    String getSymbol() {
        return this._symbol;
    }
    
    /// Method getCurPosition tipe int tidak memiliki parameter.
    /// Method getCurPosition memiliki return value int.
    /// Method berfungsi untuk mengembalikan value player berupa dimana posisi terakhir setelang melangkah.
    int getCurPosition() {
        return this._curPosition;
    }

     /// Method setCurPosition tipe bool memiliki parameter int curPosition dan int turn.
     /// Method setCurPosition memiliki return value berupa true/false.
     /// Method ini akan dipanggil di kelas games.html.
    bool setCurPosition(int curPosition, int turn) {
        this._curPosition = curPosition;
      	if(turn==0)querySelector("#posP1").text = querySelector("#posP1").text.substring(0,9)+" "+this.getCurPosition().toString();
      	else if(turn==1)querySelector("#posP2").text = querySelector("#posP2").text.substring(0,9)+" "+this.getCurPosition().toString();
      	if(this._curPosition==100)return true;
      	return false;
    }
    
    /// Method getName tipe String tidak memiliki parameter.
    /// Method getName memiliki return value String.
    /// Method berfungsi sebagai pengenal nama player.
    String getName() {
        return _name;
    }
    
    /// Method move tipe void memiliki parameter int plus dan int turn.  
    /// Method move merupakan method abstract. 
    void move(int plus,int turn);
}

/// Kelas HumanPlayer merupakan kelas yang mendefinisikan player adalah manusia. 
/// Kelas HumanPlayer merupakan turunan dari kelas Player.
class HumanPlayer extends Player{
	
    /// Constructor kelas HumanPlayer memiliki parameter yang sama dengan induk kelasnya.	
    HumanPlayer(String name,String symbol) : super(name,symbol);
     
    /// Method move merupakan method override dari kelas Player.
    /// Method move meiliki parameter yang sama dengan method move pada kelas Player.
    @override
    void move(int input,int turn){
        if(this.setCurPosition((this.getCurPosition()+input),turn)==true)querySelector('#rollButton').remove();
    }
}

/// Kelas ComputerPlayer merupakan kelas yang mendefinisikan player adalah komputer. 
/// Kelas ComputerPlayer merupakan turunan dari kelas Player.
class ComputerPlayer extends Player{
	
    /// Constructor kelas HumanPlayer memiliki parameter yang sama dengan induk kelasnya.
    ComputerPlayer(String name,String symbol): super(name,symbol);
    
    /// Method move merupakan method override dari kelas Player.
    /// Method move meiliki parameter yang sama dengan method move pada kelas Player.
    @override
    void move(int input,int turn){
        this.setCurPosition((this.getCurPosition()+input),turn);
    }
}

/// Kelas Board mendefinisikan tempat atau map dari permainan Snakes and Strairs.
/// Kelas Board merupakan kelas yang menjadi tempat penggabungan semua kelas.
class Board {
    ///atribut array yang bertipe tile yang berguna untuk mensimulasikan board
    List<Tile> _tiles = new List<Tile>();//array
    ///atribut array bertipe string yang berguna untuk menghubungkan tile yang ada dalam board dengan tampilan yang ada di html
    List<String> _boardId = new List<String>();
    ///array bertipe player yang berguna untuk menyimpan player yang akan main
    List<Player> _p = new List<Player>();//array
    ///array bertipe snake yang berguna untuk menyimpan posisi ular-ular di papan
    List<Snake> _snakes = new List<Snake>();//array
    ///array bertipe stair yang berguna untuk menyimpan posisi tangga-tangga di papan
    List<Stair> _stairs = new List<Stair>();//array
    Player _winner;
    
    ///konstrukter kedua
    ///[p1] parameter bertipe Player sebagai player 1.
    ///[p2] parameter bertipe Player sebagai player 2.
    ///[oldB] parameter bertipe Board
    Board.copy(Player p1, Player p2, Board oldB){
      	this._p.add(p1);
      	this._p.add(p2);
      	querySelector("#fPlayer").text = querySelector("#fPlayer").text.substring(0,13)+" "+_p[0].getName();
      	querySelector("#sPlayer").text = querySelector("#sPlayer").text.substring(0,14)+" "+_p[1].getName();
      	querySelector("#posP1").text = querySelector("#posP1").text.substring(0,9)+" "+_p[0].getCurPosition().toString();
      	querySelector("#posP2").text = querySelector("#posP2").text.substring(0,9)+" "+_p[1].getCurPosition().toString();
      	this._tiles = oldB.getTiles();
      	this._boardId = oldB.getId();
      	this._snakes = oldB.getSnakes();
      	this._stairs = oldB.getStairs();
      	this._winner = oldB.getWinner();
    }
  
    ///Constructor dari Kelas Board.
    ///[p1] parameter bertipe Player sebagai player 1.
    ///[p2] parameter bertipe Player sebagai player 2.
    Board(Player p1, Player p2) {
      	///inisialisasi id
      	for(int i=1;i<=100;i++){
          _boardId.add('#t'+i.toString());
        }
        this._p.add(p1);
        this._p.add(p2);
      	querySelector("#fPlayer").text = querySelector("#fPlayer").text.substring(0,13)+" "+_p[0].getName();
      	querySelector("#sPlayer").text = querySelector("#sPlayer").text.substring(0,14)+" "+_p[1].getName();
      	querySelector("#posP1").text = querySelector("#posP1").text.substring(0,9)+" "+_p[0].getCurPosition().toString();
      	querySelector("#posP2").text = querySelector("#posP2").text.substring(0,9)+" "+_p[1].getCurPosition().toString();
        for(int i=1;i<=100;i++){
            _tiles.add(new Tile(i,this._boardId[i-1]));
        }
        Random rnd = new Random();
        List<int> randIndex = _randomize(rnd);
        int countSnake = 0;
        int countStair = 0;
        for(int i=0;i<16;i++){
            if(i%2==0){
                _snakes.add(new Snake(randIndex[i+16],randIndex[i],countSnake));
              	this._tiles[this._snakes[countSnake].getTo()-1].setTele(this._snakes[countSnake]);
              	querySelector(this._tiles[this._snakes[countSnake].getTo()-1].getId()).style.backgroundImage = 'url(https://media.giphy.com/media/113681pulhNN1m/giphy.gif)';
              	querySelector(this._tiles[this._snakes[countSnake].getTo()-1].getId()).style.backgroundSize = 'cover';
              	this._tiles[this._snakes[countSnake].getFrom()-1].setTele(this._snakes[countSnake]);
              	querySelector(this._tiles[this._snakes[countSnake].getFrom()-1].getId()).style.backgroundImage = 'url(https://media.giphy.com/media/113681pulhNN1m/giphy.gif)';
              	querySelector(this._tiles[this._snakes[countSnake].getFrom()-1].getId()).style.backgroundSize = 'cover';
                countSnake++;
            }
            else if(i%2==1){
                _stairs.add(new Stair(randIndex[i],randIndex[i+16],countStair));
              	this._tiles[this._stairs[countStair].getFrom()-1].setTele(this._stairs[countStair]);
              	querySelector(this._tiles[this._stairs[countStair].getFrom()-1].getId()).style.backgroundImage = 'url(http://quintessentialpublications.com/twyman/wp-content/uploads/TrippyTrance.gif)';
              	querySelector(this._tiles[this._stairs[countStair].getFrom()-1].getId()).style.backgroundSize = 'cover';
             	this._tiles[this._stairs[countStair].getTo()-1].setTele(this._stairs[countStair]);
              	querySelector(this._tiles[this._stairs[countStair].getTo()-1].getId()).style.backgroundImage = 'url(http://quintessentialpublications.com/twyman/wp-content/uploads/TrippyTrance.gif)';
              	querySelector(this._tiles[this._stairs[countStair].getTo()-1].getId()).style.backgroundSize = 'cover';
                countStair++;
            }
       }
    }
    
    ///method ini berguna untuk merandom penempatan stair atau snake
    List<int> _randomize(Random rnd) {
        HashSet<int> set = new HashSet<int>();
        List<int> random = new List<int>();//32
        int randomized = 0;
        while (randomized < 32) {
            int value = 1 + rnd.nextInt(99);
            if (set.add(value)) {
                random.add(value);
              	randomized++;
            }
        }
        random.sort();
        return random;
    }
    
    ///Getter untuk atribut _tiles.
    List<Tile> getTiles() {
        return _tiles;
    }
  
    ///Getter untuk atribut _snakes.
    List<Snake> getSnakes(){
      	return this._snakes;
    }
  
    ///Getter untuk atribut _stairs.
    List<Stair> getStairs(){
      	return this._stairs;
    }
  
    ///Getter untuk atribut _winner.
    Player getWinner(){
      	return this._winner;
    }
  
    ///Getter untuk atribut _boardId.
    List<String> getId(){
        return this._boardId;
    }

    ///Getter untuk atribut _p.
    List<Player> getP() {
        return _p;
    }
    
    ///method ini berguna untuk menggerakan player dari tempat sebelumnya ke tempat yang dituju sesuai besar angka dadu
    ///[turn] parameter bertipe int
    bool movePlayer(int turn){
      int plus = Dice.randomDice();
      int curPos = this._p[turn].getCurPosition()+plus;
      if(curPos>100){
         int selisih = curPos-100;
         curPos = 100-selisih;
      }
      querySelector("#diceValue").text = querySelector("#diceValue").text.substring(0,11)+" "+plus.toString(); this._p[turn].move((curPos),turn);
      if(this._p[turn].setCurPosition((this._tiles[curPos-1].teleport()),turn)==true)querySelector('#rollButton').remove();
      if(plus==6){
         return true;
      }
      else return false;
    }
    
    ///method ini berguna untuk memulai permainan
    void play(){
        bool flag = false;
        while(isStillPlayable()){
            int i=0;
            while((i<_p.length)&&(isStillPlayable())){
                
                int plus = Dice.randomDice();
              	querySelector("#cur").text = querySelector("#cur").text.substring(0,14)+" "+_p[i].getName();
                _p[i].move(plus,i);
                if(_p[i].getCurPosition()>100){
                    int selisih = _p[i].getCurPosition()-100;
                    _p[i].setCurPosition((100-selisih),i);
                }
              	Tile currentTile = this._tiles[this._p[i].getCurPosition()-1];
              	_p[i].setCurPosition((currentTile.teleport()),i);
              	querySelector("#diceValue").text = querySelector("#diceValue").text.substring(0,11)+" "+plus.toString();
             		querySelector("#posP1").text = querySelector("#posP1").text.substring(0,9)+" "+_p[0].getCurPosition().toString();
      					querySelector("#posP2").text = querySelector("#posP2").text.substring(0,9)+" "+_p[1].getCurPosition().toString();
                
                if(plus!=6){
                    i++;
                    flag = false;
                }
                else if(plus==6){
                    if(flag==true){
                        i++;
                        flag = false;
                    }
                    else flag = true;
                }
            }
        }
        querySelector('#winner').text = this._winner.getName()+" WIN!";
    }
    
    ///method ini berguna untuk mengecek apakah permainan masih dapat dimainkan, bila sudah sampai finish maka akan mengeluarkan false
    bool isStillPlayable(){
        if(_p[0].getCurPosition()==100){
            _winner = _p[0];
            return false;
        }
        else if(_p[1].getCurPosition()==100){
            _winner = _p[1];
            return false;
        }
        else return true;
    }
}

///Method main.
void main(){
   Board b = new Board(new HumanPlayer("",'o'),new HumanPlayer("",'x'));
   querySelector('#startButton').onClick.listen((_) => b=start(b));
   int turn = 0;
   if(b!=null)querySelector("#cur").text = querySelector("#cur").text.substring(0,14)+" "+b.getP()[turn].getName();
   if(b!=null)querySelector('#rollButton').onClick.listen((_) => turn = helper(b,turn));
}

///Method untuk merespond start button. Dibuat di luar kelas karena termasuk dalam kelas tester.
///[b] Merupakan Board yang sedang dimainkan saat ini.
///Mengembalikan Board beserta player-player yang bermain.
Board start(Board b){
   bool cvc = false;
   Player p1;
   InputElement pa = querySelector("#inputP1");
   InputElement pb = querySelector("#inputP2");
   String namaP1 = pa.value;
   String namaP2 = pb.value;
   if(namaP1=="auto"){
      p1 = new ComputerPlayer("CP1",'x');
      cvc = true;
  }
  else{
      p1 = new HumanPlayer(namaP1,'x');
  }
  Player p2;
  if(namaP2=="auto"){
      p2 = new ComputerPlayer("CP2",'o');
  }
  else{
      p2 = new HumanPlayer(namaP2,'o');
  }
  b = new Board.copy(p1,p2,b);
  if(cvc==true){
      b.play();
    if(b.getP()[0].getCurPosition()>0)querySelector(b.getId()[b.getP()[0].getCurPosition()-1]).text = "o";
  	if(b.getP()[1].getCurPosition()>0)querySelector(b.getId()[b.getP()[1].getCurPosition()-1]).text = "x";
    querySelector('#rollButton').remove();
  }
  querySelector('#startButton').remove();
  querySelector('#inputP1').remove();
  querySelector('#inputP2').remove();
  return b;
}

///Method untuk merespond event onClick dari rollButton. Berada di luar kelas karena merupakan method dalam kelas tester.
///[b] Board yang sedang dimainkan.
///[turn] giliran saat ini.
///Mengembalikan turn selanjutnya
int helper(Board b,int turn){
  if(b.getP()[turn].getCurPosition()>0)querySelector(b.getId()[b.getP()[turn].getCurPosition()-1]).text = "";
  bool isGetSix = b.movePlayer(turn);
  if(b.getP()[0].getCurPosition()>0)querySelector(b.getId()[b.getP()[0].getCurPosition()-1]).text = "o";
  if(b.getP()[1].getCurPosition()>0)querySelector(b.getId()[b.getP()[1].getCurPosition()-1]).text = "x";
  if(b.getP()[0].getCurPosition()==100){
    querySelector('#winner').text = b.getP()[0].getName()+" WIN!";
  }
  else if(b.getP()[1].getCurPosition()==100){
    querySelector('#winner').text = b.getP()[1].getName()+" WIN!";
  }
  if(turn==0)querySelector("#cur").text = querySelector("#cur").text.substring(0,14)+" "+b.getP()[1].getName();
  else querySelector("#cur").text = querySelector("#cur").text.substring(0,14)+" "+b.getP()[0].getName();
  if(isGetSix==true)return turn;
  if(turn==0)return 1;
  else return 0;
}
