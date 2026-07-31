
source('./button_block_box_shadow.R')
startup_overlay_div <- function(overlay_out_time_ms = 5000, main_in_time_ms=7000){

tags$div(id = "startup-overlay",
         tags$head(HTML('<style>


/*
 https://blog.hubspot.com/website/css-loading-animation#:~:text=A%20loading%20animation%20is%20a,accepted%20and%20is%20being%20processed.
 */
 .loader-container1 {
  margin-top:30px;
    display: flex;
    justify-content: center;
    align-items: center;
    z-index:1001;
    width:350px;
}

.progress-bar1 {
    width: 70%;
    max-width: 500px;
    height: 15px;
    background-color: white;
    border-radius: 10px;
    border: 1px solid #white;
    overflow: hidden;
    z-index:1001;

}

.progress1 {
    width: 0;
    height: 100%;
    background-color: #ffd700;
    animation: fill1 2s ease 3s 1 forwards;
    z-index:1001;
}

@keyframes fill1 {
    0% {
        width: 0;
    }
    90% {
        width: 100%;
    }
    100%{
      border-width: 1px;
      border-color:white;
      width: 100%;
    }
    }

         .hello{
  font-weight: bold; /* Makes the text bold */
    font-size: 40px;
    margin-bottom:10px;
}
</style>')),

         tags$script(HTML(paste0("
    setTimeout(function() {
      //document.getElementById('startup-overlay').style.display = 'none';
      // document.getElementById('main-content').style.display = 'block';
        $('#startup-overlay').fadeOut(500);

        //$('#main-content').fadeIn('slow');

    }, ",overlay_out_time_ms,");  // 10 seconds = 10000 ms
    //5000
    setTimeout(function() {
      //document.getElementById('startup-overlay').style.display = 'none';
      // document.getElementById('main-content').style.display = 'block';
       // $('#startup-overlay').fadeOut(200);

        $('#main-content').fadeIn('slow');

    }, ",main_in_time_ms,");  // 10 seconds = 10000 ms
    //7000
  "))),


style = "
    background-color: white;
    position: fixed;
    top: 0%; /*110px*/
    left: 0;
    width: 100%;
    height: 100%;

    color: rgb(30,30,30);
    text-align: center;

    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 10040;
  ", div(style = 'overflow:hidden;

  background:linear-gradient(55deg, orange 5%, #ffd700 37%, #ffde6f 75%);
  margin:10px;border-radius:15px;
        height:96%;width:96%;
         top:2%;left:2%;
         display:flex;justify-content:center;align-items:center;flex-direction:column;',
              #rgb(122,236,244);
         # background-color:#FCB001;
         button_block(border = 'white',
                      h1(class = 'hello','Population Health Modelling'),
                      span(class = '', 'Disease Prevalence')
                      ),
         #div(style='display:block;position:absolute;justify-content:start;top:50px;left:50px;gap:20px;',
              #img(style= '',src = 'img/pha_logo_0.png', width = '120px;'),
              #p(style='font-size: 11px;','Population Health Model')
         #),
         HTML('<div class="loader-container1">
    <div class="progress-bar1">
        <div class="progress1"></div>
    </div>
</div>' )
              )
         )
}

startup_overlay_div()
