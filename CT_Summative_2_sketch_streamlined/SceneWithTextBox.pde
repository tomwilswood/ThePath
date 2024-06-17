class SceneWithTextBox extends Scene {
  PImage bgImage;
  PImage textBox;
  int textBoxX = 0;
  int textBoxY = 0;
  int textInBoxX = 10;
  String bodyText1; 
  String bodyText2; 
   

  String textInBox ="";

  SceneWithTextBox(int newKoanNumber, int newKoanNumberOffset, String newTitle, int newTitleSize, PFont newTitleFont, int newID, String newBgImage) {
    super(newKoanNumber, newKoanNumberOffset, newTitle, newTitleSize, newTitleFont, newID);
    bgImage = loadImage(newBgImage);
    textBox = loadImage("textBox.png");
  }

  void draw() {
    image(bgImage, 0, 0, width, height-120); //drawing the background
    noTint();
    image(textBox, textBoxX, textBoxY, width, height); //drawing the text box
    noStroke();
    fill(bgColour);
    rect(textBoxX,height+textBoxY, width, -textBoxY); //fillling in the space "below" the text box with background colour.
    
    fill(0, blackBgAlpha);
    rect(0, 0, width, height);
    super.draw();



    //drawing the current text to the box
    fill(0, textAlpha);
    textFont(TNRReg);
    textAlign(LEFT);
    textSize(20);
    text(textInBox, textInBoxX, height+textBoxY-100, width-(textInBoxX*2), 100-textBoxY); //sets the text box coordinates to automatically scale with the size of the drawn textBox
  }
  
  
  void autoTextFade(String text) { //decreases text alpha then changes text while the text isn't visible, then fades it back in, allowing for smoother transition
    if (fadeStage == 1) {
      textFadeOut(10);
      if (textAlpha<=0) {
        fadeStage=2;
        textInBox = text;
      }
    }
    if (fadeStage == 2) {
      textFadeIn(10);
    }
  }
}
