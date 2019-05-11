interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

interface Collideable {
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

class Rock extends Thing implements Collideable {
  PImage img;
  Rock(float x, float y) {
    super(x, y);
    if ((int) random (2) == 1) {
      img = loadImage("ro.jpg");
    } else {
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
    image(img, x, y, 50, 50);
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
  float t;
  float r;
  LivingRock(float x, float y) {
    super(x, y);
    r = dist(x, y, height/2, width/2);
    xd = yd =  10;
    t = 0;
    movement = "circle";
  }
  @Override
    void display() {
    super.display();
    fill(255, 100, 0);
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
    if (movement == "circle") {
      float t = millis()/1000.0f;
      x = (int)(50+r*cos(t));
      y = (int)(50+r*sin(t));
    }
  }
}

class Ball extends Thing implements Moveable {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxheight = height * 0.2;
  
  String colur;
  Ball(float x, float y) {
    super(x, y);
    if ((int) random (2) == 1) {
      colur = "red";
    } else {
      colur = "blue";
    }
    //position.add(velocity); 
    //velocity.add(acceleration);
  }

  void display() {
    if (colur == "red") {
      fill(255, 0, 0);
      arc(x, y, 50, 50, radians(0), radians(360), PIE);
    } else {
      fill(0, 0, 255);
      arc(x, y, 50, 50, radians(0), radians(360), PIE);
    }
  }

  void move() {
    bounce();
  }

  void bounce() {
    location.add(velocity);
    velocity.add(gravity);
    if ((location.x > width) || (location.x < 0)) {
      velocity.x = velocity.x * -1;
    }
    if (location.y > height) {
      velocity.y = velocity.y * -0.95; 
      location.y = height;
    }
  }

  class colorChangingBall extends Ball {
    colorChangingBall(float x, float y) {
      super(x, y);
    }
    void changecolor() {
      fill(0, 0, 0);
    }

    void display() {
      super.display();
      for ( Collideable c : ListOfCollideables) {
        if ( c.isTouching(this)) {
          changecolor();
          arc(x, y, 50, 50, radians(0), radians(360), PIE);
        }
      }
    }
  }

  class sizeChangingBall extends Ball {
    sizeChangingBall(float x, float y) {
      super(x, y);
    }
    void move() {
      super.move();
    }
    void display() {
      super.display();
    }
  }

  /*DO NOT EDIT THE REST OF THIS */

  ArrayList<Displayable> thingsToDisplay;
  ArrayList<Moveable> thingsToMove;
  ArrayList<Collideable> ListOfCollideables;

  void setup() {
    size(1000, 800);
    position = new PVector(100, 100);
    velocity = new PVector(1.5, 2);
    acceleration = new PVector(0, 0.3);

    thingsToDisplay = new ArrayList<Displayable>();
    thingsToMove = new ArrayList<Moveable>();
    ListOfCollideables = new ArrayList<Collideable>();
    for (int i = 0; i < 5; i++) {
      Ball b = new colorChangingBall(50+random(width-100), 50+random(height-100));
      thingsToDisplay.add(b);
      thingsToMove.add(b);
      Ball b1 = new sizeChangingBall(50+random(width-100), 50+random(height-100));
      thingsToDisplay.add(b1);
      thingsToMove.add(b1);
    }
    for (int i = 0; i < 10; i++) {
      Rock r = new Rock(50+random(width-100), 50+random(height-100));
      thingsToDisplay.add(r);
      ListOfCollideables.add(r);
    }

    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
    ListOfCollideables.add(m);
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
