interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
}

class Rock extends Thing {
  Rock(float x, float y) {
    super(x, y);
  }

  void display() { 
    /* ONE PERSON WRITE THIS */
    fill(0,200,30);
    rect(x,y,50,50);
    fill(18);
    rect(x + 10, y + 10, 7, 16);
    rect(x + 30, y + 10, 7, 16);
    line(x + 15, y + 40, x + 35, y + 40);
  }
}

public class LivingRock extends Rock implements Moveable {
  int xd, yd;
  String movement;
  LivingRock(float x, float y) {
    super(x, y);
    xd = yd =  10;
    movement = "bounce";
  }
  void move() {
      if (movement == "bounce") {
        if (x >= width - 35|| x <= 0) {
          xd *= -1;
        }
        if (y >= height - 35 || y <= 0) {
          yd *= -1;
        }
        x += xd;
        y += yd;
      }
  }
}

class Ball extends Thing implements Moveable {
  Ball(float x, float y) {

    super(x, y);
  }

  void display() {
    fill(255, 0, 0);
    ellipse(x, y, 50, 50);
  }

  void move() {
    /* ONE PERSON WRITE THIS */
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
  }

  LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
  thingsToDisplay.add(m);
  thingsToMove.add(m);
}

void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
}
