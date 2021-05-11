# Final Project Documentation

The complete version of my final project is a JavaScript machine learning application that recognizes if a user in front of a machine such as a laptop or desktop with a camera is wearing
sunglasses, and whether they should be wearing sunglasses at the specific time of day or not. The code was built on the ML5.js and P5.js libraries with TensorFlow support.

The primary goal of the project was for me to explore the possibilities of machine learning and to create a tool that would help me in my everyday life. I was inspired by our in-class discussions
and readings on the relationship between humans and machines, and the matter of utilizing AI to support humans in everyday tasks. My inspiration for exploring machine learning came from the moment
I struggled with our first assignment, in which I coded vehicles that would pass on "memory" through the DNA class. 

# Functionality 

My project works with the help of a pre-trained model, which I trained using the online software [Teachable Machine](https://teachablemachine.withgoogle.com/). In order to teach the model
we first must give it data and mark it as a single class. In my example this class is either Glasses or NoGlasses, and the data are images. A complex algorithm takes the raw data from the images, processes it
and stores it either on a server or a local machine. We link that data (model) in the code. Then we simply take video input from the machine's connected camera and we classify each frame of the video
by comparing it to the data in the pre-trained model. The model's classes are then stored in an array based on how confident the ML algorithm is when linking the input frame to a class from the pre-trained model 
(i.e. 0 = highest confidence, 1 = middle confidence, 2 = lowest confidence). We give a label to each class, and then read which class is at position 0 in the array, giving us information on what the algorithm thinks the current state is.
Then based on which class has the highest confidence score, the algorithm checks the time of day and displays the necissary information.

Although machine learning is an extremely complex topic, and there are multiple scientific papers and reasearch attempting to explain how specific algorighmts and models work. THe simplest
way to understand it is to understand that unlike in different types of coding, where we give the algorithm parameters, limits, and exact pre-determined values, in machine learning, we feed the algorithm data so it
would create or "learn" what specific values need to be. We are not giving it direct instructions, but data that would help it create its own instructions.

# After the project

This project was particularly challenging due to the fact that I had to learn a lot of new concepts that I was unfamiliar with. However, this is exactly why I chose to do such a project, because 
I knew there was going to be a steep learning curve. I am now confident enough to attempt more complicated challenges such as creating a machine learning algorithm for one of my robots created in previous
IM classes.

# Video of the project.
[Please click on this text to view the video demonstrating the working project.](https://drive.google.com/drive/folders/1xhWEU7ZRTOiab64Fs1_HBH0E2TZvaJig?usp=sharing)
