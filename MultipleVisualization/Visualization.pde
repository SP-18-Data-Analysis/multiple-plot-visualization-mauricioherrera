class Visualization {
  
  
  // These are the list of values to plot.
   ArrayList<Float> columnValues;
   ArrayList<Integer> xValues;
   
   
   // These are the labels for each data object. 
   // This is what you show when you do a mouse-over over that data object
   ArrayList<String> columnLabels;
   
   // The max value from the column values ( This respresents the y axis)
   Float dataMax;
   Float dataMin;
   
   // The min and max values representing the x Axis
   Integer xMin;
   Integer xMax;
  
  
  // We need a constructor to initialize the instantiated object
  Visualization() {
     columnValues = new ArrayList<Float>();
     columnLabels = new ArrayList<String>();
  }
  
  void addDataObject(Float valueObj, String stringObj) {
     columnValues.add(valueObj);
     columnLabels.add(stringObj);
     
  }
  
  void addXminMax(int xMinVal, int xMaxVal) {
      xMin  = xMinVal;
      xMax = xMaxVal;
  }
  
  void addYminMax(Float dMin, Float dMax) {
     dataMin = dMin;
     dataMax = dMax;
  }
  
  void addDataObject(Float valueObj) {
     columnValues.add(valueObj);
  }
  
  void doDraw(int plotX1,int plotX2, int plotY1, int plotY2) {
    int rowCount = columnValues.size();
    for (int row = 0; row < rowCount; row++) {
      float value = columnValues.get(row);
      // float value = data.getFloat(row, col);
     // float value = data.getFloat(row, col);
      // xMIN , xMAX these are the same range for all the visualizations
      float x = map(row, xMin, xMax, plotX1, plotX2); 
      float y = map(value, dataMin, dataMax, plotY2, plotY1); 
      rect(x-barWidth/2, y, x+barWidth/2, plotY2);
    
  } 
    
    
  }
  
  void evaluateMouseEvent(Float mouseX, Float mouseY) {
      
      // THIS FUNCTION IS CALLED FOR MOUSE PRESS EVENTS
      
      // FIND THE SCREEN COORDINATES OF EACH OF THE DATA OBJECTS
      int rowCount = columnValues.size();
      for (int row = 0; row < rowCount; row++) {
        float value = columnValues.get(row);
        float y = map(value, dataMin, dataMax, plotY2, plotY1); 
        float x = map(row, xMin, xMax, plotX1, plotX2); 
        // IS THE MOUSE X, MOUSE Y LOCATION WITH THE INVISIBLE SQUARE 
        // AROUND X,Y
        
       int leftX = x - 5;
       int upperY = y - 5;
       int rightX = x + 5;
       int lowerY = y + 5;
        // DETECTING THE X AXIS LABEL
        if (mouseY > lowerY  && mouseY < lowerY && 
            mouseX > leftX && mouseX < rightX) {
               // THIS IS WHER YOU CAN SHOW THE TEXT INFORMATION FOR 
               // THIS DATA OBJECT
        
        }
    
      }
  }
  
  
  void drawVolumeData(int col) {

  beginShape( );
  for (int row = 0; row < rowCount; row++) {
      float y = map(value, dataMin, dataMax, plotY2, plotY1); 
      float x = map(row, xMin, xMax, plotX1, plotX2); 
      vertex(x, y);
    
  }
  // Draw the lower-right and lower-left corners.
  vertex(plotX2, plotY2);
  vertex(plotX1, plotY2);
  endShape(CLOSE); 
  }
  
  
  void drawDataLine(int col) {
  beginShape( );
  rowCount = data.getRowCount();
  for (int row = 0; row < rowCount; row++) {
      float value = data.getFloat(row, col);
      float y = map(value, dataMin, dataMax, plotY2, plotY1); 
      float x = map(row, xMin, xMax, plotX1, plotX2); 
      vertex(x, y);
    
    
    
  }
  endShape( );
}
   
}