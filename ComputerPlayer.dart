class ComputerPlayer extends Player{
    ComputerPlayer(String name,String symbol): super(name,symbol);
    
    
    @override
    void move(int input){
        this.setCurPosition(this.getCurPosition()+input);
    }
}
