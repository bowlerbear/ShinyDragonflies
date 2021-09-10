tabPanel("About",
         
         fluidPage(
           
           fluidRow(
             
             column(7,
                    # iDiv logo
                    img(src = paste(img_dir, "iDivLogo-long-EN.jpg", sep="/"), height=74.671875, width=270),
                    br(), br(),
                    h5("sMon project"),
                    "sMon is a Synthesis Project of the German Centre for Integrative Biodiversity Research (iDiv) Halle-Jena-Leipzig. We aim at combining and harmonizing exemplary datasets of different taxa and habitats and to evaluate the potentials and limits for analyzing changes in the state of biodiversity in Germany.", 
                    br(),
                    "For more information, see", a("idiv.de/smon", href="https://www.idiv.de/en/smon.html", target="_blank"),
                    br(),
                    br(),
                    h5("Data"),
                    "Occurrence data for Odonata were made available by partners across Germany. We are especially thankful for collaboration with members of the GdO – the German-speaking dragonfly society.",
                    br(),
                    br(),
                    h5("Methods"),
                    "We analyzed the data using occupancy-detection models. They aim to model variation in the data including sampling effort. To produce the spatial maps, we used generalized additive models for the occupancy process.",
                    br(),
                    "Published article here:", a("https://onlinelibrary.wiley.com/doi/10.1111/ddi.13274", href="https://onlinelibrary.wiley.com/doi/10.1111/ddi.13274", target="_blank"),
                    br(),
                    br(), hr(),
                    "Comments can be directed to:", a("diana.bowler@idiv.de", href="mailto:diana.bowler@idiv.de")
             ),
             
             column(5,
                    # sMon logo
                    img(src = paste(img_dir, "sMon Logo_transparent.png", sep="/"), height=90.46638, width=321.84),
                    br(), br(), 
                    # sMon picture
                    img(src = paste(img_dir, "csm_Deutschland_Biodiv_f430e72d7c.png", sep="/"), height=480, width=357.6)
             )
             
           )
         )
)