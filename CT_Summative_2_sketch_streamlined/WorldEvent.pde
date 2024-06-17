class WorldEvent extends SceneWithTextBox {
  //String bodyText1;
  //String bodyText2;

  PImage bgImage2;
  float bgAlpha = 255; // repeated since it needs to be initilised at a different value

  String talkButtonName;
  int talkParts;
  String talkText1;
  String talkText2;

  String miscButton1Name;
  int misc1Parts;
  String misc1Text1;
  String misc1Text2;
  String misc1Text3;

  String miscButton2Name;
  int misc2Parts;
  String misc2Text1;
  String misc2Text2;

  String misc3Text;

  boolean firstWE = false;

  boolean talkResult = false;
  boolean misc1Result = false;
  boolean misc2Result = false;
  boolean misc3Result = false;

  Boolean misc1ConditionsMet = false;
  Boolean  misc2ConditionsMet = false;

  boolean body2ConditionsMet = false;

  boolean[] WEActionCompleted = {false, false, false, false, false, false}; //same as in the main code, but keeping to lower length arrays makes each action easier to track.

  int frameCount1;

  boolean sceneVisited = false;


  WorldEvent(int newKoanNumber, int newKoanNumberOffset, String newTitle, int newTitleSize, PFont newTitleFont, int newID, String newBgImage, String newBodyText1, String newBgImage2, String newBodyText2, String newTalkButtonName, int newTalkParts, String newTalkText1, String newTalkText2, 
    String  newMiscButton1Name, int newMisc1Parts, String newMisc1Text1, String newMisc1Text2, String newMisc1Text3, String  newMiscButton2Name, int newMisc2Parts, String newMisc2Text1, String newMisc2Text2, String newMisc3Text) {
    super(newKoanNumber, newKoanNumberOffset, newTitle, newTitleSize, newTitleFont, newID, newBgImage);

    bodyText1 = newBodyText1;
    bodyText2 = newBodyText2;
    if (newBgImage2.length() > 4) { //to ensure bgImage 2 isn't intiallised in scenes where there is no second background image.
      bgImage2 = loadImage(newBgImage2);
    }
    if (body2ConditionsMet) {
    }

    talkButtonName=newTalkButtonName;
    talkParts = newTalkParts;
    talkText1 = newTalkText1;
    talkText2 = newTalkText2;

    miscButton1Name = newMiscButton1Name;
    misc1Parts = newMisc1Parts;
    misc1Text1 = newMisc1Text1;
    misc1Text2 = newMisc1Text2;
    misc1Text3 = newMisc1Text3;

    miscButton2Name = newMiscButton2Name;
    misc2Parts = newMisc2Parts;
    misc2Text1 = newMisc2Text1;
    misc2Text2 = newMisc2Text2;

    misc3Text = newMisc3Text; //since misc3 is a buttonless variable, we don't need button names for it.
  }


  void draw() {
    if (body2ConditionsMet) { //this seems to slow the program down a little, but it's not too bad, and the effect is cool enough that I think I'm going to keep this. Also, if body2 is present, it is the main body, with all the buttons and stuff.
      if (!(bgImage2 == null)) {
        image(bgImage2, 0, 0, width, height-120); //drawing the new background
        tint(255, bgAlpha); //enabling the previous background image to fade into the new one
        if (bgAlpha>0) {
          bgAlpha-=5;
        }
      }
      bodyText1 = bodyText2; //setting the initial text of body to equal the new string, thus the later functions will display that one instead
    }



    super.draw();
    talkButton.setText(talkButtonName);
    miscButton1.setText(miscButton1Name);
    miscButton2.setText(miscButton2Name);



    if (blackBgAlpha<1 && stage == BODY) {
      WEActionCompleted[0] = false;
      WEActionCompleted[4] = false;
      fadeStage=1; //enables the body text to fade in without the need for an additional click
      if (!firstWE) {
        goBackButton.setVisible(true);
      } 
      goForwardButton.setVisible(true);
      talkButton.setVisible(true);
      if (WorldEvents[2].misc2Result) { // --> The player took the spyglass
        spyglassButton.setVisible(true);
      }

      if (playerCorrupted && (WECount-WECountCorruptionStarted)%3 == 0 && (WECount-WECountCorruptionStarted)!= 0) {  //if the player is corrupted and will take corruption damage this scene
        if (WEActionCompleted[1]) {
          autoTextFade(bodyText1);
        }
      } else { //otherwise just print 
        autoTextFade(bodyText1);
      }



      //drawing rectangles which enable playerHP and current Pages to be seen even with a black background
      fill(bgColour);
      rect(width-145, 10, 145, 25);
      rect(0, 10, 120, 25);

      //drawing player hit points counter
      fill(0);
      textFont(TNRReg);
      textSize(25);
      textAlign(RIGHT);
      text("Hit Points: " + playerHP + "/3", width, 30);

      textAlign(LEFT);
      text("Pages: " + pagesMatched + "/10", 0, 30);



      if (misc1ConditionsMet) { //since the needed variables are different for each scene, I think we'll need to implement those on a scene by scene basis. Like when we make the call to draw in the scene.
        miscButton1.setVisible(true);
      } else {
        miscButton1.setVisible(false);
      } 

      if (misc2ConditionsMet) {
        miscButton2.setVisible(true);
      } else {
        miscButton2.setVisible(false);
      }


      if (playerCorrupted) {
        if ((WECount-WECountCorruptionStarted)%3 == 0 && (WECount-WECountCorruptionStarted) != 0 && !WEActionCompleted[1]) { //every 3 scenes from when they get corrupted, not including the first scene they get corrupted 
          stage = CORRUPTED;
          WEActionCompleted[1] = true;
        }
      }

    } //end of BODY


    if (spyglassButtonClicked) {
      stage = SPYGLASS;
      spyglassButtonClicked = false;
    }

    if (talkButtonClicked) {
      stage = TALKP1;
      talkButtonClicked=false;
    }

    if (misc1Clicked) {
      stage = MISC1P1;
      misc1Clicked=false;
    }

    if (misc2Clicked) {
      stage = MISC2P1;
      misc2Clicked=false;
    }

    if (backButtonClicked) {
      stage = BACK;
      backButtonClicked = false;
    }

    if (forwardButtonClicked) {
      stage = FORWARD;
      forwardButtonClicked = false;
    }

    if (stage == SPYGLASS) {
      makeWEButtonsInvisible();
      if (WorldEvents[WorldEventsOrder[WECount+1]].title != null && WorldEvents[WorldEventsOrder[WECount+2]].title != null) {
        autoTextFade("Looking through The Spyglass you see some of what lies ahead. You see " + WorldEvents[WorldEventsOrder[WECount+1]].title + " close by, and then " + WorldEvents[WorldEventsOrder[WECount+2]].title + " in the distance.");
      } else {
        autoTextFade("Looking through The Spyglass you see the end of The Path fast approaching.");
      }
    }

    if (stage == BACK) {
      if (!WEActionCompleted[4]) {
        WECount --;
        WEActionCompleted[4] = true;
      } 
      WorldEvents[WorldEventsOrder[WECount]].sceneVisited = true; //so when you revisit a scene, sceneVisited is set to true for that scene right before you visit it, avoiding the issue of sceneVisited being set to true when you try and leave a scene causing the PageEvents to be missed out entirely.
      nextSceneWithFade(previousScene(), 0.2);
    }

    if (stage == FORWARD) {
      if (!WEActionCompleted[0]) {
        WECount ++;
        WEActionCompleted[0] = true;
      }
      nextSceneWithFade(nextScene(), 0.2);
    }

    if (stage == TALKP1) {
      makeWEButtonsInvisible();
      fadeStage =1;
      autoTextFade(talkText1);
      if (!(talkParts > 1)) { //if misc1Parts is not greater than 1, so that the result will only be set to true once all the parts of the scene have gone through
        talkResult = true; //result variables go at the end of the text so the result doesn't take effect until after the conversation has happened, which makes more sense with the game.
      }
    }

    if (stage == TALKP2) {
      autoTextFade(talkText2);
      talkResult = true;
    }


    //misc1 parts
    if (stage == MISC1P1) { //we can do the text for the misc options in the class format, but the effects (like HP reduction etc.) I think will need to be handled on a scene by scene basis.
      makeWEButtonsInvisible();
      autoTextFade(misc1Text1);
      misc1Result = true;
      if (!(misc2Parts > 1)) { //if misc1Parts is not greater than 1, so that the result will only be set to true once all the parts of the scene have gone through
        misc1Result = true;
      }
    }

    if (stage == MISC1P2) {
      autoTextFade(misc1Text2);
      if (!(misc2Parts > 2)) { //if misc1Parts is not greater than 2, so that the result will only be set to true once all the parts of the scene have gone through
        misc1Result = true;
      }
    }

    if (stage == MISC1P3) {
      autoTextFade(misc1Text3);
      misc1Result = true;
    }


    //misc2 parts
    if (stage == MISC2P1) {
      makeWEButtonsInvisible();
      autoTextFade(misc2Text1);
      if (!(misc2Parts > 1)) {
        misc2Result = true;
      }
    }

    if (stage == MISC2P2) {
      autoTextFade(misc2Text2);
      misc2Result = true;
    }

    //misc3 parts
    if (stage == MISC3) {
      makeWEButtonsInvisible();
      autoTextFade(misc3Text);
      misc2Result = true;
    }


    if (stage  == CORRUPTED) { //the player takes damage from the corruption.
      if (!WEActionCompleted[2]) {
        frameCount1 = frameCount;
        playerHP--;
        WEActionCompleted[2] = true;
        deathText = "The Corruption overtakes your body and you fall where you stand. You have died.";
      }
      autoTextFade("You feel the Corruption sap at your life. You lose 1HP.");
    }

    if (stage == DEATH) {
      autoTextFade(deathText);
    }

    if (stage == END) {
      nextSceneWithFade(endScene(), 0.2);
    }
  } // end of draw

  void stageChange() { //making it so the stage changes when the mouse is clicked
    textAlphaRate=1;
    blackBgAlphaRate = 1;
    if (stage != TITLE) {
      fadeStage = 1;
    }
    if (playerHP > 0 ) {
      if (!WEActionCompleted[5]) {
        frameCount1 = frameCount;
        WEActionCompleted[5] = true;
      }
      if ((stage == TITLE && fadeStage == 2) || (stage == TALKP1 && talkParts == 1) || (stage == MISC1P1 && misc1Parts == 1) || (stage == MISC1P2 && misc1Parts ==2) || (stage == MISC2P1 && misc2Parts == 1) || stage == MISC2P2 || stage == MISC1P3 || stage == TALKP2 || stage == MISC3 || stage == CORRUPTED || stage == SPYGLASS) { //all stages listed should return the text to body text when the mouse is clicked at that stage
        stage = BODY;
      } else if (stage == TALKP1 && talkParts >1) {  //each of these statements sets the stage to equal the next part of that stage, if it has mutiple parts
        stage = TALKP2;
      } else if (stage == MISC1P1 && misc1Parts >1) {
        stage = MISC1P2;
      } else if (stage == MISC1P2 && misc1Parts > 2) {
        stage = MISC1P3;
      } else if (stage == MISC2P1 && misc2Parts == 2) {
        stage = MISC2P2;
      }
    } else if (playerHP <=0 && frameCount-frameCount1>20) { //if stageChange occurs when player has 0 HP
      stage = DEATH;
      if (!WEActionCompleted[3]) {
        frameCount1 = frameCount;
        WEActionCompleted[3] = true;
      }
    }

    if (stage == DEATH && frameCount-frameCount1 > 20) {
      stage = END;
    }
  }
} //end of WE class
