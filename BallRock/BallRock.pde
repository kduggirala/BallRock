interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

interface Collidable {
  boolean isTouching(Thing other);
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
}

class Rock extends Thing implements Collidable {
  PImage img;
  Rock(float x, float y) {
    super(x, y);
    if ((int) random (2) == 1) {
      img = loadImage("ro.jpg");
      
    }
    else {
      img = loadImage("rock.jpg");
    }
  }

  void display() { 
    /* ONE PERSON WRITE THIS */
    /*fill(0,200,30);
    rect(x,y,50,50);
    fill(18);
    rect(x + 10, y + 10, 7, 16);
    rect(x + 30, y + 10, 7, 16);
    line(x + 15, y + 40, x + 35, y + 40);
    */
    image(img,x,y,50,50);
  }
  
  boolean isTouching(Thing other) {
    float xdist = abs(x - other.x);
    float ydist = abs(y - other.y);
    return xdist < 50 && ydist < 50;
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
  @Override
  void display() {
    super.display();
    fill(255,100,0);
    rect(x + 10, y + 10, 7, 10);
    rect(x + 30, y + 10, 7, 10);
    line(x + 15, y + 40, x + 35, y + 40);
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
  float r = random(255);
  float g = random(255);
  float b = random(255);
  float r1 = random(255);
  float g1 = random(255);
  float b1 = random(255);
  float r2 = random(255);
  float g2 = random(255);
  float b2 = random(255);
  Ball(float x, float y) {

    super(x, y);
  }

  void display() {
    fill(r, g, b);
    arc(x, y, 50, 50, radians(90), radians(90)+2*THIRD_PI, PIE);
    fill(r1, g1, b1);
    arc(x, y, 50, 50, radians(210), radians(210)+2*THIRD_PI, PIE);
    fill(r2, g2, b2);
    arc(x, y, 50, 50, radians(330), radians(330)+2*THIRD_PI, PIE);
  }

  void move() {
    /* ONE PERSON WRITE THIS */
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collidable> listOfCollidables;

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
    listOfCollidables.add(r);
  }

  LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
  thingsToDisplay.add(m);
  thingsToMove.add(m);
  listOfCollidables.add(m);
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
