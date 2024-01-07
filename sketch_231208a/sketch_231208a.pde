import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort;
String angle = "";
String distance = "";
String data = "";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1 = 0;
int index2 = 0;
PFont orcFont;


void setup() {
  size(1300, 650); // Canva boyutu ayarla
  smooth();
  myPort = new Serial(this, "COM5", 9600);
  myPort.bufferUntil('.');
  orcFont = loadFont("ROGFonts-Regular-48.vlw");
}


void draw() {
  fill(98, 245, 31);
  textFont(orcFont);
  noStroke();
  fill(0, 4);
  rect(0, 0, width, height - 40); // Radar için ayarılan bölgeyi tanımla

  fill(98, 245, 31);
  drawRadar();
  drawLine();
  drawObject();
  drawText();
}


void serialEvent(Serial myPort) {
  data = myPort.readStringUntil('.');
  data = data.substring(0, data.length() - 1);

  index1 = data.indexOf(",");
  angle = data.substring(0, index1);
  distance = data.substring(index1 + 1, data.length());

  iAngle = Integer.parseInt(angle);
  iDistance = Integer.parseInt(distance);
}


void drawRadar() {
  pushMatrix();
  translate(650, height - 80); // Radar sisteminin koordinatlarını tanımla
  noFill();
  strokeWeight(2);
  stroke(98, 245, 31);

  arc(0, 0, 900, 900, PI, TWO_PI); // 4.Çemberi belirle
  arc(0, 0, 700, 700, PI, TWO_PI); // 3.Çemberi belirle
  arc(0, 0, 500, 500, PI, TWO_PI); // 2.Çemberi belirle
  arc(0, 0, 300, 300, PI, TWO_PI); // 1.Çemberi belirle

  line(-450, 0, 450, 0); // Radar alt çizgisinin boyutunu belirle
  line(0, 0, -450 * cos(radians(30)), -450 * sin(radians(30))); //  Radar 1. çizginin boyutunu belirle
  line(0, 0, -450 * cos(radians(60)), -450 * sin(radians(60))); //  Radar 2. çizginin boyutunu belirle
  line(0, 0, -450 * cos(radians(90)), -450 * sin(radians(90))); //  Radar 3. çizginin boyutunu belirle
  line(0, 0, -450 * cos(radians(120)), -450 * sin(radians(120))); //  Radar 4. çizginin boyutunu belirle
  line(0, 0, -450 * cos(radians(150)), -450 * sin(radians(150))); //  Radar 5. çizginin boyutunu belirle
  line(-450 * cos(radians(30)), 0, 450, 0); //  Radar alt çizgisinin boyutunu belirle
  popMatrix();
}


void drawObject() {
  pushMatrix();
  translate(650, height - 80); // Radarın başlangıç noktası olan kırmızı çubuğun yerini belirle
  strokeWeight(5);
  stroke(255, 10, 10);
  pixsDistance = iDistance * 11.25;

  if (iDistance < 40) {
    line(pixsDistance * cos(radians(iAngle)), -pixsDistance * sin(radians(iAngle)), 445 * cos(radians(iAngle)), -445 * sin(radians(iAngle))); // Radarın başlangıç noktası olan kırmızı çubuğun uzunluğu
  }
  popMatrix();
}


void drawLine() {
  pushMatrix();
  strokeWeight(5);
  stroke(30, 250, 60);
  translate(650, height - 80); // Radar çubuğunu belirle
  line(0, 0, 445 * cos(radians(iAngle)), -445 * sin(radians(iAngle))); // Radar çubuğunun uzunluğu
  popMatrix();
}


void drawText() {
  pushMatrix();
  if (iDistance > 40) {
    noObject = "Out of Range";
  } else {
    noObject = "In Range";
  }

  fill(0, 0, 0);
  noStroke();
  rect(0, height - 40, width, height); // Alt bölümün yüksekliğini belirle
  fill(98, 245, 31);
  textSize(15); // Uzaklık metninin boyutunu ayarla
  text("40cm", 180, height - 60); // Uzaklık metnini ayarla
  text("30cm", 280, height - 60); // Uzaklık metnini ayarla
  text("20cm", 380, height - 60); // Uzaklık metnini ayarla
  text("10cm", 480, height - 60); // Uzaklık metnini ayarla
  text("0", 645, height - 60); // Uzaklık metnini ayarla
  text("10cm", 780, height - 60); // Uzaklık metnini ayarla
  text("20cm", 880, height - 60); // Uzaklık metnini ayarla
  text("30cm", 980, height - 60); // Uzaklık metnini ayarla
  text("40cm", 1080, height - 60); // Uzaklık metnini ayarla

  textSize(17); // Hedef metninin boytunu ayarla
  text("Object: " + noObject, 120, height - 10); // Hedef durumunu gösterir metin ayarlamaları
  text("Angle: " + iAngle + " °", 525, height - 10); // Taranan dereceyi gösterir metin ayarlamaları
  text("Distance: ", 880, height - 10); // Tespit edilen hedef gösterir metin ayarlamaları

  if (iDistance < 40) {
    text("        " + iDistance + " cm", 955, height - 10); // Tespit edilen hedefin uzaklığını gösterir metin ayarlamaları
  }

  textSize(15); // Yön göstergelerinin metin boyutunu ayarla
  fill(98, 245, 60);
  
  translate(650 + 450 * cos(radians(30)), height - 90 - 450 * sin(radians(30))); // Çubukların derecelerini gösteren metin ayarlamaları
  rotate(-radians(-60));
  text("30°", 0, 0);
  resetMatrix();
  
  translate(644 + 450 * cos(radians(60)), height - 90 - 450 * sin(radians(60))); // Çubukların derecelerini gösteren metin ayarlamaları
  rotate(-radians(-30));
  text("60°", 0, 0);
  resetMatrix();
  
  translate(639 + 450 * cos(radians(90)), height - 85 - 450 * sin(radians(90))); // Çubukların derecelerini gösteren metin ayarlamaları
  rotate(radians(0));
  text("90°", 0, 0);
  resetMatrix();
  
  translate(635 + 450 * cos(radians(120)), height - 77 - 450 * sin(radians(120))); // Çubukların derecelerini gösteren metin ayarlamaları
  rotate(radians(-30));
  text("120°", 0, 0);
  resetMatrix();
  
  translate(640 + 450 * cos(radians(150)), height - 70 - 450 * sin(radians(150))); // Çubukların derecelerini gösteren metin ayarlamaları
  rotate(radians(-60));
  text("150°", 0, 0);
  
  popMatrix();
}
