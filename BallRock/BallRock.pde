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
  void changecol();
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

  boolean isTouching(Thing other) {
    float xdist = abs(x - other.x);
    float ydist = abs(y - other.y);
    return xdist < 50 && ydist < 50;
  }

  void changecol() {
  };
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
  float dy; //not using vector 
  float dx;

  Ball(float x, float y) {
    super(x, y);
    radius = 50; // initial radius
  }  

  void changecol() {
  }

  void display() {
    fill(0, 0, 0);
    ellipse(position.x, position.y, radius * 1.5, radius* 1.5);
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

  boolean isTouching(Thing other) {
    return (dist(position.x, position.y, other.x, other.y) < 1.5 * radius);
  }
}

class colorBall extends Ball {
  colorBall(float x, float y) {
    super(x, y);
    position = new PVector(random(100, 400), random(100, 400));
    velocity = new PVector(random(3, 4), random(3, 4));
    acceleration = new PVector(0, random(0.1, 0.3));
  }

  void move() {
    super.move();
  }

  void display() {
    fill(0, 0, 0);
    ellipse(position.x, position.y, radius * 1.5, radius* 1.5);
  }

  void changecol() {
    fill(0, 255, 56);
    rect(position.x - radius * 0.3, position.y, radius * 0.5, radius* 0.5);
    rect(position.x + radius * 0.3, position.y, radius * 0.5, radius* 0.5);
    rect(position.x, position.y + radius * 0.3, radius * 0.5, radius* 0.5);
    rect(position.x, position.y - radius * 0.3, radius * 0.5, radius* 0.75);
  }

  boolean isTouching(Thing other) {
    return (dist(position.x, position.y, other.x, other.y) < 1.5 * radius);
  }
}

class Ball2 extends Ball {
  Ball2(float x, float y) {
    super(x, y);
    position = new PVector(random(100, 300), random(100, 300));
    dy = dx= 2;
  }

  void display() {
    fill(80, 208, 255);
    ellipse(x, y, radius * 0.6, radius* 0.6);
  }

  void changecol() {
    fill(255, 96, 208);
    triangle(x - 12, y - 12, x + 0.6 * radius -12, y - 12,(2*x+0.6*radius)/2 -12, y + 0.5*radius - 12);
  }

  void move() {
    if (y <= 0 || height <= y) {
      if (dy > 0) {
        dy = random(5, 7);
        dy *= -1;
      } else {
        dy = random(5, 7);
      }
    }
    if (x >= width || x <= 0) {
      if (dx > 0) {
        dx = random(5, 7);
        dx *= -1;
      } else {
        dx = random(5, 7);
      }
    }
    x += dx;
    y += dy;
  }

  boolean isTouching(Thing other) {
    return (dist(x, y, other.x, other.y) < 1 * radius);
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
    Ball b = new colorBall(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    ListOfCollideables.add(b);
    Ball b1 = new Ball2(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b1);
    thingsToMove.add(b1);
    ListOfCollideables.add(b1);
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
        collide.changecol();
      } else {
      }
    }
  }
}
