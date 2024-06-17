class TBPage extends Scene { //TenBullsPage
  String number;
  String baseText;
  String comment;
  PImage illustration;
  boolean[] TBActionCompleted = {false, false}; 


  TBPage( int newKoanNumber, int newKoanNumberOffset, String newTitle, int newTitleSize, PFont newTitleFont, int newID, String newNum, String newBaseText, String newComment, String newIll) {
    super(newKoanNumber, newKoanNumberOffset, newTitle, newTitleSize, newTitleFont, newID);
    number=newNum;
    baseText = newBaseText;
    comment = newComment;
    illustration=loadImage(newIll);
  }

  void draw() {
    println(blackBgAlpha);
    if (!TBActionCompleted[0]) {
      blackBgFadeOut(0.05);
    }
    if (blackBgAlpha <= 0) {
      TBActionCompleted[0] = true;
    }
    background(bgColour);
    fill(0);

    //drawing the title
    textFont(TNRReg);
    textSize(25);
    textAlign(CENTER);
    text(number, width/2-5*title.length(), 40); //drawing the number of the passage


    textFont(TNRItal);
    textSize(25);
    text(title, width/2, 40); //drawing the actual words of the title, needs to be seperate as they have different fonts

    //drawing the base text
    textSize(18);
    textAlign(LEFT);
    text(baseText, width/4, 90);

    //drawing the comment
    textSize(19);
    text("Comment:", width/4-10, 265);
    textFont(TNRReg);
    textSize(19);
    text(comment, width/4-10, 265);

    //drawing the drawing
    image(illustration, width/2-85, 400, 170, 196);


    //drawing the black background
    fill(0, blackBgAlpha);
    rect(0, 0, width, height);

    if (stage == END) {
      blackBgAlphaRate = 1.5;
      nextSceneWithFade(theEnd, 0.2);
    }
  }

  void stageChange() { //making it so the stage changes when the mouse is clicked
    stage = END;
  }
}
