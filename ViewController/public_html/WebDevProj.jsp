<jsp:include page="/includes/header.html"/>
        <div class="container">
          <div class="span11">
            <div class="hero-unit">
            <p><h2>Web Development Project</h2></p>
                <p><h4>
                This is a project I created in a group of myself and 2 others which was a basic design to allow
                users to create accounts, log in and create photo albums so their friends can view them. 
                My main responsibility was handling the uploading and resizing of photos then placing them into the proper place in the 
                database. I was also responsible for being able to view the photos and therefore had to make proper database 
                calls to retrieve them. I claim no responsibilty for any other portion of this work. The sections I worked on 
                are detailed below.  
                </h4></p>
                
                <h2 align="center"><a class="btn btn-large btn-primary" href="/Client" target="_blank">Click here to see the site</a></h2>
                <p>Log in to see organizing and editing photos and albums, or create your own account.<br>
                <strong>username:User1<br>password:demouser</strong> </p>
                
                <p align="center"><a class="btn btn-large btn-primary" href="resources/Web_Dev_Proj_Code.zip">Download the JSP and Java files</a>
                <a class="btn btn-large btn-primary" href="resources/Web_Development_Project.zip" target="_blank">Download the full project</a>
                </p>
            </div>
            <h4>The following files are my portion of the project</h4>
          </div>
        <div class="tabbable">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab1" data-toggle="tab">Addphoto.java</a></li>
            <li><a href="#tab2" data-toggle="tab">Viewphoto.java</a></li>
            <li><a href="#tab3" data-toggle="tab">Addphoto.jsp</a></li>
            <li><a href="#tab4" data-toggle="tab">Viewphoto.jsp</a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="tab1">
                <h3><a href="resources/addphoto.txt" target="_self" >addphoto.java</a></h3>
                
                <p>This class extends HttpServlet and uses the methods
                doGet() and doPost(). The doGet() method is primarily used to send users to the appropriate page
                depending on certain conditions. First, a DBC object is created which is used for the database
                queries. Then a User object is created passing the dbc and request objects.</p>
            
                <p><h5>DBC dbc = new DBC();
                <br>User u = new User(dbc,request);</h5></p>
            
                &nbsp;                
            
                <p>If the user is not logged in they are sent back to the login page.</p>
            
                &nbsp;
            
                <p><h5>if(!u.isLoggedIn()){<br>
                        &ensp;&ensp;request.setAttribute("msg", "You must be logged in to do that");<br>
                        &ensp;&ensp;dispatcher = request.getRequestDispatcher("login.jsp");<br>
                        <br>
                        if (dispatcher != null) dispatcher.forward(request, response);<br>
                        else System.err.println("Error: File not found");
                </h5></p>
            
                &nbsp;
            
                <p>If the user is logged in a new photo object will be created using clients pid and the dbc object. The attributes
                 are set and if the request processes without errors the client will be sent to the editphoto page 
                 where they can add a new photo or edit current photos.</p>
                            
                &nbsp;
            
                <p><h5>try{ pid = Integer.parseInt(request.getParameter("pid")); }<br>
                        catch(NumberFormatException e){;}<br>
                        <br>
                        if(pid > 0){<br>
                        &ensp;&ensp;Photo p = new Photo(dbc,pid);<br>
                        &ensp;&ensp;if(pid == p.getPid() && p.getOwner() == u.getUid()){<br>
                        &ensp;&ensp;&ensp;&ensp;request.setAttribute("photo",p);<br>
                        &ensp;&ensp;&ensp;&ensp;request.setAttribute("msg", "Photo Updated");<br>
                        &ensp;&ensp;&ensp;&ensp;dispatcher = request.getRequestDispatcher("editphoto.jsp?pid="+pid);<br>
                        &ensp;&ensp;&ensp;&ensp;if (dispatcher != null) dispatcher.forward(request, response);
                        &ensp;&ensp;&ensp;&ensp;else System.err.println("Error: File not found");
                </h5></p>
            
                &nbsp;
            
                <p>If the user is logged in, but for some reason has an invalid pid and uid, they be sent to the
                    viewphoto page and an error message will appear.</p>
            
                &nbsp;
            
                <p><h5>
                else{<br>
                &ensp;&ensp;request.setAttribute("msg", "An error has occured");<br>
                &ensp;&ensp;dispatcher = request.getRequestDispatcher("viewphoto.jsp?pid="+pid);<br>
                &ensp;&ensp;if (dispatcher != null) dispatcher.forward(request, response);<br>
                &ensp;&ensp;else System.err.println("Error: File not found");<br>
                }
                </h5></p>
            
                &nbsp;
            
                <p>If the user is logged in but has a pid less than or equal to 0 and error has occured and the 
                user is sent back to the addphoto page to try again. This is the end of method doGet().</p>
            
                &nbsp;
            
                <p><h5>else{<br>
                        &ensp;&ensp;dispatcher = request.getRequestDispatcher("addphoto.jsp");<br>
                        &ensp;&ensp;if (dispatcher != null) <br>
                        &ensp;&ensp;&ensp;&ensp;dispatcher.forward(request, response);<br>
                        &ensp;&ensp;else System.err.println("Error: File not found");</h5></p>
            
                &nbsp;
            
                <p>The doPost() method is used to handle form submission. There are two cases to handle, the user
                is updating a photo that is already uploaded, or the user is adding a new photo. When a user hits submit on the addphoto
                page, doPost() will attempt to process the photo. First a check is done to ensure the user is logged
                in.</p>
            
                &nbsp;
            
                <p><h5>if(!u.isLoggedIn()){<br>
                    &ensp;&ensp;request.setAttribute("msg", "You must be logged in to do that");<br>
                    &ensp;&ensp;dispatcher = request.getRequestDispatcher("login.jsp");<br>
                    &ensp;&ensp;if (dispatcher != null) dispatcher.forward(request, response);<br>
                    &ensp;&ensp;else System.err.println("Error: File not found");</h5></p>
            
                &nbsp;
            
                <p>Then a check is done to see if an existing photo is being updated or a new photo is being added.
                    The func parameter is checked to determine if the photo is being updated or added.
                </p>
            
                &nbsp;
            
                <p><h5>
                        String func = request.getParameter("func");<br>
                        try{ pid = Integer.parseInt(request.getParameter("pid")); }<br>
                        catch(NumberFormatException e){;}<br>
                        if(func != null && func.equals("save") && pid > 0){<br>
                        &ensp;&ensp;System.out.println("Saving");
                </h5></p>
            
                &nbsp;
            
                <p>The following lines ensure that all apostrophe characters 
                    entered by the client are correctly converted for database queries.</p>
            
                &nbsp;
            
                <p><h5>title = request.getParameter("title").replaceAll("'", "&amp;#39;");<br>
                        caption = request.getParameter("caption").replaceAll("'", "&amp;#39;");</h5></p>
            
                &nbsp;
            
                <p>The attributes of the photo are updated and the user is sent to the editphoto
                    page with all the new attribute values.</p>
            
                &nbsp;
            
                <p><h5>if(pid == p.getPid() && p.getOwner() == u.getUid()){<br>
                    &ensp;&ensp;if(!p.getTitle().equals(title))<br>
                    &ensp;&ensp;&ensp;&ensp;p.setTitle(dbc, title);<br>
                    &ensp;&ensp;if(!p.getCaption().equals(caption))<br>
                    &ensp;&ensp;&ensp;&ensp;p.setCaption(dbc, caption);<br>
                    &ensp;&ensp;request.setAttribute("photo",p);<br>
                    &ensp;&ensp;request.setAttribute("msg", "Photo Updated");<br>
                    &ensp;&ensp;dispatcher = request.getRequestDispatcher("editphoto.jsp?pid="+pid);</h5>
                </p>
            
                &nbsp;
            
                <p>The rest of doPost() handles the creation of a new photo. First two int variables are 
                    initialized to their default values.</p>
            
                &nbsp;
            
                <p><h5>File file;<br>
                    int maxFileSize = 5000 * 1024;<br>
                    int maxMemSize = 5000 * 1024;<br>
                </h5></p>
            
                &nbsp;
            
                <p>The <strong>maxFileSize</strong> variable is used to set the size of the file that will 
                be saved onto a physical disc. The <strong>maxMemSize</strong> variable is used to set the size
                the file is allowed to use in system memory. The next line is used to setup a path to the directory
                that will store the picture files on the host machine.</p>
            
                &nbsp;
            
                <p><h5>String filePath = liveRoot + sep+"images"+sep;</h5></p>
            
                &nbsp;
            
                <p>Next a DefaultFileItemFactory object is created which will be used to set the threashold for how
                much system memory can be used by the file before the physical disk is used, set the size each
                file is allowed on disk, and set a temporary location for files while being resized. For this project
                a size of 5 MegaBytes was chosen as the threshold. The API for org.apache.commons.fileupload.DefaultFileItemFactory
                has been deprected however the methods and constructors used are all still available through 
                org.apache.commons.fileupload.disk.DiskFileItemFactory. First, the system memory threshold is set.</p>
            
                &nbsp;
            
                <p><h5>DefaultFileItemFactory factory = new DefaultFileItemFactory();
                <br>    factory.setSizeThreshold(maxMemSize);</h5></p>
            
                &nbsp;
            
                <p>Next, the factory object is used to set the location to store pictures temporarily
                on disk if they are larger than <strong>maxMemSize</strong>, in this case 5 Megabytes</p>
            
                &nbsp;
            
                <p><h5>factory.setRepository(new File(liveRoot +sep+"temp"));</h5></p>
            
                &nbsp;
            
                <p>A FileUpload object from org.apache.commons.fileupload.FileUpload is now created and is used
                to handle the uploading of the pictures from the client to the host. The maximum size allowed on 
                disk space is set to 5 Megabytes.</p>
            
                &nbsp;
            
                <p><h5>FileUpload upload = new FileUpload(factory);
                    <br>upload.setSizeMax( maxFileSize );</h5></p>
            
                &nbsp;
            
                <p>The next line creates a List object which will hold the response from calling
                parseRequest() on the upload object and passing the HttpServletRequest object as a parameter. 
                An iterator is also created to be able to traverse the list of items from the parse.</p>
            
                &nbsp;
            
                <p><h5>List fileItems = upload.parseRequest(request);
                <br>Iterator i = fileItems.iterator();</h5></p>
            
                &nbsp;
            
                <p>The list of FileItems retrieved from the parse is now traversed using a while loop. 
                First the name of the file is obtained.</p>
            
                &nbsp;
            
                <p><h5>while ( i.hasNext () )<br>
                 {<br>
                 &ensp;&ensp;FileItem fi = (FileItem)i.next();
                  <br>   
                 &ensp;&ensp;if ( !fi.isFormField () ) { <br>
                 &ensp;&ensp;&ensp;&ensp;fileName = fi.getName();
                 </h5></p>
            
                &nbsp;
            
                <p>The file object now created using the name obtained in the previous lines and its directory 
                    path is set.</p>
            
                &nbsp;
            
                <p><h5>file = new File( liveRoot + sep +"temp" +sep+ 
                    <br>fileName.substring( fileName.lastIndexOf(sep))) ;
                    <br>fileName = fileName.substring( fileName.lastIndexOf(sep));</h5></p>
            
                &nbsp;
            
                <p>Now the values from the form that the user entered are saved, once again converting all 
                    apostrophe characters to their proper values.</p>
            
                &nbsp;
            
                <p><h5>String fieldname = fi.getFieldName();<br>
                         if (fieldname.equals("title"))<br>
                         &ensp;&ensp;title = fi.getString().replaceAll("'", "&amp;#39;");<br>
                         else if (fieldname.equals("caption"))<br>
                         &ensp;&ensp;caption = fi.getString().replaceAll("'", "&amp;#39;");
                </h5></p>
            
                &nbsp;
            
                <p>The file is then written to disk</p>
            
                &nbsp;
            
                <p><h5>fi.write(file);</h5></p>
            
                &nbsp;
            
                <p>The final step is to create a new Photo object with all the parameters constructed which will
                    add the photo into the database for later retrieval.</p>
            
                &nbsp;
            
                <p><h5>Photo photo = new Photo(dbc,u.getUid(),title,caption,liveRoot,fileName);</h5></p>
                
            </div>
            <div class="tab-pane" id="tab2">
              <h3><a href="resources/viewphoto.txt" target="_self" >viewphoto.java</a></h3>
    
                <p>viewphoto.java extends HttpServlet and uses method doGet(). There is no need for a doPost() method as the page
                only serves the purpose of viewing a photo. The doGet() method begins by instantiating a DBC object, creating a 
                User object with dbc and request as parameters, and creating a few primative variables. 
                </p>
            
                &nbsp;
                
                <p><h5>DBC dbc = new DBC();<br>
                    User user = new User(dbc,request);<br>
                    int pid;<br>
                    String links, title, caption, imagePath;</h5></p>
            
                &nbsp;
                
                <p>The pid of the current user is retrieved</p>
                
                <p><h5>pid = Integer.parseInt(request.getParameter("pid"));</h5></p>
                
                &nbsp;
                
                <p>Next, if a valid pid was retrieved, a new Photo object is created passing dbc and pid as parameters</p>
                
                &nbsp;
                
                <p><h5>if(pid > 0 ){<br>
                       &ensp;&ensp;Photo p = new Photo(dbc, pid);</h5></p>
                
                &nbsp;
                
                <p>If a the pid from the photo is the same as the pid retrieved in the previous line, then the imagePath, title and 
                caption String variables are retrieved.</p>
                
                &nbsp;
                
                <p><h5>if(p.getPid()==pid){<br>
                       &ensp;&ensp;imagePath = "/Client/images/"+p.getFullFilename();  <br>
                       &ensp;&ensp;title = p.getTitle();<br>
                       &ensp;&ensp;caption = p.getCaption();<br>
                </h5></p>
                
                &nbsp;
                
                <p>If the user is the owner of the photo they will be given an extra option to edit the current photo.
                The next if statment checks if the Album ID(p.getAid()) is valid and that the links string
                is not empty, if so then a "View Album" link will be added. The else if statement is used to add the 
                "View Album" link if the user is the owner, and only needs to check the Album ID is valid.</p>
                
                &nbsp;
                
                <p><h5>if(p.getOwner() == user.getUid())<br>
                       &ensp;&ensp;links+="< a href='/Client/addphoto?pid="+pid+"'>Edit< /a>";<br>
                       if(p.getAid() != -1 && links=="")<br>
                       &ensp;&ensp;links+="< a href='/Client/viewalbum?aid="+p.getAid()+"'>View Album< /a>";<br>
                       else if(p.getAid() != -1)<br>
                       &ensp;&ensp;links+=" | < a href='/Client/viewalbum?aid="+p.getAid()+"'>View Album< /a>";</h5></p>
                
                &nbsp;
                
                <p>The last steps prepare the attributes and dispatch the viewphoto.jsp page.</p>
                
                &nbsp;
                
                <p><h5>request.setAttribute("src", imagePath);<br>
                    request.setAttribute("title", title);<br>
                    request.setAttribute("caption", caption);<br>
                    request.setAttribute("links",links);</h5></p>
                
                &nbsp;
                
                <p><h5>RequestDispatcher dispatcher = request.getRequestDispatcher("viewphoto.jsp");<br>
                    if (dispatcher != null)<br>
                    &ensp;&ensp;dispatcher.forward(request, response);<br>
                    else System.err.println("Error: File not found");<br>
                    out.close();</h5></p>
                
                &nbsp;
            </div>
            <div class="tab-pane" id="tab3">
                <h3><a href="resources/addphoto.jsp.txt" target="_self" >addphoto.jsp</a></h3>
            
                <p> The addphoto page is used to allow a user to select the file from their local disk
                and upload it to the machine running the web server which will store the photo in the database.</p>
                
                &nbsp;
                
                <p><h5>form action="addphoto" method="POST" enctype="multipart/form-data"</h5></p>
                
                &nbsp;
                
                <p>The form tag is used with attributes action, method, and enctype. action="addphoto" specifies where
                the form data will be going once submitted, in this case it will be sent to the addphoto.java class.
                method="POST" is used because the client is sending files to the server. enctype="multipart/form-data" is used 
                since files will be sent through the form.</p>
                
                &nbsp;
                
                <p>The rest of the page is a basic HTML form for selecting the file and typing a comment
                then submitting. Once the user submits the form the addphoto.java class will recieve the 
                request and process the form data.</p>
            </div>
            <div class="tab-pane" id="tab4">
                <h3><a href="resources/viewphoto.jsp.txt" target="_self" >viewphoto.jsp</a></h3>
                
                <p>Viewphoto is the page users go when they want to view a single photo from an album. It will display the 
                title and any related links added above the image, the image in full size aligned in the center, 
                and the caption below the picture. It is a static page, users cannot change anything, the only purpose is to
                display an image.</p>
                
                &nbsp;
                
                <p><h5> h1 id="page-title">${requestScope.title}</h5></p>
                
                &nbsp;
                
                <p>This is an EL (Expression Language) statement to display the title of the picture. The requestScope variable is
                used to retrieve the values needed to display the content on this page. requestScope is an object which allow access
                to all the variables at the request scope level.</p>
                
                &nbsp;
                
                <p><h5>div id="contextual-links">${requestScope.links}</h5></p>
                
                &nbsp;
                
                <p>Any related links which have been added during the user session will be displayed.</p>
                
                &nbsp;
                
                <p><h5>img class="large_img" src="${requestScope.src}" align="middle" /></h5></p>
            
                <p>The image should have been retrieved from the database by the viewphoto.java class and sent through the request
                object to the viewphoto.jsp page. If everything processed correctly the image will be displayed in full size on the
                page.</p>
                
                &nbsp;
                
                <p><h5>class="caption">${requestScope.caption}</h5></p>
            
                <p>Underneath the image a caption will be displayed which was set earlier when the client uploaded the image.</p>
            </div>  
          </div>
        </div>
        </div>
<jsp:include page="/includes/footer.html"/>