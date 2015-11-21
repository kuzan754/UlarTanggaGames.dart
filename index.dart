import 'dart:math';
import 'dart:collection';
import 'dart:html';

/// Kelas ini merupakan kelas yang mempresentasikan sebuah tile yang ada pada board permainan
/// ular tangga.
class Tile {

    /// Atribut ini digunakan untuk index
    int _index;
    String _id;
    Teleporter _tele;
    
    /// Constructor dari kelas Tile
    /// Constructor kelas Tile digunakan untuk mendapatkan nilai atribut index dan id yang diisi dari tester
    /// [index] merupakan nilai index
    /// [id] merupakan 
    Tile(int index,String id){
        this._index = index;
      	this._id = id;
    }

	
    Teleporter getTele() {
        return _tele;
    }

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
	
    /// Method ini merupakan method static yang akan menangani nilai random yang keluar
    /// dari dadu yang akan digunakan untuk menjalankan langkah sebuah pion
    static int randomDice(){
        Random rnd = new Random();
        return 1 + rnd.nextInt(6);
    }
}

abstract class Teleporter {
    int _identifier;
    int _from;
    int _to;
    
    Teleporter(int from,int to,int identifier){
        this._identifier = identifier;
        this._from = from;
        this._to = to;
    }

    int getFrom() {
        return _from;
    }

    int getTo() {
        return _to;
    }
    
    int getIdentifier(){
        return _identifier;
    }
}

/// Kelas Snake yang merupakan turunan kelas Teleporter.
/// Kelas yang digunakan sebagai ular pada Game Ular Tangga.
class Snake extends Teleporter{
    
    /// Constructor dari kelas Snake.
    /// COnstructor kelas Snake memanggil Constructor Kelas Teleporter(Super Classnya).
    /// [from] merupakan nilai awal atau Kepala Ular.
    /// [to] merupakan nilai akhir atau Ekor Ular.
    Snake(int from, int to,int identifier) : super(from, to,identifier);
}

/// Kelas Stair yang merupakan turunan kelas Teleporter.
/// Kelas yang digunakan sebagai Tangga pada Game Ular Tangga.
class Stair extends Teleporter{
    
    /// Constructor dari kelas Stair.
    /// Constructor kelas Stair memanggil Constructor Kelas Teleporter(Super Classnya).
    /// [from] merupakan nilai awal atau titik awal tangga.
    /// [to] merupakan nilai akhir atau titik akhir tangga.
    Stair(int from, int to,int identifier) : super(from, to, identifier);
}

abstract class Player {
	
    int _curPosition;
    String _name;
    String _symbol;

    Player(String name,String symbol) {
        this._curPosition = 0;
        this._name = name;
        this._symbol = symbol;
    }

    String getSymbol() {
        return this._symbol;
    }
    
    int getCurPosition() {
        return this._curPosition;
    }

    bool setCurPosition(int curPosition, int turn) {
        this._curPosition = curPosition;
      	if(turn==0)querySelector("#posP1").text = querySelector("#posP1").text.substring(0,9)+" "+this.getCurPosition().toString();
      	else if(turn==1)querySelector("#posP2").text = querySelector("#posP2").text.substring(0,9)+" "+this.getCurPosition().toString();
      	if(this._curPosition==100)return true;
      	return false;
    }

    String getName() {
        return _name;
    }
    
    void move(int plus,int turn);
}

class HumanPlayer extends Player{
	
     HumanPlayer(String name,String symbol) : super(name,symbol);
    
    @override
    void move(int input,int turn){
        if(this.setCurPosition((this.getCurPosition()+input),turn)==true)querySelector('#rollButton').remove();
    }
}

class ComputerPlayer extends Player{
    ComputerPlayer(String name,String symbol): super(name,symbol);
    
    
    @override
    void move(int input,int turn){
        this.setCurPosition((this.getCurPosition()+input),turn);
    }
}

class Board {
	
    List<Tile> _tiles = new List<Tile>();//array
    List<String> _boardId = new List<String>();
    List<Player> _p = new List<Player>();//array
    List<Snake> _snakes = new List<Snake>();//array
    List<Stair> _stairs = new List<Stair>();//array
    Player _winner;
  	
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
    
    List<Tile> getTiles() {
        return _tiles;
    }
  
    List<Snake> getSnakes(){
      	return this._snakes;
    }
  
    List<Stair> getStairs(){
      	return this._stairs;
    }
  
    Player getWinner(){
      	return this._winner;
    }
  
    List<String> getId(){
        return this._boardId;
    }

    List<Player> getP() {
        return _p;
    }
    
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

void main(){
   Board b = new Board(new HumanPlayer("",'o'),new HumanPlayer("",'x'));
   querySelector('#startButton').onClick.listen((_) => b=start(b));
   int turn = 0;
   if(b!=null)querySelector("#cur").text = querySelector("#cur").text.substring(0,14)+" "+b.getP()[turn].getName();
   if(b!=null)querySelector('#rollButton').onClick.listen((_) => turn = helper(b,turn));
}

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

int helper(Board b,int turn){
  if(b.getP()[turn].getCurPosition()>0)querySelector(b.getId()[b.getP()[turn].getCurPosition()-1]).text = "";
  if(turn==0)querySelector("#cur").text = querySelector("#cur").text.substring(0,14)+" "+b.getP()[1].getName();
  else querySelector("#cur").text = querySelector("#cur").text.substring(0,14)+" "+b.getP()[0].getName();
  bool isGetSix = b.movePlayer(turn);
  if(b.getP()[0].getCurPosition()>0)querySelector(b.getId()[b.getP()[0].getCurPosition()-1]).text = "o";
  if(b.getP()[1].getCurPosition()>0)querySelector(b.getId()[b.getP()[1].getCurPosition()-1]).text = "x";
  if(b.getP()[0].getCurPosition()==100){
    querySelector('#winner').text = b.getP()[0].getName()+" WIN!";
  }
  else if(b.getP()[1].getCurPosition()==100){
    querySelector('#winner').text = b.getP()[1].getName()+" WIN!";
  }
  if(isGetSix==true)return turn;
  if(turn==0)return 1;
  else return 0;
}
