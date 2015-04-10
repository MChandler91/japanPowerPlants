float meridian = 138f;
float lower = 30.62f;
float upper = 46.23f;

String [] nameAndLocation;
String [] activityData;
String [] nameAndLocation1;
String [] activityData1;
PImage japanMap;

float minX, minY, maxX, maxY;


void setup() {
  size(950, 950);
  japanMap = loadImage("japanMapW.png");

  processFiles();
  minX = getX(30.858646, 129.477627);
  maxX = getX(45.372774, 148.7);
  minY = getY(30.858646, 129.477627);
  maxY = getY(45.372774, 148.7);
}

void draw() {
  image(japanMap, 0, 0, width, height); 
  fill(200);
  stroke(0);
  strokeWeight(3);
  rect(600, 855, 400, 100);
  for (int i = 1; i < nameAndLocation.length; i++) {
    String[] nameAndLocation1 = split(nameAndLocation[i], TAB);
    String[] activityData1 = split(activityData[i], TAB);

    float x = getX(parseFloat(nameAndLocation1[1]), parseFloat(nameAndLocation1[2]));
    float y = getY(parseFloat(nameAndLocation1[1]), parseFloat(nameAndLocation1[2]));

    float realX = map(x, minX, maxX, 0, width);
    float realY = map(y, minY, maxY, 0, height);

    fill(255,0,0);
    stroke(0);
    strokeWeight(0);
    ellipse(realX, height-realY, 8, 8);
    

    if (dist(mouseX, mouseY, realX, height-realY) < 3) {
        fill(0);
         textSize(14);
         textAlign(LEFT);
         text(nameAndLocation1[0], 610, 895);
         textSize(14);
         text(activityData1[1], 610, 925);
      }
    }
}

float getX(float lat, float lon) {
  float phi0 = 0;
  float lambda0 = radians(meridian);
  float phi1 = radians(lower);
  float phi2 = radians(upper);

  float phi = radians(lat);
  float lambda = radians(lon);

  float n = 0.5f * (sin(phi1) + sin(phi2));
  float theta = n * (lambda - lambda0);
  float c = sq(cos(phi1)) + 2*n*sin(phi1);
  float rho = sqrt(c - 2*n*sin(phi)) / n;
  float rho0 = sqrt(c - 2*n*sin(phi0)) / n;

  return rho * sin(theta);
}

float getY(float lat, float lon) {
  float phi0 = 0;
  float lambda0 = radians(meridian);
  float phi1 = radians(lower);
  float phi2 = radians(upper);

  float phi = radians(lat);
  float lambda = radians(lon);

  float n = 0.5f * (sin(phi1) + sin(phi2));
  float theta = n * (lambda - lambda0);
  float c = sq(cos(phi1)) + 2*n*sin(phi1);
  float rho = sqrt(c - 2*n*sin(phi)) / n;
  float rho0 = sqrt(c - 2*n*sin(phi0)) / n;

  return rho0 - rho*cos(theta);
}

void processFiles() {
  nameAndLocation = loadStrings("JapanPowerPlants.txt");
  activityData = loadStrings("powerplantActive.txt");
}

