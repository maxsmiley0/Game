/*
Note: This code was adapted from the Processing.org example for an animated sprite class
https://processing.org/examples/animatedsprite.html
*/

public class Animation 
{
  PImage[] images;      //The images an animation will cycle through
  int imageCount;       //The number of images in the animation
  float frequency;      //The number of times a full animation loop will be displayed, per second
  float frame;
  
  Animation(String imagePrefix, int imageCount, float frequency) {
    this.frequency = frequency;
    this.imageCount = imageCount;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      //Loads the images, which MUST be stored in data/Animations/imagePrefix, and ordered from 00 - imageCount, and be of file type png
      String filename = "data/Animations/" + imagePrefix + "/" + imagePrefix + nf(i, 2) + ".png";
      images[i] = loadImage(filename);
    }
  }

  //Displays the animation at a given position
  void display(PVector position) {
    //Increments the frames such that it will cycle through "frequency" loops in one second
    frame = (frame + (frequency * imageCount / frameRate)) % imageCount;
    image(images[floor(frame)], position.x, position.y);
  }
}
