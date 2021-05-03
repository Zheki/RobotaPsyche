let imageModelURL = 'https://teachablemachine.withgoogle.com/models/rvEr_g4rj/';    //Link for my trained model.
let classifier;     //Classifier
let video;          //Video
let flippedVideo;
let label = "";     //Labels
let day;            //Day or night



//Function to load my model from the url.
function preload() {
  classifier = ml5.imageClassifier(imageModelURL + 'model.json');
}

//Setup function (runs only once)
function setup() {
    createCanvas(320, 240);      //Note that canvas w and h are determined in the style.css
    video = createCapture(VIDEO);//Capturing from webcam
    video.size(320, 240);        //Stretching the video on the canvas
    video.hide();
    flippedVideo = ml5.flipImage(video);
    classifyVideo();             //Begin classifying the video
}

function draw() {
  background(0);
  image(flippedVideo, 0, 0);
  textSize(28);
  textAlign(CENTER);

  //Checking if it is day or night and if I am wearing sunglasses or not (comparing)
  if (label == 'noGlasses' && day == true){
      fill(100,0,0)
      text('It is daytime, please wear your sunglasses!', width /16, height - 220, 280);
  }
  if (label == 'Glasses' && day == true){
    fill(0,100,0)
    text('Have a nice day!', width /16, height - 220, 280);
  }
  if (label == 'Glasses' && day == false){
    fill(100,0,0)
    text('It is nighttime, you do not need sunglasses.', width /16, height - 220, 280);
  }
  if (label == 'noGlasses' && day == false){
    fill(0,100,0)
    text('Have a nice day!', width /16, height - 220, 280);
  }
}

//Function that checks the time (day or night)
function checkTime(){
    let time = hour();
    if (time < 19 && time > 7){
        day = true;
    }
    else{
        day = false;
    }
}

//Function that classifies (gets a prediction) of the current frame of the video.
function classifyVideo() {
  flippedVideo = ml5.flipImage(video)
  classifier.classify(flippedVideo, gotResult);
}


//Function for getting a result
function gotResult(error, results) {
  label = results[0].label;
  checkTime();      //Checking time when getting the results
  classifyVideo();  //Classifying video again when getting the results
}