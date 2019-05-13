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
  void changecolor();
}

abstract class Thing implements Displayable, Collideable {
  float x, y;//Position of the Thing
  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
  abstract void move();
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
  void move() {
  };
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

  void changecolor() {
    fill(0, 255, 0);
    rect(x+10, y+10, 7, 16);
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
  float t, r, speed;
  LivingRock(float x, float y) {
    super(x, y);
    int choice = (int) random(3);
    xd = yd =  10;
    r = random(100) + 50;
    t = 0;
    speed = 0;
    switch (choice) {
    case 0:
      movement = "lines";
      break;
    case 1:
      movement = "circle";
      break;
    default:
      movement = "up and down";
    }
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
    if (movement.equals("lines")) {
      if (x >= width - 35|| x <= 0) {
        xd *= -1;
      }
      if (y >= height - 35 || y <= 0) {
        yd *= -1;
      }
      x += xd;
      y += yd;
    } else if (movement.equals("circle")) {
      x = (int)(height / 2 + r*sin(t));
      y = (int)(width / 2 - r*cos(t));
      t += 0.05;
    } else if (movement.equals("up and down")) {
      if (x >= width - 35|| x <= 0) {
        xd *= -1;
      }

      x += xd;
      y += yd / 3;

      if (t == 10) {  
        if ((int) random(2) == 1) {
          y = height / 3;
        } else {
          y  = 2 * height / 3;
        }
        t = 0;
      }
      t += 0.5;
    }
  }
}

class Ball extends Thing implements Moveable, Collideable, Displayable {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float radius;
  boolean movetype;
  float t, r;

  Ball(float x, float y) {
    super(x, y);
    position = new PVector(random(100, 800), random(100, 800));
    velocity = new PVector(random(2, 5), random(2, 5));
    acceleration = new PVector(0, random(0.1, 0.3)); // no x acc
    radius = 50; // initial radius
  }  

  void changecolor() {
    fill(255, 0, 0);
    ellipse(position.x, position.y, radius*1.5, radius*1.5);
  }

  void display() {
    fill(0, 0, 0);
    ellipse(position.x, position.y, radius * 1.5, radius* 1.5);
  }

  void move() {
  }

  boolean isTouching(Thing other) {
    return (dist(position.x, position.y, other.x, other.y) < 1.5 * radius);
  }
}

class Bouncyball extends Ball {
  Bouncyball(float x, float y) {
    super(x, y);
  }

  void move() {
    bounce();
  }

  void bounce() {
    position.add(velocity);
    velocity.add(acceleration);

    if (position.x > width || position.x < 0) {
      velocity.x = velocity.x * -1;
    }

    if (position.y > height) {
      velocity.y = velocity.y * -0.95; 
      position.y = height;
    }
  }

  void display() {
    fill(0, 0, 0);
    ellipse(position.x, position.y, radius * 1.5, radius* 1.5);
  }


  void changecolor() {
    fill(0, 255, 56);
    ellipse(position.x, position.y, radius * 1.5, radius* 1.5);
  }

  boolean isTouching(Thing other) {
    return (dist(position.x, position.y, other.x, other.y) < 1.5 * radius);
  }
}


/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> ListOfCollideables;
ArrayList<Thing> holder;

void setup() {
  size(1000, 800);
  img1 = loadImage("ro.jpg");
  img2 = loadImage("rock.jpg");
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  ListOfCollideables = new ArrayList<Collideable>();
  holder = new ArrayList<Thing>();
  for (int i = 0; i < 5; i++) {
    Ball b = new Bouncyball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    ListOfCollideables.add(b);
    //Ball b = new Ball2(50+random(width-100), 50+random(height-100));
    //thingsToDisplay.add(b);
    //thingsToMove.add(b);
  }
  for (int i = 0; i < 10; i++) {
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
    ListOfCollideables.add(r);
    holder.add(r);
  }

  LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
  thingsToDisplay.add(m);
  thingsToMove.add(m);
  ListOfCollideables.add(m);
  holder.add(m);
}

void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }

  for (Moveable thing : thingsToMove) {
    thing.move();
  }
  for (Thing thing : holder) {
    for (Collideable collide : ListOfCollideables) {
      if (collide.isTouching(thing)) {
        collide.changecolor();
      } else {
      }
    }
  }
}
