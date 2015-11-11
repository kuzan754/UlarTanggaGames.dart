class Board {
    List<Tile> _tiles = new List<Tile>();//array
    List<Player> _p = new List<Player>();//array
    List<Snake> _snakes = new List<Snake>();//array
    List<Stair> _stairs = new List<Stair>();//array
    Player _winner;

    Board(Player p1, Player p2) {
        _p[0] = p1;
        _p[1] = p2;
        for(int i=1;i<=100;i++){
            _tiles.add(new Tile(i));
        }
        Random rnd = new Random();
        List<int> randIndex = _randomize(rnd);
        int countSnake = 0;
        int countStair = 0;
        for(int i=0;i<16;i++){
            if(i%2==0){
                _snakes.add(new Snake(randIndex[i+16],randIndex[i],countSnake));
                for(int j=0;j<100;j++){
                        if((_tiles[j].getIndex()==_snakes[countSnake].getTo())||(_tiles[j].getIndex()==_snakes[countSnake].getFrom())){
                            _tiles[j].setTele(_snakes[countSnake]);
                        }
                    }
                countSnake++;
        		}
            else if(i%2==1){
                _stairs.add(new Stair(randIndex[i],randIndex[i+16],countStair));
                    for(int j=0;j<100;j++){
                        if((_tiles[j].getIndex()==_stairs[countStair].getTo())||(_tiles[j].getIndex()==_stairs[countStair].getFrom())){
                            _tiles[j].setTele(_stairs[countStair]);
                        }
                    }
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
                random[randomized++] = value;
            }
        }
        random.sort();
        return random;
    }
    
    List<Tile> getTiles() {
        return _tiles;
    }

    List<Player> getP() {
        return _p;
    }
    
    void play(){
        bool flag = false;
        while(isStillPlayable()){
            int i=0;
            while((i<_p.length)&&(isStillPlayable())){
                
                int plus = Dice.randomDice();
                _p[i].move(plus);
                
                if(_p[i].getCurPosition()>100){
                    int selisih = _p[i].getCurPosition()-100;
                    _p[i].setCurPosition(100-selisih);
                }
                
                Tile currentTile = null;
                for(int j=0;j<_tiles.length;j++){
                        if(_tiles[j].getIndex()==_p[i].getCurPosition()){
                            currentTile = _tiles[j];
                        }
                }
                
                _p[i].setCurPosition(currentTile.teleport());
                
                //this.print(_p[i],plus);
                
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
        //System.out.println(winner.getName()+" WIN!");
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
    
    /*void print(Player curP,int dice){
        for(int i=0;i<this._tiles.length;i++){
            
            for(int j=0;j<this._tiles[i].length;j++){
                
                if(j==0)System.out.print("|");
                System.out.printf("%4d",_tiles[i][j].getIndex());
                
                for(int k=0;k<p.length;k++){
                    if(this._tiles[i][j].getIndex()==_p[k].getCurPosition())System.out.print(_p[k].getSymbol());
                    else System.out.print(" ");
                }
                
                if(_tiles[i][j].getTele()==null)System.out.print("  ");
                else if(this._tiles[i][j].getTele().getClass().toString().substring(17,this._tiles[i][j].getTele().getClass().toString().length()).equals("Snake")){
                    System.out.print("s"+this._tiles[i][j].getTele().getIdentifier());
                }
                else if(this._tiles[i][j].getTele().getClass().toString().substring(17,this._tiles[i][j].getTele().getClass().toString().length()).equals("Stair")){
                    System.out.print("t"+this._tiles[i][j].getTele().getIdentifier());
                }
                System.out.print("|");
                
            }
            
            System.out.println("\n");
        }
        System.out.println(curP.getName()+" has rolled the dice and get "+dice+"\n");
    }*/
}
