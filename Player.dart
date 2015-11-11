package sas.engine;

/**
 *
 * @author i14058
 */
 abstract class Player {
    int _curPosition;
    String _name;
    String _symbol;

    Player(String name,String symbol) {
        this._curPosition = 0;
        this._name = name;
        this._symbol = symbol;
    }

    char getSymbol() {
        return _symbol;
    }
    
    int getCurPosition() {
        return _curPosition;
    }

    void setCurPosition(int curPosition) {
        this._curPosition = curPosition;
    }

    String getName() {
        return _name;
    }
    
    abstract void move(int plus);
}
