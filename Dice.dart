package sas.engine;

import 'dart:math';
/**
 *
 * @author i14062
 */

class Dice {
    static int randomDice(){
        Random rnd = new Random();
        return 1 + rnd.nextInt(6);
    }
}
