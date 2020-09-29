#!/bin/bash
echo "

<head>
<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\" /> <title>Monitoring</title>

</head>

<link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/icon?family=Material+Icons\">
<script defer src=\"https://code.getmdl.io/1.1.2/material.min.js\"></script>
 <link rel=\"stylesheet\" href=\"https://code.getmdl.io/1.1.2/material.indigo-deep_purple.min.css\" />
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">

  <link rel=\"stylesheet\" href=\"styles.css\"> 
<body>

<!-- Always shows a header, even in smaller screens. -->
<div class=\"mdl-layout mdl-js-layout mdl-layout--fixed-header\">
  <header class=\"mdl-layout__header\">
    <div class=\"mdl-layout__header-row\">
      <!-- Title -->
      <span class=\"mdl-layout-title\">
Monitoring</span>
      <!-- Add spacer, to align navigation to the right -->
      <div class=\"mdl-layout-spacer\"></div>
      <!-- Navigation. We hide it in small screens. -->
      <nav class=\"mdl-navigation mdl-layout--large-screen-only\">
 <a class=\"mdl-navigation__link\" href=\"./index.html\">Home</a>
       <a class=\"mdl-navigation__link\" href=\"/cgi-bin/control.cgi\">Control</a>
        <a class=\"mdl-navigation__link\" href=\"/cgi-bin/logs.cgi\">Logs</a>
        <a class=\"mdl-navigation__link\" href=\"./Checklist.html\">Monitoring</a>
        <a class=\"mdl-navigation__link\" href=\"/cgi-bin/SQL.cgi\">SQL</a>
        <a class=\"mdl-navigation__link\" href=\"./Cameras.html\">Cameras</a>
      </nav>
    </div>

  <div class=\"mdl-layout__tab-bar mdl-js-ripple-effect\">
      <a class=\"mdl-layout__tab is-active\" href=\"/cgi-bin/monitoring.cgi\"  onclick=\"window.open('/cgi-bin/monitoring.cgi','_self');\">All Plots</a>
      <a class=\"mdl-layout__tab\" href=\"./Checklist.html\" onclick=\"window.open('./Checklist.html','_self');\">Checklist</a>
      <a class=\"mdl-layout__tab\" href=\"./MRDSummary.html\" onclick=\"window.open('./MRDSummary.html','_self');\">MRD Summary</a>
      <a class=\"mdl-layout__tab\" href=\"./TankSummary.html\" onclick=\"window.open('./TankSummary.html','_self');\">Tank Summary</a>
      <a class=\"mdl-layout__tab\" href=\"./TriggerSummary.html\" onclick=\"window.open('./TriggerSummary.html','_self');\">Trigger Summary</a>
      <a class=\"mdl-layout__tab\" href=\"./MRDLastFile.html\" onclick=\"window.open('./MRDLastFile.html','_self');\">MRD LastFile</a>
      <a class=\"mdl-layout__tab\" href=\"./MRDHitmaps.html\" onclick=\"window.open('./MRDHitmaps.html','_self');\">MRD Hitmaps</a>
      <a class=\"mdl-layout__tab\" href=\"./MRDTimeEvolution.html\" onclick=\"window.open('./MRDTimeEvolution.html','_self');\">MRD TimeEvolution</a>
      <a class=\"mdl-layout__tab\" href=\"./MRDRates.html\" onclick=\"window.open('./MRDRates.html','_self');\">MRD Rates</a>
      <a class=\"mdl-layout__tab\" href=\"./TankElectronics.html\" onclick=\"window.open('./TankElectronics.html','_self');\">Tank Electronics</a>
      <a class=\"mdl-layout__tab\" href=\"./TankTimeEvolution.html\" onclick=\"window.open('./TankTimeEvolution.html','_self');\">Tank TimeEvolution</a>
      <a class=\"mdl-layout__tab\" href=\"./TankFrequency.html\" onclick=\"window.open('./TankFrequency.html','_self');\">Tank Frequency</a>
      <a class=\"mdl-layout__tab\" href=\"./TankBuffer.html\" onclick=\"window.open('./TankBuffer.html','_self');\">Tank Buffer</a>
      <a class=\"mdl-layout__tab\" href=\"./TriggerRates.html\" onclick=\"window.open('./TriggerRates.html','_self');\">Trigger Rates</a>
      <a class=\"mdl-layout__tab\" href=\"./TriggerAlignment.html\" onclick=\"window.open('./TriggerAlignment.html','_self');\">Trigger Alignment</a>
    </div> 

  </header>
  <div class=\"mdl-layout__drawer\">
 <img src=\"../ANNIE-logo.png\"  width=\"90%\" height=\"10%\"> 
    <span class=\"mdl-layout-title\"></span>
<div class=\"android-drawer-separator\"></div>
    <nav class=\"mdl-navigation\">
<a class=\"mdl-navigation__link\" href=\"./index.html\">Home</a>
      <a class=\"mdl-navigation__link\" href=\"/cgi-bin/control.cgi\">Control</a>
        <a class=\"mdl-navigation__link\" href=\"/cgi-bin/logs.cgi\">Logs</a>
	<a class=\"mdl-navigation__link\" href=\"./Checklist.html\">Monitoring</a>
        <a class=\"mdl-navigation__link\" href=\"/cgi-bin/SQL.cgi\">SQL</a>
	<a class=\"mdl-navigation__link\" href=\"./Cameras.html\">Cameras</a>
    </nav>
  </div>
  <main class=\"mdl-layout__content\">
    <div class=\"page-content\">
<!-- Your content goes here -->

<!-- <p> <a href=\"/cgi-bin/monitoring.cgi\">All Plots</a> , <a href=\"./MRDSummary.html\">MRD Summary</a> , <a href=\"./TankSummary.html\"> Tank Summary</a>
</p> -->

<p>  </p>

<select id=\"mySelect\" onchange=\"myFunction()\">

"
for folder in `ls -d /web/monitoringplots/*/`
do
 echo " <option value=\"$folder\">$folder</option>"
done

for file in `ls /web/monitoringplots/`
do
 echo " <option value=\"$file\">$file</option>"
done

echo "</select>

"


for file in `ls /web/monitoringplots/`
do
 echo " <img id=\"$file\" style=\"display:none\" src=\"./monitoringplots/$file\"  width=\"40%\" height=\"40%\"> "
done


echo "



  <footer class=\"mdl-mega-footer\">                                                                                                     
                                                                                                                                                            
          <div class=\"mdl-mega-footer--top-section\">                                                                                                        
            <div class=\"mdl-mega-footer--right-section\">                                                                                                    
              <a class=\"mdl-typography--font-light\" href=\"#top\">                                                                                            
                Back to Top                                                                                                                                 
                <i class=\"material-icons\">expand_less</i>                                                                                                   
              </a>                                                                                                                                          
            </div>                                                                                                                                          
          </div>                                                                                                                                            
                                                                                                                                                            
                                                                                                                                                            
                                                                                                                                                            
                                                                                                                                                            
          <div class=\"mdl-mega-footer--middle-section\">                                                                                                     
            <p class=\"mdl-typography--font-light\">ANNIE Collaboration © 2016 </p>                                                                           
            <p class=\"mdl-typography--font-light\">Created by Dr. B.Richards (b.richards@qmul.ac.uk)</p>                                                     
          </div>                                                                                                                                            
                                                                                                                                                            
                                                                                                                                                            
          </footer>   



</div>
  </main>
</div>

<script>

function myFunction() {
// var y = document.getElementsByClassName(\"on\");
//var i;
//for (i = 0; i < y.length; i++) {
//  y[i].style.display=\"none\";
//y[i].className=\"off\";
//}
  var x = document.getElementById(\"mySelect\").value;
  document.getElementById(x).style.display='block';
document.getElementById(x).className=\"on\";

}

function myFunction2() {

 var y = document.getElementsByClassName(\"on\");
var i;
 timestamp = (new Date()).getTime();
for (i = 0; i < y.length; i++) {
var a = y[i].src;
var b = a.split(\"?_=\", 1) 
var c = b + '?_=' + timestamp;
 y[i].src =  c;
}

}


setInterval(myFunction2, 20000);



</script>

</body>
"                                                                                                                              
