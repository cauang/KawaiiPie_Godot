const int button1Pin = 12; // P1 = Enter
const int button2Pin = 14; // P2 = Space

void setup() {
  Serial.begin(9600);
  pinMode(button1Pin, INPUT_PULLUP);
  pinMode(button2Pin, INPUT_PULLUP);
}

void loop() {
  if (digitalRead(button1Pin) == LOW) {
    Serial.println("P1");
    delay(200);
  }
  if (digitalRead(button2Pin) == LOW) {
    Serial.println("P2");
    delay(200);
  }
}
