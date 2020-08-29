PVector pos;
boolean hasGem = false;
class Player {

  float c = 0;
  boolean up = true;
  int HEIGHT = 50;
  int WIDTH = 20;
  float xSpeed = 0;
  float ySpeed = 0;
  Lever leverNear;
  boolean leftLast = false;
  public Player(float startX, float startY) {
    pos = new PVector(startX, startY);
  }



  void fall() {
    if (ySpeed < 10 && !standingOnBlock()) {
      ySpeed+=0.7;
      boolean doAccelFall = true;
      for (Block b : blocks) {
        if (b.containsPoint(pos.x, pos.y+ySpeed)) {
          doAccelFall = false;
          ySpeed = 0;
        }
        // }
      }
      if (doAccelFall)
        pos.y+= ySpeed;
    }
  }
  void countSpeed(boolean left, boolean right, boolean up, boolean interact) {
    if (left && xSpeed > -5) {
      leftLast = true;
      xSpeed-= 0.5;
    }
    if (right && xSpeed < 5) {
      leftLast = false;
      xSpeed+= 0.5;
    }
    if (up && standingOnBlock()) ySpeed = -22;
    fall();
    for (Lever l : levers) {
      if (sqrt((pos.x - l.getX()) * (pos.x - l.getX()) + (pos.y - l.getY()) * (pos.y - l.getY())) < 25) {
        leverNear = l;
        break;
      }
    }
    if (interact && standingOnBlock() && leverNear != null) {
      leverNear.use();
    } else if (interact && standingOnBlock() && checkpointInv.size()>0) {
      checkpointInv.remove(0);
      checkpointPlace.add(new Checkpoint(pos.x+10, pos.y-20));
    }
    leverNear = null;
  }





  boolean standingOnBlock() {
    for (Block b : blocks) {
      if (b.isTouchingTop(pos.x, pos.x + WIDTH, pos.y + HEIGHT)) {
        pos.y = b.getTop() - HEIGHT;
        return true;
      }
    }
    return false;
  }

  void breathe() {

    if (!up) {
      c+=0.1;
    } else {
      c-=0.1;
    }
    if (c > 4 || c < 0) up=!up;
  }
  void drawPlayer() {
    breathe();
    //below for loops adjust speeds for collision for each solid object in the level
    for (Block b : blocks) {
      if (b.containsPoint(pos.x+xSpeed, pos.y +HEIGHT) || b.containsPoint(pos.x+xSpeed, pos.y) || b.containsPoint(pos.x+xSpeed + WIDTH, pos.y) ||  b.containsPoint(pos.x+xSpeed + WIDTH, pos.y + HEIGHT)) { 
        xSpeed=0;
      }
      if (b.containsPoint(pos.x, pos.y + HEIGHT +ySpeed) || b.containsPoint(pos.x + WIDTH, pos.y + HEIGHT +ySpeed) || 
        b.containsPoint(pos.x + WIDTH, pos.y +ySpeed) || b.containsPoint(pos.x, pos.y +ySpeed)) {  
        ySpeed=0;
      }
      if (b.containsPoint(pos.x+xSpeed, pos.y + HEIGHT +ySpeed) || b.containsPoint(pos.x+xSpeed + WIDTH, pos.y + HEIGHT +ySpeed) ||
        b.containsPoint(pos.x+xSpeed, pos.y +ySpeed) ||b.containsPoint(pos.x+xSpeed + WIDTH, pos.y +ySpeed)) {
        xSpeed=0;
        ySpeed=0;
      }
    }
    for (Lever l : levers) {
      if (l.containsPoint(pos.x+xSpeed, pos.y +HEIGHT) || l.containsPoint(pos.x+xSpeed, pos.y) || l.containsPoint(pos.x+xSpeed + WIDTH, pos.y) ||  l.containsPoint(pos.x+xSpeed + WIDTH, pos.y + HEIGHT)) { 
        xSpeed=0;
      }
      if (l.containsPoint(pos.x, pos.y + HEIGHT +ySpeed) || l.containsPoint(pos.x + WIDTH, pos.y + HEIGHT +ySpeed) || 
        l.containsPoint(pos.x + WIDTH, pos.y +ySpeed) || l.containsPoint(pos.x, pos.y +ySpeed)) {  
        ySpeed=0;
      }
      if (l.containsPoint(pos.x+xSpeed, pos.y + HEIGHT +ySpeed) || l.containsPoint(pos.x+xSpeed + WIDTH, pos.y + HEIGHT +ySpeed) ||
        l.containsPoint(pos.x+xSpeed, pos.y +ySpeed) ||l.containsPoint(pos.x+xSpeed + WIDTH, pos.y +ySpeed)) {
        xSpeed=0;
        ySpeed=0;
      }
    }
    if (t.containsPoint(pos.x+xSpeed, pos.y +HEIGHT) || t.containsPoint(pos.x+xSpeed, pos.y) || t.containsPoint(pos.x+xSpeed + WIDTH, pos.y) ||  t.containsPoint(pos.x+xSpeed + WIDTH, pos.y + HEIGHT)) { 
      xSpeed=0;
    }
    if (t.containsPoint(pos.x, pos.y + HEIGHT +ySpeed) || t.containsPoint(pos.x + WIDTH, pos.y + HEIGHT +ySpeed) || 
      t.containsPoint(pos.x + WIDTH, pos.y +ySpeed) || t.containsPoint(pos.x, pos.y +ySpeed)) {  
      ySpeed=0;
    }
    if (t.containsPoint(pos.x+xSpeed, pos.y + HEIGHT +ySpeed) || t.containsPoint(pos.x+xSpeed + WIDTH, pos.y + HEIGHT +ySpeed) ||
      t.containsPoint(pos.x+xSpeed, pos.y +ySpeed) ||t.containsPoint(pos.x+xSpeed + WIDTH, pos.y +ySpeed)) {
      xSpeed=0;
      ySpeed=0;
    } 
    pos.x += xSpeed;
    pos.y += ySpeed;




    if (standingOnBlock())xSpeed *= 0.85; 
    else xSpeed *=0.9995;

    ySpeed *= 0.9;
    fill(7, 7, 7);
    ellipse(pos.x, pos.y-10, WIDTH+5, HEIGHT+10);

    fill(255);
    if (!leftLast) {  
      arc(pos.x+4, pos.y-3+c, 7, 7, 0, PI+QUARTER_PI, OPEN);
      arc(pos.x+WIDTH-4, pos.y-3+c, 7, 7, 0, PI-QUARTER_PI, OPEN);
      if (hasGem) {
        translate(pos.x+20, pos.y+15+c);
        rotate(radians(20));
        image(target, 0, 0, 10, 10);
        rotate(radians(-20));
        translate(-(pos.x+20), -(pos.y+15+c));
      }
    } else {
      arc(pos.x+4, pos.y-3+c, 7, 7, radians(30), PI, OPEN);
      arc(pos.x+WIDTH-4, pos.y-3+c, 7, 7, -radians(20), PI, OPEN);
      if (hasGem) {
        translate(pos.x, pos.y+15+c);
        rotate(radians(-20));
        image(target, 0, 0, 10, 10);
        rotate(radians(20));
        translate(-pos.x, -(pos.y+15+c));
      }
    }
  }
}
