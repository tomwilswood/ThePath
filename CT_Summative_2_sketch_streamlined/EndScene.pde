class EndScene extends Scene {

  EndScene(int newKoanNumber, int newKoanNumberOffset, String newTitle, int newTitleSize, PFont newTitleFont, int newID) {
    super(newKoanNumber, newKoanNumberOffset, newTitle, newTitleSize, newTitleFont, newID);
  }

  void draw() {
    //drawing the black background
    fill(0, blackBgAlpha);
    rect(0, 0, width, height);

    if (fadeStage == 0) {
      if (blackBgAlpha >=50 && mousePressed) {
        blackBgAlpha = 255;
        fadeStage = 1;
      }
    }

    if (fadeStage == 1) {

      //drawing the title (in this case the "The End" text)
      fill(255, textAlpha);
      textFont(titleFont);
      textAlign(CENTER);
      textSize(titleSize);
      text(title, width/2, height/3);
      textFadeIn(0.01);
    }
  } // end of draw
} //end of EndScene
