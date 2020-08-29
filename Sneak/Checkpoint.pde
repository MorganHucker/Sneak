class Checkpoint {
  float x;
  float y;
  float xI = 100;
  float yI = 5;
  float wid = 40;
  float heigh = 70;
  float widI = 20;
  float heighI = 35;

  public Checkpoint() {
  }

  public Checkpoint(float xc, float yc) {
    x = xc;
    y = yc;
  }

  float getX() {
    return x;
  }
  float getY() {
    return y;
  }

  void drawFlag() {
    image(flag, x, y, wid, heigh);
  }
  //draws small flag for icon
  void drawIcon(int i) { 
    translate(xI+i*30, yI);
    rotate(radians(-30));
    image(flag, 0, 0, widI, heighI);
    rotate(radians(30));
    translate(-(xI+i*30), -yI);
  }
}
