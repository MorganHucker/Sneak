class Gaurd {
  float x;
  float y;
  int moveT; 
  boolean left;
  boolean up;
  float xRange1; //x range for gaurd without colliding
  float xRange2;
  float v; 
  float speed;
  float oscilAngle;
  float dirAngle;
  int c;
  float WIDTH = 40;
  float HEIGHT = 30;

  public Gaurd(float xc, float yc, float x1, float x2, float s) {
    x =xc;
    y = yc;
    speed = s;
    v = speed;
    xRange1 = x1; 
    xRange2 = x2;
  }

  boolean checkPlayer(float xp, float yp) {
    noFill();
    stroke(0, 255, 0);

    if (v < 0) {
      x -=250;
    }
    if (xp > x && xp < x + 250 && yp > y && yp < y + 80) {
      if (v < 0) {
        x+=250;
      }
      displayNum = 3;
      return true;
    }
    if (v < 0) {
      x+=250;
    }
    return false;
  }
  //used to find the nagle to roate the gaurds light to make it appear to be walking
  void breathe() { 

    if (!up) {
      c+=1.5;
    } else {
      c-=1.5;
    }
    if (c > 3 || c < -3) up=!up;
  }

  void move() {
    checkPlayer(pos.x, pos.y);
    x+= v;
    for (Block b : blocks) {
      if (b.isTouchingLeft(x, x + WIDTH*2, y)) {
        v=-speed;
        dirAngle = PI;
        return;
      }

      if (b.isTouchingRight(x, x + WIDTH*2, y)) {
        v=speed;
        dirAngle = 0;
        return;
      }
      if (x > xRange2) {
        dirAngle = PI;
        v = -speed;
      }
      if (x < xRange1) {
        dirAngle = 0;
        v = speed;
      }
    }
    drawGuard();
  }



  void drawGuard() {
    breathe();
    ellipseMode(CORNER);
    fill(255, 255, 40, 100);
    oscilAngle = c;
    translate(x, y+40);

    rotate(dirAngle + radians(oscilAngle));
    image(light, 0, -40, 300, 80);
    rotate(-(dirAngle + radians(oscilAngle)));
    translate(-x, -y-40);
  }
}
