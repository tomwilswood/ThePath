class IntroScene extends Scene {
  String text1;
  String text2;
  String text3;
  String writtenText = "";
  int textX;
  int textY;

  IntroScene(int newKoanNumber, int newKoanNumberOffset, String newTitle, int newTitleSize, PFont newTitleFont, int newID, String NewText1, String NewText2, String NewText3) {
    super(newKoanNumber, newKoanNumberOffset, newTitle, newTitleSize, newTitleFont, newID);
    text1=NewText1;
    text2=NewText2;
    text3=NewText3;
  }

  void draw() {
    playButton.setVisible(false);
    if (stage != TITLE) {
      background(bgColour);
    }
    fill(0, blackBgAlpha);
    rect(0, 0, width, height);
    super.draw();

    if (stage == TITLE) {
      textSize(30);
      text("By Ekai, called Mumon Wumen Huikai", width/2, height/3+70); //this is the additional bit for the intro alone.
    }

    //enables a series of different pieces of text to appear when the player clicks, allowing them to view the whole intro

    if (stage >=BODY) {
      textSize(25);
      textAlign(LEFT);
      fill(0, textAlpha);
      text(writtenText, textX, textY);
    }

    if (stage == BODY) {  
      autoTextFade(text1, 70, 100);
    }

    if (stage == 2) {
      autoTextFade(text2, 70, 70);
    }

    if (stage == 3) {
      autoTextFade(text3, width/2-200, height/2-100);
    }

    if (stage == 4) {
      nextSceneWithFade(WorldEvents[WorldEventsOrder[0]], 0.2);
    }
  }

  void stageChange() {
    super.stageChange();
    textAlphaRate=1;
    blackBgAlphaRate = 1;
    if (stage ==1 && blackBgAlpha <=0) {
      stage=2;
    }
    if (stage != TITLE) {
      fadeStage = 1;
    } 
    if (stage == 2 && writtenText == text2) { //cycling to the next block of text
      stage=3;
    }

    if (stage == 3 && writtenText == text3) { //moving on to the next scene.

      stage=4;
    }
  }



  void autoTextFade(String text, int x, int y) {
    if (fadeStage == 1) {
      textFadeOut(0.3);
      if (textAlpha<=0) {
        fadeStage=2;
        writtenText = text;
        textX = x;
        textY = y;
      }
    }
    if (fadeStage == 2) {
      textFadeIn(0.3);
    }
  }
} //end of class
