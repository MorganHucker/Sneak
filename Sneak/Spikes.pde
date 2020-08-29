class Spikes {
  float x;
  float y;
  float w = 100;
  float h = 100;
  public Spikes(float xc, float yc) {
    x = xc;
    y = yc;
  } 
  void drawSpikes() {
    image(spikesPNG, x, y, w, h); 
    if (containsPoint(pos.x, pos.y) || containsPoint(pos.x + 30, pos.y  + 50) ||   containsPoint(pos.x + 30, pos.y) ||   containsPoint(pos.x, pos.y+ 50)) {
      displayNum = 3;
    }
  }
  boolean containsPoint(float xp, float yp) {
    if (xp > x +20 && xp+20 < x + w && yp > y+8 && yp < y + h/2) {
      return true;
    }
    return false;
  }
}
