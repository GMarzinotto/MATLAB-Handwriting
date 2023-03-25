# MATLAB-Handwriting


A Toolbox for Online Handwriting analysis in MATLAB.

## Features
* **Load Data** with a simple interface to read online handwriting recordings in csv alike format. 
* **Visualize** different handwriting parameters, such as speed, pressure, pen angles, curvature, inclination, etc.
* **Preprocess** handwriting to correct inclination, slant, skew.
* **Segment** long texts into lines or words.
* **Detect** punctuation marks, diacritics and/or delayed segments. Use the pre-trained SVM classifiers of retrain your own!
* **Extract** a large amount of possible features from handwriting, These features can be word specific, writer specific of both. 
* **Analyse** handwriting using the extracted features with some simple machine learning techniques.

## Toy Database
The repository contains some online handwriting extracts recorded using a Wacom tablet. See Demo Folder. <br />
Each person  in the database copied a proposed text while the tablet recorded the pen position, pressure and angles. <br />
This set can be used to test the toolbox modules, and further Demo scripts show how to do so.   



![Text Sample](https://raw.githubusercontent.com/GMarzinotto/MATLAB-Handwriting/master/Demo/img/full_text.png)

## Demo Scripts
The code is provided along with some demo scripts that perform some simple supervised and unsupervised machine learning techniques on handwriting. <br />
They study the relations between handwriting and age or handwriting and gender. The provided database is too small to carry real experiments. <br />
However it may be an useful source of inspiration for users with their own data <br />

Each handwriting demo can be seen as a pipeline with at least one of the following steps:

1. Read data
2. Segment data into paragraphs, lines, words, characters, etc. 
3. Preprocess each segment of data (correct inclination, slant, skew, etc.)
4. Extract features from each segment
5. Select which features are relevant and which are not for the task 
6. Continue applying visualization or machine learning techniques as in any usual data science pipeline 


## Demo Visualizations
Probably the most powerful and flexible components of this toolbox is the visualization part. <br />
For this reason we provide a set of Visualization Demo scripts that better explain the functionality

### Plot Pen Trajectories On Table and/or On Air

![Text Sample](https://raw.githubusercontent.com/GMarzinotto/MATLAB-Handwriting/master/Demo/img/Demo_Plot_On_Tablet_On_Air.png)

### Plot GIF Image

<p align="center">
  <img src='https://raw.githubusercontent.com/GMarzinotto/MATLAB-Handwriting/master/Demo/img/my_gif_on_tablet.gif'/>
</p>


### Plot On Color Scale to represent Kinematics

![Text Sample](https://raw.githubusercontent.com/GMarzinotto/MATLAB-Handwriting/master/Demo/img/Demo_Plot_In_Color_Scale.png)


