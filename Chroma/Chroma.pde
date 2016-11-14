import processing.serial.*;

Serial serial = new Serial(this, Serial.list()[0], 9600);
int stateButtonR = 0, stateButtonG = 0, stateButtonB = 0, statButtonUse=0, dataR=255, dataG=255, dataB=255, data = 1023;

void setup() {
  size(600, 600);
}

void draw() {
  if (statButtonUse == 0) {
    if (serial.available() > 0) {
      StringBuilder builder = new StringBuilder();
      while (!builder.toString().endsWith("\n")) {
        String buff = serial.readString();
        if (buff == null)
          continue;
        builder.append(buff);
      }
      data = int(builder.toString().split("\n")[0]);
      if (stateButtonR == 1)
        dataR = (int)(data/1023.0*255.0);
      if (stateButtonG == 1)
        dataG = (int)(data/1023.0*255.0);
      if (stateButtonB == 1)
        dataB = (int)(data/1023.0*255.0);
    }
  }

  background(dataR, dataG, dataB);
  //RED
  displayButton(255, 0, 0, 187.5, 100, 25, 75, stateButtonR);

  //GREEN
  displayButton(0, 255, 0, 287.5, 100, 25, 75, stateButtonG);

  //BLUE
  displayButton(0, 0, 255, 387.5, 100, 25, 75, stateButtonB);

  //CHOIX
  displayButton(125, 125, 125, 262.5, 25, 75, 25, statButtonUse);
}

void mouseClicked() {
  if (mouseX > 187.5 && mouseX < 212.5 && mouseY > 100 && mouseY < 175) {
    stateButtonR = stateButtonR == 0?1:0;
    stateButtonG = stateButtonB = 0;
  } else if (mouseX > 287.5 && mouseX < 312.5 && mouseY > 100 && mouseY < 175) {
    stateButtonG = stateButtonG == 0?1:0;
    stateButtonR = stateButtonB = 0;
  } else if (mouseX > 387.5 && mouseX < 412.5 && mouseY > 100 && mouseY < 175) {
    stateButtonB = stateButtonB == 0?1:0;
    stateButtonR = stateButtonG = 0;
  } else if (mouseX > 262.5 && mouseX < 337.5 && mouseY > 25 && mouseY < 75) {
    statButtonUse = statButtonUse == 0?1:0;
  }
}

void mouseWheel(MouseEvent event) {
  if ()
    float e = event.getCount();
  if (stateButtonR == 1 && dataR+e <= 1023 && dataR-e >=0)
    dataR += e;
  if (stateButtonG == 1 && dataG+e <= 1023 && dataG-e >=0)
    dataG += e;
  if (stateButtonB == 1 && dataB+e <= 1023 && dataB-e >=0)
    dataB += e;
}

/*
 * colorR -> compris entre 0 et 255, couleur Rouge
 * colorG -> compris entre 0 et 255, couleur Verte
 * colorB -> compris entre 0 et 255, couleur Bleue
 * x -> coordoné x du coté droit du curseur
 */
void displayButton(int colorR, int colorG, int colorB, float x, float y, float sizeX, float sizeY, int state) {
  fill(colorR, colorG, colorB);
  rect(x, y, sizeX, sizeY);
  fill(255);
  rect(x + (sizeX>sizeY?(state==1?50:0):0), y + (sizeX<sizeY?(state==1?50:0):0), 25, 25);
}