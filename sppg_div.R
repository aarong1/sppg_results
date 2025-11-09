# nav_panel(title = HTML( '<b style="font-weight: bold;
#                           font-size: x-small;">DoH</b>
#                                                   Baseline '),
#           value = 'baseline_results',
#           #div(class='divider','Overview'),
#           class = 'fade m-3',
          #https://stackoverflow.com/questions/4907843/open-a-url-in-a-new-tab-and-not-a-new-window

#           HTML('  <ol class="breadcrumb breadcrumb-nav p-3 bg-body-tertiary rounded-3">
#     <li class="breadcrumb-item fa fa-home" ><a href="#" onclick = window.change_tab("Landing");></a></li>
#     <li class="breadcrumb-item "><a href="#" onclick = window.change_tab("info-home");>Info</a></li>
#     <li class="breadcrumb-item  active">Baseline Results</li>
#   </ol>
# '),

sppg_div <- function(){div(
          tags$head(
            tags$style(HTML("

      #scrollspy-nav i {
  /*
  color: grey;
  Change icon color */
      }

      #scrollspy-content h5 {
  color: grey;         /* Change icon color */
  margin-left:1rem;
  margin-top:10px;

      }

            #scrollspy-content span {
  font-size: 90%;;
  margin-left:2rem;
  padding-bottom:1.5rem;
  color:rgba(0,0,0,0.8);

            }

                  #scrollspy-content div {

  margin-left:0.5rem;
  padding-bottom:0.5rem;

      }

           #intro h5 >h5 {
  color: grey;         /* Change icon color */
  margin-left:2rem;

           }

                 #intro p {
  color: dimgrey;         /* Change icon color */
  margin-left:2rem;

      }

      #scrollspy-nav {

        border-radius:15px;
        /*
        position: sticky;
        top: 22vh;
        right: 10px;
        width: 80px;
        */
      }

      #scrollspy-content {
        margin-left: 50px;
        /*height: 6000px;*/
        overflow-y: scroll;
        position: relative;
      }

     #scrollspy-nav > a.nav-link.active{
      background-color:dar;
      color:white;
      border-radius:4px;
      }

      #scrollspy-nav a.nav-link.active{
      background-color:orange;
      color:white;
      border-radius:4px;
      }

      .section {
        height: 400px;
        padding-top: 60px;
      }
    "))
          ),

          # HTML('
          # <div class="row">
          #   <div class="col-4">
          #   <nav id="scrollspy-nav" class="h-20 flex-column align-items-stretch pe-4 border-end">
          #   <nav class="nav nav-pills flex-column">
          #   <a class="nav-link" href="#item-1">Item 1</a>
          #   <nav class="nav flex-column">
          #   <a class="nav-link ms-3 my-1" href="#item-1-1">Item 1-1</a>
          #   <a class="nav-link ms-3 my-1" href="#item-1-2">Item 1-2</a>
          #   </nav>
          #   <a class="nav-link" href="#item-2">Item 2</a>
          #   <a class="nav-link" href="#item-3">Item 3</a>
          #   <nav class="nav nav-pills flex-column">
          #   <a class="nav-link ms-3 my-1" href="#item-3-1">Item 3-1</a>
          #   <a class="nav-link ms-3 my-1" href="#item-3-2">Item 3-2</a>
          #   </nav>
          #   </nav>
          #   </nav>
          #   </div>
          #
          #   <div class="col-8">
          #   <div data-bs-spy="scroll" data-bs-target="#scrollspy-nav" data-bs-smooth-scroll="true" class="scrollspy-example-2" tabindex="0">
          #   <div id="item-1">
          #   <h4>Item 1</h4>
          #   <p>This is some placeholder content for the scrollspy page. Note that as you scroll down the page, the appropriate navigation link is highlighted. It’s repeated throughout the component example. We keep adding some more example copy here to emphasize the scrolling and highlighting.  Keep in mind that the JavaScript plugin tries to pick the right element among all that may be visible. Multiple visible scrollspy targets at the same time may cause some issues.</p>
          #   </div>
          #   <div id="item-1-1">
          #   <h5>Item 1-1</h5>
          #   <p>This is some placeholder content for the scrollspy page. Note that as you scroll down the page, the appropriate navigation link is highlighted. It’s repeated throughout the component example. We keep adding some more example copy here to emphasize the scrolling and highlighting.  Keep in mind that the JavaScript plugin tries to pick the right element among all that may be visible. Multiple visible scrollspy targets at the same time may cause some issues.</p>
          #   </div>
          #   <div id="item-1-2">
          #   <h5>Item 1-2</h5>
          #   <p>This is some placeholder content for the scrollspy page. Note that as you scroll down the page, the appropriate navigation link is highlighted. It’s repeated throughout the component example. We keep adding some more example copy here to emphasize the scrolling and highlighting.  Keep in mind that the JavaScript plugin tries to pick the right element among all that may be visible. Multiple visible scrollspy targets at the same time may cause some issues.</p>
          #   </div>
          #   <div id="item-2">
          #   <h4>Item 2</h4>
          #   <p>This is some placeholder content for the scrollspy page. Note that as you scroll down the page, the appropriate navigation link is highlighted. It’s repeated throughout the component example. We keep adding some more example copy here to emphasize the scrolling and highlighting.  Keep in mind that the JavaScript plugin tries to pick the right element among all that may be visible. Multiple visible scrollspy targets at the same time may cause some issues.</p>
          #   </div>
          #   <div id="item-3">
          #   <h4>Item 3</h4>
          #   <p>This is some placeholder content for the scrollspy page. Note that as you scroll down the page, the appropriate navigation link is highlighted. It’s repeated throughout the component example. We keep adding some more example copy here to emphasize the scrolling and highlighting.  Keep in mind that the JavaScript plugin tries to pick the right element among all that may be visible. Multiple visible scrollspy targets at the same time may cause some issues.</p>
          #   </div>
          #   <div id="item-3-1">
          #   <h5>Item 3-1</h5>
          #   <p>This is some placeholder content for the scrollspy page. Note that as you scroll down the page, the appropriate navigation link is highlighted. It’s repeated throughout the component example. We keep adding some more example copy here to emphasize the scrolling and highlighting.  Keep in mind that the JavaScript plugin tries to pick the right element among all that may be visible. Multiple visible scrollspy targets at the same time may cause some issues.</p>
          #   </div>
          #   <div id="item-3-2">
          #   <h5>Item 3-2</h5>
          #   <p>This is some placeholder content for the scrollspy page. Note that as you scroll down the page, the appropriate navigation link is highlighted. It’s repeated throughout the component example. We keep adding some more example copy here to emphasize the scrolling and highlighting.  Keep in mind that the JavaScript plugin tries to pick the right element among all that may be visible. Multiple visible scrollspy targets at the same time may cause some issues.</p>
          #   </div>
          #   </div>
          #   </div>
          #   </div>'),
          tags$head(
            tags$script(
              "
document.addEventListener('shown.bs.tab', function (event) {
                                          const scrollSpy = bootstrap.ScrollSpy.getInstance(document.body);
                                          if (scrollSpy) {
                                            //scrollSpy.refresh();
                                          } else {
                                          console.log('1');
                                            new bootstrap.ScrollSpy(document.body, {
                                              target: '#scrollspy-nav',
                                              offset: 0
                                            });
                                          }
                                        });

                                          // Re-initialize ScrollSpy every time a tab is shown
                                      document.addEventListener('DOMContentLoaded', function () {
                                          const scrollSpy = bootstrap.ScrollSpy.getInstance(document.body);
                                          if (scrollSpy) {
                                            //scrollSpy.refresh();
                                          } else {
                                          console.log('1');
                                            new bootstrap.ScrollSpy(document.body, {
                                              target: '#scrollspy-nav',
                                              offset: 0
                                            });
                                          }
                                        });"
            )),

          # Scrollspy Nav

         # div( class="row",
            #   div( class="col-2",
         #div(style='',class = ' ms-2 p-3 d-flex flex-row',#shadow-sm glass-card

         div(style = 'padding-left:15%;height:100vh;',
             id = "scrollspy-content",
             `data-bs-spy` = "scroll",
             `data-bs-target` = "#scrollspy-nav",
             #`data-bs-offset` = "0",
             #tabindex = "0",
             style = "position: relative; overflow-y: auto; scroll-behavior: smooth;", # height: 100vh;

         tags$div( id = "intro",
                   h4('QoF definitions',class = 'border-bottom border-warning'),
                   tags$div(id = "item-1",
                            tags$h5("Stroke and Transient Ischaemic Attack (TIA)"),
                            tags$span("Number of patients with stroke or transient ischaemic attack (TIA).")
                   ),

                   tags$div(id = "item-2",
                            tags$h5("Atrial Fibrillation"),
                            tags$span("Number of patients with atrial fibrillation.")
                   ),

                   tags$div(id = "item-3",
                            tags$h5("Hypertension"),
                            tags$span("Number of patients with established hypertension.")
                   ),

                   tags$div(id = "item-4",
                            tags$h5("Coronary Heart Disease"),
                            tags$span("Number of patients with coronary heart disease.")
                   ),

                   tags$div(id = "item-5",
                            tags$h5("Chronic Kidney Disease"),
                            tags$span("Number of patients aged 18 years and over with chronic kidney disease (US National Kidney Foundation: Stage 3 to 5 CKD)."),
                            tags$div(id = "item-5-1",
                                     # tags$h5("Note 1"),
                                     tags$span("Inclusion in the register is based on estimated Glomerular Filtration Rate (eGFR), a measure of kidney function. People with CKD stages 3 to 5 have, by definition, less than 60% of their kidney function.")
                            ),
                            tags$div(id = "item-5-2",
                                     # tags$h5("Note 2"),
                                     tags$span(style='font-weight:bold;',"This register was removed from the QOF from 2014/15.")
                            ),
                            tags$div(id = "item-5-3",
                                     #tags$h5("Note 3"),
                                     tags$span(style='font-weight:bold;',"The CKD register was re-introduced in the QOF from 2022/23; the definition is consistent with the previous register.")
                            ),
                            # tags$div(id = "item-5-4",
                            #          #tags$h5("Note 4"),
                            #          tags$span("Number of patients aged 18 or over with CKD with classification of categories G3a to G5 (previously stage 3 to 5).")
                            # ),
                            tags$div(id = "item-5-5",
                                     #tags$h5("Note 5"),
                                     tags$span("This disease area applies to patients with category G3a, G3b, G4 and G5 CKD (eGFR<60 mL/min/1.73 m² confirmed with at least two separate readings over a three month period).")
                            ),
                            tags$div(id = "item-5-6",
                                     #tags$h5("Note 6"),
                                     tags$span("Patients with CKD stage G3 (eGFR 30-59 ml/min/1.73m2) have impaired kidney function. These patients can be further subdivided based on their eGFR as follows:\nCKD stage G3a: eGFR 45-59 ml/min/1.73m2\nCKD stage G3b: eGFR 30-44 ml/min/1.73m2")
                            )
                   ),

                   tags$div(id = "item-6",
                            tags$h5("Cancer"),
                            tags$span("Number of patients with a diagnosis of cancer, excluding non-melanotic skin cancers, from 1st April 2003."),
                            tags$div(id = "item-6-1",
                                     #tags$h5("Cancer - Note 1"),
                                     tags$span(style='font-weight:bold;',"Because of the date cut-off in the definition of this register, prevalence trends are obscured by the increase in the size of the register due to the cumulative accrual of new cancer cases onto practice registers with each passing year.")
                            )
                   ),

                   tags$div(id = "item-7",
                            tags$h5("Chronic Obstructive Pulmonary Disease (COPD)"),
                            tags$span("Number of patients with chronic obstructive pulmonary disease."),
                            tags$div(id = "item-7-1",
                                     # tags$h5("Note 1"),
                                     tags$span("For 2004/05 and 2005/06 QOF definitions did not allow patients to be on both asthma and COPD registers thus patients with a degree of reversible airway disease were not included on the COPD register. From 2006/07 the rules were revised to allow patients to be included on both COPD and asthma registers. Approximately 15% of patients with COPD will also have asthma. Any comparisons of COPD prevalence before and after this change in definition should be made with caution.")
                            )
                   ),

                   tags$div(id = "item-8",
                            tags$h5("Diabetes Mellitus"),
                            tags$span("Number of patients aged 17 years and over with diabetes mellitus (specified as type 1 or type 2 diabetes)."),
                            tags$div(id = "item-8-1",
                                     #  tags$h5("Note 1"),
                                     tags$span("Since April 2006, the definition includes all patients aged 17 years and over with diabetes mellitus defined by clinical (Read) codes specific to Type 1 or Type 2 diabetes. Previously there was a wider range of codes accepted under the definition, although the age constraint has remained consistent. The prevalence statistics for 2006/07 onwards are therefore not directly comparable with those for 2004/05 and 2005/06.")
                            ),
                            tags$div(id = "item-8-2",
                                     #   tags$h5("Note 2"),
                                     tags$span("Although the practice must record whether the patient has Type 1 or Type 2 diabetes, this level of detail is not collected centrally, therefore the register size cannot be disaggregated by type of diabetes.")
                            )
                   ),

                   tags$div(id = "item-9",
                            tags$h5("Dementia"),
                            tags$span("Number of patients diagnosed with dementia."),
                            tags$div(id = "item-9-1",
                                     # tags$h5("Note 1"),
                                     tags$span("This indicator applies to all people diagnosed with dementia either directly by the GP or through referral to secondary care.")
                            )
                   )
         )
         ),

             tags$nav(
                      id = "scrollspy-nav",
                      class = "nav flex-column align-items-stretch nav-pills position-absolute position-sticky float-left",
                      style = 'width:12vw; z-index:100; top:30vh; left:0%;',
                      `data-bs-spy` = "scroll",
                      `data-bs-target` = "#scrollspy-nav",
                      `data-bs-offset` = "0",
                      tabindex = "0",

                      tags$a(class = "nav-link active", href = "#intro", "Intro", `data-value` = "interactive"),

                      tags$a(class = "nav-link", href = "#stroke", "Stroke", `data-value` = "interactive"),

                      tags$div(class = "nav flex-row ms-3 my-1",
                               tags$a(class = "nav-link", href = "#stroke_age", icon('person-cane'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#stroke_sex", icon('venus-mars'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#stroke_trust", icon('globe'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#stroke_MDMquintile", icon('comments-dollar'), `data-value` = "interactive")
                      ),

                      tags$a(class = "nav-link", href = "#section2", "Atrial Fibrillation", `data-value` = "interactive"),
                      tags$div(class = "nav flex-row ms-3 my-1",
                               tags$a(class = "nav-link", href = "#atrial_fibrillation_age", icon('person-cane'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#atrial_fibrillation_sex", icon('venus-mars'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#atrial_fibrillation_trust", icon('globe'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#atrial_fibrillation_MDMquintile", icon('comments-dollar'), `data-value` = "interactive")
                      ),

                      tags$a(class = "nav-link", href = "#section3", "Hypertension", `data-value` = "interactive"),
                      tags$div(class = "nav flex-row ms-3 my-1",
                               tags$a(class = "nav-link", href = "#hypertension_age", icon('person-cane'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#hypertension_sex", icon('venus-mars'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#hypertension_trust", icon('globe'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#hypertension_MDMquintile", icon('comments-dollar'), `data-value` = "interactive")
                      ),

                      tags$a(class = "nav-link", href = "#section4", "CHD", `data-value` = "interactive"),
                      tags$div(class = "nav flex-row ms-3 my-1",
                               tags$a(class = "nav-link", href = "#chd_age", icon('person-cane'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#chd_sex", icon('venus-mars'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#chd_trust", icon('globe'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#chd_MDMquintile", icon('comments-dollar'), `data-value` = "interactive")
                      ),

                      tags$a(class = "nav-link", href = "#section5", "CKD", `data-value` = "interactive"),
                      tags$div(class = "nav flex-row ms-3 my-1",
                               tags$a(class = "nav-link", href = "#ckd_age", icon('person-cane'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#ckd_sex", icon('venus-mars'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#ckd_trust", icon('globe'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#ckd_MDMquintile", icon('comments-dollar'), `data-value` = "interactive")
                      ),
                      tags$a(class = "nav-link", href = "#section9", "Cancer", `data-value` = "interactive"),
                      tags$div(class = "nav flex-row ms-3 my-1",
                               tags$a(class = "nav-link", href = "#cancer_age", icon('person-cane'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#cancer_sex", icon('venus-mars'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#cancer_trust", icon('globe'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#cancer_MDMquintile", icon('comments-dollar'), `data-value` = "interactive")
                      ),

                      tags$a(class = "nav-link", href = "#section6", "Diabetes", `data-value` = "interactive"),
                      tags$div(class = "nav flex-row ms-3 my-1",
                               tags$a(class = "nav-link", href = "#diabetes_age", icon('person-cane'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#diabetes_sex", icon('venus-mars'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#diabetes_trust", icon('globe'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#diabetes_MDMquintile", icon('comments-dollar'), `data-value` = "interactive")
                      ),

                      tags$a(class = "nav-link", href = "#section8", "Dementia", `data-value` = "interactive"),
                      tags$div(class = "nav flex-row ms-3 my-1",
                               tags$a(class = "nav-link", href = "#dementia_age", icon('person-cane'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#dementia_sex", icon('venus-mars'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#dementia_trust", icon('globe'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#dementia_MDMquintile", icon('comments-dollar'), `data-value` = "interactive")
                      ),

                      tags$a(class = "nav-link", href = "#section7", "Heart Failure", `data-value` = "interactive"),
                      tags$div(class = "nav flex-row ms-3 my-1",
                               tags$a(class = "nav-link", href = "#heart_failure_age", icon('person-cane'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#heart_failure_sex", icon('venus-mars'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#heart_failure_trust", icon('globe'), `data-value` = "interactive"),
                               tags$a(class = "nav-link", href = "#heart_failure_MDMquintile", icon('comments-dollar'), `data-value` = "interactive")
                      )
               ),

               #
               #div(class = 'col-9',
                   #
                   # Scrollspy content container — requires height and overflow
                   div(style = 'padding-left:5%;',
                     id = "scrollspy-content",
                     `data-bs-spy` = "scroll",
                     `data-bs-target` = "#scrollspy-nav",
                     #`data-bs-offset` = "0",
                     #tabindex = "0",
                     style = "position: relative; overflow-y: auto; scroll-behavior: smooth;", # height: 100vh;



                     # Stroke Section,

                     #
                     #
                     div(id = "stroke", class = "pt-5", h2("Stroke")),
                     div(tbl, style = 'overflow:visible;width:70vw;padding-top:100px;padding-bottom:50px;font-size:0.7rem;'),
                     div(id = "stroke_age", class = "pt-5", h4("Age")),
                     stroke_age20,
                     div(id = "stroke_sex", class = "pt-5", h4("Sex")),
                     stroke_sex,
                     div(id = "stroke_trust", class = "pt-5", h4("Trust")),
                     stroke_HSCT,
                     div(id = "stroke_MDMquintile", class = "pt-5", h4("MDM Quintile")),
                     stroke_mdm_quintile,
                     #
                     div(id = "atrial_fibrillation", class = "pt-5", h2("Atrial Fibrillation")),
                     div(id = "atrial_fibrillation_age", class = "pt-5", h4("Age")),
                     atrial_fibrillation_age20,
                     div(id = "atrial_fibrillation_sex", class = "pt-5", h4("Sex")),
                     atrial_fibrillation_sex,
                     div(id = "atrial_fibrillation_trust", class = "pt-5", h4("Trust")),
                     atrial_fibrillation_HSCT,
                     div(id = "atrial_fibrillation_MDMquintile", class = "pt-5", h4("MDM Quintile")),
                     atrial_fibrillation_mdm_quintile,

                     div(id = "hypertension", class = "pt-5", h2("Hypertension")),
                     div(id = "hypertension_age", class = "pt-5", h4("Age")),
                     hypertension_age20,
                     div(id = "hypertension_sex", class = "pt-5", h4("Sex")),
                     hypertension_sex,
                     div(id = "hypertension_trust", class = "pt-5", h4("Trust")),
                     hypertension_HSCT,
                     div(id = "hypertension_MDMquintile", class = "pt-5", h4("MDM Quintile")),
                     hypertension_mdm_quintile,

                     div(id = "chd", class = "pt-5", h2("Coronary Heart Disease")),
                     div(id = "chd_age", class = "pt-5", h4("Age")),
                     chd_age20,
                     div(id = "chd_sex", class = "pt-5", h4("Sex")),
                     chd_sex,
                     div(id = "chd_trust", class = "pt-5", h4("Trust")),
                     chd_HSCT,
                     div(id = "chd_MDMquintile", class = "pt-5", h4("MDM Quintile")),
                     chd_mdm_quintile,

                     div(id = "ckd", class = "pt-5", h2("Chronic Kidney Disease")),
                     div(id = "ckd_age", class = "pt-5", h4("Age")),
                     chronic_kidney_disease_age20,
                     div(id = "ckd_sex", class = "pt-5", h4("Sex")),
                     chronic_kidney_disease_sex,
                     div(id = "ckd_trust", class = "pt-5", h4("Trust")),
                     chronic_kidney_disease_HSCT,
                     div(id = "ckd_MDMquintile", class = "pt-5", h4("MDM Quintile")),
                     chronic_kidney_disease_mdm_quintile,

                     div(id = "cancer", class = "pt-5", h2("Cancer")),
                     div(id = "cancer_age", class = "pt-5", h4("Age")),
                     lung_cancer_age20,
                     div(id = "cancer_sex", class = "pt-5", h4("Sex")),
                     lung_cancer_sex,
                     div(id = "cancer_trust", class = "pt-5", h4("Trust")),
                     lung_cancer_HSCT,
                     div(id = "cancer_MDMquintile", class = "pt-5", h4("MDM Quintile")),
                     lung_cancer_mdm_quintile,

                     div(id = "diabetes", class = "pt-5", h2("Diabetes")),
                     div(id = "diabetes_age", class = "pt-5", h4("Age")),
                     diabetes_age20,
                     div(id = "diabetes_sex", class = "pt-5", h4("Sex")),
                     diabetes_sex,
                     div(id = "diabetes_trust", class = "pt-5", h4("Trust")),
                     diabetes_HSCT,
                     div(id = "diabetes_MDMquintile", class = "pt-5", h4("MDM Quintile")),
                     diabetes_mdm_quintile,

                     div(id = "dementia", class = "pt-5", h2("Dementia")),
                     div(id = "dementia_age", class = "pt-5", h4("Age")),
                     dementia_age20,
                     div(id = "dementia_sex", class = "pt-5", h4("Sex")),
                     dementia_sex,
                     div(id = "dementia_trust", class = "pt-5", h4("Trust")),
                     dementia_HSCT,
                     div(id = "dementia_MDMquintile", class = "pt-5", h4("MDM Quintile")),
                     dementia_mdm_quintile,

                     div(id = "outro", class = "pt-5", h2("Notes")),
                     #
                   )
               #) #col
         # ) #row

)}
