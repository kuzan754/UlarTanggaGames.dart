class ComputerPlayer extends Player{
    ComputerPlayer(String name,char symbol): super(name,symbol);
    
    
    @override
    void move(int input){
        this.setCurPosition(this.getCurPosition()+input);
    }
}
