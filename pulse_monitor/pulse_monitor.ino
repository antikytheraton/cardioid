// Pulse Monitor Test Script

// Valores entre 500 y 530

int sensorPin = 0;
double alpha = 0.75;
int period = 10;
double change = 0.0;
double minval = 0.0;
void setup ()
{
  Serial.begin (9600);
}
void loop ()
{
    static double oldValue = 0;
    static double oldChange = 0;
 
    int rawValue = analogRead (sensorPin);
    double value = alpha * oldValue + (1 - alpha) * rawValue;
 
//    Serial.print (rawValue);
//    Serial.print ("\t");
    Serial.println (value);
    oldValue = value;
 
    delay (period);
}
