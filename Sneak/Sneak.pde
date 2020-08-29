//import processing.sound.*;

//Arraylists to store all game objects when a level is loaded
ArrayList<Spikes> spikes = new ArrayList<Spikes>();
ArrayList<Block> blocks = new ArrayList<Block>();
ArrayList<Gaurd> gaurds = new ArrayList<Gaurd>();
ArrayList<Checkpoint> checkpointInv = new ArrayList<Checkpoint>();    //Checkpoints available to be placed
ArrayList<Checkpoint> checkpointPlace = new ArrayList<Checkpoint>();  //Checpoints already placed
ArrayList<Lever> levers = new ArrayList<Lever>();

//Declare player and target object
Player player;
Target t;

//Declare all resources
PImage wood;
PImage light;
PImage spikesPNG;
PImage bg;
PImage podium;
PImage target;
PImage flag;
PFont font;
//SoundFile click;

//Fields for level selecting and int to determine what to display 
int prevLevel;
int displayNum;
boolean mClick = false;

//boolean passed to player object
boolean up = false;
boolean left = false;
boolean right = false;
boolean interact = false;

void setup() {
  displayNum = 0; // set display num to main menu
  
  //Load resources
  //click = new SoundFile(this, "button.mp3");
  light = loadImage("light3.png");
  target =loadImage("gem.png");
  podium =loadImage("Column.png");
  bg = loadImage("bg.jpg");
  spikesPNG = loadImage("spikes.png");
  flag = loadImage("flag.png");
  wood = loadImage("wood.jpg");
  font = createFont("font.otf", 80);
  
  
  frameRate(60);
  fullScreen();
}

void draw() {

  background(bg);
  if (displayNum == 0) {
    drawMenu();
  } else if (displayNum == 1) {
    drawLevelSelect();
  } else if (displayNum == 2) {
    drawPause();
  } else if (displayNum == 3) {
    drawDead();
  } else if (displayNum == 4) {
    drawWin();
  } else {
    runGame();
  }
  mClick = false;
  interact = false;
}

//is player in the level or not
boolean inLevel() { 

  if (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height) return false;
  return true;
}

//updates keys pressed to be passed to player object
void keyPressed() {
  if (key == ' ' || key == 'w') {
    up = true;
  }
  if (key == 'e') {
    interact = true;
  }
  if (key == 'a') {
    left = true;
  }
  if (key == 'd') {
    right = true;
  }
}

//updates keys released to be passed to player object
void keyReleased() {
  if (key == ' ' || key == 'w') {
    up = false;
  }
  if (key == 'e') {
    interact = false;
  }
  if (key == 'a') {
    left = false;
  }
  if (key == 'd') {
    right = false;
  }
}


//Mouse method for menu interaction
void mouseReleased() {
  mClick = true;
}

//Draws all game objects, updates player
void runGame() {
  player.countSpeed(left, right, up, interact);
  player.drawPlayer();

  for (Gaurd g : gaurds) {
    g.move();
  }
  for (Spikes spike : spikes) {
    spike.drawSpikes();
  }
  for (Checkpoint c : checkpointPlace) {
    c.drawFlag();
  }
  for (Lever l : levers) {
    l.drawLever();
  }
  
  t.checkPlayer();
  t.drawT();
  
  for (Block b : blocks) {
    b.drawBlock();
  }
  if (!inLevel()) {
    if (prevLevel == 2) 
      displayNum = 4;
    else {
      loadLevel2();
      prevLevel = 2;
    }
  }

  textFont(font);
  textSize(25);
  fill(255);
  text("Checkpoints:", 50, 15);
  drawCIcons();
  
}

//Draws checkpoint icons
void drawCIcons() {
  for (int i = 0; i< checkpointInv.size(); i++) {
    checkpointInv.get(i).drawIcon(i);
  }
}

void drawMenu() {
  fill(255);
  textFont(font);
  textSize(350);
  textAlign(CENTER, CENTER);
  text("Sneak", width/2, height/3);
  textSize(90);
  text("Play", width/2, height - 345);
  if (mClick == true && mouseX > width/2 - 175 && mouseX < width/2 + 175 && mouseY > height - 400 && mouseY < height - 280) {
    //click.play();
    displayNum = 1;
  }
}

void drawWin() {
  textFont(font);
  fill(255);
  textSize(350);
  textAlign(CENTER, CENTER);
  text("You WIN! :)", width/2, height/3);
  textSize(150);
  text("other levels", width/2, height/1.5);
  if (mClick && mouseX > width / 2 - 300 && mouseY > height/1.5-60 && mouseX < width/2+300 && mouseY < height/1.5+90) {
    //click.play(); 
    displayNum = 1;
  }
}

void drawPause() {
  fill(255);
  textSize(350);
  textAlign(CENTER, CENTER);
  text("Sneak", width/2, height/3);
  textSize(90);
  text("Play", width/2, height - 345);
  if (mClick && mouseX > width/2 - 175 && mouseX < width/2 + 175 && mouseY > height - 400 && mouseY < height - 280) {
    //click.play();
    displayNum = 1;
  }
}

void drawDead() {
  if (checkpointPlace.size()==0) {
    fill(255);
    textFont(font);
    textSize(300);
    textAlign(CENTER, CENTER);
    text("You failed :(", width/2, height/3-30);
    textSize(150);
    text("Retry", width/2, height/2);
    text("other levels", width/2, height/1.5);
    text("Quit", width/2, height-180);
    if (mClick && mouseX > width/2-140 && mouseY > height/2-60 && mouseX < width/2+140 && mouseY < height/2+90) {
      //click.play(); 
      if (prevLevel == 1)
        loadLevel1();
      else 
      loadLevel2();
      displayNum = 5;
    }
    if (mClick && mouseX > width / 2 - 300 && mouseY > height/1.5-60 && mouseX < width/2+300 && mouseY < height/1.5+90) {
      //click.play(); 
      displayNum = 1;
    }
    if (mClick && mouseX > width/2-100 && mouseY > height-235 && mouseX < width/2+100 && mouseY < height-85) {
      //click.play(); 
      delay(80);
      exit();
    }
  } else {
    fill(255);
    textFont(font);
    textSize(300);
    textAlign(CENTER, CENTER);
    text("You failed :(", width/2, 120);
    textSize(150);
    text("Use checkpoint", width/2, height/3);
    text("Retry", width/2, height/2);
    text("other levels", width/2, height/1.5);
    text("Quit", width/2, height-180);

    if (mClick && mouseX > width/2-350 && mouseY > height/3-60 && mouseX < width/2+350 && mouseY < height/3+90) {
     // click.play(); 
      displayNum = 5;
      pos.x = checkpointPlace.get(checkpointPlace.size()-1).getX() - 10;
      pos.y = checkpointPlace.get(checkpointPlace.size()-1).getY() + 10;
      checkpointPlace.remove(checkpointPlace.size()-1);
    } else if (mClick && mouseX > width/2-140 && mouseY > height/2-60 && mouseX < width/2+140 && mouseY < height/2+90) {
     // click.play(); 
      if (prevLevel == 1)
        loadLevel1();
      else 
      loadLevel2();
      displayNum = 5;
    } 
    else if (mClick && mouseX > width / 2 - 300 && mouseY > height/1.5-60 && mouseX < width/2+300 && mouseY < height/1.5+90) {
     // click.play(); 
      displayNum = 1;
    }
    if (mClick && mouseX > width/2-100 && mouseY > height-235 && mouseX < width/2+100 && mouseY < height-85) {
     // click.play(); 
      delay(80);
      exit();
    }
  }
} 

void drawLevelSelect() {
  fill(255);
  textSize(250);
  textAlign(CENTER, CENTER);
  textFont(font);
  text("select level", width/2, height/2-50);
  textSize(350);
  text("1", width/2 -100, height/2+120);
  text("2", width/2+100, height/2+120);
  if (mClick && mouseX > width/2-150 && mouseX < width/2 -50 && mouseY > height/2 && mouseY < height/2+300) {
    //click.play(); 
    displayNum = 5;
    loadLevel1();
    prevLevel = 1;
  }
  if (mClick && mouseX > width/2+30 && mouseX < width/2 +160 && mouseY > height/2 && mouseY < height/2+300) {
    //click.play(); 
    displayNum = 5;
    prevLevel = 2;
    loadLevel2();
  }
}
//clears all game object array lists and creates and stores objects needed for the level
void loadLevel1() {
  checkpointPlace.clear();
  checkpointInv.clear();
  blocks.clear();
  gaurds.clear();
  spikes.clear();
  levers.clear();
  player = null;
  t = null; 

  player = new Player (60, 820);

  t = new Target(1820, 855, 1895, 30);

  //checkpoints
  checkpointInv.add(new Checkpoint());
  checkpointInv.add(new Checkpoint());
  checkpointInv.add(new Checkpoint());

  //gaurds
  gaurds.add(new Gaurd(490, 620, 300, 700, 3));
  gaurds.add(new Gaurd(1490, 770, 1180, 1630, 3));

  //Levers
  levers.add(new Lever(870, 140, 0, 1660, 30));
  levers.add(new Lever(1560, 80, 0, 940, 95));

  //Spikes
  spikes.add(new Spikes(30, 980));
  spikes.add(new Spikes(130, 980));
  spikes.add(new Spikes(230, 980));
  spikes.add(new Spikes(330, 980));
  spikes.add(new Spikes(430, 980));
  spikes.add(new Spikes(530, 980));
  spikes.add(new Spikes(630, 980));
  spikes.add(new Spikes(730, 980));
  spikes.add(new Spikes(830, 980));
  spikes.add(new Spikes(930, 980));
  spikes.add(new Spikes(1030, 980));
  spikes.add(new Spikes(1130, 980));
  spikes.add(new Spikes(1230, 980));
  spikes.add(new Spikes(1330, 980));
  spikes.add(new Spikes(1430, 980));
  spikes.add(new Spikes(1530, 980));
  spikes.add(new Spikes(1630, 980));
  spikes.add(new Spikes(1730, 980));
  spikes.add(new Spikes(1830, 980));
  spikes.add(new Spikes(1125, 480));
  spikes.add(new Spikes(1325, 280));
  spikes.add(new Spikes(925, 280));


  //outline blocks
  blocks.add(new Block(0, 1050, 1920, 30));
  blocks.add(new Block(0, 0, 1920, 30));
  blocks.add(new Block(0, 0, 30, 1080));
  blocks.add(new Block(1890, 110, 30, 970));

  //blocks
  blocks.add(new Block (0, 900, 200, 50));
  blocks.add(new Block (1540, 110, 350, 120));
  blocks.add(new Block (1760, 940, 160, 50));
  blocks.add(new Block (300, 700, 400, 50));
  blocks.add(new Block(475, 750, 50, 300));
  blocks.add(new Block(30, 530, 150, 50));
  blocks.add(new Block(310, 380, 50, 50));
  blocks.add(new Block(535, 380, 50, 50));
  blocks.add(new Block(970, 950, 150, 50));
  blocks.add(new Block(1180, 840, 450, 50));
  blocks.add(new Block(1380, 890, 50, 160));
  blocks.add(new Block(1020, 1000, 50, 50));
  blocks.add(new Block(1380, 700, 50, 50));
  blocks.add(new Block(800, 175, 200, 50));
  blocks.add(new Block(800, 30, 200, 65));
  blocks.add(new Block(800, 30, 50, 145));
  blocks.add(new Block(1100, 550, 150, 50));
  blocks.add(new Block(1300, 350, 150, 50));
  blocks.add(new Block(900, 350, 150, 50));

  blocks.add(new Block(1490, 180, 100, 50));

  hasGem = false;
}

void loadLevel2() {
  checkpointPlace.clear();
  checkpointInv.clear();
  blocks.clear();
  gaurds.clear();
  spikes.clear();
  levers.clear();
  player = null;
  t = null;
  player = new Player (80, 980);

  t = new Target(600, 963, 1895, 970);

  //checkpoints
  checkpointInv.add(new Checkpoint());
  checkpointInv.add(new Checkpoint());
  checkpointInv.add(new Checkpoint());
  checkpointInv.add(new Checkpoint());
  checkpointInv.add(new Checkpoint());


  //Levers
  levers.add(new Lever(80, 115, 0, 815, 70));
  levers.add(new Lever(1840, 575, 0, 730, 970));
  levers.add(new Lever(1150, 105, 0, 1780, 530));
  levers.add(new Lever(1600, 115, 0, 1720, 530));


  //outline blocks
  blocks.add(new Block(0, 1050, 1920, 30));
  blocks.add(new Block(0, 0, 1920, 30));
  blocks.add(new Block(0, 0, 30, 1080));
  blocks.add(new Block(1890, 0, 30, 970));

  //other blocks
  blocks.add(new Block(0, 780, 300, 50));
  blocks.add(new Block(500, 300, 80, 900));
  blocks.add(new Block(400, 880, 100, 50));
  blocks.add(new Block(400, 620, 100, 50));
  blocks.add(new Block(0, 510, 300, 50));
  blocks.add(new Block(300, 300, 580, 50));
  blocks.add(new Block(800, 150, 80, 180));
  blocks.add(new Block(350, 150, 50, 50));
  blocks.add(new Block(450, 150, 50, 50));
  blocks.add(new Block(550, 150, 50, 50));
  blocks.add(new Block(650, 150, 50, 50));
  blocks.add(new Block(950, 0, 50, 500));
  blocks.add(new Block(750, 500, 50, 110));
  blocks.add(new Block(750, 550, 110, 110));
  blocks.add(new Block(800, 0, 80, 70));
  blocks.add(new Block(0, 150, 200, 50));
  blocks.add(new Block(800, 610, 200, 50));
  blocks.add(new Block(950, 500, 50, 160));
  blocks.add(new Block(580, 850, 215, 80));
  blocks.add(new Block(715, 930, 80, 40));
  blocks.add(new Block(1375, 770, 50, 300));  
  blocks.add(new Block(920, 910, 50, 50));
  blocks.add(new Block(1100, 840, 50, 50));
  blocks.add(new Block(1325, 770, 50, 50));
  blocks.add(new Block(1000, 510, 325, 50));
  blocks.add(new Block(1420, 610, 500, 50));
  blocks.add(new Block(1710, 450, 200, 80));
  blocks.add(new Block(1420, 0, 50, 360));
  blocks.add(new Block(1470, 310, 150, 50));
  blocks.add(new Block(1470, 240, 20, 70));
  blocks.add(new Block(1570, 150, 320, 50));
  blocks.add(new Block(1100, 400, 50, 50));
  blocks.add(new Block(1000, 280, 50, 50));
  blocks.add(new Block(1140, 140, 50, 50));


  //gaurds
  gaurds.add(new Gaurd(50, 700, 30, 300, 3));
  gaurds.add(new Gaurd(400, 230, 300, 600, 3));
  gaurds.add(new Gaurd(900, 970, 980, 1180, 3));
  gaurds.add(new Gaurd(1830, 380, 1710, 1890, 2));
  gaurds.add(new Gaurd(1720, 75, 1700, 1890, 1.5));


  //spikes
  spikes.add(new Spikes(330, 980));
  spikes.add(new Spikes(30, 440));
  spikes.add(new Spikes(130, 440));
  spikes.add(new Spikes(850, 545));
  spikes.add(new Spikes(1420, 980));
  spikes.add(new Spikes(1560, 980));
  spikes.add(new Spikes(1680, 980));
  spikes.add(new Spikes(630, 780));
  spikes.add(new Spikes(1460, 250));
  spikes.add(new Spikes(1000, 440));
  spikes.add(new Spikes(1100, 440));
  spikes.add(new Spikes(1200, 440));

  hasGem = false;
}
