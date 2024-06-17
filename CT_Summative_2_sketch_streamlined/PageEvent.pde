class PageEvent extends SceneWithTextBox {
  PImage commentImage;
  String commentText;
  String commentTitle;
  float commentY = 0;

  int targetRectX;
  int targetRectY;
  int targetRectWidth;
  int targetRectHeight;
  boolean targetRectClicked;

  String answer1Text;
  String answer2Text;
  String hiddenAnswerText;

  float answer1X;
  float answer2X;
  float hiddenAnswerX;

  int answer1Width;
  int answer2Width;
  int hiddenAnswerWidth;


  int matchingNumber; //which number of button gives the "matching answer", 1 is answer1, 2 is answer2, 3 is hiddenAnswer
  boolean matchingAnswerChosen = false; //if the player chose the answer that matches the origional text. In keeping with the Zen Buddist themes of the game, labelling the answers as "correct" wouldn't quite work.

  boolean[] actionCompleted = {false, false, false, false, false}; //same as in the main code, but keeping to lower length arrays makes each action easier to track.

  String verseText;
  String verseWrittenText =""; //a standin to allow the autoTextFade function to work for the verseText variable.
  int verseOffset; //the amount the verse is offset by to enable it to appear central while still having text drawn from the left

  float bgAlpha = 0; // repeated since it needs to be initilised at a different value
 

  final int COMMENT = 2;
  final int ANSWERED = 3;
  final int VERSEBG = 4;
  final int VERSE = 5;
  final int NEXT = 6;
  final int NONMATCH = 7;


  PageEvent(int newKoanNumber, int newKoanNumberOffset, String newTitle, int newTitleSize, PFont newTitleFont, int newID, String newBgImage, int newTextBoxY, int newTextInBoxX, String newBodyText1, String newBodyText2, String newCommentTitle, String newCommentText, int newTargetRectX, int newTargetRectY, 
    int newTargetRectWidth, int newTargetRectHeight, String newAnswer1Text, String newAnswer2Text, String newHiddenAnswerText, int newMatchingNumber, String newVerseText, int newVerseOffset) {
    super(newKoanNumber, newKoanNumberOffset, newTitle, newTitleSize, newTitleFont, newID, newBgImage);
    textBoxY = newTextBoxY;
    textInBoxX = newTextInBoxX;
    bodyText1 = newBodyText1;
    bodyText2 = newBodyText2;
    commentImage = loadImage("commentBg3.png");
    commentTitle = newCommentTitle;
    commentText = "                                  " + newCommentText; //to allow space for the comment title to be drawn.

    targetRectX = newTargetRectX;
    targetRectY = newTargetRectY;
    targetRectWidth = newTargetRectWidth;
    targetRectHeight = newTargetRectHeight;


    answer1Text = newAnswer1Text;
    answer2Text = newAnswer2Text;
    hiddenAnswerText = newHiddenAnswerText;



    matchingNumber = newMatchingNumber;

    verseText = newVerseText;
    verseOffset = newVerseOffset;
  }


  void draw() {
    super.draw(); 

    answer1Button.setText(answer1Text);
    answer2Button.setText(answer2Text);
    hiddenAnswerButton.setText(hiddenAnswerText);


    mouseWheel();
    

    //code enabling the y position of the buttons to automatically adjust with the position of the text box
    commentButton.moveTo(commentButton.getX(), (height+textBoxY)-180);
    answer1Button.moveTo(answer1Button.getX(), (height+textBoxY)-200);
    answer2Button.moveTo(answer2Button.getX(), (height+textBoxY)-200);
    hiddenAnswerButton.moveTo(hiddenAnswerButton.getX(), (height+textBoxY)-250);


    if (blackBgAlpha<1 && stage == BODY) {
      fadeStage=1; //enables the body text to fade in without the need for an additional click
      autoTextFade(bodyText1);


      if (!actionCompleted[0]) {
        frameCount1 = frameCount;
        actionCompleted[0] = true;
        commentButton.setVisible(true);
      }
      if (mousePressed && (frameCount-frameCount1>10) && currentScene!=PE_10) { //since Page Event 10 specifically is the only one without the answer 1 and 2 buttons.
        answer1Button.setVisible(true);
        answer2Button.setVisible(true);
      }

      if (mousePressed && (mouseX>targetRectX && mouseY>targetRectY && mouseX<targetRectX+targetRectWidth && mouseY<targetRectY + targetRectHeight)) { //if target rect is clicked on.
        targetRectClicked = true;
      }

      if (currentScene == PE_6) { //if Page Event is Do Not Think Good etc. as this scene has a very specific target area compared to the other scenes.
        if (mouseX > 220 && mouseY >110 && mouseX < 540 && mouseY < 600) {
          PageEvents[5].targetRectClicked = false;
        }
      }

      if (targetRectClicked) {
        hiddenAnswerButton.setVisible(true);
      }

      if (answerButtonClicked) { //if an answer is clicked..
        if ((matchingNumber == 1 && answer1Clicked) ||(matchingNumber == 2 && answer2Clicked) || (matchingNumber == 3 && hiddenAnswerClicked)) { //...and the answer that is clicked is correct
          stage = ANSWERED;
          matchingAnswerChosen = true;
          setRelaventClickedFalse();
        } else {//an answer is clicked but it's not correct
          answerButtonClicked = false;
          stage = NONMATCH;
        }
      }
    } //end of BODY stage
    
    if (stage == NONMATCH){
      makePEButtonsInvisible();
     nextSceneWithFade(nextScene(), 0.2); 
    }

    if (stage == BODY || stage == ANSWERED) { //so you can scroll the text after clicking the answer
      if (scrolling) {
        if (scrollDirection > 0) { //if mouse is scrolling "down"
          textBoxY-=50;
        } else if (scrollDirection < 0) { //if mouse is scrolling "up"
          textBoxY+=50;
        }
        textBoxY = constrain(textBoxY, -700, 0); //prevents the text box from moving too far
        scrolling = false;
      }
    }

    if (stage == ANSWERED) {
      hideAnswerButtons();
      if (matchingAnswerChosen) {
        if (!actionCompleted[1]) {
          bodyText2 = bodyText1 + bodyText2;
          actionCompleted[1] = true;
        }
        autoTextFade(bodyText2);
      }
    }

    if (stage == VERSEBG) {

      commentButton.setVisible(false);

      fill(bgColour, bgAlpha);
      rect(0, 0, width, height); //Creates a rectangle which can fade in, causing the scene to change in a more aesthetically pleasing manner.
      bgAlpha= constrain(bgAlpha, 0, 255);
      bgAlpha+=5;
    } // end of VERSEBG stage


    if (stage == VERSE || stage == NEXT) {
      fill(bgColour, bgAlpha);
      rect(0, 0, width, height); //Creates a rectangle which can fade in, causing the scene to change in a more aesthetically pleasing manner.

      fill(0, textAlpha);
      textFont(TNRItal);
      textAlign(LEFT);
      textSize(30);
      text(verseWrittenText, width/2-verseOffset, height/2-100);
      if (stage == VERSE) {
        autoTextFadeVerse(verseText);
      }

      if (stage == NEXT) {
        //drawing the black background
        fill(0, blackBgAlpha);
        rect(0, 0, width, height);
        if (!actionCompleted[4]) {
          pagesMatched++;
          actionCompleted[4] = true;
        }
        nextSceneWithFade(nextScene(), 0.2);
      }
    }



    if (commentButtonClicked) {
      stage = COMMENT;

      commentButtonClicked = false;
    }

    if (stage == COMMENT) {
      hideAnswerButtons();

      image(commentImage, 0, commentY, width, height*2); //drawing the commentImage

      textAlpha = 255;
      textFont(TNRItal);
      textSize(20);
      text(commentTitle, 200, commentY+30, 350, height*2);

      textFont(TNRReg);
      textSize(20);
      text(commentText, 200, commentY+30, 350, height*2); //sets the text box coordinates to automatically scale with the size of the drawn textBox

      if (scrolling) {
        if (scrollDirection > 0) { //if mouse is scrolling "down"
          commentY-=50;
        } else if (scrollDirection < 0) { //if mouse is scrolling "up"
          commentY+=50;
        }
        commentY = constrain(commentY, -600, 0); //prevents the comment box from moving completely offscreen
        scrolling = false;
      }

      if (mousePressed && (mouseX < 150 || mouseX > width-150)) {
        stage = BODY;
      }
    } // end of if stage == COMMENT
  } // end of draw



  void stageChange() { //making it so the stage changes when the mouse is clicked
    textAlphaRate=1;
    blackBgAlphaRate = 1;
    super.stageChange(); //enables title to text fading
    if (stage != TITLE) {
      fadeStage = 1;
    }
    if (stage == ANSWERED) {
      stage = VERSEBG;
    }

    if (stage == VERSEBG && bgAlpha >=255) {
      stage = VERSE;
      if (!actionCompleted[2]) {
        frameCount1 = frameCount;
        actionCompleted[2] = true;
      }
    }

    if (stage == VERSE && frameCount-frameCount1>10) {
      stage = NEXT;
    }
  }

  void hideAnswerButtons() { //function for hiding answer buttons, since it comes up a few times.
    answer1Button.setVisible(false);
    answer2Button.setVisible(false);
    hiddenAnswerButton.setVisible(false);
  }

  void autoTextFadeVerse(String text) {
    if (fadeStage == 1) {
      textFadeOut(5);
      if (textAlpha<=0) {
        fadeStage=2;
        verseWrittenText = text;
      }
    }
    if (fadeStage == 2) {
      textFadeIn(5);
    }
  }

  void setRelaventClickedFalse() {
    answerButtonClicked = false;
    answer1Clicked = false;
    answer2Clicked = false;
    hiddenAnswerClicked = false;
  }
}//end of PageEvent Class
