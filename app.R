
library(shiny)
# library(shi18ny)

source("species.R")



ui <- tagList(
  #includeCSS("styles.css"),
  
  navbarPage(
    
    # inverse=TRUE,
    
    id = "navbar",
    
    # app title
    title = "Odonata Trends",
    
    tabPanel("Statistics",
             fluidPage(
               
               fluidRow(
                 
                 column(width = 3,
                        
                        # iDiv logo
                        img(src = paste(img_dir, "iDivLogo-short.jpg", sep="/"), height=36.61875, width=108),
                        br(), br(), 
                        
                        # select species
                        selectInput(inputId = "species",
                                    label = "Choose a species to display",
                                    choices = species_names,
                                    selected = "Aeshna affinis"),
                        
                        
                        # display trend classification
                        h5(textOutput(outputId = "trend")), 
                        # just to balance out the longer height on the right side
                        # h5(" ", style='display: inline'), #textOutput(), 
                        # br(),br(),
                        ),
                 
                 column(width = 3,
                        # dragon fly silhouette
                        br(), br(), 
                        img(src = paste(img_dir, "dragonfly_silhouette.jpg", sep="/"), height=134.765625, width=220.5484375),
                        ),
                 
                 column(width = 6,
                        br(), br(), 
                        # sliding bar for year
                        sliderInput(inputId = "year",
                                    label = "Year",
                                    min = 1990, max = 2016, value = 1990, step = 1, sep = "",
                                    animate = animationOptions(interval = 300,
                                                               playButton = icon('play', "fa-lg"),
                                                               pauseButton = icon('pause', "fa-lg"))
                                    ),
                        ),
                 
                 ),
               
               # line break
               # br(),
               hr(),
               
               fluidRow(
                 
                 column(width = 6,
                        # time series plot
                        #h5('Time Series'),
                        br(), br(),
                        #br(), br(), br(), 
                        plotOutput(outputId = "ts_plot")
                        # img(src = paste(ts_plots_dir, "Aeshna affinis_ts.png", sep="/"), height=400, width=500)
                        ),
                 
                 
                 column(width = 6,
                        # map tabs
                        #h5('Map', style='display: inline'),
                        tabsetPanel(
                          
                          tabPanel(
                            # map
                            title = "Estimate",
                            plotOutput(outputId = "estimate_map", height=545.455, width=500)
                            # img(src = paste(estimate_maps_dir, "Map_1990_Aeshna affinis.png", sep="/"), height=562.5, width=515.625)
                            
                          ),
                          
                          tabPanel(
                            # map
                            title = "Error",
                            plotOutput(outputId = "error_map", height=545.455, width=500)
                            ),
                          
                          tabPanel(
                            # map
                            title = "Data",
                            plotOutput(outputId = "data_map", height=545.455, width=500)
                          )
                          
                          ),
                        )
                 ),
               
               fluidRow(
                 hr(),
                 # info about the last update
                 helpText(paste0("Latest update on ", Sys.Date()))
                 )
               
               )
             ),
    
    tabPanel("About",
             
             fluidPage(
               
               fluidRow(
                 
                 column(3,
                        # iDiv logo
                        img(src = paste(img_dir, "iDivLogo-long-EN.jpg", sep="/"), height=74.671875, width=270),
                        # br(), br()
                        # select language
                        selectInput(inputId = "language",
                                    label = "",
                                    choices = c("EN", "DE"),
                                    selected = "EN",
                                    width = "40%"
                        )
                        ),
                 
                 column(4,
                        # dragonfly_silhouette
                        img(src = paste(img_dir, "dragonfly_silhouette.jpg", sep="/"), height=134.765625, width=220.5484375
                            # height=86.25, width=141.151
                            ),
                        ),
                 
                 
                 column(5,
                        # sMon logo
                        img(src = paste(img_dir, "sMon Logo_transparent.png", sep="/"), height=90.46638, width=321.84),
                        # br(), br()
                        ),
                 
                 ),
               
               fluidRow(
                 
                 column(7,
                        h5(textOutput(outputId = "sMon1")),
                        textOutput(outputId = "sMon2"), 
                        br(),
                        textOutput(outputId = "sMon3", inline=T), a("idiv.de/smon", href="https://www.idiv.de/en/smon.html", target="_blank"),
                        br(),
                        br(),
                        h5(textOutput(outputId = "Data1")),
                        textOutput(outputId = "Data2"),
                        br(),
                        # br(),
                        h5(textOutput(outputId = "Methods1")),
                        textOutput(outputId = "Methods2"),
                        br(),
                        textOutput(outputId = "Methods3", inline=T), a("https://onlinelibrary.wiley.com/doi/10.1111/ddi.13274", href="https://onlinelibrary.wiley.com/doi/10.1111/ddi.13274", target="_blank"),
                        br(),
                        br(), hr(),
                        textOutput(outputId = "Comment", inline=T), a("diana.bowler@idiv.de", href="mailto:diana.bowler@idiv.de")
                        ),
                 
                 column(5,
                        # sMon picture
                        img(src = paste(img_dir, "csm_Deutschland_Biodiv_f430e72d7c.png", sep="/"), height=480, width=357.6)
                        )
                 
                 )
               )
             )
    )
  )








server <- function(input, output) {
  output$ts_plot <- renderImage({
    filename <- normalizePath(file.path(ts_plots_dir, paste(input$species, '.png', sep='_ts')))
    list(src = filename,
         width = 500,
         height = 400)
    }, deleteFile = FALSE)
  
  output$estimate_map <- renderImage({
    filename <- normalizePath(file.path(estimate_maps_dir, paste0("Map_", input$year, "_", input$species, '.png')))
    list(src = filename,
         width = 500,
         height = 545.455)
    }, deleteFile = FALSE)
  
  output$error_map <- renderImage({
    filename <- normalizePath(file.path(error_maps_dir, paste0("Map_error_", input$year, "_", input$species, '.png')))
    list(src = filename,
         width = 500,
         height = 545.455)
  }, deleteFile = FALSE)
  
  output$trend <- renderText({
    paste("Trend classification:", 
          (Datafile_1_Traits_and_trends %>% filter(Species == input$species))$trend_classification)
    })
  
  output$sMon1 <- renderText({
    if (input$language == "EN") {
      "sMon project"
    } else {"sMon Projekt"}
  })
  output$sMon2 <- renderText({
    if (input$language == "EN") {
      "sMon is a Synthesis Project of the German Centre for Integrative Biodiversity Research (iDiv) Halle-Jena-Leipzig. We aim at combining and harmonizing exemplary datasets of different taxa and habitats and to evaluate the potentials and limits for analyzing changes in the state of biodiversity in Germany."
    } else {"sMon ist ein Syntheseprojekt des Deutschen Zentrums für integrative Biodiversitätsforschung (iDiv) Halle-Jena-Leipzig. Unser Ziel ist es, exemplarische Datensätze verschiedener Taxa und Lebensräume zu kombinieren und zu harmonisieren und die Möglichkeiten und Grenzen für die Analyse von Veränderungen des Zustands der Biodiversität in Deutschland zu bewerten."}
  })
  output$sMon3 <- renderText({
    if (input$language == "EN") {
      "For more information, see"
    } else {"Weitere Informationen finden Sie unter"}
  })
  
  output$Data1 <- renderText({
    if (input$language == "EN") {
      "Data"
    } else {"Daten"}
  })
  output$Data2 <- renderText({
    if (input$language == "EN") {
      "Occurrence data for Odonata were made available by partners across Germany. We are especially thankful for collaboration with members of the GdO – the German-speaking dragonfly society."
    } else {"Die Daten über das Vorkommen von Odonata wurden von Partnern aus ganz Deutschland zur Verfügung gestellt. Besonders dankbar sind wir für die Zusammenarbeit mit den Mitgliedern der GdO - der Gesellschaft der deutschsprachigen Libellen."}
  })
  
  output$Methods1 <- renderText({
    if (input$language == "EN") {
      "Methods"
    } else {"Methoden"}
  })
  output$Methods2 <- renderText({
    if (input$language == "EN") {
      "We analyzed the data using occupancy-detection models. They aim to model variation in the data including sampling effort. To produce the spatial maps, we used generalized additive models for the occupancy process."
    } else {"Wir analysierten die Daten mit Hilfe von Modellen zur Erfassung der Belegung. Sie zielen darauf ab, Variationen in den Daten einschließlich des Stichprobenaufwands zu modellieren. Zur Erstellung der räumlichen Karten verwendeten wir verallgemeinerte additive Modelle für den Besetzungsprozess."}
  })
  output$Methods3 <- renderText({
    if (input$language == "EN") {
      "Published article here:"
    } else {"Veröffentlichter Artikel hier:"}
  })
  
  output$Comment <- renderText({
    if (input$language == "EN") {
      "Comments can be directed to:"
    } else {"Kommentare können gerichtet werden an:"}
  })
  
  }


shinyApp(ui = ui, server = server)
