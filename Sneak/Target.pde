class Target {
  float x; 
  float y;
  float xd; 
  float yd;
  float wid = 24;
  float heigh = 24;
  float wid2 = 40;
  float heigh2 = 60;
  boolean stolen = false;
  boolean moving = false;
  boolean movingUp;
  int moveTicks = 0;
  boolean up = false;
  
  public Target(float xc, float yc, float xdc, float ydc) {
    x = xc;
    y = yc;
    xd = xdc;
    yd = ydc;
  }

  void drawT() {
    if (!stolen)
    image(target, x, y, wid, heigh);
    image(podium, x-8, y + 28, wid2, heigh2);
    drawExitDoor();
  }

  void drawExitDoor() {
    if (stolen && moveTicks != 160) {
      moveTicks+=4;
      if (moveTicks == 160) 
        up = true;
    }
    image(wood, xd, yd, 50, 80 - moveTicks);
  }

  boolean containsPoint(float xp, float yp) {

    if (xp > xd && xp < xd + 50 && yp > yd && yp < yd + 80) {
      if (!up) return true;
    }
    return false;
  }

  boolean checkPlayer() {
    if (sqrt((pos.x-x)*(pos.x-x)+(pos.y-y)*(pos.y-y)) < 30) {
      stolen = true;
      hasGem = true;
      return true;
    }
    return false;
  }
}
