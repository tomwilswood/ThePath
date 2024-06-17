class MenuScene extends Scene {
  PImage bgImage;



  MenuScene(int newKoanNumber, int newKoanNumberOffset, String newTitle, int newTitleSize, PFont newTitleFont, int newID, String newBgImage) {
    super(newKoanNumber, newKoanNumberOffset, newTitle, newTitleSize, newTitleFont, newID);
    bgImage = loadImage(newBgImage);
    blackBgAlpha= 0;

  }

  void draw() {
    goBackButton.setVisible(false);
    goForwardButton.setVisible(false);
    talkButton.setVisible(false);
    miscButton1.setVisible(false);
    miscButton2.setVisible(false);
    playButton.setVisible(true);


    image(bgImage, 0, 0, width, height);
    fill(0);
    //textFont(TNRReg);
    textFont(titleFont);
    textAlign(CENTER);
    textSize(titleSize);
    text(title, width/2, height/3); 
    
    //drawing the credit
    noStroke();
    fill(bgColour);
    rect(10,height-130,200,130);
    textAlign(LEFT);
    textSize(20);
    fill(0);
    text("Elements of original text 'Writings from the Zen Masters' used. Published by the Penguin Group. Compiled by Paul Reps.", 10, height-120, 250, 120); 

    //drawing the black background
    fill(0, blackBgAlpha);
    rect(0, 0, width, height);

    if (playClicked) {
      playButton.setVisible(false);
      nextSceneWithFade(nextScene(), 0.2);
    }
  }
}
