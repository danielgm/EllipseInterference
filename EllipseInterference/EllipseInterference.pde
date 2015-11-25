import themidibus.*;

final int MIDI_MIN = 0;
final int MIDI_MAX = 128;

MidiBus bus;

ConcentricEllipse ellipse0, ellipse1;

void setup() {
  size(1024, 768);
  frameRate(5);

  MidiBus.list();
  bus = new MidiBus(this, 0, 1);

  ellipse0 = new ConcentricEllipse(width/2, height/2, 200, 200);
  ellipse1 = new ConcentricEllipse(width/2, height/2, 200, 200);

  zero();
}

void draw() {
  background(0);

  g.pushStyle();
  g.noFill();

  g.stroke(255, 128);
  g.strokeWeight(1);

  ellipse0.draw(g);
  ellipse1.draw(g);

  g.popStyle();

  g.text(ellipse0.toString(), 10, 20);
  g.text(ellipse1.toString(), 10, 100);
}

void zero() {
  for (int i = 0; i < 24; i++) {
    controllerChange(0, i, MIDI_MIN);
  }
}

void controllerChange(int channel, int number, int value) {
  println(channel, number, value);
  float maxOffset = 50;
  float minSize = 100;
  float maxSize = 400;
  float minFactor = 1.01;
  float maxFactor = 1.08;
  float minHeightRatio = 1;
  float maxHeightRatio = 2;
  float minStartIndex = 0;
  float maxStartIndex = 128;

  switch (number) {

    // Sliders.

    case 0:
      println("center x");
      ellipse0.centerX = midiMap(value, width/2 - maxOffset, width/2 + maxOffset);
      break;
    case 1:
      println("center y");
      ellipse0.centerY = midiMap(value, height/2 - maxOffset, height/2 + maxOffset);
      break;

    case 2:
      println("center x");
      ellipse1.centerX = midiMap(value, width/2 - maxOffset, width/2 + maxOffset);
      break;
    case 3:
      println("center y");
      ellipse1.centerY = midiMap(value, height/2 - maxOffset, height/2 + maxOffset);
      break;

    case 4:
      println("base width");
      ellipse0.baseWidth = midiMap(value, minSize, maxSize);
      break;
    case 5:
      println("base height");
      ellipse0.baseHeight = midiMap(value, minSize, maxSize);
      break;

    case 6:
      println("base width");
      ellipse1.baseWidth = midiMap(value, minSize, maxSize);
      break;
    case 7:
      println("base height");
      ellipse1.baseHeight = midiMap(value, minSize, maxSize);
      break;

    // Knobs.

    case 16:
      println("size factor");
      ellipse0.widthFactor = midiMap(value, minFactor, maxFactor);
      break;
    case 17:
      println("height ratio");
      ellipse0.heightRatio = midiMap(value, minHeightRatio, maxHeightRatio);
      break;

    case 18:
      println("size factor");
      ellipse1.widthFactor = midiMap(value, minFactor, maxFactor);
      break;
    case 19:
      println("height ratio");
      ellipse1.heightRatio = midiMap(value, minHeightRatio, maxHeightRatio);
      break;

    case 20:
      println("start index");
      ellipse0.startIndex = midiMap(value, minStartIndex, maxStartIndex);
      break;
    case 21:
      println("start index");
      ellipse1.startIndex = midiMap(value, minStartIndex, maxStartIndex);
      break;

    case 22:
      println("rotation");
      ellipse0.rotation = midiMap(value, 0, PI);
      break;
    case 23:
      println("rotation");
      ellipse1.rotation = midiMap(value, 0, PI);
      break;

    default:
  }
}

float midiMap(float value, float minValue, float maxValue) {
  return map(value, MIDI_MIN, MIDI_MAX, minValue, maxValue);
}

