PImage img1;
PImage img2;
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
      img = img1;
    } else {
      img = img2;
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
    
    xd = yd =  10;
    r = random(100) + 50;
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
    if (movement == "lines") {
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
      x = (int)(height / 2 +r*sin(t));
      y = (int)(width / 2 -r*cos(t));
      t += 0.05;
    }
    else {
      
    }
  }
}

class Ball extends Thing implements Moveable {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxheight = height * 0.2;
  float radius;
  String colur;

  Ball(float x, float y) {
    super(x, y);
    if ((int) random (2) == 1) {
      colur = "red";
    } else {
      colur = "blue";
    }
    position = new PVector(random(100, 800), random(100, 800));
    velocity = new PVector(random(2, 5), random(2, 5));
    acceleration = new PVector(0, random(0.1, 0.3)); // no x acc
    radius = 50; // initial radius
  }

  void display() {
    if (colur == "red") {
      fill(255, 0, 0);
      ellipse(position.x, position.y, radius, radius);
    } else {
      fill(0, 0, 255);
      ellipse(position.x, position.y, radius, radius);
    }
  }

  void move() {
    bounce();
  }

  void bounce() {
    position.add(velocity);
    velocity.add(acceleration);
    if ((position.x > width) || (position.x < 0)) {
      velocity.x = velocity.x * -1;
    }
    if (position.y > height) {
      velocity.y = velocity.y * -0.95; 
      position.y = height;
    }
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
    fill(255,0,0);
    for ( Collideable c : ListOfCollideables) {
      if ( c.isTouching(this)) {
        changecolor();
        ellipse(position.x, position.y, radius, radius);
      } else {
        super.display();
      }
    }
  }
}

class sizeChangingBall extends Ball {      
  float var = random(10, 50);
  float var2 = random(50, 90);
  sizeChangingBall(float x, float y) {
    super(x, y);
  }
  void move() {
    super.move();
  }

  void display() {
    fill(255,0,0);
    for ( Collideable c : ListOfCollideables) {
      if ( c.isTouching(this)) {
        if (radius > 50) {
          fill(0, 192, 0);
          ellipse(position.x, position.y, var, var);
        } else {
          ellipse(position.x, position.y, var2, var2);
        }
      } else {
        super.display();
      }
    }
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> ListOfCollideables;

void setup() {
  size(1000, 800);
  img1 = loadImage("ro.jpg");
  img2 = loadImage("rock.jpg");
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
