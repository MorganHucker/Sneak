class Block {
  int x;
  int y;
  int wid;
  int heigh;
  ArrayList<Float> particlenums = new ArrayList<Float>();

  public Block(int xc, int yc, int widc, int heighc) {
    x =xc;
    y = yc;
    wid = widc;
    heigh = heighc;
    for (int i=0; i<(wid*heigh)/30; i++) { //creates particles in a block
      particlenums.add(random(x, x+wid));
      particlenums.add(random(y, y+heigh));
      particlenums.add(random(1, 4));
      particlenums.add(random(1, 4));
    }
  }

  int getTop() {
    return y;
  }

  int getLeft() {
    return x;
  }

  int getRight() {
    return x + wid;
  }

  int getBottom() {
    return y + heigh;
  }

  void drawBlock() {
    noStroke();
    fill(30, 30, 30);
    rect(x, y, wid, heigh);
    fill(15);
    for (int i=0; i<(wid*heigh)/30; i+=4) {


      ellipse(particlenums.get(i), particlenums.get(i+1), particlenums.get(i+2), particlenums.get(i+3));
    }
  }


//All boolean methods below used for collision detection

  boolean isTouchingTop(float xi, float xf, float yp) {
    if (((xi > x && xi < x + wid) || (xf > x && xf < x+ wid)) && yp >= y && yp < y + heigh * 0.5) return true; 
    return false;
  }

  boolean isTouchingLeft(float xi, float xf, float yp) {
    if (xf >= x && ((yp < y && yp > y + heigh) || (yp > y && yp < y + heigh)) && xi < x + wid/2) return true; 
    return false;
  }

  boolean isTouchingRight(float xi, float xf, float yp) {
    if (xi <= x + wid && ((yp < y && yp > y + heigh) || (yp > y && yp  < y + heigh)) && xf > x + wid/2) return true; 
    return false;
  }

  boolean isTouchingBottom(float xi, float xf, float yp) {
    if (((xi >= x && xi <= x + wid) ||(xf >= x && xf <= x + wid))  && yp >= y + heigh - 10 && yp < y + heigh + 10  ) {


      return true;
    }
    return false;
  }

  boolean containsPoint(float xp, float yp) {
    if (xp > x && xp < x + wid && yp > y && yp < y + heigh) {
      return true;
    }
    return false;
  }
}
