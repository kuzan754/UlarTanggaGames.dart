package sas.engine;

/**
 *
 * @author i14058
 */
import 'dart:io';

class HumanPlayer extends Player{
     HumanPlayer(String name,char symbol) : super(name,symbol);
    
    @override
     void move(int input){
        String indicator = stdin.nextLine();
        this.setCurPosition(this.getCurPosition()+input);
    }
}
