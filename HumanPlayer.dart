package sas.engine;

/**
 *
 * @author i14058
 */
public class HumanPlayer extends Player{
    java.util.Scanner sc = new java.util.Scanner(System.in);
    
    HumanPlayer(String name,char symbol) {
        super(_name,_symbol);
    }
    
    @Override
    void move(int input){
        String indicator = sc.next();
        this.setCurPosition(this.getCurPosition()+input);
    }
}
