<jsp:include page="/includes/header.html"/>
        <div class="container">
            <div class="row">
                <div class="span3">
                    <p><applet code="part1.ClockMain" width="202" height="202"></applet></p>
                </div>           
               <div class="span9">
                <h1>Java Applet: Analog Clock</h1>
                <p>This is a simple applet I wrote to demonstrate deploying applets directly to a web page. The applet
                uses the system time on the current machine and redraws the clock hands every second. The applet can also
                be run directly from the clients machine using a JNLP file which will download the code from the server
                and run it on the local JVM the client is using.</p>
                <p><a class="btn btn-large btn-primary" href = "jnlp/Clock.jnlp"> Click here to download the applet</a></p>       
                </div>
             </div>
             <div class="row">
               <div class="span9 offset2">
                <h2>See the code</h2>
                <div class="tabbable">
                <ul class="nav nav-tabs">
                 <li class="active"><a href="#tab1" data-toggle="tab">Clock.java</a></li>
                 <li><a href="#tab2" data-toggle="tab">ClockMain.java</a></li>
                </ul>
                <div class="tab-content">
                 <div class="tab-pane active" id="tab1">
                  <pre class="prettyprint">
package part1;

import java.util.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.awt.image.*;
import javax.swing.Timer;
import java.awt.geom.Line2D;

public class Clock extends JComponent {

        private static final long serialVersionUID = 1L;

        private static final int UPDATE_INTERVAL = 500;  // .5 seconds
    
    private Calendar now = Calendar.getInstance();  // Current time.
    
    // Height and width of clock face
    private int diameter;                 
    
    // x coord of middle of clock
    private int centerX;             
    
    // y coord of middle of clock
    private int centerY;                  
    
    // Saved image of the clock face.
    private BufferedImage clockImage;     
    
    private Timer timer;      // Fires to update clock.
    Graphics2D g2a;
    
    //constructor
    public Clock() {
        timer = new Timer(UPDATE_INTERVAL, new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                updateTime();
                repaint();
            }
        });
    }
    
    // Start the timer
    public void start() {
        timer.start(); 
    }
    
    // Stop the timer
    public void stop() {
        timer.stop(); 
    }
    
    private void updateTime() {
        now.setTimeInMillis(System.currentTimeMillis());
    }
    
    public void paintComponent(Graphics g) {
        
        Graphics2D g2 = (Graphics2D)g;
        
        double seconds = now.get(Calendar.SECOND);
        double minutes = now.get(Calendar.MINUTE);
        double hours   = now.get(Calendar.HOUR);
        
        int w = getWidth();
        int h = getHeight();
        diameter = ((w < h) ? w : h);
        centerX = diameter / 2;
        centerY = diameter / 2;
        
        // Create the clock face background image if this is the first time,
        if (clockImage == null || clockImage.getWidth() != w || clockImage.getHeight() != h) {
            clockImage = (BufferedImage)(this.createImage(w, h));
            
            g2a = clockImage.createGraphics();
            drawClockFace(g2a);
        }
        
        // Draw the clock face 
        g2.drawImage(clockImage, null, 0, 0);
        
        //adjust the starting point to be at 12 o'clock
        g2.rotate( ((Math.PI) / 2), centerX, centerY);		
        
        //convert the hour value to an angle in degrees
        double degreeHours = 0.5 * (60 * hours + minutes);		
        //convert degrees to radians
        double radianHours = degreeHours * (Math.PI / 180);		
        
        double degreeMinutes = ( (minutes + (seconds/100)) * 6);
        double radianMinutes =  degreeMinutes * (Math.PI/180);
        
        double degreeSeconds = (seconds * 6);
        double radianSeconds = degreeSeconds * (Math.PI/180);
        
        // Draw the clock hands dynamically each time.
        drawHourHand(g2, radianHours);
        drawMinuteHand(g2, radianMinutes);
        drawSecondHand(g2, radianSeconds);
        
    }
    
    private void drawSecondHand(Graphics2D g2, double theta) {
        Line2D secondHand = new Line2D.Double();
        secondHand.setLine(centerX, centerY, 0, getHeight()/2);

        g2.rotate(theta, centerX, centerY);
        g2.draw(secondHand);
        g2.rotate(-theta, centerX, centerY);
    }
    
    private void drawHourHand(Graphics2D g2, double theta) {
        Line2D hourHand = new Line2D.Double();
        hourHand.setLine(centerX, centerY, getWidth()/4, getHeight()/2);

        g2.rotate(theta, centerX, centerY);
        g2.draw(hourHand);
        g2.rotate(-theta, centerX, centerY);
    }
    
    private void drawMinuteHand(Graphics2D g2, double theta) {
        Line2D minuteHand = new Line2D.Double();
        minuteHand.setLine(centerX, centerY, getWidth()/6, getHeight()/2);

        g2.rotate(theta, centerX, centerY);
        g2.draw(minuteHand);
        g2.rotate(-theta, centerX, centerY);
    }
    
    private void drawClockFace(Graphics2D g2) {
        g2.setColor(Color.YELLOW);
        g2.fillOval(0, 0, diameter, diameter);
        g2.setColor(Color.BLACK);
        g2.drawOval(0, 0, diameter, diameter);
        
        Line2D shortTick = new Line2D.Double(getWidth()/2, getHeight(), getWidth()/2, getHeight() - 10);
        Line2D middleTick = new Line2D.Double(getWidth()/2, getHeight(), getWidth()/2, getHeight() - 15);
        Line2D longTick = new Line2D.Double(getWidth()/2, getHeight(), getWidth()/2, getHeight() - 20);
        
        g2.setColor(Color.BLACK);
        
        for (int i = 0; i < 4; i++) {
                g2.draw(longTick);
                g2.rotate((2*Math.PI)/4, centerX, centerY);
        }
        for (int i = 0; i < 12; i++) {
                g2.draw(middleTick);
                g2.rotate(Math.PI/6, centerX, centerY);
        }
        for (int i = 0; i < 60; i++) {
                g2.draw(shortTick);
                g2.rotate((2*Math.PI)/60, centerX, centerY);
        }
        
    }
}
                  </pre>
                  </div>
                  <div class="tab-pane" id="tab2">
                  <pre class="prettyprint">
package part1;

import java.awt.BorderLayout;

import javax.swing.JApplet;

public class ClockMain extends JApplet {
    
	private static final long serialVersionUID = 1L;
	private Clock clock;                        
    
    public void init() {

    	//new clock component.
        clock = new Clock();
        
        //... Set the applet's layout and add the clock to it.
        setLayout(new BorderLayout());
        add(clock, BorderLayout.CENTER);
        
        //Start the clock
        start();
    }
    
    public void start() {
        clock.start();
    }
    
    public void stop() {
        clock.stop();
    }
}
                  </pre>
                  </div>
                </div>
                </div>
               </div>
            </div>
        </div>
<jsp:include page="/includes/footer.html"/>