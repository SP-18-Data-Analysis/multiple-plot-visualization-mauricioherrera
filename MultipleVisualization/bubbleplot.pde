PImage img;
float [] xCoordinates;
float [] yCoordinates;

int numRows;
int numColumns;
void setup() {
   // Load the data , and load the image
   size(1000,500);
   FloatTable data = new FloatTable("data/locations.tsv"); 
   img = loadImage("data/usmap.png");
   
   numRows = data.getRowCount();
   numColumns = data.getColumnCount();
   // Column 1
   xCoordinates = new float[numRows];
   // Column 2
   yCoordinates = new float[numRows];
   
   for ( int i = 0; i < numRows; i++) {
      xCoordinates[i] = data.getFloat(i,0);
      yCoordinates[i] = data.getFloat(i,1); 
      //print(xCoordinates[i],yCoordinates[i]);
   }
}

void draw() {
   background(0);
   image(img,0,0);
   drawCoordinates();
   
  
}

void drawCoordinates() {
    fill(0);
    for (int i = 0; i < numRows; i++) {
      // We are putting a uniform volume size for every data point
      // For the next homewor - find some statistics for each state
      // generate the find the max and min values and map the values
      // between 1 and 10.
      // radius = map(value,datMin,dataMax,1,10)
      ellipse(xCoordinates[i],yCoordinates[i],5,5);
    }
}