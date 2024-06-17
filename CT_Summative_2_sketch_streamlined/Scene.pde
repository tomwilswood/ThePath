class Scene {
  int koanNumber;
  int koanNumberOffset;
  String title;
  int titleSize;
  PFont titleFont;
  int sceneID;

  float blackBgAlpha = 255;
  float blackBgAlphaRate = 1;
  float textAlpha = 0;
  float textAlphaRate=1;



  int stage = TITLE;

  int fadeStage=0;



  Scene(int newKoanNumber, int newKoanNumberOffset, String newTitle, int newTitleSize, PFont newTitleFont, int newID) {
    koanNumber = newKoanNumber;
    title = newTitle;
    titleSize= newTitleSize;
    titleFont = newTitleFont;
    sceneID = newID;
    koanNumberOffset = newKoanNumberOffset; //This allows the koan number (which has to be seperate since it's a different font) to be placed in an appropriate place for each scene
  }


  void draw() {
    playButton.setVisible(false);
    //println(fadeStage);

    if (stage == BODY) { //enables a fade effect removing the black screen when the stage changes to body.
      blackBgFadeOut(0.1);
    }

    if (stage == TITLE) {



      //drawing the black background
      fill(0, blackBgAlpha);
      rect(0, 0, width, height);

      if (fadeStage == 0) {
        if (blackBgAlpha >=50 && mousePressed) {
          blackBgAlpha = 255;
          fadeStage = 1;
        }
      }

      if (fadeStage == 1 || fadeStage == 2) {

        //drawing koanNumber, if relavent
        if (koanNumber>0) {
          fill(255, textAlpha);
          textFont(TNRReg);
          textAlign(CENTER);
          textSize(titleSize);
          text(koanNumber + ".", width/2-koanNumberOffset, height/3);
        }

        //drawing the title
        fill(255, textAlpha);
        textFont(titleFont);
        textAlign(CENTER);
        textSize(titleSize);
        text(title, width/2, height/3);

        if (fadeStage == 1) {

          textFadeIn(0.5);
          if (textAlpha >=255 && mousePressed) {
            fadeStage=2;
          }
        }

        if (fadeStage == 2) {
          textFadeOut(0.5);
        }
      }
    }
  } // end of draw


  void stageChange() { //making it so the stage changes when the mouse is clicked
    if ((stage == TITLE && fadeStage == 2)) {
      stage = BODY;
    }
  }

  void blackBgFadeIn(float increaseRate) {
    blackBgAlpha = constrain(blackBgAlpha, 0, 255);
    blackBgAlpha+=blackBgAlphaRate;
    if (blackBgAlpha>0 && blackBgAlpha<255) {
      blackBgAlphaRate+=increaseRate;
    }
  }



  void blackBgFadeOut(float increaseRate) {
    blackBgAlpha = constrain(blackBgAlpha, 0, 255);
    blackBgAlpha-=blackBgAlphaRate;
    if (blackBgAlpha>0 && blackBgAlpha<255) {
      blackBgAlphaRate+=increaseRate;
    }
  }

  void textFadeIn(float increaseRate) {  
    textAlpha = constrain(textAlpha, 0, 255);
    textAlpha+=textAlphaRate;
    if (textAlpha>0 && textAlpha<255) {
      textAlphaRate+=increaseRate;
    }
  }

  void textFadeOut(float increaseRate) { //decreases the alpha of the text, until it's invisible 
    textAlpha = constrain(textAlpha, 0, 255);
    textAlpha-=textAlphaRate;
    if (textAlpha>0 && textAlpha<255) {
      textAlphaRate+=increaseRate;
    }
  }

  void nextSceneWithFade(Scene nextScene, float fadeAmount) { //enables a fade to black, then changes the scene when the background is black to allow for smoother transition
    makeWEButtonsInvisible();
    makePEButtonsInvisible();
    blackBgFadeIn(fadeAmount);

    if (blackBgAlpha >=255) {
      nextScene.stage = TITLE;
      currentScene = nextScene.sceneID;
    }
  }

  void makePEButtonsInvisible() {
    answer1Button.setVisible(false);
    answer2Button.setVisible(false);
    hiddenAnswerButton.setVisible(false);
    commentButton.setVisible(false);
  }

  void makeWEButtonsInvisible() {
    goBackButton.setVisible(false);
    goForwardButton.setVisible(false);
    talkButton.setVisible(false);
    miscButton1.setVisible(false);
    miscButton2.setVisible(false);
    spyglassButton.setVisible(false);
  }

  void makeConvoButtonsInvisible() {
    talkButton.setVisible(false);
    miscButton1.setVisible(false);
    miscButton2.setVisible(false);
  }
} //end of Scene class
