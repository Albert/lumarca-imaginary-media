// in this particular program, projector is at (0, 0, 0)

float nearPlane;     // distance from projector to close plane
float farPlane;      // distance from projector to far plane
PVector renderField; // x left right, y is near far
int numOfStrings;
PVector[] strings;
float projectorRatio;

float unitsPerStringNear;
float unitsPerStringFar;

void setup() {
  size(1024, 768);
  numOfStrings = 85;
  strings = new PVector[numOfStrings];
  renderField = new PVector(17.0, 16.0);
  farPlane = 39.0;
  nearPlane = farPlane - renderField.y;
  projectorRatio = nearPlane / (renderField.x);

  unitsPerStringNear = renderField.x / float(numOfStrings);
  unitsPerStringFar = unitsPerStringNear * (farPlane / nearPlane);

  for (int i = 0; i < numOfStrings; i++) {
    float depth = getWeightedRandom();
    float nearPlaneXOffset = -(renderField.x / 2) + (float(i) * unitsPerStringNear);
    float xLocation = (depth + nearPlane) * (nearPlaneXOffset / nearPlane);
    
    strings[i] = new PVector(xLocation, depth);
  }
}

void draw() {
  float radius = 2.0;
  for (int i = 0; i < numOfStrings; i++) {
    float x = map(strings[i].x, -(renderField.x / 2), renderField.x / 2, 0, 1024);
    float y = map(strings[i].y, 0, renderField.y, 0, 768);
    ellipse(x, y, radius, radius);
  }
}

float getWeightedRandom() {
  /*
    If not weighted, string placement will have higher density close to the near plane.
    Weighting is done by finding potential spots, and statistically removing an reassigning
  */
  boolean findNewPotential = true;
  float potentialSpot = 0;
  float lowestChance, chance;
  lowestChance = unitsPerStringNear / unitsPerStringFar; // something like .58
  while (findNewPotential) {
    potentialSpot = random(renderField.y); // 0 and 15

    chance = map(potentialSpot, 0, renderField.y, lowestChance, 1.0);

    if (random(1) < chance) {
      findNewPotential = false;
    }
  }
  return potentialSpot;
}
