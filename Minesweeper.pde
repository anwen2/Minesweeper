import de.bezier.guido.*;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined
private int NUM_ROWS = 20;
private int NUM_COLS = 20;
boolean isLost = false;
int tileCount = 0;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager

    buttons = new MSButton [NUM_ROWS] [NUM_COLS];
    mines = new ArrayList <MSButton>();
    //your code to declare and initialize buttons goes here
    for(int i = 0;i<NUM_COLS;i++)
    {
        for(int j = 0; j < NUM_ROWS;j++){
            buttons[j][i]= new MSButton(j,i);
    }
}
    
    
    setMines();
}
public void setMines()
{  for (int i = 0; i < 60; i++) {
    final int r1 = (int)(Math.random()*20);
    final int r2 = (int)(Math.random()*20);
    if ((mines.contains (buttons[r1][r2])) == false) {
      mines.add(buttons[r1][r2]);
    }
    else {i +=-1;}
}
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
        
        //new
    for (int i = 0; i < NUM_ROWS; i++) {
     for (int j = 0; j < NUM_COLS; j++) {
        buttons[i][j].draw();
      } 
    }
    //end
    
}
public boolean isWon()
{  
  
  return false;
}
public void displayLosingMessage()
{  
    
    for(int i=0;i<mines.size();i++)
        if(mines.get(i).isClicked()==false)
            mines.get(i).mousePressed();
    isLost = true;
    buttons[NUM_ROWS/2][(NUM_COLS/2)-5].setLabel("G");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-4].setLabel("A");
    buttons[NUM_ROWS/2][(NUM_COLS/2-3)].setLabel("M");
    buttons[NUM_ROWS/2][(NUM_COLS/2-2)].setLabel("E");
    buttons[NUM_ROWS/2][(NUM_COLS/2-1)].setLabel("");
    buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2+1)].setLabel("V");
    buttons[NUM_ROWS/2][(NUM_COLS/2+2)].setLabel("E");
    buttons[NUM_ROWS/2][(NUM_COLS/2+3)].setLabel("R");
}
public void displayWinningMessage()
{
    isLost = true;
    buttons[NUM_ROWS/2][(NUM_COLS/2)-1].setLabel("G");
    buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("G");
}

//new
public void mousePressed (){
  int mX = mouseX;
  int mY = mouseY;
  buttons[(int)(mY/20)][(int)(mX/20)].mousePressed();
}
//end

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;

    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
      if (isLost == false) {
        if (mouseButton == RIGHT && buttons[r][c].isClicked()) {
         
        }
        else if (mouseButton == RIGHT) {
          marked = !marked;
        }
        else if (marked == true) {}
        else if (mines.contains(this)) {
          clicked = true;
          displayLosingMessage();
        }
        else if (countmines(r,c) > 0) {
          label = ""+countmines(r,c);
          if (!clicked) {tileCount+=1;}
          if (tileCount == 400-mines.size()) {displayWinningMessage();}
          clicked = true;
        }
        else {

          
          if (!clicked) {tileCount+=1;}
          if (tileCount == 400-mines.size()) {displayWinningMessage();}
          clicked = true;
          
          if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked()) {
          buttons[r-1][c-1].mousePressed();} 
          if(isValid(r-1,c) && !buttons[r-1][c].isClicked()) {
          buttons[r-1][c].mousePressed();}
          if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked()){
          buttons[r-1][c+1].mousePressed();}
          
          if(isValid(r,c-1) && !buttons[r][c-1].isClicked()){
          buttons[r][c-1].mousePressed();}
          if(isValid(r,c+1) && !buttons[r][c+1].isClicked()){
          buttons[r][c+1].mousePressed();}
          
          if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked()){
          buttons[r+1][c-1].mousePressed();}
          if(isValid(r+1,c) && !buttons[r+1][c].isClicked()){
          buttons[r+1][c].mousePressed();}
          if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked()){
          buttons[r+1][c+1].mousePressed();}
        }
      }
    }

    public void draw () 
    {    
      if (marked)
            fill(0);
         
         else if( !marked && clicked && mines.contains(this) ) 
             fill(255,0,0);
         else if( marked && mines.contains(this) ) 
             fill(100);
         else if( !marked && clicked && !mines.contains(this) ) 
             fill(200);
             
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if (r <NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0) {return true;}
        return false;
    }
    public int countmines(int row, int col)
    {
        int nummines = 0;
        if (isValid(row-1,col) == true && mines.contains(buttons[row-1][col]))
        {
            nummines++;
        }
        if (isValid(row+1,col) == true && mines.contains(buttons[row+1][col]))
        {
            nummines++;
        }
         if (isValid(row,col-1) == true && mines.contains(buttons[row][col-1]))
        {
            nummines++;
        }
         if (isValid(row,col+1) == true && mines.contains(buttons[row][col+1]))
        {
            nummines++;
        }
         if (isValid(row-1,col+1) == true && mines.contains(buttons[row-1][col+1]))
        {
            nummines++;
        }
         if (isValid(row-1,col-1) == true && mines.contains(buttons[row-1][col-1]))
        {
            nummines++;
        }
         if (isValid(row+1,col+1) == true && mines.contains(buttons[row+1][col+1]))
        {
            nummines++;
        }
         if (isValid(row+1,col-1) == true && mines.contains(buttons[row+1][col-1]))
        {
            nummines++;
        }
        return nummines;
    }
}