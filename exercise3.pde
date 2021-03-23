PImage bg, startNormal, startHover, lose, win, restart, ship;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
final int GAME_WIN = 3;
int gameState = GAME_START;

final int BUTTON_TOP = 210;
final int BUTTON_BOTTOM = 280;
final int BUTTON_LEFT = 115;
final int BUTTON_RIGHT = 450;

float shipX, shipY;
float shipSpeed = 5;
float shipWidth = 50;

float wall1Speed = 1;
float wall2Speed = 2;
float wall3Speed = 3;

float wall1Y = 100;
float wall2Y = 200;
float wall3Y = 300;

float hole1X;
float hole2X;
float hole3X;

float wall1HoleWidth = 300;
float wall2HoleWidth = 200;
float wall3HoleWidth = 100;

final float wallWeight = 10;

float winningLineY = 400;

color wallColor;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;


void setup() 
{
  size(600, 500);
  bg=loadImage("img/bg.png");
  startNormal=loadImage("img/start1.png");
  startHover=loadImage("img/start2.png");
  lose=loadImage("img/lose.png");
  win=loadImage("img/win.png");
  restart=loadImage("img/restart.png");
  ship=loadImage("img/ship.png");

  shipX = width / 2 - shipWidth / 2;
  shipY = 0;
  
  wallColor = color(247, 210, 60);
  
  hole1X = (width - wall1HoleWidth)/2;
  hole2X = (width - wall2HoleWidth)/2;
  hole3X = (width - wall3HoleWidth)/2;
  
  
}

void draw() 
{ 
  switch(gameState)
  {
    case GAME_START:
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM)
      {
        image(startHover, 0, 0);
        if(mousePressed)
        {
          gameState = GAME_RUN;
        }
      }else
      {
        image(startNormal, 0, 0);
      }
    break;
    
    case GAME_RUN:
      image(bg, 0, 0);
      
      //wall&hole
      //1st
      noStroke();
      fill(wallColor);
      rect(0, wall1Y, width, wallWeight);
      fill(255);
      rect(hole1X, wall1Y, wall1HoleWidth, wallWeight);
      
      //2nd
      noStroke();
      fill(wallColor);
      rect(0, wall2Y, width, wallWeight);
      fill(255);
      rect(hole2X, wall2Y, wall2HoleWidth, wallWeight);
      
      //3rd
      noStroke();
      fill(wallColor);
      rect(0, wall3Y, width, wallWeight);
      fill(255);
      rect(hole3X, wall3Y, wall3HoleWidth, wallWeight);
      
      //hole movement
      hole1X += wall1Speed;
      hole2X += wall2Speed;
      hole3X += wall3Speed;
      if(hole1X + wall1HoleWidth >= width || hole1X <= 0)
      {
        wall1Speed *= -1;
      }
      
      if(hole2X + wall2HoleWidth >= width || hole2X <= 0)
      {
        wall2Speed *= -1;
      }
      
      if(hole3X + wall3HoleWidth >= width || hole3X <= 0)
      {
        wall3Speed *= -1;
      }
      
      //ship movement
      //keypressed detection
      if (upPressed){
        shipY -= shipSpeed;
      }
      if (downPressed){
        shipY += shipSpeed;
      }
      if (leftPressed){
        shipX -= shipSpeed;
      }
      if (rightPressed){
        shipX += shipSpeed;
      }
      
      //boundary detection
      if(shipX > width - shipWidth){
        shipX = width - shipWidth;
      }
      if(shipX < 0){
        shipX = 0;
      }
      if(shipY > height - shipWidth){
        shipY = height - shipWidth;
      }
      if(shipY < 0){
        shipY = 0;
      }
      
      //winningline detection
      if(shipY >= winningLineY - shipWidth){
        gameState = GAME_WIN;
      }
      
      //wall crash detection
      //1st wall
      if(shipY > wall1Y - shipWidth && shipY < wall1Y + wallWeight)
      {
        if(shipX < hole1X || shipX + shipWidth > hole1X + wall1HoleWidth)
        {
          gameState = GAME_OVER;
        }
      }
      //2nd wall
      if(shipY > wall2Y - shipWidth && shipY < wall2Y + wallWeight)
      {
        if(shipX < hole2X || shipX + shipWidth > hole2X + wall2HoleWidth)
        {
          gameState = GAME_OVER;
        }
      }
      //3rd wall
      if(shipY > wall3Y - shipWidth && shipY < wall3Y + wallWeight)
      {
        if(shipX < hole3X || shipX + shipWidth > hole3X + wall3HoleWidth)
        {
          gameState = GAME_OVER;
        }
      }
      
      image(ship, shipX, shipY);
      break;
    case GAME_WIN:
      image(win, 0, 0);
      break; //<>//
      
    case GAME_OVER: //<>//
      image(lose, 0, 0);
      break;
  }
}

void keyPressed()
{
  if (key == CODED) 
  {
    // detect special keys
    switch (keyCode) 
    {
      case ENTER: //<>//
        if(gameState == GAME_WIN || gameState == GAME_OVER)
        {
          shipX = width / 2 - shipWidth / 2;
          shipY = 0;
          gameState = GAME_RUN; //<>//
        }
        break;
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}

void keyReleased() 
{
  if (key == CODED) 
  {
    switch (keyCode) 
    {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
