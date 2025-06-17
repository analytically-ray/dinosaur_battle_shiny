## BEGIN ####
library(shiny)
library(htmltools)
library(plotly)
library(dplyr)

## DINO DATABASE ####
dino_db <- list(
  "Acrocanthosaurus" = list(
    facts = "A powerful apex predator with high endurance and strength, but limited agility and speed.",
    strength = 8, speed = 5, ferocity = 7, intelligence = 5, agility = 4, stamina = 7,
    countries = c("USA"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Acrocanthosaurus_UDL.png/960px-Acrocanthosaurus_UDL.png"
  ),
  
  "Albertosaurus" = list(
    facts = "A fast and agile tyrannosaurid, well-rounded in attack and stamina, but average in intelligence.",
    strength = 7, speed = 8, ferocity = 7, intelligence = 5, agility = 7, stamina = 7,
    countries = c("Canada"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Albertosaurus_UDL.png/960px-Albertosaurus_UDL.png"
  ),
  
  "Allosaurus" = list(
    facts = "A top predator of its time with balanced physical traits, though not specialized in any one area.",
    strength = 7, speed = 7, ferocity = 7, intelligence = 5, agility = 6, stamina = 6,
    countries = c("USA", "Portugal"),  # Also found in Tanzania
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Allosaurus_UDL.png/960px-Allosaurus_UDL.png"
  ),
  
  "Ankylosaurus" = list(
    facts = "Heavily armored and strong with high stamina, but slow and lacking agility.",
    strength = 8, speed = 3, ferocity = 4, intelligence = 4, agility = 2, stamina = 8,
    countries = c("USA", "Canada"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Ankylosaurus_UDL.png/960px-Ankylosaurus_UDL.png"
  ),
  
  "Brachiosaurus" = list(
    facts = "Massive and enduring herbivore, peaceful by nature but slow and unintelligent.",
    strength = 7, speed = 2, ferocity = 2, intelligence = 4, agility = 2, stamina = 9,
    countries = c("USA", "Tanzania"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Brachiosaurus_UDL.png/960px-Brachiosaurus_UDL.png"
  ),
  
  "Carnotaurus" = list(
    facts = "A swift predator with excellent speed and agility, but lighter in strength and endurance.",
    strength = 6, speed = 9, ferocity = 6, intelligence = 5, agility = 8, stamina = 5,
    countries = c("Argentina"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Carnotaurus_UDL.png/960px-Carnotaurus_UDL.png"
  ),
  
  "Compsognathus" = list(
    facts = "One of the smallest known dinosaurs, extremely fast and agile but low in strength and endurance.",
    strength = 2, speed = 10, ferocity = 3, intelligence = 5, agility = 9, stamina = 3,
    countries = c("Germany", "France"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Compsognathus_UDL.png/960px-Compsognathus_UDL.png"
  ),
  
  "Dilophosaurus" = list(
    facts = "Lightly built, fast, and agile hunter known for the distinctive twin crests on its head. Likely a scavenger and opportunistic predator, it relied on speed rather than brute force.",
    strength = 5, speed = 9, ferocity = 4, intelligence = 6, agility = 8, stamina = 6,
    countries = c("USA"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Dilophosaurus_UDL.png/960px-Dilophosaurus_UDL.png"
  ),
  
  "Dreadnoughtus" = list(
    facts = "One of the largest land animals ever, Dreadnoughtus had immense strength and stamina, but was extremely slow and not agile.",
    strength = 9, speed = 2, ferocity = 2, intelligence = 3, agility = 1, stamina = 9,
    countries = c("Argentina"),
    image = "https://upload.wikimedia.org/wikipedia/commons/6/6c/Dreadnoughtus_NT_small.jpg"
  ),
  
  "Giganotosaurus" = list(
    facts = "Massive and strong with high ferocity, though not as agile or fast as smaller theropods.",
    strength = 9, speed = 6, ferocity = 8, intelligence = 4, agility = 5, stamina = 7,
    countries = c("Argentina"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/Giganotosaurus_carolinii_colored_pencil_drawing.jpg/330px-Giganotosaurus_carolinii_colored_pencil_drawing.jpg"
  ),
  
  "Gigantspinosaurus" = list(
    facts = "Well-armored stegosaur with decent strength and stamina but poor speed and agility.",
    strength = 6, speed = 3, ferocity = 4, intelligence = 4, agility = 3, stamina = 6,
    countries = c("China"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Gigantspinosaurus_sichuanensis.png/330px-Gigantspinosaurus_sichuanensis.png"
  ),
  
  "Herrerasaurus" = list(
    facts = "A primitive, muscular predator from South America with high agility and surprising strength for its size.",
    strength = 7, speed = 8, ferocity = 6, intelligence = 4, agility = 8, stamina = 6,
    countries = c("Argentina"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Herrerasaurus_UDL.png/960px-Herrerasaurus_UDL.png"
  ),
  
  "Liliensternus" = list(
    facts = "A sleek and agile European theropod, one of the earliest large carnivores in its ecosystem.",
    strength = 6, speed = 8, ferocity = 6, intelligence = 5, agility = 9, stamina = 5,
    countries = c("Germany"),
    image = "https://upload.wikimedia.org/wikipedia/commons/0/0b/Liliensternus.jpg"
  ),
  
  "Megalosaurus" = list(
    facts = "Early theropod with balanced traits, moderately strong and agile but not exceptional.",
    strength = 7, speed = 6, ferocity = 6, intelligence = 5, agility = 5, stamina = 6,
    countries = c("UK"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Megalosaurus_UDL.png/960px-Megalosaurus_UDL.png"
  ),
  
  "Micropachycephalosaurus" = list(
    facts = "A tiny herbivore with limited strength and intelligence, but nimble and likely quick-moving.",
    strength = 3, speed = 7, ferocity = 2, intelligence = 4, agility = 6, stamina = 4,
    countries = c("China"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/MicropachycephalosaurusMinorRs.png/330px-MicropachycephalosaurusMinorRs.png"
  ),
  
  "Pachycephalosaurus" = list(
    facts = "Head-butting herbivore with moderate speed and stamina, but low ferocity and intelligence.",
    strength = 6, speed = 6, ferocity = 4, intelligence = 4, agility = 5, stamina = 6,
    countries = c("USA", "Canada"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Pachycephalosaurus_UDL.png/330px-Pachycephalosaurus_UDL.png"
  ),
  
  "Spinosaurus" = list(
    facts = "A massive semi-aquatic predator with immense strength and ferocity, but sluggish on land.",
    strength = 9, speed = 4, intelligence = 5, agility = 5, ferocity = 9, stamina = 6,
    countries = c("Egypt", "Morocco", "Tunisia", "Niger", "Algeria", "Libya"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Spinosaurus_UDL.png/960px-Spinosaurus_UDL.png"
  ),
  
  "Stegosaurus" = list(
    facts = "Defensive herbivore with strong stamina and a spiked tail, but low intelligence and speed.",
    strength = 7, speed = 3, intelligence = 2, agility = 3, ferocity = 4, stamina = 8,
    countries = c("USA", "Portugal"),  # Also found in UK
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Stegosaurus_UDL.png/960px-Stegosaurus_UDL.png"
  ),
  
  "Therizinosaurus" = list(
    facts = "A bizarre herbivore with enormous claws, above-average intelligence, but slow and passive.",
    strength = 6, speed = 4, ferocity = 3, intelligence = 6, agility = 4, stamina = 6,
    countries = c("Mongolia"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Therizinosaurus.png/330px-Therizinosaurus.png"
  ),
  
  "Triceratops" = list(
    facts = "Formidable herbivore with high strength and stamina, using its horns to fend off predators.",
    strength = 9, speed = 4, intelligence = 4, agility = 3, ferocity = 6, stamina = 9,
    countries = c("USA", "Canada"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Triceratops_UDL.png/960px-Triceratops_UDL.png"
  ),
  
  "Tyrannosaurus Rex" = list(
    facts = "One of the most powerful predators ever with unmatched strength and ferocity, but not very agile.",
    strength = 10, speed = 6, intelligence = 5, agility = 4, ferocity = 10, stamina = 8,
    countries = c("USA", "Canada"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Tyrannosaurus_UDL.png/960px-Tyrannosaurus_UDL.png"
  ),
  
  "Tylosaurus" = list(
    facts = "Dominant marine predator with impressive speed and agility, strong in the water but vulnerable on land.",
    strength = 8, speed = 9, ferocity = 7, intelligence = 6, agility = 7, stamina = 7,
    countries = c("USA", "Canada"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Tylosaurus_pembinensis_1DB.jpg/330px-Tylosaurus_pembinensis_1DB.jpg"
  ),
  
  "Velociraptor" = list(
    facts = "Small but extremely fast, agile, and intelligent hunter that relied on strategy over strength.",
    strength = 4, speed = 10, intelligence = 8, agility = 10, ferocity = 6, stamina = 5,
    countries = c("Mongolia", "China"),
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Velociraptor_UDL.png/960px-Velociraptor_UDL.png"
  )
)

## UI ####
ui <- fluidPage(
  tags$style(HTML("
    body {
      font-family: Arial, sans-serif;
      font-size: 18px;  /* sets base font size for everything */
    }
  ")),
  titlePanel("Who Would Win? Dinosaur Battle Royale 🦖 ⚔️ 🦕"),
  sidebarLayout(
    sidebarPanel(
      tags$audio(
        src = "https://ia801504.us.archive.org/27/items/JurassicParkThemeSong./Jurassic%20Park%20theme%20song..mp3", 
        type = "audio/ogg",
        autoplay = NA,
        loop = NA,
        controls = NA),
      selectInput("dino1", "Choose Dinosaur 1:", choices = names(dino_db), selected="Tyrannosaurus Rex"),
      selectInput("dino2", "Choose Dinosaur 2:", choices = names(dino_db), selected="Triceratops"),
      actionButton("start", "Begin Battle!"),
      uiOutput("dino_info")
    ),
    mainPanel(
      uiOutput("main_panel_content")
    )
  )
)

## SERVER ####
server <- function(input, output, session) {
  
  
  # Track battle mode
  battle_started <- reactiveVal(FALSE)
  
  state <- reactiveValues(
    dino1 = NULL, dino2 = NULL,
    hp1 = 100, hp2 = 100,
    round = 0,
    log = "",
    turn = 0,
    step = 0,
    winner = NULL,
    stats1 = NULL, stats2 = NULL
  )
  
  observeEvent(input$start, {
    state$dino1 <- input$dino1
    state$dino2 <- input$dino2
    state$hp1 <- 100
    state$hp2 <- 100
    state$round <- 1
    state$turn <- 1
    state$step <- 0
    state$log <- paste0("<p><b>The battle begins between ", input$dino1, " and ", input$dino2, "!</b></p>")
    state$winner <- NULL
    state$stats1 <- dino_db[[input$dino1]]
    state$stats2 <- dino_db[[input$dino2]]
    
    battle_started(TRUE)
  })
  
  observeEvent(input$reset_btn, {
    # Reset state values
    state$dino1 <- input$dino1
    state$dino2 <- input$dino2
    state$hp1 <- 100
    state$hp2 <- 100
    state$round <- 1
    state$step <- 0
    state$turn <- 0
    state$winner <- NULL
    state$log <- ""
    
    # Reset the battle status so plot shows again
    battle_started(FALSE)
    
    # Also reset selected dinosaurs (UI dropdowns)
    updateSelectInput(session, "dino1", selected = "")
    updateSelectInput(session, "dino2", selected = "")
  })
  
  # Reset on dinosaur change
  observeEvent(c(input$player_dino, input$opponent_dino), {
    battle_started(FALSE)
  })
  
  ## BATTLE LOG ####
  observe({
    req(state$turn > 0, is.null(state$winner))
    invalidateLater(1000, session)  # 1s pause between steps
    
    isolate({
      d1 <- state$dino1
      d2 <- state$dino2
      s1 <- state$stats1
      s2 <- state$stats2
      
      # Alternate storytelling steps per round
      if (state$step == 0) {
        state$attacker_first <- sample(c(TRUE, FALSE), 1, 
                                       prob=c(s1$speed/(s1$speed+s2$speed),s2$speed/(s1$speed+s2$speed)))
        state$log <- paste0(state$log, "<p><b>Round ", state$round, "</b> – ",
                            if (state$attacker_first) paste0(state$dino1, " goes first!") else paste0(state$dino2, " goes first!"), "</p>")
        state$step <- 1
      }
      if (state$step == 1) {
        if (state$attacker_first) {
          dmg <- round(
            ( runif(1, 1, 10) + s1$strength * 1.0 + s1$ferocity * runif(1, 0.5, 0.8) +
                s1$intelligence * 0.3 + s1$agility * 0.3 )*(1-state$round*((10-s1$stamina)/100)))
          state$hp2 <- max(0, state$hp2 - dmg)
          state$log <- paste0(state$log, "<p>🦖 ", d1, " attacks ", d2, " for <b>", dmg, "</b> damage!</p>")
        } else {
          dmg <- round(
            ( runif(1, 1, 10) + s2$strength * 1.0 + s2$ferocity * runif(1, 0.5, 0.8) +
                s2$intelligence * 0.3 + s2$agility * 0.3 )*(1-state$round*((10-s2$stamina)/100)))
          state$hp1 <- max(0, state$hp1 - dmg)
          state$log <- paste0(state$log, "<p>🦕 ", d2, " attacks ", d1, " for <b>", dmg, "</b> damage!</p>")
        }
        state$step <- 2
      } else if (state$step == 2 && state$hp1 > 0 && state$hp2 > 0) {
        if (state$attacker_first) {
          dmg <- round(
            ( runif(1, 1, 10) + s2$strength * 1.0 + s2$ferocity * runif(1, 0.5, 0.8) +
                s2$intelligence * 0.3 + s2$agility * 0.3 )*(1-state$round*((10-s2$stamina)/100)))
          state$hp1 <- max(0, state$hp1 - dmg)
          state$log <- paste0(state$log, "<p>🦕 ", d2, " counters and hits ", d1, " for <b>", dmg, "</b> damage!</p>")
        } else {
          dmg <- round(
            ( runif(1, 1, 10) + s1$strength * 1.0 + s1$ferocity * runif(1, 0.5, 0.8) +
                s1$intelligence * 0.3 + s1$agility * 0.3 )*(1-state$round*((10-s1$stamina)/100)))
          state$hp2 <- max(0, state$hp2 - dmg)
          state$log <- paste0(state$log, "<p>🦖 ", d1, " counters and hits ", d2, " for <b>", dmg, "</b> damage!</p>")
        }
        state$step <- 3
      }
      else {
        if (state$hp1 <= 0 && state$hp2 <= 0) {
          state$winner <- "🤝 It's a draw! Both dinosaurs collapse!"
        } else if (state$hp1 <= 0) {
          state$winner <- paste0("🏆 ", d2, " wins!")
        } else if (state$hp2 <= 0) {
          state$winner <- paste0("🏆 ", d1, " wins!")
        }
        
        if (is.null(state$winner)) {
          state$step <- 0
          state$round <- state$round + 1
        }
      }
    })
  })
  
  ## MAIN PANEL ####
  output$main_panel_content <- renderUI({
    req(input$dino1, input$dino2)
    
    if (!battle_started()) {
      tagList(
        plotlyOutput("combined_stats_plot"),
        div(
          style = "text-align: left; max-width: 600px; margin: 0 auto 0 0;",
          plotlyOutput("dino_map", width = "100%", height = "350px")
        )
      )
      
    } else {
      tagList(  # replaces with battle panel only after battle starts
        uiOutput("hp_bars"),
        uiOutput("battle_log"),
        h3(textOutput("winner")),
        uiOutput("reset_button")
      )
    }
  })
  
  ## PLOTLY STATS ####
  output$combined_stats_plot <- renderPlotly({
    req(input$dino1, input$dino2)
    
    categories <- c("strength", "speed", "ferocity", "intelligence", "agility", "stamina")
    
    stats1 <- as.numeric(dino_db[[input$dino1]][categories])
    stats2 <- as.numeric(dino_db[[input$dino2]][categories])
    
    # Custom tooltips
    text1 <- paste0(input$dino1, "<br>", categories, ": ", stats1)
    text2 <- paste0(input$dino2, "<br>", categories, ": ", stats2)
    
    plot_ly() %>%
      add_trace(
        x = categories,
        y = as.numeric(stats1[1:6]),
        type = 'bar',
        name = input$dino1,
        marker = list(color = 'darkgreen'),
        text = stats1,
        hovertext = text1,
        hoverinfo = "text"
      ) %>%
      add_trace(
        x = categories,
        y = as.numeric(stats2[1:6]),
        type = 'bar',
        name = input$dino2,
        marker = list(color = 'purple'),
        text = stats2,
        hovertext = text2,
        hoverinfo = "text"
      ) %>%
      layout(
        title = list(text=paste0(input$dino1," vs ",input$dino2,": Dinosaur Statistics"),
                     font = list(size=18),
                     x = 0,
                     xanchor = 'left'),
        barmode = 'group',
        yaxis = list(range = c(0, 10)),
        showlegend = FALSE
      )
  })
  
  ## DINO MAP ####
  output$dino_map <- renderPlotly({
    req(input$dino1, input$dino2)
    
    # Get countries by dino
    countries1 <- dino_db[[input$dino1]]$countries
    countries2 <- dino_db[[input$dino2]]$countries
    
    all_countries <- unique(c(countries1, countries2))
    
    country_df <- data.frame(
      country = all_countries,
      group = sapply(all_countries, function(cty) {
        if (cty %in% countries1 && cty %in% countries2) {
          "Both"
        } else if (cty %in% countries1) {
          input$dino1
        } else {
          input$dino2
        }
      }),
      stringsAsFactors = FALSE
    )
    
    # Assign numeric z-values for the choropleth
    country_df$value <- as.numeric(factor(country_df$group, levels = c(input$dino1, input$dino2, "Both")))
    
    # ISO3 codes for plotly mapping
    country_df$iso3 <- countrycode::countrycode(country_df$country, "country.name", "iso3c")
    
    # Manual color scale: Dino1 (green), Dino2 (purple), Both (brown)
    custom_colorscale <- list(
      list(0, "darkgreen"),
      list(0.5, "purple"),
      list(1, "554422")
    )
    
    plot_ly() %>%
      add_trace(
        type = 'choropleth',
        locations = country_df$iso3,
        z = country_df$value,
        text = paste0(country_df$country, ": ", country_df$group),
        hoverinfo = "text",
        colorscale = custom_colorscale,
        zmin = 1,
        zmax = 3,
        showscale = FALSE,
        marker = list(
          line = list(
            color = 'black',    # outline color here
            width = 0.5         # outline width (thickness)
          )
        )
      ) %>%
      layout(
        geo = list(
          showframe = FALSE,
          projection = list(type = 'natural earth')
        ),
        title = list(
          text = paste("Countries Where", input$dino1, "and", input$dino2, "Were Found"),
          font = list(size=18),
          x = 0,  # x=0 means left align the title
          xanchor = 'left'
        )
      )
  })
  
  output$battle_log <- renderUI({
    HTML(state$log)
  })
  
  ## HP BARS ####
  output$hp_bars <- renderUI({
    req(state$dino1, state$dino2)
    tagList(
      tags$div(style = "margin-top:20px;",
               tags$b(state$dino1), ": ", state$hp1, " HP",
               tags$div(style = "background:#ddd; height:20px; width:100%;",
                        tags$div(style = paste0("background:red; height:100%; width:", state$hp1, "%;")))),
      tags$div(style = "margin-top:10px;",
               tags$b(state$dino2), ": ", state$hp2, " HP",
               tags$div(style = "background:#ddd; height:20px; width:100%;",
                        tags$div(style = paste0("background:blue; height:100%; width:", state$hp2, "%;"))))
    )
  })
  
  output$winner <- renderText({ state$winner })
  
  ## RESET BUTTON ####
  output$reset_button <- renderUI({
    tagList(
      if (!is.null(state$winner)) {
        tagList(
          actionButton("reset_btn", "🔁 Reset Fight", class = "btn btn-danger mt-3")
        )
      }
    )
  })
  
  ## DINO DETAILS ####
  output$dino_info <- renderUI({
    req(input$dino1, input$dino2)
    
    hp1 <- state$hp1
    hp2 <- state$hp2
    
    base_height <- 150
    
    red_opacity1 <- round((1 - hp1 / 100) * 0.4, 2)
    red_opacity2 <- round((1 - hp2 / 100) * 0.4, 2)
    
    red_overlay1 <- if (hp1 == 0) {
      "background-color: rgba(0.8,0.8,0.8,0.8);"  # full black at zero HP
    } else {
      paste0("background-color: rgba(139,0,0,", red_opacity1, ");")
    }
    
    red_overlay2 <- if (hp2 == 0) {
      "background-color: rgba(0.8,0.8,0.8,0.8);"  # full black at zero HP
    } else {
      paste0("background-color: rgba(139,0,0,", red_opacity2, ");")
    }
    
    tagList(
      tags$div(style = "border-right: 20px solid darkgreen; background-color: #e6f4ea; padding-left: 10px; margin-bottom: 20px;",
               h4(input$dino1),
               tags$div(style = "position: relative; display: inline-block;",
                        tags$img(src = dino_db[[input$dino1]]$image,
                                 height = paste0(base_height, "px")),
                        tags$div(style = paste0("position: absolute; top: 0; left: 0; width: 100%; height: 100%; ",
                                                red_overlay1))
               ),
               p(dino_db[[input$dino1]]$facts)
      ),
      
      tags$div(style = "border-right: 20px solid purple; background-color: #f3e6fa; padding-left: 10px;",
               h4(input$dino2),
               tags$div(style = "position: relative; display: inline-block;",
                        tags$img(src = dino_db[[input$dino2]]$image,
                                 height = paste0(base_height, "px")),
                        tags$div(style = paste0("position: absolute; top: 0; left: 0; width: 100%; height: 100%; ",
                                                red_overlay2))
               ),
               p(dino_db[[input$dino2]]$facts)
      )
    )
  })
}

shinyApp(ui, server)
## END ####