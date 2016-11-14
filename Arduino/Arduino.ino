#include <LiquidCrystal.h>

LiquidCrystal lcd(8,9,4,5,6,7);

byte batterie=A1; 

void setup() {
  Serial.begin(9600);
  lcd.begin(16,2); // initialisation de l'écran LCD
  lcd.clear(); // effacement de l'écran LCD
}

void loop() {
  int valBatterie=analogRead(batterie);
  Serial.print(valBatterie);
  Serial.print('\n');
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print(int(valBatterie/1023.0*255.0));
  delay(100);
}
