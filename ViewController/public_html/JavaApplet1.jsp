<jsp:include page="/includes/header.html"/> 
        <div class="container">
          <div class="hero-unit">
                <h2>Java Applet: Jigsaw Puzzle</h2>
                <p>The purpose of this applet is to demonstrate using JNLP 
                to download a program to the client machine then be able to access files on
                the client machine using the JNLP file service. The applet also demonstrates using
                event handlers by the ability to move the images and snap them into place. The last feature
                demonstrated is using the AWT Graphics, Graphics2D, and BufferedImage libraries to draw the images
                and separate them into pieces. The applet demonstrates
                these features through a jigsaw puzzle game. See more details below.</p>
                <p align="center"><a class="btn btn-large btn-primary" href="jnlp/JigsawPuzzle.jnlp">Click here to download the applet</a> 
                </p>
          </div>
          <div class="tabbable"> <!-- Only required for left/right tabs -->
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab1" data-toggle="tab">Description</a></li>
            <li class="pull-right"><a href="#tab3" data-toggle="tab">Jigsaw.java</a></li>
            <li class="pull-right"><a href="#tab2" data-toggle="tab">DrawPuzzelPanel.java</a></li>
            <li class="pull-right"><h4>See the Code</h4></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="tab1">
                <div class="row">
                    <div class="span4"><h4>The user will first run the JNLP file 
                    which can be downloaded from the server. The applet will open on the clients screen
                    with 3 options on the bottom panel, load, split and solve. Selecting
                    load will use the JNLP file open service to open a file browser on the
                    clients machine.</h4></div>
                    <div class="span8 pull-right">
                        <img src="resources/Images/Jigsaw04.jpg" height="1196" width="724"
                             alt="Sample Image" />
                    </div>
                </div>
                &nbsp;
                <div class="row">
                    <div class="span8">
                        <img src="resources/Images/Jigsaw01.jpg" height="724" width="1194"
                             alt="Sample Image 1" />
                    </div>
                    <div class="span4"><h4>The user will then select an image file from their machine
                        and it will be loaded into the applet window. The image is resized to fit the
                        container.</h4></div>
                </div>
                &nbsp;
                <div class="row">
                    <div class="span4"><h4>Now the user can select the split option and the image
                    will be divided into pieces and randomly placed inside a grid. Each seperate image
                    can be moved anywhere inside the applet. The pieces will snap into place inside
                    the grid. </h4></div>
                    <div class="span8 pull-right">
                        <img src="resources/Images/Jigsaw02.jpg" height="1191" width="720"
                             alt="Sample Image" />
                    </div>
                </div>
                &nbsp;
                <div class="row">
                    <div class="span8">
                        <img src="resources/Images/Jigsaw03.jpg" height="1194" width="722"
                             alt="Sample Image" />
                    </div>
                    <div class="span4"><h4>The user can attemp to assemble the images back together
                    in the correct order or the solve button can be used to automatically place the 
                    pieces in the correct places.</h4></div>
                </div>
            </div>
            <div class="tab-pane" id="tab2">
            <pre class="prettyprint">
package part2;

import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import java.awt.image.*;
import javax.jnlp.FileContents;
import javax.jnlp.FileOpenService;
import javax.jnlp.ServiceManager;

public class Jigsaw extends JApplet 
{   
    private static final long serialVersionUID = 1L;

    // references image to display
    public ImageIcon image; 

    // the panel the image will be displayed on
    public DrawPuzzlePanel puzzlePanel;	
    
    public Color bgColor = Color.ORANGE;

    public JButton load; 	// button to select image
    public JButton split;	// button to split the images
    public JButton solve;	// button to solve the puzzle
    public JPanel bottomPanel;	// the panel with the buttons
    
    private final static int IMG_WDTH = 500;
    private final static int IMG_HGT = 500;
	
    public void init() {
	
	// set window size and initialize variables
	setSize(1180, 690);
	puzzlePanel = new DrawPuzzlePanel(this);

	bottomPanel = new JPanel();
	load = new JButton( "Load" );
	split = new JButton( "Split" );
	solve = new JButton( "Solve" );
	
		 		
	// add components and place bottomPanel in applet's south region
	bottomPanel.add( load ); 
  	bottomPanel.add( split );
  	bottomPanel.add( solve );
  	add( bottomPanel, BorderLayout.SOUTH);
	
  	// add the puzzlePanel
  	puzzlePanel.setSize(1180, 690);
  	puzzlePanel.setBackground(bgColor);
  	puzzlePanel.grid = new BufferedImage[50][50];
  	puzzlePanel.outlineGrid = new Point[1000][1000];
  	puzzlePanel.puzzlePoints = new Point[1000][1000];  
  	add( puzzlePanel, BorderLayout.CENTER );
  
  	// register event handler for load
  	load.addActionListener(
            new ActionListener()
            {
                public void actionPerformed( ActionEvent event ) 
                {
                    try
                    {
                        // get a reference to the FileOpenService
                        FileOpenService fileOpenService = 
                            (FileOpenService) ServiceManager.lookup("javax.jnlp.FileOpenService");	
                        // get file's contents from the FileOpenService
                        FileContents contents = 
                            fileOpenService.openFileDialog( null, null );

                        // byte array to store image's data
                        byte[] imageData = new byte[ (int) contents.getLength() ];
                        contents.getInputStream().read( imageData ); // read image bytes
                        image = new ImageIcon( imageData );         // create the image

                    } catch( Exception e ) {
                            e.printStackTrace();
                    }
                    convertToBufferedImage();	// get the image the user selected
                    puzzlePanel.repaint();          // repaint the panel to display the image once loaded
                }  
            }); // end anonymous inner class

      // register event handler for split
      split.addActionListener(new ActionListener() {
        public void actionPerformed(ActionEvent e) {
            if (puzzlePanel.originalImage != null)
                    puzzlePanel.splitImage(puzzlePanel.getGraphics());
        }
      });
   
      solve.addActionListener(new ActionListener() {
        public void actionPerformed(ActionEvent e) {
                Graphics2D g2d = (Graphics2D)puzzlePanel.getGraphics();
                puzzlePanel.solve(g2d);
        }
      });
      	
   } // end method init
   
   private void convertToBufferedImage() {
	   puzzlePanel.originalImage = new BufferedImage(IMG_WDTH, IMG_HGT, 
			   BufferedImage.TYPE_INT_RGB);
	   Graphics2D g2d = puzzlePanel.originalImage.createGraphics();
	   g2d.drawImage(image.getImage(), 0, 0, IMG_WDTH, IMG_HGT, null);
	   g2d.dispose();
   }
   
}// end Jigsaw Applet 
            </pre>
            </div>
            <div class="tab-pane" id="tab3">
            <pre class="prettyprint">
package part2;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Point;
import java.awt.image.BufferedImage;
import java.util.Random;
import javax.swing.JPanel;
import java.awt.event.*;

public class DrawPuzzlePanel extends JPanel {

    public BufferedImage originalImage;	// gets the image user selects from file
    public BufferedImage grid[][];	// holds the image split into puzzle pieces
    
    public Point outlineGrid[][];	// array for points of the grid to place the pieces
    public Point puzzlePoints[][];	// array for points of current locatioins of puzzle pieces
    
    public int gridRows=0, gridCols=0;	// keeps track of the number of rows and cols the picture has when broken up
    public int move_x, move_y; 		// the x and y of the current image being moved
    public int move_col, move_row;	// the row and col of the current image being moved
    
    boolean solved=false;		// used to check if the puzzle has been solved
    boolean snapping=false;		// used to check if the current image is being snapped 
    boolean firstDraw=true;		// used to check if the split image has been drawn yet
    boolean pieceMoving=false;		// checks if a piece is being dragged

    private MouseHandler handler;
    private MouseMotionHandler motionHandler;
    
    public Color bgColor = Color.ORANGE;

    private static final long serialVersionUID = 1L;

    // constructor registers mouse event handler
    public DrawPuzzlePanel(Jigsaw jigsaw) {
            handler = new MouseHandler();
            motionHandler = new MouseMotionHandler();
            addMouseListener(handler);
            addMouseMotionListener(motionHandler);
    }
    
    // display image
    public void paintComponent( Graphics g ) {
            super.paintComponent( g );
            Graphics2D g2d = (Graphics2D) g;
            int x=10, y=10;		// x and y coordinates for drawing the image
            
            // if the user has selected split draw the tiles
               if (grid[0][0] != null ) {
                       drawGrid(g2d);
                       drawSplitImages(g2d);
               }		
            // otherwise draw the original image
         else if (originalImage != null && !pieceMoving)
             g.drawImage(originalImage, x, y, this);
    }
   
   // method that will split the image into equal parts
   public void splitImage(Graphics g) {

 	  int x=0, y=0;		// the x y coordinates of the tile to create
 	  int w=100, h=100;		// the width and height of the tile to create
 	  Graphics2D g2d;
 	  
 	  // create the puzzle pieces
 	  for (int i = 0; y < originalImage.getHeight(); y += 100, i++){
 		  for (int j = 0; x < originalImage.getWidth(); x += 100, j++) {
                      grid[i][j] = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
                      g2d = grid[i][j].createGraphics();
                      g2d.drawImage(originalImage.getSubimage(x, y, w, h), 0, 0, null);
                      gridCols = j;
 		  }
 		  x = 0; // reset y to top of window
 		  gridRows = i;
 	  }
 	  repaint();
   }
   
   // puts all the pieces in the correct places
   public void solve(Graphics2D g2d) {
	   g2d.setBackground(bgColor);
	   g2d.clearRect(0, 0, getWidth(), getHeight());
	   drawGrid(g2d);	
	   for (int i = 0; i <= gridRows; i++){
		   for (int j = 0; j <= gridCols; j++) {
			   g2d.drawImage(grid[i][j], outlineGrid[i][j].x+5, outlineGrid[i][j].y+5, null);
		   }
	   }
   	}

   // method to handle drawing the outline grid
    public void drawGrid(Graphics g2d){
        int x=10, y=10;
        if (grid[0][0] != null ) {
            if (firstDraw) {
                // set up the array of grid points
                for(int i = 0; i <= gridRows; y += 110, i++) {
                    for(int j = 0; j <= gridCols; x += 110, j++ ) {		
                        outlineGrid[i][j] = new Point(x-5, y-5);
                        // need an extra point for the right side of the grid
                        if (i == gridRows)
                            outlineGrid[gridRows+1][j] = new Point(x-5, y+105);
                    }// end inner for loop	

                    // need an extra point for the bottom of the grid
                    if (i == gridRows)
                        outlineGrid[gridRows+1][gridCols+1] = new Point(x-5, y+105);
                    
                    outlineGrid[i][gridCols+1] = new Point(x-5, y-5);
                    x = 10;	// reset y to top of window
                }// end outer for loop
            }
            // draw the grid lines
            for (int i = 0; i <= gridRows+1; i++)
                g2d.drawLine(outlineGrid[i][0].x, outlineGrid[i][0].y, 
                    outlineGrid[i][gridCols+1].x, outlineGrid[i][gridCols+1].y);
                    
            for (int i = 0; i <= gridCols+1; i++)
                g2d.drawLine(outlineGrid[0][i].x, outlineGrid[0][i].y, 
                    outlineGrid[gridRows+1][i].x, outlineGrid[gridRows+1][i].y);
        }
    }

    // method to handle drawing the piece being moved
    public void drawSplitImages(Graphics2D g2d) {
       int x=0 , y=0;
       int pointsDrawn = 0;
       
       // case used when the image is initially being split up and randomized
       if(firstDraw) {
               firstDrawSplitImages(g2d);
       }
       else {
               //draw all the image pieces except the one being moved
               for(int i = 0; i <= gridRows; i++) {
                            for(int j = 0; j <= gridCols; j++ ) {
                                    if (i != move_row || j != move_col)
                                            g2d.drawImage( grid[i][j], puzzlePoints[i][j].x ,
                                                            puzzlePoints[i][j].y, this );
                            }// end inner for
               }// end outer for
               
               // draw image while piece is moving
               if ( pieceMoving && move_row <= gridRows && move_col <= gridCols)
                               g2d.drawImage(grid[move_row][move_col], move_x, move_y, this);
               
               snapIntoPlace(g2d);
       }
       
    }

    // method to handle snapping pieces into place when done moving
    private void snapIntoPlace(Graphics2D g2d) {
       for (int i = 0; i <= gridRows; i++) {
           for (int j = 0; j <= gridCols; j++) {
                if ( (move_x > outlineGrid[i][j].x && move_x < outlineGrid[i][j].x+20) 
                                && (move_y > outlineGrid[i][j].y && move_y < outlineGrid[i][j].y+20)) {
                        snapping = true;
                        g2d.setBackground(bgColor);
                        g2d.clearRect(move_x,move_y, 100, 100);
                        drawGrid(g2d);
                        g2d.drawImage(grid[move_row][move_col], outlineGrid[i][j].x+5,
                                        outlineGrid[i][j].y+5, this);
                        puzzlePoints[move_row][move_col].setLocation(outlineGrid[i][j].x+5,
                                        outlineGrid[i][j].y+5);
                        }
                }
       }
    }

    private void firstDrawSplitImages(Graphics2D g2d) {
            int x = outlineGrid[0][0].x+5, y=outlineGrid[0][0].y+5, 
                            pointsDrawn=0;
            int randomRow, randomCol;		// the random row and cols to draw
            
            // array to store the rows and cols which have been used already
            int usedPoints[][] = new int[gridRows+1][gridCols+1];
            Random r = new Random();		// create a random generator
            boolean done = false;		// checks if all the images have been drawn
            
       // fill the usedPoints array with zeros to indicate that row 
       // and column has not been used
       for (int i = 0; i <= gridRows; i++)
               for (int j = 0; j <= gridCols; j++)
                       usedPoints[i][j] = 0;
       
       // while there are still images that haven't been drawn keep looking for 
       // a row and column that can be used
       while(!done){
               
              randomRow = r.nextInt(gridRows+1);
              randomCol = r.nextInt(gridCols+1);
               
              // if the image at the random row and col has not been used draw it
       if (usedPoints[randomRow][randomCol] == 0) {
               g2d.drawImage( grid[randomRow][randomCol], x , y, this );
               puzzlePoints[randomRow][randomCol] = new Point(x, y);
               usedPoints[randomRow][randomCol] = 1;
               pointsDrawn++;
               
               // move to the next image draw location 
               x += 110;
               
               // reset x to the left and move y to the next row
               if ( x > 500) {
                       x = 10;
                       y += 110;
               }
            }
                       // check if all the images have been used
                       if (pointsDrawn == ( (gridRows+1)*(gridCols+1)) )
                               done = true;
              }
               firstDraw=false;
    }

    //class to handle dragging the images
    public class MouseMotionHandler extends MouseMotionAdapter {
            public void mouseDragged(MouseEvent e) {
                    super.mouseDragged(e);
                    pieceMoving = true;
                    move_x = e.getX();
                    move_y = e.getY();
                    repaint();
            }
    }

    //class to handle acquiring and placing the image 
    public class MouseHandler extends MouseAdapter {
        public void mousePressed(MouseEvent e) {
            super.mousePressed(e);
            move_x = e.getX();
            move_y = e.getY();
            
            // look for the position of the mouse and check which image it is on
            for (int i = 0; i <= gridRows; i++)
                for (int j = 0; j <= gridCols; j++){
                    if(e.getX() > puzzlePoints[i][j].x && e.getX() < puzzlePoints[i][j].x+100
                                    &&e.getY() > puzzlePoints[i][j].y && e.getY() < puzzlePoints[i][j].y+100) {
                            move_row = i;
                            move_col = j;
                    }
                }
        }
    
        public void mouseReleased(MouseEvent e) {
                super.mouseReleased(e);
                
                int correctPlaces = 0;
                
                if (!snapping)
                        puzzlePoints[move_row][move_col] = e.getPoint();
                
                snapping = false;
                pieceMoving = false;
                
                // set the movable row and col out of bounds so pic will not move on random click
                move_row = gridRows+10;
                move_col = gridCols+10;
                
            for (int i = 0; i <= gridRows; i++)
                for (int j= 0; j <= gridCols; j++)
                    if (puzzlePoints[i][j].x-5 == outlineGrid[i][j].x && 
                        puzzlePoints[i][j].y-5 == outlineGrid[i][j].y)
                            correctPlaces++;
        }
    }

}// end DrawPuzzelPanel
            </pre>
            </div>
            </div>
           </div>
         </div>
        </div>
<jsp:include page="/includes/footer.html"/>
