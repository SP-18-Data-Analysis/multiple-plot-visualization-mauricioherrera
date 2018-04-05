// THIS VISUALIZATION CREATES MULTIPLE VISUALZATION WITHIN A SINGLE PLOT
// WE NEED A DATA TABLE
FloatTable data;
// WE NEED A DATA STRUCTURE TO ITERATE OVER ALL THE VISUALIZATIONS
ArrayList<Visualization> visualizationList;
// WE NEED SCREEN COORDATES TO MAP THE VISUALIZATION WITHIN THIS WINDOW
float plotX1, plotY1;   // UPPER LEFT COORDINATES
float plotX2, plotY2;   // LOWER RIGHT COORDINATES
// WE NEED DATA MIN AND DATA MAX REPRESENTS THE LOWEST AND HIGHEST VALUES IN THE DATASET
Float dataMin;
Float dataMax;
// int  yearsMin;
// int yearsMax;
//int [] years;
// LABEL STRING FOR BOTH AXIS AND TICK MARKERS 
String labelStringX  = "YOUR X AXIS LABEL HERE ";
String labelStringY  = "YOUR Y AXIS LABEL HERE ";
// Small tick line
int volumeIntervalMinor = 5;
// Big tick line
int volumeInterval = 10;
int yearInterval = 10;
// LABEL COORDINATES  - LETS ALSO HAVE THE ABILITY TO MOVE THE LABELS
float labelX, labelY; // WE HARD CODED LABEL X AS INITIALIZATION OF 50
// NEED VARIABLES TO ACCESS OUR VISUALIZATION DATA (TABLE)
int columnCount = 0;
int rowCount = 0;
// WE NEED MOUSE INTERACTION VARIABLES - A KEY WILL TOGGLE THE VISUALIZATIONS
int visualizationLimit = 2;
int vizToggleCount = 0;
int vizType = 0;
// [ 0 - point plot, 1 - bar graph ]
// --- WE WILL HAVE A MOUSE DOWN EVENTS TO MOVE THE TEXT
// WE WANT TO MOVE 5 TEXT ITEMS BASED ON THE TOGGLE COUNT
int moveObjectLimit = 5;
int moveObjectCount = 0;
int moveObjectType = 0;
// What ever labels that you need, hard code them into here
String [] moveItems = {"YEAR","Gallons\nconsumed\nper capita","Milk","Tea","Coffee"};
void setup() {
    // This is your screen resolution, width, height
    //  upper left starts at 0, bottom right is max width,height
    size(720,405);
  
    // This calls the class FloatTable - java class 
    data = new FloatTable("data/milk-tea-coffee.tsv");
    rowCount = data.getRowCount();
    // Retrieve number of columns in the dataset
    columnCount = data.getColumnCount();
    dataMax = data.getTableMax();
    dataMin = data.getTableMin();
  
    // FIND THE MIN AND MAX VALUES FOR THE X AXIS
    int xMin = 0;
    int xMax  = 0;
  
  
    // Corners of the plotted time series
    plotX1 = 120;
    plotX2 = width - 80;
    labelX = 50;
    plotY1 = 60;
    plotY2 = height - 70;
    labelY = height - 25;
  
    // LETS SAY WE HAVE OUR VISUALIZATION WTIHN THE COLUMNS 2 - 3
    // TWO VISUALIZATIONS
    
    // HERE WE CREATED A LIST OF VISUALIZATION ELEMENTS
    visualizationList = new ArrayList<Visualization>();
  
    // INSTANTIATION OR VISUALIZATIONS
    // WE NEED TO KNOW HOW MANY VISUALIZATION WE HAVE IN OUR DATASET
    for (int i = 2; i < 4; i++ ) {
         Visualization viz = new Visualization();
         // Iterate over each element of the column and add to viz
         for ( int j = 0; j < rowCount; j++ ) {
             viz.addDataObject(data.getFloat( j,i));
             viz.addXminMax(xMin,xMax); // X MIN , MAX VALUES
             viz.addYminMax(dataMin,dataMax);
         }
         
         // ADDING THE VISUALIZATION
         visualizationList.add(viz);
    }
    
  
  
//      for ( int i = 0; i < numColumns; i++ ) {
        // print out the first column
//      if ( i == 1 ) {
//          for (int j = 0; j < numRows; j++ ) {
//              float cellValue = data.getFloat( j,i);
//           print("Column " + i + " Row " + j + " " + cellValue + " ");
            }
//        println();       
//     }
   
    
  }
  
  
}
//Require function that outputs the visualization specified in this function
// for every frame. 
void draw() {
  
  
    // Filling the screen white (FFFF) -- all ones, black (0000)
    background(255);
    drawVisualizationWindow();
    drawGraphLabels();
    for ( int i = 0; i < visualizationList.size(); i++ ) {
       // OBTAIN THE VISUALIZATION FOR EACH ITERATION
       Visualization viz = visualizationList.get(i);
       viz.doDraw();
    }
 
    // These functions contain the labels along with the tick marks
//      drawYTickMarks();
 /  drawXTickMarks();
    // The 'v' key will toggle the type of plot (bar,scatter)
    // The 'm' key will toggle the labels that activate its move properties
//      if (vizType == 0) {
        // Bar plot
   
//      drawDataBars();
//      }else if (vizType == 1) {
        // Point plot
       // drawPointPlot();
//      } else if (vizType == 2 ) {
        // Line plot
      //    drawDataLine();
//  }
    // [ 0 - labelX, 1 - labelY, 2 - column 0 label, 3 - column 1 label, 4 column 2 label ]
    
    
//  if (volumeOn == true) {
    // v key
//    drawVolumeData(currentColumn);
//  }
//  drawTitleTabs();
  
//  for (int row = 0; row < rowCount; row++) { 
//    interpolators[row].update( );
//  }
  
}
void drawTitleTabs() { 
  rectMode(CORNERS); 
  noStroke( ); 
  textSize(20); 
  textAlign(LEFT);
  // On first use of this method, allocate space for an array
  // to store the values for the left and right edges of the tabs.
  if (tabLeft == null) {
    tabLeft = new float[columnCount];
    tabRight = new float[columnCount];
  }
  float runningX = plotX1;
  tabTop = plotY1 - textAscent() - 15; 
  tabBottom = plotY1;
  for (int col = 0; col < columnCount; col++) {
    String title = data.getColumnName(col);
    tabLeft[col] = runningX;
    float titleWidth = textWidth(title);
    tabRight[col] = tabLeft[col] + tabPad + titleWidth + tabPad;
    // If the current tab, set its background white; otherwise use pale gray.
    fill(col == currentColumn ? 255 : 224);
    rect(tabLeft[col], tabTop, tabRight[col], tabBottom);
    // If the current tab, use black for the text; otherwise use dark gray.
    fill(col == currentColumn ? 0 : 64);
    text(title, runningX + tabPad, plotY1 - 10);
    runningX = tabRight[col];
  }
}
void mousePressed() {
  
  for ( int i = 0; i < visualizationList.size(); i++) {
       Visualization viz = visualizationList.get(i);
       // If the a particular mouse press action for the visualiztion
       // Then have a mouse press function call
       viz.evaluateMouseEvent(mouseX,mouseY);
    
  }
    int leftX = moveList[moveObject].xcoord - 5;
    int upperY = moveList[moveObject].ycoord - 5;
    int rightX = mouseX[moveObject].xcoord + 5;
    int lowerY = mouseY[moveObject].ycoord + 5;
    // DETECTING THE X AXIS LABEL
    if (mouseY > lowerY 
        
        
   if (mouseY > tabTop && mouseY < tabBottom) {
    for (int col = 0; col < columnCount; col++) {
      if (mouseX > tabLeft[col] && mouseX < tabRight[col]) {
        setColumn(col);
      }
    }
  }
  
  
}
void keyPressed() {
  
}
float barWidth = 2; // Add to the end of setup()
void drawYTickMarks() {
  fill(0);
  textSize(10);
  stroke(128);
  strokeWeight(1);
  for (float v = dataMin; v <= dataMax; v += volumeIntervalMinor) { 
    if (v % volumeIntervalMinor == 0) { // If a tick mark
      float y = map(v, dataMin, dataMax, plotY2, plotY1);
      if (v % volumeInterval == 0) { // If a major tick mark
        if (v == dataMin) {
          textAlign(RIGHT); // Align by the bottom
        } else if (v == dataMax) {
          textAlign(RIGHT, TOP); // Align by the top
        } else {
          textAlign(RIGHT, CENTER); // Center vertically
        }
        text(floor(v), plotX1 - 10, y);
        line(plotX1 - 4, y, plotX1, y); // Draw major tick
      } else {
        line(plotX1 - 2, y, plotX1, y); // Draw minor tick
      }
    }
  }  
  
}
void drawXTickMarks() {
  
  fill(0);
  textSize(10);
  textAlign(CENTER, TOP);
  // Use thin, gray lines to draw the grid.
  stroke(224);
  strokeWeight(5);
  for (int row = 0; row < rowCount; row++) {
    if (years[row] % yearInterval == 0) {
      float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
      text(years[row], x, plotY2 + 10);
      
      // Long verticle line over each year interval
      line(x, plotY1, x, plotY2);
    }
  } 
  
}
void drawVisualizationWindow() {
    fill(255);
  rectMode(CORNERS);
  // noStroke( );
  rect(plotX1, plotY1, plotX2, plotY2);
  
}
void drawGraphLabels() {
  fill(0);
  textSize(15);
  textAlign(CENTER, CENTER);
  text("Year", (plotX1+plotX2)/2, labelY);  
  text("Gallons\nconsumed\nper capita", labelX, (plotY1+plotY2)/2);
  
}