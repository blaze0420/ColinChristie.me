<%@ page contentType="text/html;charset=UTF-8"%>
<jsp:include page="/includes/header.html"/>
    <div class="container">
     <div class="hero-unit">
        <h2>Java Application: Typing Tutor</h2>
         <h4>This is a Java Application I wrote to demonstrate creating a GUI with using AWT event handlers, 
            as well as deploying an application to a client. To demonstrate these features, the application
            is a virtual keyboard which has its keys mapped to the users keyboard. The program can test
            the user on typing skills based on the accuracy of a test string the user will type. </h4>
            <p align="center"><a class="btn btn-primary" href="jnlp/TypingTutor.jnlp">Click here to download the application</a></p>
     </div>
     <div class="row">
      <div class="span12">
       <div class="tabbable"> 
        <ul class="nav nav-tabs">
            <li class="active"><a href="#tab1" data-toggle="tab">Description</a></li>
            <li class="pull-right"><a href="#tab3" data-toggle="tab">KeyTutorMain.java</a></li>
            <li class="pull-right"><a href="#tab2" data-toggle="tab">KeyTutor.java</a></li>
            <li class="pull-right"><h4>See the Code</h4></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="tab1">
            <div class="row">
                <div class="span4"><h4>
                    The application will test the users ability to type randomly selected phrases
                    each selected to use a wide variety of different letters to make them
                    challenging.
                </h4></div>
                <div class="span8 pull-right">
                    <img src="resources/Images/Keyboard01.jpg" height="655" width="857"
                         alt="Sample Image" />
                </div>
            </div>
            <div class="row" style="padding:20px 0px 0px 0px">
                <div class="span8">
                    <img src="resources/Images/Keyboard02.jpg" height="661" width="858"
                         alt="Sample Image 1" />
                </div>
                <div class="span4"><h4>
                    When the user presses a key on their keyboard event handlers will 
                    cause the keys on the screen to be higlighted in yellow.
                </h4></div>
            </div>
            <div class="row" style="padding:20px 0px 0px 0px" >
                <div class="span4"><h4>
                    When the test button is selected a window will appear with a sentence 
                    that the user will have to type.
                </h4></div>
                <div class="span8 pull-right">
                    <img src="resources/Images/Keyboard03.jpg" height="198" width="599"
                         alt="Sample Image" />
                </div>
            </div>
            <div class="row" style="padding:20px 0px 0px 0px">
                <div class="span8">
                    <img src="resources/Images/Keyboard04.jpg" height="661" width="859"
                         alt="Sample Image" />
                </div>
                <div class="span4"><h4>
                    The user can make their attempt, but if a mistake is made it cannot be
                    undone as the backspace key has been disabled. This was done intentionally
                    to make the test more challenging.
                </h4></div>
            </div>
            <div class="row" style="padding:20px 0px 0px 0px">
                <div class="span4"><h4>
                    When finished typing the test sentence the user can hit finish and get
                    a report on how well they did. The test button can now be pressed again 
                    and another randomly selected sentence will appear to begin a new test.
                </h4></div>                
                <div class="span8 pull-right">
                <img src="resources/Images/Keyboard05.jpg" height="659" width="860"
                         alt="Sample Image" />
                </div>
            </div>
            </div>
            <div class="tab-pane" id="tab2">
            <pre class="prettyprint">
package keyboardTutor;

import java.awt.Color;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.util.Random;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextArea;
import javax.swing.JPanel;
import javax.swing.WindowConstants;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class KeyTutor extends JPanel {

	private int X = 10;			//X value used to position buttons
    private int Y = 270;		//Y value used to position buttons
    private int index = 0;		//keeps track of the current button to create in the qwertyButtons array
   
    private String userInput = "";		//the string that the user types 
    private String testString;			//the string randomly selected that the user must type
    private String phrases[];			//holds the random strings the user will be asked to type
    
    private JButton qwertyButtons[];	    //array to hold all the buttons that will be displayed
    private JButton keyCodes[];				//references to the qwerty buttons where the array index is its virtual key code
    private JTextArea outputArea;			//text area to display output
    private JLabel infoLabel1; 				//displays the info at the top of the window 
    private JLabel infoLabel2; 				//displays the info at the top of the window 
    private JDialog dialog;				//the non-modal dialog which will display the test string
    
    //the remaining misc buttons needed for the keyboard
    private JButton tab, caps, shift, backspace, enter, space, upArrow, downArrow, leftArrow, rightArrow, test, finish;
    
    //qwerty arrays used to add keyboard symbols that will be added to the frame
    private String qwerty1[] = {"~","1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "="};
    private String qwerty2[] = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "[", "]", "\\"};
    private String qwerty3[] = {"A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "\""};
    private String qwerty4[] = {"Z", "X", "C", "V", "B", "N", "M", ",", ".", "?"};
    
    //event handlers
    keyHandler handler;
    testButtonHandler testButton;
    FinishButtonHandler finishButton;
    
    //constructor
	public KeyTutor() {
		
        //the random sentences the user will be asked to type
        phrases = new String[5];
        phrases[0] = "The quick brown fox jumps over a lazy dog";
        phrases[1] = "The five boxing wizards jump quickly";
        phrases[2] = "We promptly judged antique ivory buckles for the next prize";
        phrases[3] = "A mad boxer shot a quick, gloved jab to the jaw of his dizzy opponent";
        phrases[4] = "How razorback-jumping frogs can level six piqued gymnasts";

        //the text at the top of the window telling the user how to proceed
        infoLabel1 = new JLabel("Type some text using your keyboard. The keys you press will be highlighted" +
        		" and the text will be displayed.");
        infoLabel2 = new JLabel("Note: Clicking the buttons with your mouse will not" +
        		" perform any action.");
        
        //text area to display what the user typed
        outputArea = new JTextArea(5, 50);
        //outputArea.setBounds(10, 10, 300, 100);
        outputArea.setFocusable(false);
        
        //create the array to store references to the qwerty buttons using virtual key code as array index
        keyCodes = new JButton[522];
        
        //create misc buttons around the keyboard
        tab = new JButton("Tab");
        caps = new JButton("Caps");
        shift = new JButton("Shift");
        backspace = new JButton("Backspace");
        enter = new JButton("Enter");
        space = new JButton(" ");
        upArrow = new JButton("^");
        downArrow = new JButton("v");
        leftArrow = new JButton("<");
        rightArrow = new JButton(">");
        test = new JButton("Test");
        finish = new JButton("Finish");

        //assign the misc keys to the keyCode position
        keyCodes[KeyEvent.VK_TAB] = tab;				
        keyCodes[KeyEvent.VK_CAPS_LOCK] = caps;
        keyCodes[KeyEvent.VK_SHIFT] = shift;
        keyCodes[KeyEvent.VK_BACK_SPACE] = backspace;
        keyCodes[KeyEvent.VK_ENTER] = enter;
        keyCodes[KeyEvent.VK_SPACE] = space;

        //create the key event handler
        handler = new keyHandler();
        //register the event handlers
        keyCodes[KeyEvent.VK_TAB].addKeyListener(handler);				
        keyCodes[KeyEvent.VK_CAPS_LOCK].addKeyListener(handler);
        keyCodes[KeyEvent.VK_SHIFT].addKeyListener(handler);
        keyCodes[KeyEvent.VK_BACK_SPACE].addKeyListener(handler);
        keyCodes[KeyEvent.VK_ENTER].addKeyListener(handler);
        keyCodes[KeyEvent.VK_SPACE].addKeyListener(handler);        
        
        //set the size and position of the buttons
        infoLabel1.setBounds(5, 5, 1000, 20);
        infoLabel2.setBounds(5, 20, 600, 20);
        outputArea.setBounds(10, 50, 825, 200);
        tab.setBounds(X, Y+50, 69, 48);
        caps.setBounds(X, Y+100, 69, 48);
        shift.setBounds(X, Y+150, 87, 48);
        backspace.setBounds(X+650, Y, 125, 48);
        enter.setBounds(X+620, Y+100, 98, 48);
        space.setBounds(X+150, Y+200, 400, 48);
        upArrow.setBounds(X+650, Y+150, 48, 48);
        downArrow.setBounds(X+650, Y+200, 48, 48);
        leftArrow.setBounds(X+600, Y+200, 48, 48);
        rightArrow.setBounds(X+700, Y+200, 48, 48);
        test.setBounds(X, Y+300, 75, 48);
        finish.setBounds(X+76, Y+300, 80, 48);

        //create and register event handlers for 'Test' and 'Finish' buttons
        testButton = new testButtonHandler();
        test.addActionListener(testButton);
        
        finishButton = new FinishButtonHandler();
        finish.addActionListener(finishButton);
        
        //add the buttons to the frame
        add(infoLabel1);
        add(infoLabel2);
        add(outputArea);
        add(tab);
        add(caps);
        add(shift);
        add(backspace);
        add(enter);
        add(space);
        add(upArrow);
        add(downArrow);
        add(leftArrow);
        add(rightArrow);
        add(test);
        add(finish);
        
        //create an array of JButtons to hold row of keyboard
        qwertyButtons = new JButton[qwerty1.length + qwerty2.length + qwerty3.length + qwerty4.length];
        
        //add the first row of buttons and register the event handlers
        for (index = 0; index < qwerty1.length; ++index, X += 50) {
        	qwertyButtons[index] = new JButton( qwerty1[index] );
        	qwertyButtons[index].addKeyListener(handler);
        	qwertyButtons[index].setBounds(X, Y, 48, 48);
        	add(qwertyButtons[index]);
        }
        
        keyCodes[KeyEvent.VK_1] = qwertyButtons[1];				// '1'
        keyCodes[KeyEvent.VK_2] = qwertyButtons[2];				// '2'
        keyCodes[KeyEvent.VK_3] = qwertyButtons[3];				// '3'
        keyCodes[KeyEvent.VK_4] = qwertyButtons[4];				// '4'
        keyCodes[KeyEvent.VK_5] = qwertyButtons[5];				// '5'
        keyCodes[KeyEvent.VK_6] = qwertyButtons[6];				// '6'
        keyCodes[KeyEvent.VK_7] = qwertyButtons[7];				// '7'
        keyCodes[KeyEvent.VK_8] = qwertyButtons[8];				// '8'
        keyCodes[KeyEvent.VK_9] = qwertyButtons[9];				// '9'
        keyCodes[KeyEvent.VK_0] = qwertyButtons[10];			// '0'
        keyCodes[KeyEvent.VK_DEAD_TILDE] = qwertyButtons[0];	// '~'
        keyCodes[KeyEvent.VK_MINUS] = qwertyButtons[11];		// '-'
        keyCodes[KeyEvent.VK_PLUS] = qwertyButtons[12];			// '+'
        
        //move to next row
        X = 80;
        Y += 50;

        //add the second row of buttons and register the event handlers
        for (int i = 0; i < qwerty2.length; ++index, ++i, X += 50) {
        	qwertyButtons[index] = new JButton( qwerty2[i] );
        	qwertyButtons[index].addKeyListener(handler);
        	qwertyButtons[index].setBounds(X, Y, 48, 48);
        	add(qwertyButtons[index]);
        }
        
        keyCodes[KeyEvent.VK_Q] = qwertyButtons[13];				// 'Q'
        keyCodes[KeyEvent.VK_W] = qwertyButtons[14];				// 'W'
        keyCodes[KeyEvent.VK_E] = qwertyButtons[15];				// 'E'
        keyCodes[KeyEvent.VK_R] = qwertyButtons[16];				// 'R'
        keyCodes[KeyEvent.VK_T] = qwertyButtons[17];				// 'T'
        keyCodes[KeyEvent.VK_Y] = qwertyButtons[18];				// 'Y'
        keyCodes[KeyEvent.VK_U] = qwertyButtons[19];				// 'U'
        keyCodes[KeyEvent.VK_I] = qwertyButtons[20];				// 'I'
        keyCodes[KeyEvent.VK_O] = qwertyButtons[21];				// 'O'
        keyCodes[KeyEvent.VK_P] = qwertyButtons[22];				// 'P'
        keyCodes[KeyEvent.VK_BRACELEFT] = qwertyButtons[23];		// '['
        keyCodes[KeyEvent.VK_BRACERIGHT] = qwertyButtons[24];		// ']'
        keyCodes[KeyEvent.VK_BACK_SLASH] = qwertyButtons[25];		// '\'

        //move to next row
        X = 80;
        Y += 50;
        
        //add the third row of buttons and register the event handlers
        for (int i = 0; i < qwerty3.length; ++index, ++i, X += 50) {
        	qwertyButtons[index] = new JButton( qwerty3[i] ) ;
        	qwertyButtons[index].addKeyListener(handler);
        	qwertyButtons[index].setBounds(X, Y, 48, 48);
        	add(qwertyButtons[index]);
        }
        
        keyCodes[KeyEvent.VK_A] = qwertyButtons[26];				// 'A'
        keyCodes[KeyEvent.VK_S] = qwertyButtons[27];				// 'S'
        keyCodes[KeyEvent.VK_D] = qwertyButtons[28];				// 'D'
        keyCodes[KeyEvent.VK_F] = qwertyButtons[29];				// 'F'
        keyCodes[KeyEvent.VK_G] = qwertyButtons[30];				// 'G'
        keyCodes[KeyEvent.VK_H] = qwertyButtons[31];				// 'H'
        keyCodes[KeyEvent.VK_J] = qwertyButtons[32];				// 'J'
        keyCodes[KeyEvent.VK_K] = qwertyButtons[33];				// 'K'
        keyCodes[KeyEvent.VK_L] = qwertyButtons[34];				// 'L'
        keyCodes[KeyEvent.VK_SEMICOLON] = qwertyButtons[35];		// ';'
        keyCodes[KeyEvent.VK_QUOTEDBL] = qwertyButtons[36];			// '"'

        //move to next row
        X = 100;
        Y += 50;
        
        //add the fourth row of buttons and register the event handlers
        for (int i = 0; i < qwerty4.length; ++index, ++i, X += 50) {
        	qwertyButtons[index] = new JButton( (qwerty4[i]) );
        	qwertyButtons[index].addKeyListener(handler);
        	qwertyButtons[index].setBounds(X, Y, 48, 48);
        	add(qwertyButtons[index]);
        }
        
        keyCodes[KeyEvent.VK_Z] = qwertyButtons[37];				// 'Z'
        keyCodes[KeyEvent.VK_X] = qwertyButtons[38];				// 'X'
        keyCodes[KeyEvent.VK_C] = qwertyButtons[39];				// 'C'
        keyCodes[KeyEvent.VK_V] = qwertyButtons[40];				// 'V'
        keyCodes[KeyEvent.VK_B] = qwertyButtons[41];				// 'B'
        keyCodes[KeyEvent.VK_N] = qwertyButtons[42];				// 'N'
        keyCodes[KeyEvent.VK_M] = qwertyButtons[43];				// 'M'
        keyCodes[KeyEvent.VK_COMMA] = qwertyButtons[44];			// ','
        keyCodes[KeyEvent.VK_PERIOD] = qwertyButtons[45];			// '.'

	}

	public class keyHandler extends KeyAdapter{

		//stores the original background color of the key being pressed
		Color originalColor;	
		
		//when a key is pressed add the char to the user input string and highlight the key yellow
		public void keyPressed(KeyEvent e){
			
			int codeIndex = e.getKeyCode();
			String s = keyCodes[codeIndex].getActionCommand();
			
			//Only want single chars
			if(s.length() == 1) {
				//if shift modifier is being held down leave upper case
				if(e.isShiftDown())
					userInput += keyCodes[codeIndex].getActionCommand();
				//otherwise convert to lower case
				else
					userInput += Character.toLowerCase(s.charAt(0));
			}
			//add new line char when user presses return
			else if (s.compareTo("Enter") == 0)
				userInput += "\n";
			
			//highlight the key yellow
			originalColor = keyCodes[codeIndex].getBackground();
			keyCodes[codeIndex].setBackground(Color.YELLOW);
		}
		
		//when a key is released restore the original background color 
		//and show the updated input string in the text area 
		public void keyReleased(KeyEvent e){
			keyCodes[e.getKeyCode()].setBackground(originalColor);
			outputArea.setText(userInput);
		}
	}
	
	public class testButtonHandler implements ActionListener{

		public void actionPerformed(ActionEvent e) {
			
			//clear the output area
			outputArea.setText("");
			
			//reset the user input string
			userInput = "";
			
			//create a random number generator object and use system time as seed
			Random randomPhrase = new Random(System.currentTimeMillis());
			
			//get a random phrase
			testString = phrases[randomPhrase.nextInt(5)];
			
			//create a JLabel to display the test string in the non modal dialog box
			JLabel testStringLabel = new JLabel(testString);
			testStringLabel.setBounds(50, -10, 500, 190);
			
			//create the non-modal dialog box to display the test string to the user
			dialog = new JDialog();
			dialog.setTitle("Type this text");
			dialog.setLayout(null);
			dialog.setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
			dialog.setLocationByPlatform(false);
			dialog.add(testStringLabel);
			dialog.setSize(600, 200);
			dialog.setVisible(true);
			
			//set the focus back on the keyboard
			space.requestFocus();
		}
		
	}
	
	public class FinishButtonHandler implements ActionListener{
		
		//output a msg dialog with the results of the test
		public void actionPerformed(ActionEvent e){

			dialog.dispose();	//clear the test string dialog
			int correct = myCompareTo(testString);	//the number of correct chars the user entered
			int errors = (testString.length() - correct);	//the number of incorrect chars the user entered
			double accuracy = (double)correct / (double)testString.length();	//the ratio of correct chars to total chars 
			
			//display a modal dialog box informing the user of the results of the test 
			JOptionPane.showMessageDialog(null, "The numer of correctly input characters is: " + correct + "\n" +
					"The number of wongly input characters is: " + errors + "\n" +
					String.format("The accuracy rate is: %.2f", accuracy),
					"Typing Test Results",
					JOptionPane.PLAIN_MESSAGE);
		}
		
		//myCompareTo goes through the string typed by the user and the test string
		//comparing each character to see if they are equal. It is case sensitive.
		public int myCompareTo(String s){
			
			int result = 0;
			
			for (int i = 0; i < s.length() && i < userInput.length(); ++i){
				if (userInput.charAt(i) == s.charAt(i))
					++result;
			}
			return result;
		}
	}
}            
            </pre>
            </div>
            <div class="tab-pane" id="tab3">
                <pre class="prettyprint">
package keyboardTutor;

import javax.swing.JFrame;

public class KeyTutorMain extends JFrame{
	
	//constants for the size of the window
    public static final int WIDTH = 860;
    public static final int HEIGHT = 660;
    
	public static void main(String args[]) {
		
		JFrame frame = new JFrame("Typing Tutor");
		KeyTutor tutor = new KeyTutor();

		tutor.setLayout(null);
		tutor.setSize(WIDTH, HEIGHT);

		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setSize(WIDTH, HEIGHT);
		frame.add(tutor);
        frame.setVisible(true); // display frame
        frame.setLocationRelativeTo(null);
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