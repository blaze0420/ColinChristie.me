<%@ include file="/includes/header.html"%>
        <div class="container">
         <div class="row">
          <div class="span9 offset1">
           <div class="tabbable"> 
            <ul class="nav nav-tabs">
                <li class="active"><a href="#tab1" data-toggle="tab">Basic Concepts</a></li>
                <li><a href="#tab2" data-toggle="tab">Sorting</a></li>
                <li><a href="#tab3" data-toggle="tab">Advanced Concepts</a></li>
                <li><a href="#tab4" data-toggle="tab">Advanced Concepts 2</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane active" id="tab1">
                    <p>This script demonstrates basic C++ concepts. It uses basic input/output, typedefs, iterators
                    and vectors. It reads 
                    input from a text file and stores each string in a vector cell. Each string is then sent to standard 
                    output in a comma separted list. The purpose of this script is to demonstrate the use of containers
                    by inserting strings into a vector, traverse through it, and display its contents with formatting.</p>
                    <h2 align="center">Sample output</h2>
                    <p align="center"><img src="resources/Images/BasicConceptsOutput.jpg" height="116" width="955" 
                                           alt="Basic Concepts Output Image"/></p>
                    <pre class="prettyprint">
#include &lt;iostream&gt;
#include &lt;vector&gt;
#include &lt;string&gt;

using namespace std;
typedef vector&lt;string&gt; V;
typedef V::iterator VIter;

int main(int argc, char* argv[])
{
        V v;            //container to hold the strings
        string word;    //string to store the individual words entered

        //store the strings in the container v
        while (cin >> word)
                v.push_back(word);

        //create iterators to move through the list
        VIter vBeg = v.begin();
        VIter vEnd = v.end();

        VIter vStop = vEnd;     //need an iterator to stop before the last

        vStop-=2;       //move back 2 positions to stop at 2nd last word

        //if 3 or more words are input put them all in quotes and separate the last word with 'and'
        if (v.size() >= 3){

                cout << "The words are: ";

                for (;vBeg != vStop; ++vBeg)
                        cout << "\"" << *vBeg << "\"" << ", ";

                cout << "\"" << *vStop++ << "\"";

                cout << " and " << "\"" << *vStop << "\"" << endl;
        }

        //if 2 words are input put them in quotes and separate them with and
        else if (v.size() == 2) {
                cout << "The words are: " << "\"" << *vBeg << "\"" << " and " << "\"" << *vStop << "\"" << endl;
        }

        //if only 1 word is input put the word in quotes
        else if (v.size() == 1) {
                cout << "The word is: " << "\"" << *vBeg << "\"" << endl;
        }

        return 0;

}//end main
                    </pre>
                </div>
                            
                <div class="tab-pane" id="tab2">
                    <p>This example builds upon the BasicConcepts script. It takes strings from an input file which then 
                    are stored in a linked list. The linked list is sorted using a merge sort algorithm. The sorted list
                    is then displayed on standard output. This script demonstrates using containters and sorting their 
                    contents.</p>
                    <h2 align="center">Sample output</h2>
                    <p align="center"><img src="resources/Images/MergeSortOutput.jpg" width="562" height="319" 
                                           alt="Merge Sort Output Image" /></p>
                    <pre class="prettyprint">

#include &lt;iostream&gt;
#include &lt;list&gt;
#include &lt;string&gt;
#include &lt;iterator&gt;

using namespace std;

typedef list&lt;string&gt; LIST;				// linked list type
typedef LIST::size_type LIST_SIZE;                      // size type for list, e.g., unsigned
typedef LIST::iterator LIST_ITER;			// iterator type
typedef LIST::value_type LIST_CONTAINS;		        // type in the list, i.e., a string

void merge_sort(LIST_ITER beg, LIST_ITER end, LIST_SIZE sz);
void merge(LIST_ITER bLeft, LIST_ITER bRight, LIST_ITER end);
LIST_ITER min_element ( LIST_ITER first, LIST_ITER last );

int main()
{
	LIST l;
	LIST_CONTAINS v;

	// Read in the data...
	while (cin &gt;&gt; v)
		l.push_back(v);

	// Merge the data...
	LIST_ITER i = l.begin();
	LIST_ITER iEnd = l.end();

	LIST_SIZE size = std::distance(i, iEnd);

	/* CALL merge_sort() HERE! */
	merge_sort(i, iEnd, size);

	// Output everything...
	for (; i != iEnd; ++i)
		cout &lt;&lt; *i &lt;&lt; '\n';
}

void merge_sort(LIST_ITER beg, LIST_ITER end, LIST_SIZE sz)
{
  //If the size of the sequence is 1 or smaller, then return.
	if (sz &lt;= 1) return;

	int left_size, right_size;

	if (sz % 2 == 0) {
		left_size = sz / 2;
		right_size = sz /2;
	}
	else {
		left_size = sz / 2;
		right_size = (sz / 2) + 1;
	}

	LIST_ITER mid_iter = beg;
	std::advance(mid_iter, left_size);	//move to the middle element

	merge_sort(beg, mid_iter, left_size);

	merge_sort(mid_iter, end, right_size);

	merge(beg, mid_iter, end);
}

void merge(LIST_ITER bLeft, LIST_ITER bRight, LIST_ITER end)
{
	LIST_ITER left_ptr = bLeft;

	LIST_ITER right_ptr = bRight;

	LIST temp;

  while(left_ptr != bRight && right_ptr != end)
   {
	  if( *min_element(left_ptr, bRight) &lt; *min_element(right_ptr, end) )
	  {
		  temp.push_back(*min_element(left_ptr, bRight));
		  ++left_ptr;
	  }
	  else
	  {
		  temp.push_back(*min_element(right_ptr, end));
		  ++right_ptr;
	  }
  }

  //While there are still elements to process in the left sequence
  while(left_ptr != bRight)
  {
    //Append the least item (in the left sequence) to the temporary list.
    //Move the current left sequence item to the next item.
	  temp.push_back(*min_element(left_ptr, bRight));
	  ++left_ptr;
  }

  //While there are still elements to process in the right sequence.
  while(right_ptr != end)
  {
    //Append the least item (in the right sequence) to the temporary list.
    //Move the current left sequence item to the next item.
	  temp.push_back(*min_element(right_ptr, end));
	  ++right_ptr;
  }

  //For all elements in the temporary list starting with the first one:
  for (LIST_ITER temp_iter = temp.begin(); temp_iter != temp.end(); ++temp_iter)
  {
    //Assign the element to the corresponding element in [bLeft,end)
      //(NOTE: bLeft and end as originally passed in!).
  	*bLeft = *temp_iter;
  	++bLeft;
  }
}

LIST_ITER min_element ( LIST_ITER first, LIST_ITER last ) {

	LIST_ITER lowest = first;

	while (first != last) {
		if (*first &lt; *lowest)
			lowest = first;
		++first;
	}
	return lowest;
}
                </pre>
                </div>
                <div class="tab-pane" id="tab3">    
                   <p> This script employs more advanced C++ concepts such as templates, classes, 
                        operator overloading, function pointers, and C++11 strongly typed enumerations. 
                        The script demonstrates these concepts by reading standard input as a string
                        and creating a new string with characters alternating between UPPER and LOWER
                        case which is sent to standard output as soon as a carriage return is encountered.</p>
                        <h2 align="center">Sample output</h2>
                        <p align="center"><img src="resources/Images/AlternatingCaseOutput.jpg" height="213" width="465"
                                               alt="Alternating Case Output Image"/></p>
                     <pre class="prettyprint">
#include &lt;iostream&gt;
#include &lt;algorithm&gt;
#include &lt;string&gt;

class alternating_case
{
  public
    // default constructor
    alternating_case() {
    	state_ = STATEUPPER;
    }

    // copy constructor
    alternating_case(alternating_case const& a) {
    	state_ = a.state_;
    }

    // copy assignment operator
    alternating_case& operator =(alternating_case const& f) {
    	state_ = f.state_;
    	return this;
    }

    /* overload funtion brackets to make class a functor
    the functor will check the current state of the char
    passed and switch it to its alternating case */
    char operator ()(char c) const {
    	if (state_ == STATEUPPER) {
    		state_ = STATELOWER;
    		return stdtoupper(c);
    	}
    	else if (state_ == STATELOWER) {
    		state_ = STATEUPPER;
    		return stdtolower(c);
    	}
    	return c;
    }

    // reset the current state to UPPER
    void reset() {
    	state_ = STATEUPPER;
    }

  private
  enums UPPER and LOWER represent the current state of the char to be checked
  by alternating_case()
    enum class STATE { UPPER, LOWER };	
    mutable STATE state_;
};

int main()
{
  using namespace std;

  string line;		used to store strings input by user
	
    /*keep reading input until eof or termination and apply transform to each
    string input. When a string is read in it will be output to the screen
    with alternating chars going between upper and lower case*/
  while (getline(cin, line))
  {
    transform(line.begin(), line.end(), line.begin(), alternating_case());
    cout &lt;&lt; line &lt;&lt; endl;
  }
}                    
                    </pre>
                </div>
                <div class="tab-pane" id="tab4">
                    <p>This script builds upon the previous example (Advanced Concepts) by adding a class template, 
                    even more operator overloading, and heavy use of function pointers. The idea behind the script 
                    is to increase the use of generics by using templates and function pointers to perform operations
                    on various types of data.</p>
                    <h2 align="center">Sample output</h2>
                        <p align="center"><img src="resources/Images/GenericsOutput.jpg" height="122" width="514"
                                               alt="Generics Output Image"/></p>
                    <pre class="prettyprint">
#include &lt;iostream&gt;
#include &lt;cctype&gt;
#include &lt;iterator&gt;
#include &lt;string&gt;

template &lt;typename Cont&gt;
class append_to_iterator :
 std::iterator&lt;std::output_iterator_tag,void,void,void,void&gt;
{
  public:

    //default constructor
    explicit append_to_iterator(Cont& cont) {
    	cont_ = &cont;
    }

    append_to_iterator&lt;Cont&gt;& operator =(typename Cont::const_reference value) {
    	cont_-&gt;push_back(value);
    	return *this;
    }

    //indirection operator
    append_to_iterator&lt;Cont&gt;& operator *() {
    	return *this;
    }

    //default increment operator
    append_to_iterator&lt;Cont&gt;& operator ++() {
    	return *this;
    }

    //increment operator for type int
    append_to_iterator&lt;Cont&gt; operator ++(int) {
    	return *this;
    }

  private:
    Cont* cont_;
};

class alternating_case
{
  public:
	//default constructor
    alternating_case() {
    	state_ = STATE::UPPER;
    }

    //copy constructor
    alternating_case(alternating_case const& a) {
    	state_ = a.state_;
    }

    //copy assignment operator
    alternating_case& operator =(alternating_case const& f) {
    	state_ = f.state_;
    	return *this;
    }

	//overload funtion brackets to make class a functor
	//the functor will check the current state of the char
	//passed and switch it to its alternating case
    char operator ()(char c) const {
    	if (state_ == STATE::UPPER) {
    		state_ = STATE::LOWER;
    		return std::toupper(c);
    	}
    	else if (state_ == STATE::LOWER) {
    		state_ = STATE::UPPER;
    		return std::tolower(c);
    	}
    	return c;
    }

	//reset the current state to UPPER
    void reset() {
    	state_ = STATE::UPPER;
    }

  private:
  //enums UPPER and LOWER represent the current state of the char to be checked
  //by alternating_case()
    enum class STATE { UPPER, LOWER };	
    mutable STATE state_;
};

//creates an append_to_iterator object
template &lt;typename Cont&gt;
append_to_iterator&lt;Cont&gt; append_to_container(Cont& cont)
{
	return append_to_iterator&lt;Cont&gt;(cont);
}

//goes through each element in a container and applies the operation passed to it
template &lt;typename InIter, typename OutIter, typename Op&gt;
OutIter update(InIter first, InIter last, OutIter out, Op o)
{
	for (; first != last; ++first)
	{
		*out = o(*first);
		++out;
	}
	return out;
}

//takes a reference to a string and an operator to perform and creates a copy of
//the string passed with the operation performed on the copy and returns the copy
template &lt;typename F&gt;
std::string to_xxx(std::string const& str, F f) {
	std::string retval;
	update(str.begin(), str.end(), append_to_container(retval), f);
	return retval;
}

//takes a reference to a string and creates a copy of the string all in upper case
std::string to_upper(std::string const& str) {
	 int (* const ptrfunc)(int) = std::toupper;
	 return to_xxx(str, ptrfunc);
}

//takes a reference to a string and creates a copy of the string all in lower case
std::string to_lower(std::string const& str) {
	 int (* const ptrfunc)(int) = std::tolower;
	 return to_xxx(str, ptrfunc);
}

//takes a reference to a string and creates a copy of the string all in alternating case
std::string to_alternating(std::string const& str) {
	return to_xxx(str, alternating_case());
}

int main()
{
  using namespace std;

  string line;		//stores input
  
  //keep reading input and output copies of the input in upper, lower, and alternating case
  while (getline(cin, line))
  {
    cout &lt;&lt; "to_upper: " &lt;&lt; to_upper(line) &lt;&lt; endl;
    cout &lt;&lt; "to_lower: " &lt;&lt; to_lower(line) &lt;&lt; endl;
    cout &lt;&lt; "to_alternating: " &lt;&lt; to_alternating(line) &lt;&lt; endl;
  }

  return 0;
}                    
                    </pre>
                   </div>
                  </div>  
                </div>
              </div>
           </div>
        </div>
<%@ include file="/includes/footer.html"%>