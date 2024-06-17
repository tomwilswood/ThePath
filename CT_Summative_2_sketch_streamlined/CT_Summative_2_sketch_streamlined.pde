import g4p_controls.*;

//setting the IDs for each of the scenes
final int MENU = 0;
final int INTRO = 1;

final int WE_SOLDIER = 2; // World Event Soldier
final int WE_OLDMAN = 3; // World Event Old man etc.
final int WE_ITEMS = 4;
final int WE_KING = 5;
final int WE_POOL = 6;
final int WE_CORRUPTION = 7;
final int WE_MONSTER = 8;
final int WE_PRIEST = 9;
final int WE_BEGGAR = 10;
final int WE_COIN = 11;

final int PE_1 =12; //Page Event 1: "1. Joshu's Dog"
final int PE_2 =13; //Page Event 2: "2. Hyakujo's Dog"
final int PE_3 =14; //Page Event 3: "7. Joshu's Washes the Bowl"
final int PE_4 =15; //Page Event 4: "18. Tozan's Three Pounds"
final int PE_5 =16; //Page Event 5: "19. Everyday life is the path"
final int PE_6 =17; //Page Event 6: "23. Do not think good, do not think not good"
final int PE_7 =18; //Page Event 7: "30. This Mind is Buddha"
final int PE_8 =19; //Page Event 8: "33. This Mind is Not Buddha"
final int PE_9 =20; //Page Event 9: "38. An Oak Tree in the Garden"
final int PE_10 =21; //Page Event 10: "49. Amban's Addition"

final int TB_1 =22; //Ten Bulls: "1. The Search for the Bull" 
final int TB_2 =23; //Ten Bulls: "2. Discovering the Footprints"
final int TB_3 =24; //Ten Bulls: "3. Percieving the Bull"
final int TB_4 =25; //Ten Bulls: "4. Catching the Bull"
final int TB_5 =26; //Ten Bulls: "5. Taming the Bull"
final int TB_6 =27; //Ten Bulls: "6. Riding the Bull Home"
final int TB_7 =28; //Ten Bulls: "7. The Bull Transcended"
final int TB_8 =29; //Ten Bulls: "8. Both Bull and Self Transcended"
final int TB_9 =30; //Ten Bulls: "9. Reaching the Source"
final int TB_10 =31; //Ten Bulls: "10. In the World"

final int WE_PATH_END = 32; //end scene if you make it all the way to the end of The Path
final int THE_END = 33; //end scene if you make it all the way to the end of The Path

int currentScene = MENU; //decides what scene we are currently on
int WECount = 0; //World Event Count - number of world events ELAPSED

color bgColour = #F6EBDD;
PFont TNRReg;
PFont TNRItal;

//declaring the pages and events

IntroScene intro;
MenuScene menu;

WorldEvent[] WorldEvents = new WorldEvent[11];

PageEvent[] PageEvents = new PageEvent[10];

TBPage[] TBPages = new TBPage[10];

EndScene theEnd;


//declaring variables used in the World Event order randomiser
int[] WorldEventsOrder = new int[11]; //only 9 as The Monster is in a fixed position
int counter = 0;
Boolean eventSet = true;


//declearing button variables
boolean playClicked = false;

boolean talkButtonClicked = false;
boolean misc1Clicked = false;
boolean misc2Clicked = false;
boolean backButtonClicked = false;
boolean forwardButtonClicked = false;
boolean spyglassButtonClicked = false;


boolean answerButtonClicked = false;
boolean answer1Clicked = false;
boolean answer2Clicked = false;
boolean hiddenAnswerClicked = false;
boolean commentButtonClicked = false;


//choice variables
int playerHP = 3;
boolean[] actionCompleted = {false, false, false, false, false, false, false, false}; //to enable for certain events to only occur once, despite the code they are within being part of draw, which is called every frame. Doing this in an array instead of with specific variables saves space.

boolean soldierInsulted = false;
boolean restedInGraveyard = false;
boolean playerCorrupted = false;
boolean playerPartiallyCorrupted = false;
int WECountCorruptionStarted;
boolean corruptionCured = false;
boolean coinRemoved = false;
boolean poolHealingUsed = false;


//stage variables
final int TITLE = 0;
final int BODY = 1;
final int TALKP1 = 2;
final int TALKP2 = 3;
final int MISC1P1 = 4;
final int MISC1P2 = 5;
final int MISC1P3 = 6;
final int MISC2P1 = 7;
final int MISC2P2 = 8;
final int MISC3 = 9;
final int BACK = 10;
final int FORWARD = 11;
final int CORRUPTED = 12;
final int SPYGLASS = 13;
final int DEATH = 14;
final int END = 15;


//frameCount varibles for calculations
int frameCount1;


float scrollDirection;
boolean scrolling = false;


int pagesMatched = 0;


String deathText;



void setup() {
  size(750, 600);
  background(bgColour);
  createGUI();

  //intialising the fonts
  TNRReg = loadFont("TimesNewRomanPSMT-48.vlw");
  TNRItal = loadFont("TimesNewRomanPS-ItalicMT-48.vlw");


  //intialising the scenes
  menu = new MenuScene(0, 0, "The Path", 124, TNRReg, MENU, "menuBg.png");

  intro = new IntroScene(0, 0, "The Gateless Gate", 45, TNRItal, INTRO, "‘Zen has no gates. The purpose of Buddha’s words is to\nenlighten others. Therefore Zen should be gateless.\n     ‘Now, how does one pass through this gateless gate? Some\nsay that whatever enters through a gate is not family treasure,\nthat whatever is produced by the help of another is likely to\ndissolve and perish. \n     ‘Even such words are like raising waves in a windless sea\nor performing an operation upon a healthy body. If one clings\nto what others have said and tries to understand Zen by\nexplanation, he is like a dunce who thinks he can beat the\nmoon with a pole or scratch an itching foot from the outside\nof a shoe. It will be impossible after all.", 
    "   ‘In the year 1228 I was lecturing monks in the Ryusho\ntemple in eastern China, and at their request I retold old\nkoans, endeavouring to inspire their Zen spirit. I meant to use\nthe koans as a man who picks up a piece of brick to knock at\na gate, and after the gate is opened the brick is useless and is\nthrown away. My notes, however, were collected unexpectedly,\nand there were forty-nine koans, together with my comment\nin prose and verse concerning each, although their arrangement\nwas not in the order of the telling. I have called the book The\nGateless Gate, wishing students to read it as a guide.\n     ‘If a reader is brave enough and goes straight forward in\nhis meditation, no delusions can disturb him. He will become\nenlightened just as did the patriarchs in India and in China,\nprobably even better. But if he hesitates one moment, he is as\na person watching from a small window for a horseman to\npass by, and in a wink he has missed seeing.", 
    "‘The great path has no gates,\nThousands of roads enter it.\nWhen one passes through this gateless gate\nHe walks freely between heaven and earth.'");

  theEnd = new EndScene(0, 0, "The End.", 124, TNRReg, THE_END);

  initiliseWorldEvents();

  initialiseTenBulls();

  initilisePageEvents();

  randomiseWorldEventOrder();
  printArray(WorldEventsOrder);


  goBackButton.setVisible(false);
  goForwardButton.setVisible(false);
  talkButton.setVisible(false);
  miscButton1.setVisible(false);
  miscButton2.setVisible(false);
  playButton.setVisible(false);
  commentButton.setVisible(false);
  answer1Button.setVisible(false);
  answer2Button.setVisible(false);
  hiddenAnswerButton.setVisible(false);
  spyglassButton.setVisible(false);
}




void draw() {
  //println("WECount " + WECount);
  //println("Mouse X: " + mouseX + " Mouse Y: " + mouseY);
  //println(PageEvents[1].textBoxY);
  //println(frameCount + " ");
  //println(currentScene);
  //println(TBPages[0].sceneID);

  WorldEvents[WorldEventsOrder[0]].firstWE = true;


  if (currentScene == MENU) { //drawing the menu
    menu.draw();
  }

  if (currentScene == INTRO) { //drawing the intro
    intro.draw();
  } //end of intro 


  drawPE();

  drawWorldEvents(); //if currentScene is set to a specific World Event, this function will draw it and deal with the scene-specific variables.

  drawTB();

  if (currentScene == THE_END) {
    theEnd.draw();
  }

  //println(WECount);
}//end of draw


void mousePressed() {  //code here enables the scenes to shift between different stages when the mouse is clicked.
  clickInteract(intro, INTRO);
  for (int i = 0; i<10; i++) {
    clickInteract(WorldEvents[i], i+2);
    clickInteract(PageEvents[i], i+12);
    clickInteract(TBPages[i], i+22);
  }
  clickInteract(WorldEvents[10], WE_PATH_END);
}


void clickInteract(Scene scene, int desiredSceneID) {
  if (currentScene == desiredSceneID) {
    scene.stageChange();
  }
}

void mouseWheel(MouseEvent event) { //from https://processing.org/reference/mouseWheel_.html
  float e = event.getCount();
  scrollDirection = e;
  scrolling = true;
}


boolean mouseOverBackButton() {
  if (mouseX>9 && mouseX < 9+80 && mouseY>420 && mouseY <420+30) { //if the mouseX is greater than the x of the top left of the button, but less than the top left x + the width of the button etc.
    return true;
  }
  return false;
}


void randomiseWorldEventOrder() { //creates a random order for the array elements to go in 
  counter = int(random(0, 10));

  for (int i=0; i<10; i++) { 

    while (eventUsed(counter, i)==true) {
      counter = int(random(0, 10)); //sets counter to refrence a random world event.
    }

    WorldEventsOrder[i] = counter;
    WorldEventsOrder[6] = 6; //sets The Monster to be the 7th World Event in the order
  }
}

boolean eventUsed(int counter1, int currentPlace) {
  if (counter1 == 6) {//since The Monster (WorldEvents[6]) is in a fixed position.
    return true;
  }

  for (int j=0; j<currentPlace; j++) { //checks to see if the world event has already been placed in the order.
    if (counter1 == WorldEventsOrder[j]) { 
      return true; // returns true if the counter is already listed in the array.
    }
  }
  return false;
} 



Scene nextScene() { 
  if (currentScene >= 2 && currentScene <= 11) { //if current scene is a World Event
    if (WorldEvents[WorldEventsOrder[WECount]].sceneVisited || WorldEvents[WorldEventsOrder[WECount-1]].sceneVisited) {
      return WorldEvents[WorldEventsOrder[WECount]];
    } else {
      return PageEvents[WECount-1];
    }
  }

  if (currentScene >=12 && currentScene <= 20) { //if current scene is a Page Event but not the final one
    return(WorldEvents[WorldEventsOrder[WECount]]);
  }
  if (currentScene == 21) { //if currentScene is Amban's Addition, the final PageEvent
    return(WorldEvents[10]);
  }
  if (currentScene == MENU) {
    return(intro);
  }
  if (currentScene == INTRO) {
    return WorldEvents[WorldEventsOrder[0]];
  }
  if (currentScene >= TB_1 && currentScene <= TB_10) { //if current scene is a Ten Bulls Page
    return theEnd;
  }
  return menu;
}

Scene previousScene() {
  return(WorldEvents[WorldEventsOrder[WECount]]);
}


Scene endScene() { //gives the scene that should be returned if the player finishes the game or dies.
  if (pagesMatched == 0) {
    return TBPages[0];
  } else {
    return TBPages[pagesMatched-1];
  }
}


void drawPE() {
  for (int i = 0; i<10; i++) { //prints whichever PageEvent matches the scene ID
    if (currentScene == PageEvents[i].sceneID) {
      PageEvents[i].draw();
    }
  }
}

void drawTB() {
  for (int i = 0; i<10; i++) { //prints whichever PageEvent matches the scene ID
    if (currentScene == TBPages[i].sceneID) {
      TBPages[i].draw();
    }
  }
}


void initilisePageEvents() {
  //initialising Page Events
  //the "    " before the title is to allow for the title to appear central, despite having to use seperate strings for title and koanNumber, given that they have seperate fonts.
  PageEvents[0] = new PageEvent(1, 185, "   Joshu's Dog", 72, TNRItal, PE_1, "PageEvent1Bg.png", 0, 50, "A monk asked Joshu, a Chinese Zen master: ‘Has a dog Buddha-nature or not?’\n     Joshu answered: ", 
    "‘Mu.’ [Mu is the negative symbol in Chinese, meaning ‘No-thing’ or ‘Nay’.]", 
    "Mumon's comment:", "To realize Zen one has to pass through the barrier of the patriarchs. Enlightenment always comes after the road of thinking is blocked. If you do not pass the barrier of the patriarchs or if your thinking road is not blocked, whatever you think, whatever you do, is like a tangling ghost. You may ask: What is a barrier of a patriarch? This one word, Mu, is it.\n      This is the barrier of Zen. If you pass through it you will see Joshu face to face. Then you can work hand in hand with the whole line of patriarchs. Is this not a pleasant thing to do?\n           If you want to pass this barrier, you must work through every bone in your body, through every pore of your skin, filled with this question: What is Mu? and carry it day and night. Do not believe it is the common negative symbol meaning nothing. It is not nothingness, the opposite of existence. If you really want to pass this barrier, you should feel like drinking a hot iron ball that you can neither swallow nor spit out.\n      Then your previous lesser knowledge disappears. As a  fruit ripening in season, your subjectivity and objectivity naturally become one. It is like a dumb man who has had a dream. He knows about it but he cannot tell it.\n      When he enters this condition his ego-shell is crushed and he can shake the heaven and move the earth. He is like a great warrior with a sharp sword. If a Buddha stands in his way, he will cut him down; if a patriarch offers him any obstacle, he will kill him; and he will be free in his way of birth and death. He can enter any world as if it were his own playground. I will tell you how to do this with this koan:\n      Just concentrate your whole energy into this Mu, and do not allow any discontinuation. When you enter this Mu and there is no discontinuation, your attainment will be as a candle burning and illuminating the whole universe.", 
    216, 163, 90, 50, "YES", "NO", "Mu.", 3, "Has a dog Buddha-nature?\nThis is the most serious question of all.\n if you say yes or no,\n you lose your own Buddha-nature.", 220);

  PageEvents[1] = new PageEvent(2, 220, "   Hyakujo’s Fox", 72, TNRItal, PE_2, "PageEvent2Bg.png", 0, 50, "Once when Hyakujo delivered some Zen lectures an old man attended them, unseen by the monks. At the end of each talk when the monks left so did he. But one day he remained after they had gone, and Hyakujo asked him: ‘Who are you?’\n     The old man replied: ‘I am not a human being, but I was a human being when the Kashapa Buddha preached in this world. I was a Zen master and lived on this mountain. At that time one of my students asked me whether or not the enlightened man is subject to the law of causation. I answered him: “The enlightened man is not subject to the law of causation.” For this answer evidencing a clinging to absoluteness I became a fox for five hundred rebirths, and I am still a fox. Will you save me from this condition with your Zen words and let me get out of a fox’s body? Now may I ask you: Is the enlightened man subject to the law of causation?’\n     Hyakujo said:", 
    "‘The enlightened man is one with the law of causation.’\n     At the words of Hyakujo the old man was enlightened. ‘I am emancipated,’ he said, paying homage with a deep bow. ‘I am no more a fox, but I have to leave my body in my dwelling place behind this mountain. Please perform my funeral as a monk.’ Then he disappeared.\n     The next day Hyakujo gave an order through the chief  monk to prepare to attend the funeral of a monk. ‘No one was sick in the infirmary,’ wondered the monks. ‘What does our teacher mean?’\n     After dinner Hyakujo led the monks out and around the mountain. In a cave, with his staff he poked out the corpse of an old fox and then performed the ceremony of cremation.\n     That evening Hyakujo gave a talk to the monks and told them this story about the law of causation.\n     Obaku, upon hearing the story, asked Hyakujo: ‘I understand that a long time ago because a certain person gave a wrong Zen answer he became a fox for five hundred rebirths. Now I want to ask: If some modern master is asked many questions and he always gives the right answer, what will become of him?’\n     Hyakujo said: ‘You come here near me and I will tell you.’\n     Obaku went near Hyakujo and slapped the teacher’s face with his hand, for he knew this was the answer his teacher intended to give him.\n     Hyakujo clapped his hands and laughed at this discernment. ‘I thought a Persian had a red beard,’ he said, ‘and now I know a Persian who has a red beard.", 
    "Mumon's comment:", "‘The enlightened man is not subject.’ How can this answer make the monk a fox?\n     ‘The enlightened man is one with the law of causation.’ How can this answer make the fox emancipated?\n     To understand this clearly one has to have just one eye.", 
    213, 171, 18, 15, "HE IS", "HE IS NOT", "HE IS ONE", 3, "Controlled or not controlled?\nThe same dice shows two faces.\nNot controlled or controlled,\nBoth are a grievous error.", 180);

  PageEvents[2] = new PageEvent(7, 300, "  Joshu Washes the Bowl", 60, TNRItal, PE_3, "PageEvent3Bg.png", 0, 50, "A monk told Joshu: ‘I have just entered the monastery. Please teach me.’\n     Joshu asked: ‘Have you eaten your rice porridge?’\n     The monk replied: ‘I have eaten.’\n     Joshu said: ", 
    "‘Then you had better wash your bowl.’\n     At that moment the monk was enlightened", 
    "Mumon's comment:", "Joshu is the man who opens his mouth and shows his heart. I doubt if this monk really saw Joshu’s heart. I hope he did not mistake the bell for a pitcher.", 
    0, 0, 0, 0, "Then you have already been taught.", "Then you had better wash your bowl.", "", 2, "It is too clear so it is hard to see.\nA dunce once searched for a fire with a\n     lighted lantern\nHad he known what fire was,\nHe could have cooked his rice much sooner.", 
    240);

  PageEvents[3] = new PageEvent(18, 270, "     Tozan's Three Pounds", 60, TNRItal, PE_4, "PageEvent4Bg.png", 0, 50, "A monk asked Tozan when he was weighing some flax: ‘What is Buddha?’\n     Tozan said:", 
    "‘This flax weighs three pounds.'", 
    "Mumon's comment:", "Old Tozan’s Zen is like a clam. The minute the shell opens you see the whole inside. However, I want to ask you: Do you see the real Tozan?", 
    478, 184, 92, 64, "This mind is Buddha.", "This mind is not Buddha.", "This flax weighs three pounds.", 3, 
    "Three pounds of flax in front of your nose,\nClose enough, and mind is still closer.\nWhoever talks about affirmation and negation\nLives in the right and wrong region.", 260);

  PageEvents[4] = new PageEvent(19, 295, "     Everyday Life is the Path", 57, TNRItal, PE_5, "PageEvent5Bg.png", 0, 50, "Joshu asked Nansen: ‘What is the path?’\n     Nansen said: ‘Everyday life is the path.’\n     Joshu asked: ‘Can it be studied?’\n     Nansen said: ‘If you try to study, you will be far away from it.’\n     Joshu asked: ‘If I do not study, how can I know it is the path?’\n     Nansen said:", 
    "‘The path does not belong to the perception world, neither does it belong to the nonperception world. Cognition is a delusion and noncognition is senseless. If you want to reach the true path beyond doubt, place yourself in the same freedom as sky. You name it neither good nor not-good.’\n     At these words Joshu was enlightened.", 
    "Mumon's comment:", "Nansen could melt Joshu’s frozen doubts at once when Joshu asked his questions. I doubt though if Joshu reached the point that Nansen did. He needed thirty more years of study.", 
    104, 0, 506, 233, "You have always known the Path.", "Without study, without mind, you can see the Path.", "Place yourself in the same freedom as the sky.", 3, 
    "In spring, hundreds of flowers; in autumn, a harvest moon;\nIn summer, a refreshing breeze; in winter, snow will\n     accompany you.\nIf useless things do not hang in your mind,\nAny season is a good season for you.", 350);

  PageEvents[5] = new PageEvent(23, 255, "   Do Not Think Good,\nDo Not Think Not Good", 57, TNRItal, PE_6, "PageEvent6Bg.png", 0, 50, "When he became emancipated the sixth patriarch received from the fifth patriarch the bowl and robe given from the Buddha to his successors, generation after generation.\n     A monk named E-myo out of envy pursued the patriarch to take this great treasure away from him. The sixth patriarch placedthe bowl and robe on a stone in the road and told E-myo: ‘These objects just symbolize the faith. There is no use fightingover them. If you desire to take them, take them now.’\n     When E-myo went to move the bowl and robe they were as heavy as mountains. He could not budge them. Trembling for shame he said: ‘I came wanting the teaching, not the material treasures. Please teach me.’\n     The sixth patriarch said: ", 
    "‘When you do not think good and when you do not think not-good, what is your true self ?’ \n     At these words E-myo was illumined. Perspiration broke out all over his body. He cried and bowed, saying: ‘You have given me the secret words and meanings. Is there yet a deeper part of the teaching?’\n     The sixth patriarch replied: ‘What I have told you is no secret at all. When you realize your own true self the secret belongs to you.’\n     E-myo said: ‘I was under the fifth patriarch many years  but could not realize my true self until now. Through your teaching I find the source. A person drinks water and knows himself whether it is cold or warm. May I call you my teacher?’\n     The sixth patriarch replied: ‘We studied together under the fifth patriarch. Call him your teacher, but just treasure what you have attained.’", 
    "Mumon's comment:", "The sixth patriarch certainly was kind in such an emergency. It was as if he removed the skin and seeds from the fruit and then, opening the pupil’s mouth, let him eat.", 
    113, 0, 507, 457, "Teaching only exists for those who can hear it.", "When the wind does not move, what thought is left?", "Do not think good, do not think not-good.", 3, 
    "You cannot describe it, you cannot picture it,\nYou cannot admire it, you cannot sense it.\nIt is your true self, it has nowhere to hide.\nWhen the world is destroyed, it will not be destroyed.", 300);

  PageEvents[6] = new PageEvent(30, 255, "     This Mind is Buddha", 60, TNRItal, PE_7, "PageEvent7Bg.png", 0, 50, "Daibai asked Baso: ‘What is Buddha?’\n     Baso said: ", 
    "‘This mind is Buddha.'", 
    "Mumon's comment:", " If anyone wholly understands this, he is wearing Buddha’s clothing, he is eating Buddha’s food, he is speaking Buddha’s words,he is behaving as Buddha, he is Buddha.\n     This ancedote, however, has given many a pupil the sickness of formality. If one truly understands, he will wash out his mouthfor three days after saying the word Buddha, and he will close his ears and flee after hearing ‘This mind is Buddha.’.", 
    0, 0, 0, 0, "This mind is Buddha.", "This mind is not Buddha.", "", 1, 
    "Under blue sky, in bright sunlight,\nOne need not search around.\nAsking what Buddha is\nIs like hiding loot in one’s pocket and\n     declaring oneself innocent.", 220);

  PageEvents[7] = new PageEvent(33, 305, "     This Mind is Not Buddha", 60, TNRItal, PE_8, "PageEvent8Bg.png", 0, 50, "A monk asked Baso: ‘What is Buddha?’\n     Baso said: ", 
    "‘This mind is not Buddha.’", 
    "Mumon's comment:", "If anyone understands this, he is a graduate of Zen.", 
    0, 0, 0, 0, "This mind is Buddha.", "This mind is not Buddha.", "", 2, 
    "If you meet a fencing-master on the road, you\n     may give him your sword,\nIf you meet a poet, you may offer him your poem.\nWhen you meet others, say only a part of what\n     you intend.\nNever give the whole thing at once.", 280);

  PageEvents[8] = new PageEvent(38, 280, "     An Oak Tree in the Garden", 50, TNRItal, PE_9, "PageEvent9Bg.png", 0, 50, "A monk asked Joshu why Bodhidharma came to China. Joshu said: ", 
    "‘An oak tree in the garden.'", 
    "Mumon's Comment:", "If one sees Joshu’s answer clearly, there is no Shakyamuni Buddha before him and no future Buddha after him.", 
    436, 10, 184, 419, "Bodhidharma was already here.", "Speak the answer yourself.", "An oak tree in the garden.", 3, 
    "Words cannot describe everything.\nThe heart’s message cannot be delivered in words.\nIf one receives words literally, he will be lost.\nIf he tries to explain with words, he will not attain\n     enlightenment in this life", 300);

  PageEvents[9] = new PageEvent(49, 225, "     Amban’s Addition", 60, TNRItal, PE_10, "PageEvent10Bg.png", 0, 50, "Amban, a layman Zen student, said: ‘Mumon has just published forty-eight koans and called the book Gateless Gate. He criticizes the old patriarchs’ words and actions. I think he is very mischievous. He is like an old doughnut seller trying to catch a passer-by to force his doughnuts down his mouth. The customer can neither swallow nor spit out the doughnuts, and this causes suffering. Mumon has annoyed everyone enough, so I think I shall add one more as a bargain. I wonder if he himself can eat this bargain. If he can, and digest it well, it will be fine, but if not, we will have to put it back into the frying pan with his forty-eight also and cook them again. Mumon, you eat first, before someone else does:\n    ‘Buddha, according to a sutra, once said: ", 
    "“Stop, stop. Do not speak. The ultimate truth is not even to think.”’", 
    "Amban's comment:", "Where did that so-called teaching come from? How is it that one could not even think it? Suppose someone spoke about it, then what became of it? Buddha himself was a great chatterbox and in this sutra spoke contrarily. Because of this, persons like Mumon appear afterwards in China and make useless doughnuts, annoying people. What shall we do after all? I will show you.\n     Then Amban put his palms together, folded his hands,  and said: ‘Stop, stop. Do not speak. The ultimate truth is not even to think. And now I will make a little circle on the sutra with my finger and add that five thousand other sutras and Vimalakirti’s gateless gate all are here!’", 
    319, 155, 58, 63, "", "", "Stop, Stop, Do not speak...", 3, 
    "If anyone tells you fire is light,\nPay no attention.\nWhen two thieves meet they need no introduction:\nThey recognize each other without question", 300);
}

void initiliseWorldEvents() { 
  WorldEvents[0] = new WorldEvent(0, 0, "The Soldier", 72, TNRReg, WE_SOLDIER, "TheSoldier.png", "You see a man leaned up against a tree ahead of you. On his body he wears a set of dirty and\nill-cared for armour. On his shoulder, he rests a sword. You see The Soldier.", 
    "", "", "TALK", 1, "‘There are dangers on The Path. Watch yourself, stranger, lest they consume you.’", "", "INSULT", 3, "Sword on your waist, you feel confident. You laugh at the soldier’s shabby armour.", 
    "‘I would not harm one who is unarmed, but you do not have that issue.’\nThe Soldier draws his blade and swings at you. You fend off the first strike with your own sword but are damaged by the second. You decide to run. The Soldier watches you go.", 
    "You lose 1HP", "LEARN", 2, "Thinking back to the words of The Old Man, you ask The Soldier for help defending yourself on the road. He considers for a moment, then leads you through the basics of defending yourself with a sword, giving you a stick to practice with. You now feel confident you have the knowledge to defend yourself better, should you have a Sword.", 
    "You gained SWORD TRAINING.", "");

  WorldEvents[1] = new WorldEvent(0, 0, "The Old Man and\n The Graveyard", 72, TNRReg, WE_OLDMAN, "TheOldMan.png", "You come across a small graveyard sitting peacefully along the path. You see many stones of varying shapes and sizes, inscribed with the names of the dead. A tree rises from among the tombstones and a small hut sits within the grounds. An aged and bent figure stands by the shack. You see The Old Man.", 
    "", "", "TALK", 1, "‘Remember. There is no shame in asking for help young one. It is the wise who admit when they need assistance.’", "", "REST", 2, 
    "Feeling your wiery bones, and trusting in The Old Man’s words, you ask if you can rest within his home. He agrees, setting you out a small mat on his floor to sleep on and providing you with a quaint, but pleasant meal", "You regain 1HP", "", "", 1, "", "", 
    "misc3Text");

  WorldEvents[2] = new WorldEvent(0, 0, "The Three Items", 72, TNRReg, WE_ITEMS, "TheItems.png", "You find your way into a small clearing, the trees of the forest around you giving way. On the ground in front of you, you see The Three Items: The Mirror, The Spyglass and The Sword. You must take one. Make your choice.", 
    "emptyClearing.png", "You stand within an empty clearing.", "SWORD", 2, "You pick up the sword from the ground, tucking it into your belt. The other items dissapear without a trace.", "You have gained The Sword.", "MIRROR", 2, 
    "You reach down a take the mirror, carefully stowing it within your bag. ", "You have gained The Mirror. The other items dissapear without a trace.", "", "SPYGLASS", 2, 
    "You take the spyglass from the ground, placing it within its case and letting it hang from one shoulder. The other items dissapear without a trace.", "You have gained The Spyglass.", "misc3Text");

  WorldEvents[3] = new WorldEvent(0, 0, "The King", 72, TNRReg, WE_KING, "TheRoyalProcession.png", "You see before you a Royal Procession, with dozens marching on. Among them, some hold up The King.", "TheKing.png", 
    "You approach the Royal Procession. On a wooden throne you see a man, wide-eyed and regal, who you can only assume is The King.", "TALK", 1, "'Beware if you see a coin along The Path. For riches it may bring, but such things always have a cost. If you must look upon it, only use its reflection.'", 
    "", "KILL THE KING", 2, "With a single swing of your sword you cut down The King. ", "The King is dead. Long live The King.", "", "REFLECT", 2, 
    "You take out The Mirror and show The King his reflection. ‘It has been some time since I have seen myself. Thank you, stranger. I will tell you were to find The Pool.", "You have learned the location of The Pool. The Pool is [insert pool location]", "");

  WorldEvents[4] = new WorldEvent(0, 0, "The Pool", 72, TNRReg, WE_POOL, "ThePool.png", "You see ahead of you, in a gap between the trees, a glistening pool of water, its surface rippling gently.", "", "body2", "TALK", 1, "talk1", "talk2", "BATHE", 2, 
    "You lower yourself gently into the pool, allowing it to cleanse you of all your ills.", "You feel invigorated.", "misc1p3", "misc2", 1, "misc2Text1", "misc2Text2", "misc3Text");

  WorldEvents[5] = new WorldEvent(0, 0, "The Corruption", 72, TNRReg, WE_CORRUPTION, "TheCorruption.png", "As you step through the next length of The Path, black sticky smoke fills the sky. The trees and rocks drip with a strange black fluid, their forms seemingly converted into this odd substance. You see The Corruption.", 
    "", "Unaware of the danger it poses, you attempt to push through The Corruption. You make it out the other side, but not untouched. You see a spot of flesh on your arm now completely black, sending small bursts of pain throughout your body at odd intervals. And it appears to be spreading.", 
    "TALK", 1, "talk1", "talk2", "misc1", 1, "misc1Text1", "misc1Text2", "misc1p3", "misc2", 1, "misc2Text1", "misc2Text2", "misc3Text");

  WorldEvents[6] = new WorldEvent(0, 0, "The Monster", 72, TNRReg, WE_MONSTER, "TheDarkness.png", "The path darkens and you feel a sense of deep unease. Dare you go on?", "TheMonster2.png", "With terrible teeth and burning eyes, you see… The Monster.", "TALK", 2, 
    "Lacking other options, you attempt to run past The Monster. As you do so The Monster lashes out with it’s fearsome fangs and deals you a fearsome blow.", "You lose 2HP.", "MISC1", 2, 
    "You attempt to run past The Monster, desperately holding The Mirror in your hand. The Monster pays it no head, slashing at you with terrible might. At the last moment one of the few remaining sunbeams strikes The Mirror, and reflects into The Monster, causing it to flee in pain.", 
    "You lose 1HP.", "misc1p3", "MISC2", 1, "Sword in your hand, and your Training to guide you, you fend off The Monster’s attacks and make it out the other side. You take a breath. You are unharmed.", "misc2Text2", 
    "Holding The Charm you step forward shakily into the darkness. The Monster never strikes. You make it through unharmed.");

  WorldEvents[7] = new WorldEvent(0, 0, "The Priest", 72, TNRReg, WE_PRIEST, "ThePriest.png", "Continuing down The Path, you see trees rise along its sides. Ahead of you stands a jovial figure, in black robes and with a smile on his face. You see The Priest.", 
    "", "body2", "TALK", 2, "‘Preoccupied with a single leaf, you won’t see the tree.’ ", "‘Preoccupied with a single tree, you’ll miss the entire forest.’", "REALISE", 1, "‘I think at this point you realise. The Monster was never there to begin with.’", 
    "misc1p2.", "misc1p3", "misc2", 1, "misc2Text1", "misc2Text2", "misc3Text");

  WorldEvents[8] = new WorldEvent(0, 0, "The Beggar", 72, TNRReg, WE_BEGGAR, "TheBeggar.png", "Ahead of you, you see a figure crouched beside The Path. Their clothes are matted in dirt and their eyes face down. You see The Beggar.", 
    "", "body2", "TALK", 1, "‘Along The Path, there is a sickly darkness. It is The Corruption. If you find it, do not let it upon your skin. Upon your clothes. Run from it. If it finds its way onto you, your only salvation lies within The Pool.’ ", 
    "talk2", "GIVE", 3, "You place The Coin on the ground in front of The Beggar. They look up at you. ‘Thank you, stanger. You have done me a great kindness. I haven’t much, but I will do my best to return the favour.’", 
    "The Beggar takes a small stick from the side of the road and wraps it in a dirty piece of string. They smile at you. ‘A gift of thanks, from my hand to yours.’ .", "You have received The Charm.", "THE KING IS DEAD", 2, 
    "The Beggar looks up at you, a stony expression on their face. ‘The King is dead. Long live The King.’", "‘Think on: [insert next Page Event “answer”] ’.", "misc3Text");

  WorldEvents[9] = new WorldEvent(0, 0, "The Coin", 72, TNRReg, WE_COIN, "TheCoin2.png", "The sides of The Path become more barren, the land becoming more empty. On the road in front of you, a slight glint of metal catches your eye. Lying on The Path, you see The Coin.", 
    "NoCoin.png", "The Path now lies empty before you, The Coin clutched tightly in your hand.", "TALK", 1, 
    "‘Along The Path, there is a sickly darkness. It is The Corruption. If you find it, do not let it upon your skin. Upon your clothes. Run from it. If it finds its way onto you, your only salvation lies within The Pool.’ ", "talk2", "TAKE", 3, 
    "You bend down and pick up The Coin. As you do, a flash of searing pain pieces into your head. It fades, leaving The Coin still clutched tightly in your hand.", "You have gained The Coin.", "You have lost 1HP.", "MISC2", 2, 
    "You almost touch The Coin, before a foreboding feeling in your gut brings you up short. Tentatively, you reach into your bag, and pull out The Mirror. Instead of reaching for The Coin, you instead reach into The Mirror, grasping the reflection of The Coin, painlessly and without issue.", 
    "You have gained The Coin.", "misc3Text");

  WorldEvents[10] = new WorldEvent(0, 0, "The Hill", 72, TNRReg, WE_PATH_END, "PathEndBg.png", "You have reached the end of The Path. You sit upon a hill. You are at peace with the universe.", 
    "", "", "", 1, 
    "", "", "", 1, 
    "", "", "", "", 2, 
    "", 
    "", "");
}



void drawWorldEvents() { //draws the world events and deals with scene-specific details if currentScene is a world event

  playerHP = constrain(playerHP, 0, 4); 

  if (currentScene == WE_SOLDIER) { //drawing The Soldier scene and assigning the scene-specific variables.
    WorldEvents[0].draw();

    if (WorldEvents[0].misc1Result && !soldierInsulted) {
      playerHP--; 
      soldierInsulted = true;
      deathText = "The wound The Soldier dealt you was worse than you initialy realised. As the pain fades from your side, darkness takes your vision. You have died.";
    }

    if (soldierInsulted) { //hides all conversation options if you insult The Soldier
      WorldEvents[0].makeConvoButtonsInvisible();
    }

    if (WorldEvents[2].talkResult) { //if player has The Sword
      WorldEvents[0].misc1ConditionsMet = true;
    }
    if (WorldEvents[1].talkResult) { //if the player talked to the Old Man
      WorldEvents[0].misc2ConditionsMet = true;
    }
  }


  if (currentScene == WE_OLDMAN) {
    WorldEvents[1].draw();
    //WorldEvents[1].talkResult -> talked to old man

    if (WorldEvents[1].misc1Result && !restedInGraveyard) {
      playerHP++; 
      restedInGraveyard = true;
    }

    if (restedInGraveyard) { //hides rest button if you've already rested.
      miscButton1.setVisible(false);
    }

    if (playerHP < 3) {
      WorldEvents[1].misc1ConditionsMet = true;
    }


    //since conidtions are set to false automatically, we don't need to do anything with the misc2 conditions, since that button isn't meant to appear in this scene.
  }

  if (currentScene == WE_ITEMS) {
    WorldEvents[2].draw();
    //WorldEvents[2].talkResult; --> The player took the sword
    //WorldEvents[2].misc1Result; --> The player took the mirror
    //WorldEvents[2].misc2Result; --> The player took the spyglass

    WorldEvents[2].misc1ConditionsMet = true; //since there are no conditions that need be met to see all the items, both these variables should be instantly set to true.
    WorldEvents[2].misc2ConditionsMet = true;

    if (WorldEvents[2].talkResult || WorldEvents[2].misc1Result || WorldEvents[2].misc2Result) { //if the player takes an item sets the background to an empty clearing (no more items) and removes the options to pick items.      
      WorldEvents[2].body2ConditionsMet = true; //set the case for the change of background/body text
      WorldEvents[2].makeConvoButtonsInvisible(); //hide the options to pick items.
    }
  }

  if (currentScene == WE_KING) {
    WorldEvents[3].draw();

    //WorldEvents[3].talkResult ---> talked to the king
    //WorldEvents[3].misc1Result ---> killed to the king
    //WorldEvents[3].misc2Result ---> showed the mirror to the king


    if (WorldEvents[3].stage == BODY && mousePressed && WorldEvents[3].textAlpha >= 200 && frameCount-WorldEvents[3].frameCount1 > 100) { //if stage == BODY, and mouse is pressed and the text has loaded a certain amount (to prevent the scene immidietly shifting to the next scene). I added in the frameCount stuff to enable the text not to immidietly shift to bodyText2 if the player loses health to corruption during this scene 
      WorldEvents[3].body2ConditionsMet = true;
    }


    if (WorldEvents[3].body2ConditionsMet) { //if the player has reached The King, passed The Royal Procession
      if (WorldEvents[2].talkResult) { //if player has The Sword
        WorldEvents[3].misc1ConditionsMet = true;
      }
      if (WorldEvents[2].misc1Result) { //if player has The Mirror
        WorldEvents[3].misc2ConditionsMet = true;
        for (int i = 0; i<WorldEventsOrder.length; i++) {
          if (WorldEventsOrder[i] == 4) { //finds where in the order The Pool is for this run.
            if (WECount < i) { //if the player hasn't yet reached The Pool
              if (i-WECount == 1) {
                WorldEvents[3].misc2Text2 = "The Pool lies " + (i-WECount) + " meeting ahead";
              } else {
                WorldEvents[3].misc2Text2 = "The Pool lies " + (i-WECount) + " meetings ahead"; //for gramatical correctness. Of course.
              }
            } else { //if the player has found the Pool already.
              WorldEvents[3].misc2Text2 = "The Pool lies behind you.";
            }
          }
        }
      }
      if (WorldEvents[3].misc1Result) { //if the player has killed the king
        if (!actionCompleted[0]) {
          WorldEvents[3].bgImage2 = loadImage("TheKingIsDead.png");
          WorldEvents[3].bodyText2 = "The King is dead. Long live The King.";
          actionCompleted[0] = true;
        }
        WorldEvents[3].makeConvoButtonsInvisible(); //hide the options to interact with The King.
      }
    } else { //if the player is still on the Royal Procecesion
      WorldEvents[3].makeWEButtonsInvisible(); //hide all the buttons so the players can't click on anything else, but to bring them closer to The King.
    }
  }


  if (currentScene == WE_POOL) {
    WorldEvents[4].draw();
    talkButton.setVisible(false);
    WorldEvents[4].misc1ConditionsMet = true; //since the only visible buttons should be the middle one, we hide the talk button, show misc1, and allow misc2 to remain hidden.

    if (WorldEvents[4].stage== BODY && WorldEvents[4].misc1Result) { //sets that the player has used the pool in such a way that it doesn't automatically set it to be the case as soon as the player heals, thus allowing the text telling the player they've been healed to show
      poolHealingUsed = true;
    }

    if (WorldEvents[4].stage== MISC1P1) {
      if (playerHP < 3 && !poolHealingUsed) {
        playerHP = 3;
        WorldEvents[4].misc1Text2 = "You have regained HP.";
      } else if (playerHP < 3 && poolHealingUsed) { //if the player attepts to heal using the pool a second time.
        WorldEvents[4].misc1Text2 = "The waters fail to heal you beyond your first attempt.";
      } 
      if (playerCorrupted) {
        playerCorrupted = false; 
        corruptionCured = true;
      }
      if (corruptionCured && !actionCompleted[6]) {
        WorldEvents[4].misc1Text2 += " You feel The Corruptoin leave your body. You are healed.";
        actionCompleted[6] = true;
      }

      if (WorldEvents[9].misc1Result && !WorldEvents[8].misc1Result) {  //if the player picked up The Coin and didn't give it to the Beggar
        WorldEvents[9].misc1Result = false; //removes The Coin from the player
        coinRemoved = true;
      }
      if (coinRemoved && !actionCompleted[7]) {
        WorldEvents[4].misc1Text2 += " As you leave the waters, you find The Coin has vanished from your person. Though perterbed by the loss, you feel as though a weight has been lifted from your shoulders.";
        actionCompleted[7] = true;
      }
    }
  }

  if (currentScene == WE_CORRUPTION) {
    WorldEvents[5].draw();
    talkButton.setVisible(false);

    if (!WorldEvents[5].sceneVisited) { //if this scene has not been visited yet

      if (!WorldEvents[5].body2ConditionsMet) {
        WorldEvents[5].makeWEButtonsInvisible();
      }

      if (WorldEvents[5].stage == BODY && mousePressed && WorldEvents[5].textAlpha >= 100) { // if the mouse is pressed after the text loads enough and the stage is BODY
        WorldEvents[5].body2ConditionsMet = true;
        goForwardButton.setVisible(true);
        goBackButton.setVisible(true);
        if (!WorldEvents[2].misc2Result) { //if the player doesn't have the spyglass
          if (!WorldEvents[8].misc1Result) {//if player doesn't have the Charm
            playerCorrupted = true;
            if (WorldEvents[8].talkResult) { //if the player spoke with The Beggar
              WorldEvents[5].bodyText2 = "Having been forwarned by The Beggar, you managed to avoid the worst of its effects. Though you still see a small black spot spreading on your hand, you feel confident that things could have been much worse";
              playerPartiallyCorrupted = true;
              WECountCorruptionStarted = WECount;// the player is still corrupted, but sicne they don't take damage when
            }
          } else { //if player does have the Charm
            WorldEvents[5].stage = MISC3;
          }
        } else { //if the player has the Spyglass
          WorldEvents[5].bodyText2 = "Having seen The Corruption from afar using The Spyglass, you avoid it all together. It takes time to find your way around it, but you feel it was worth it.";
        }
      }

      if (playerCorrupted && !actionCompleted[4]) {
        WECountCorruptionStarted = WECount;
        actionCompleted[4]=true;
      }
    } else { //if this scene has been visited before
      WorldEvents[5].bodyText2 = "You stand again at the sight of The Corruption. Knowing its effects, you don't get too close.";
    }
  } // end of Corruption

  if (WorldEvents[8].talkResult && playerPartiallyCorrupted) { //player partially corrupted used so if they spoke to the beggar after initially being corrupted, this statement woudln't activate.
    if (WECountCorruptionStarted == WECount-2 && !actionCompleted[5]) { // after 2 scenes have past from The Corruption, resets the WECountSinceCorruptionStarted to effectivally give the player another 2 scenes before they start taking damage from the Corruption.
      WECountCorruptionStarted = WECount;
      actionCompleted[5] = true;
    }
  }


  if (currentScene == WE_MONSTER) {
    WorldEvents[6].draw();
    WorldEvents[6].makeConvoButtonsInvisible(); 

    if (!WorldEvents[7].misc1Result) { //if the player has not Realised from the priest.

      if (!(WorldEvents[6].talkResult || WorldEvents[6].misc1Result || WorldEvents[6].misc2Result || WorldEvents[6].misc3Result)) { //sets the foward button invisilbe and the back button to visible for the first screen, then makes both invisible until one of the conditions for getting past The Monster has been met
        if (WorldEvents[6].stage == BODY && WorldEvents[6].blackBgAlpha <= 0) {
          goForwardButton.setVisible(false);
        }
        if (WorldEvents[6].body2ConditionsMet) {
          goBackButton.setVisible(false);
        }
      }

      if (WorldEvents[6].stage == BODY && mousePressed && WorldEvents[6].textAlpha >= 100 && !mouseOverBackButton()) { // if the mouse is pressed after the text loads enough and the stage is body
        WorldEvents[6].body2ConditionsMet = true;

        if (!actionCompleted[2]) {
          frameCount1 = frameCount;
          actionCompleted[2] = true;
        }

        if (WorldEvents[6].body2ConditionsMet && mousePressed && frameCount-frameCount1 > 10 && !(WorldEvents[6].talkResult || WorldEvents[6].misc1Result || WorldEvents[6].misc2Result || WorldEvents[6].misc3Result)) { //if the mouse is pressed again and at least 1 second has gone by (assuming 10fps), and none of the interacts have yet occured.

          if (WorldEvents[2].misc1Result) {//if player took The Mirror
            WorldEvents[6].stage = MISC1P1; //stage is set to where the appropriate text is held
            deathText = "Even with The Mirror lessening its effects, your body was not strong enough to withstand The Monster. You have died";
          } else if ((WorldEvents[2].talkResult)) { //if player took The Sword
            WorldEvents[6].stage = MISC2P1; //stage is set to where the appropriate text is held, since no HP lost, we don't need to worry about actionCompleted[]

            if (!WorldEvents[0].misc2Result) { //if player doesn't have Sword Training 
              WorldEvents[6].misc2Parts = 2;
              WorldEvents[6].misc2Text1 = "Untrained with your Sword, and lacking other options, you attempt to run past The Monster. As you do so The Monster lashes out with it’s fearsome fangs and deals you a fearsome blow.";
              WorldEvents[6].misc2Text2 = "You lose 2HP.";
              deathText = "As you stagger from the darkness, you realise The Monster's fangs bit deeper than you realised. You collapse to the ground. You have died.";
            }
          } else if (WorldEvents[8].misc1Result) { //if player has the Charm
            WorldEvents[6].stage = MISC3;
          } else { // if player has no other options when confronting The Monster
            WorldEvents[6].stage = TALKP1;
            deathText = "As you stagger from the darkness, you realise The Monster's fangs bit deeper than you realised. You collapse to the ground. You have died.";
          }
          WorldEvents[6].bodyText2 = "You stand alone in the darkness.";
        }
      }
      if (WorldEvents[6].stage == BODY && (WorldEvents[6].talkResult || WorldEvents[6].misc1Result || WorldEvents[6].misc2Result || WorldEvents[6].misc3Result)) { // if the stage is body after an interaction has occurred sets the forward button to visible and sets the first image of just the darkness to be the one the player sees
        if (!actionCompleted[1]) { //when the appropriate text reaches its end, the effect is called once, so HP isn't just being continually lost. 
          if ( WorldEvents[6].talkResult || (WorldEvents[6].misc2Result && !WorldEvents[0].misc2Result)) { //Both the events when the player has The Sword but no Training and the events where the player has nothing are linked here, as the player loses the same amount of health
            playerHP-=2;
          } else if ( WorldEvents[2].misc1Result) { //if player had the mirror they only lose 1hp
            playerHP-=1;
          } //else they don't lose HP so nothing needs be added here.
          actionCompleted[1] = true;
        } 

        if (WorldEvents[6].bgAlpha<255) {
          WorldEvents[6].bgAlpha += 5;
        }
        WorldEvents[6].bgAlpha += 5;
      }
    } else { //if the player has Realised from The Priest
      WorldEvents[6].bodyText1 = "The Monster never was.";
      WorldEvents[6].bodyText2 = "The Monster never was.";
      if (!actionCompleted[3]) {
        WorldEvents[6].bgImage2 = loadImage("TheDarkness.png");
        actionCompleted[3] = true;
      }
    }
  } //end of The Monster


  if (currentScene == WE_PRIEST) {
    WorldEvents[7].draw();

    if (pagesMatched > 5) {
      WorldEvents[7].misc1ConditionsMet = true;
    }
  }

  if (currentScene == WE_BEGGAR) {
    WorldEvents[8].draw();
    //WorldEvents[8].talkResult ---> talked to the beggar
    //WorldEvents[8].misc1Result ---> gave Coin to beggar, got Charm
    //WorldEvents[8].misc2Result ---> player killed the king then spoke to the beggar

    if (WorldEvents[9].misc1Result) { //if player has The Coin
      WorldEvents[8].misc1ConditionsMet = true;
    }

    if (WorldEvents[3].misc1Result) { //if the player has killed the king
      WorldEvents[8].misc2ConditionsMet = true;
      WorldEvents[8].misc2Text2 = "Perhaps try " + PageEvents[WECount].matchingNumber + "."; //giving the number of the matching answer to the player, 1 and 2 for the base options, 3 for the hidden answer
    }
  }

  if (currentScene == WE_COIN) {
    WorldEvents[9].draw();
    talkButton.setVisible(false);
    WorldEvents[9].misc1ConditionsMet = true;

    if (WorldEvents[2].misc1Result && misc1Clicked) { //if the player does have The Mirror && they click the TAKE button
      WorldEvents[9].stage = MISC2P1;
    } else if (WorldEvents[9].misc1Result) { //if player just takes the coin without having the mirror
      if (!actionCompleted[2]) { //to avoid player losing 1HP every frame
        playerHP --;
        actionCompleted[2] = true;
        deathText = "As you clutch The Coin in your hand, you feel your vision start to blur. Your body sways. Then everything goes black. You have died.";
      }
      WorldEvents[9].body2ConditionsMet = true;
    }

    if (WorldEvents[9].body2ConditionsMet) {
      miscButton1.setVisible(false);
    }
  }

  if (currentScene == WE_PATH_END) {
    WorldEvents[10].draw();
    WorldEvents[10].makeWEButtonsInvisible();
    if (WorldEvents[10].stage == BODY && mousePressed && WorldEvents[10].textAlpha >= 100) { // if the mouse is pressed after the text loads enough and the stage is body
      WorldEvents[10].stage = END;
    }
  }
}

void initialiseTenBulls() {
  //initialising the Ten Bulls Pages
  TBPages[0] = new TBPage(0, 0, "  The Search for the Bull", 0, TNRReg, TB_1, "1.", "In the pasture of this world, I endlessly push aside the tall\n     grasses in search of the bull.\nFollowing unnamed rivers, lost upon the interpenetrating\n     paths of distant mountains,\nMy strength failing and vitality exhauseted, I cannot find\n     the bull.\nI only hear the locusts chirring through the forest at night.", 
    "                 The bull has been lost. What need is there to\nsearch? Only because of the separation from my true nature,\nI fail to find him. In the confusion of the senses I lose\neven his tracks. Far from home, I see many crossroads,\nbut which way is the right one I know not. Greed and\nfear, good and bad, entangle me.", 
    "TBImage1.png");
  TBPages[1] = new TBPage(0, 0, "  Discovering the Footprints", 0, TNRReg, TB_2, "2.", "Along the riverbank under the trees, I discover footprints!\nEven under the fragrant grass I see his prints.\nDeep in remote mountains they are found.\nThese traces no more can be hidden than one’s nose, looking\n     heavenward.", 
    "                 Understanding the teaching, I see the foot-\nprints of the bull. Then I learn that, just as many utensils\nare made from one metal, so too are myriad entities\nmade of the fabric of self. Unless I discriminate, how will\nI perceive the true from the untrue? Not yet having\n entered the gate, nevertheless I have discerned the path.", 
    "TBImage2.png");
  TBPages[2] = new TBPage(0, 0, "  Perceiving the Bull", 0, TNRReg, TB_3, "3.", "I hear the song of the nightingale.\nThe sun is warm, the wind is mild, willows are green along the\n     shore,\nHere no bull can hide!\nWhat artist can draw that massive head, those majestic horns?", 
    "                 When one hears the voice, one can sense its\nsource. As soon as the six senses merge, the gate is\n entered. Wherever one enters one sees the head of the\nbull! This unity is like salt in water, like colour in dyestuff.\nThe slightest thing is not apart from self.", 
    "TBImage3.png");
  TBPages[3] = new TBPage(0, 0, "   Catching the Bull", 0, TNRReg, TB_4, "4.", "I seize him with a terrific struggle.\nHis great will and power are inexhaustible.\nHe charges to the high plateau far above the cloud-mists,\nOr in an impenetrable ravine he stands.", 
    "                 He dwelt in the forest a long time, but I caught\nhim today! Infatuation for scenery interferes with his\ndirection. Longing for sweeter grass, he wanders away.\nHis mind still is stubborn and unbridled. If I wish him to\nsubmit, I must raise my whip.", 
    "TBImage4.png");
  TBPages[4] = new TBPage(0, 0, "   Taming the Bull", 0, TNRReg, TB_5, "5.", "The whip and rope are necessary,\nElse he might stray off down some dusty road.\nBeing well trained, he becomes naturally gentle.\nThen, unfettered, he obeys his master.", 
    "                 When one thought arises, another thought\nfollows. When the first thought springs from enlighten-\nment, all subsequent thoughts are true. Through\ndelusion, one makes everything untrue. Delusion is not\ncaused by objectivity; it is the result of subjectivity. Hold\nthe nose-ring tight and do not allow even a doubt.", 
    "TBImage5.png");
  TBPages[5] = new TBPage(0, 0, "   Riding the Bull Home", 0, TNRReg, TB_6, "6.", "Mounting the bull, slowly I return homeward.\nThe voice of my flute intones through the evening.\nMeasuring with hand-beats the pulsating harmony, I direct the\n     endless rhythm.\nWhoever hears this melody will join me.", 
    "                 This struggle is over; gain and loss are assimi-\nlated. I sing the song of the village woodsman, and play\nthe tunes of the children. Astride the bull, I observe the\nclouds above. Onward I go, no matter who may wish to\ncall me back.", 
    "TBImage6.png");
  TBPages[6] = new TBPage(0, 0, "   The Bull Transcended", 0, TNRReg, TB_7, "7.", "Astride the bull, I reach home.\nI am serene. The bull too can rest.\nThe dawn has come. In blissful repose,\nWithin my thatched dwelling I have abandoned the whip and\n     rope.", 
    "                 All is one law, not two. We only make the bull\na temporary subject. It is as the relation of rabbit and\ntrap, of fish and net. It is as gold and dross, or the moon\nemerging from a cloud. One path of clear light travels\non throughout endless time.", 
    "TBImage7.png");
  TBPages[7] = new TBPage(0, 0, "   Both Bull and Self Transcended", 0, TNRReg, TB_8, "8.", "Whip, rope, person, and bull – all merge in No-thing.\nThis heaven is so vast no message can stain it.\nHow may a snowflake exist in a raging fire?\nHere are the footprints of the patriarchs.", 
    "                 Mediocrity is gone. Mind is clear of limitation.\nI seek no state of enlightenment. Neither do I remain\nwhere no enlightenment exists. Since I linger in neither\ncondition, eyes cannot see me. If hundreds of birds strew\nmy path with flowers, such praise would be meaningless.", 
    "TBImage8.png");
  TBPages[8] = new TBPage(0, 0, "   Reaching the Source", 0, TNRReg, TB_9, "9.", "Too many steps have been taken returning to the root and the\n     source.\nBetter to have been blind and deaf from the beginning!\nDwelling in one’s true abode, unconcerned with that without –\nThe river flows tranquilly on and the flowers are red", 
    "                 From the beginning, truth is clear. Poised in\nsilence, I observe the forms of integration and disinte-\ngration. One who is not attached to ‘form’ need not be\n ‘reformed’. The water is emerald, the mountain is indigo,\nand I see that which is creating and that which is\nand that which is destroying.", 
    "TBImage9.png");
  TBPages[9] = new TBPage(0, 0, "   In the World", 0, TNRReg, TB_10, "10.", "Barefooted and naked of breast, I mingle with the people of the\n     world.\nMy clothes are ragged and dust-laden and I am ever blissful.\nI use no magic to extend my life;\nNow, before me, the trees become alive.", 
    "                 Inside my gate, a thousand sages do not know\nme. The beauty of my garden is invisible. Why should\none search for the footprints of the patriarchs? I go\nto the market place with my wine bottle and return home\nwith my staff. I visit the wineshop and the market, and\neveryone I look upon becomes enlightened.", 
    "TBImage10.png");
}
