import processing.pdf.*;
float ppi = 300.0;
//float ppi = 50.0;

PVector renderField; // x left right, y is near far

void setup() {
  renderField = new PVector(17.0, 16.0);
  size(int(renderField.x * ppi), int(renderField.y * ppi), PDF, "print.pdf");
  //size(int(renderField.x * ppi), int(renderField.y * ppi));
}

void draw() {
  background(255);
  String lines[] = loadStrings("lines.txt");
  textSize(12);
  for (int i = 0; i < lines.length; i++) {
    float x = (float(lines[i].split(" ")[0]) + (renderField.x / 2.0)) * ppi;
    float y = float(lines[i].split(" ")[1]) * ppi;
    fill(255);
    rect(x-5, y-5, 10, 10);
    line(x-5, y-5, x+5, y+5);
    line(x-5, y+5, x+5, y-5);
    fill(0);
    text(str(i), x-5, y-5); 
  }
  exit();
}
