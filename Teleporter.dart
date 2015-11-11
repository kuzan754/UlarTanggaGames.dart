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
