<jsp:include page="/includes/header.html"/>
    <div class="container">
      <div class="hero-unit">
      <h2>JUnit Testing</h2>
      <p>This is an assignment I was given on JUnit Testing. All the classes were provided to me
      except the CustomerTest.java class which is the class I wrote that contains the testing units. The example is based
      on a video store which rents movies to customers.</p></div>
      
      <div class="row">
        <div class="span9">
          <h4> Price class is an abstract class which is used by the following 3 classes</h4>
        </div>
        <div class="span3">
            <h4><a href="resources/JUnitTestCode/Price.txt" target="_blank">Price.java</a></h4>
        </div>
      </div>
      <div class="row">
        <div class="span9">
          <h4>The next 3 classes are used to define the price rates applied to different types of rentals</h4>
        </div>
        <div class="span3">
            <h4><a href="resources/JUnitTestCode/RegularPrice.txt" target="_blank">RegularPrice.java</a><br>
            <a href="resources/JUnitTestCode/ChildrensPrice.txt" target="_blank">ChildrensPrice.java</a><br> 
            <a href="resources/JUnitTestCode/NewReleasePrice.txt" target="_blank">NewReleasePrice.java</a></h4>
        </div>
      </div>
      <div class="row">
        <div class="span9">
            <h4>The rental class defines methods to handle renting to a customer such as how much to charge and how many days the
            movie can be taken.</h4>
        </div>
        <div class="span3">
            <h4><a href="resources/JUnitTestCode/Rental.txt" target="_blank">Rental.java</a></h4>
        </div>
      </div>
      <div class="row">
        <div class="span9"><h4>
            The Movie class stores the properties of a movie, like the title, type of rental, and how much to charge.
        </h4></div>
        <div class="span3">
            <h4><a href="resources/JUnitTestCode/Movie.txt" target="_blank">Movie.java</a></h4>
        </div>
      </div>
      <div class="row">
        <div class="span9"><h4>
            The Customer class stores information about the rentals a customer has as well as adding new rentals
            in order to calculate their bill when they check out a movie.</h4>
        </div>
        <div class="span3">
            <h4><a href="resources/JUnitTestCode/Customer.txt" target="_blank">Customer.java</a></h4>
        </div>
      </div>
      <div class="row">
        <div class="span9"><h4>
            The CustomerTest class contains all the testing units written to test the given classes.</h4>
        </div>
        <div class="span3">
            <h4><a href="resources/JUnitTestCode/CustomerTest.txt" target="_blank">CustomerTest.java</a></h4>
        </div>
      </div>
    </div>
<jsp:include page="/includes/footer.html"/>