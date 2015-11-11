package sas.engine;

class Tile {

    int _index;
    Teleporter _tele;
    
    Tile(int index){
        this._index = index;
    }

    Teleporter getTele() {
        return _tele;
    }

    void setTele(Teleporter tele) {
        this._tele = tele;
    }
    
    int getIndex(){
        return this._index;
    }
    
    int teleport(){
        if(this._tele != null){
            return this._tele.getTo();
        }
        else return this._index;
    }
}
