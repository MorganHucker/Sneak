class Lever {
  ArrayList<Float> particlenums = new ArrayList<Float>();
  boolean on = false;
  float x;
  float y;
  float xd;
  float yd;
  int type;
  boolean moving = false;
  boolean movingUp;
  int moveTicks = 0;
  int moveTicks2 = 160;
  boolean up = false;

  public Lever(float xc, float yc, int typec, float xdc, float ydc) {

    x = xc;
    y = yc;
    xd = xdc;
    yd = ydc;
    type = typec;
  }

  float getX() {
    return x;
  }
  float getY() {
    return y;
  }

  boolean containsPoint(float xp, float yp) {

    if (xp > xd && xp < xd + 50 && yp > yd && yp < yd + 80) {
      if (!up) return true;
    }
    return false;
  }

  void use() {
    if (!moving) {
      on = !on;
      //click.play();
      moving = true;
      movingUp = !movingUp; 
      up = false;
    }
  }

  void drawLever() {
    stroke(0);
    strokeWeight(0);
    if (type == 0) {
      if (moving) {
        if (movingUp) {
          moveTicks+=4;
          if (moveTicks == 160) {
            up = true;
            moving = false;
          }
        } else {
          moveTicks-=4;
          if (moveTicks == 0) {
            moving = false;
            up = false;
          }
        }
      }

      image(wood, xd, yd, 50, 80 - moveTicks);
    }
    if (type == 1) {
      if (moving) {
        if (movingUp) {
          moveTicks2+=4;
          if (moveTicks2 == 160) {
            up = true;
            moving = false;
          }
        } else {
          moveTicks2-=4;
          if (moveTicks2 == 0) {
            moving = false;
            up = false;
          }
        }
      }

      image(wood, xd, yd, 50, 80 - moveTicks2);
    }

    if (on) {
      translate(x, y);
      fill(60, 35, 1);
      translate(12.5, 0);
      translate(0, 22);
      rotate(radians(35));
      translate(0, -22);
      ellipse(0, -5, 5, 38); 
      translate(0, 22);
      rotate(-radians(35));
      translate(0, -22);
      translate(-12.5, 0);
      fill(40);
      rect(0, 20, 30, 15);
      translate(-x, -y);
    } else {
      translate(x, y);
      fill(60, 35, 1);
      translate(12.5, 0);
      translate(0, 22);
      rotate(-radians(35));
      translate(0, -22);
      ellipse(0, -5, 5, 38); 
      translate(0, 22);
      rotate(radians(35));
      translate(0, -22);
      translate(-12.5, 0);
      fill(40);
      rect(0, 20, 30, 15);
      translate(-x, -y);
    }
  }
}
