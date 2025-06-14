library(shiny)
library(htmltools)

# Dino database
dino_db <- list(
  "Acrocanthosaurus" = list(
    facts = "A powerful apex predator with high endurance and strength, but limited agility and speed.",
    strength = 8, speed = 5, ferocity = 7, intelligence = 5, agility = 4, stamina = 7,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Acrocanthosaurus_atokensis.png/330px-Acrocanthosaurus_atokensis.png"
  ),
  
  "Albertosaurus" = list(
    facts = "A fast and agile tyrannosaurid, well-rounded in attack and stamina, but average in intelligence.",
    strength = 7, speed = 8, ferocity = 7, intelligence = 5, agility = 7, stamina = 7,
    image = "https://upload.wikimedia.org/wikipedia/commons/9/94/Albertosaurus_NT_small.jpg"
  ),
  
  "Allosaurus" = list(
    facts = "A top predator of its time with balanced physical traits, though not specialized in any one area.",
    strength = 7, speed = 7, ferocity = 7, intelligence = 5, agility = 6, stamina = 6,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Allosaurus_anax.png/330px-Allosaurus_anax.png"
  ),
  
  "Ankylosaurus" = list(
    facts = "Heavily armored and strong with high stamina, but slow and lacking agility.",
    strength = 8, speed = 3, ferocity = 4, intelligence = 4, agility = 2, stamina = 8,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Ankylosaurus_magniventris_reconstruction.png/330px-Ankylosaurus_magniventris_reconstruction.png"
  ),
  
  "Brachiosaurus" = list(
    facts = "Massive and enduring herbivore, peaceful by nature but slow and unintelligent.",
    strength = 7, speed = 2, ferocity = 2, intelligence = 4, agility = 2, stamina = 9,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Brachiosaurus_altithorax_side_profile.png/330px-Brachiosaurus_altithorax_side_profile.png"
  ),
  
  "Carnotaurus" = list(
    facts = "A swift predator with excellent speed and agility, but lighter in strength and endurance.",
    strength = 6, speed = 9, ferocity = 6, intelligence = 5, agility = 8, stamina = 6,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Carnotaurus_life_restoration_%28mirrored%29.jpg/330px-Carnotaurus_life_restoration_%28mirrored%29.jpg"
  ),
  
  "Dilophosaurus" = list(
    facts = "Lightly built, fast, and agile hunter known for the distinctive twin crests on its head. Likely a scavenger and opportunistic predator, it relied on speed rather than brute force.",
    strength = 5, speed = 9, ferocity = 5, intelligence = 6, agility = 8, stamina = 5,
    image = "https://upload.wikimedia.org/wikipedia/commons/5/59/Dilophosaurus_Walking.gif"
  ),
  
  "Giganotosaurus" = list(
    facts = "Massive and strong with high ferocity, though not as agile or fast as smaller theropods.",
    strength = 9, speed = 6, ferocity = 8, intelligence = 5, agility = 5, stamina = 7,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/Giganotosaurus_carolinii_colored_pencil_drawing.jpg/330px-Giganotosaurus_carolinii_colored_pencil_drawing.jpg"
  ),
  
  "Gigantspinosaurus" = list(
    facts = "Well-armored stegosaur with decent strength and stamina but poor speed and agility.",
    strength = 6, speed = 3, ferocity = 4, intelligence = 4, agility = 3, stamina = 6,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Gigantspinosaurus_sichuanensis.png/330px-Gigantspinosaurus_sichuanensis.png"
  ),
  
  "Herrerasaurus" = list(
    facts = "An early, agile predator known for its speed and mobility but limited size and stamina.",
    strength = 6, speed = 8, ferocity = 6, intelligence = 5, agility = 8, stamina = 6,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/86/Herrerasaurus_ischigualastensis_Illustration.jpg/330px-Herrerasaurus_ischigualastensis_Illustration.jpg"
  ),
  
  "Megalosaurus" = list(
    facts = "Early theropod with balanced traits, moderately strong and agile but not exceptional.",
    strength = 7, speed = 6, ferocity = 6, intelligence = 5, agility = 5, stamina = 6,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/1824_-_Megalosaurus.png/330px-1824_-_Megalosaurus.png"
  ),
  
  "Pachycephalosaurus" = list(
    facts = "Head-butting herbivore with moderate speed and stamina, but low ferocity and intelligence.",
    strength = 6, speed = 6, ferocity = 4, intelligence = 4, agility = 5, stamina = 6,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Pachycephalosaurus_Reconstruction.jpg/330px-Pachycephalosaurus_Reconstruction.jpg"
  ),
  
  "Spinosaurus" = list(
    facts = "A massive semi-aquatic predator with immense strength and ferocity, but sluggish on land.",
    strength = 9, speed = 5, intelligence = 5, agility = 5, ferocity = 9, stamina = 6,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Spinosaurus_Model.png/330px-Spinosaurus_Model.png"
  ),
  
  "Stegosaurus" = list(
    facts = "Defensive herbivore with strong stamina and a spiked tail, but low intelligence and speed.",
    strength = 7, speed = 3, intelligence = 2, agility = 3, ferocity = 4, stamina = 8,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Stegosaurus_stenops_Life_Reconstruction_%28flipped%29.png/330px-Stegosaurus_stenops_Life_Reconstruction_%28flipped%29.png"
  ),
  
  "Therizinosaurus" = list(
    facts = "A bizarre herbivore with enormous claws, above-average intelligence, but slow and passive.",
    strength = 6, speed = 4, ferocity = 4, intelligence = 6, agility = 4, stamina = 6,
    image = "https://upload.wikimedia.org/wikipedia/commons/7/71/Nothronychus_BW2.jpg"
  ),
  
  "Triceratops" = list(
    facts = "Formidable herbivore with high strength and stamina, using its horns to fend off predators.",
    strength = 9, speed = 4, intelligence = 4, agility = 3, ferocity = 6, stamina = 9,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Triceratops_horridus_2.jpg/330px-Triceratops_horridus_2.jpg"
  ),
  
  "Tyrannosaurus Rex" = list(
    facts = "One of the most powerful predators ever with unmatched strength and ferocity, but not very agile.",
    strength = 10, speed = 6, intelligence = 5, agility = 4, ferocity = 10, stamina = 8,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Tyrannosaurus_rex_Reconstruction_by_Nobu_Tamura.jpg/330px-Tyrannosaurus_rex_Reconstruction_by_Nobu_Tamura.jpg"
  ),
  
  "Tylosaurus" = list(
    facts = "Dominant marine predator with impressive speed and agility, strong in the water but vulnerable on land.",
    strength = 8, speed = 9, ferocity = 7, intelligence = 6, agility = 7, stamina = 7,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Tylosaurus_pembinensis_1DB.jpg/330px-Tylosaurus_pembinensis_1DB.jpg"
  ),
  
  "Velociraptor" = list(
    facts = "Small but extremely fast, agile, and intelligent hunter that relied on strategy over strength.",
    strength = 4, speed = 10, intelligence = 8, agility = 10, ferocity = 6, stamina = 5,
    image = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Velociraptor_recon.png/330px-Velociraptor_recon.png"
  )
)

ui <- fluidPage(
  tags$style(HTML("
    body {
      font-size: 18px;  /* sets base font size for everything */
    }
  ")),
  titlePanel("Who Would Win? 🦖 Dinosaur Battle Royale"),
  sidebarLayout(
    sidebarPanel(
      tags$audio(
        src = "https://ia801504.us.archive.org/27/items/JurassicParkThemeSong./Jurassic%20Park%20theme%20song..mp3", 
        type = "audio/ogg",
        autoplay = NA,
        loop = NA,
        controls = NA),
      selectInput("dino1", "Choose Dinosaur 1:", choices = names(dino_db)),
      selectInput("dino2", "Choose Dinosaur 2:", choices = names(dino_db)),
      actionButton("start", "Begin Battle!"),
      uiOutput("dino_info"),
      uiOutput("hp_bars")
    ),
    mainPanel(
      uiOutput("battle_log"),
      h1(textOutput("winner")),
      uiOutput("reset_button")
    )
  )
)

server <- function(input, output, session) {
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
    
    # Also reset selected dinosaurs (UI dropdowns)
    updateSelectInput(session, "dino1", selected = "")
    updateSelectInput(session, "dino2", selected = "")
  })
  
  
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
                                       prob=c(s1$agility/(s1$agility+s2$agility),s2$agility/(s1$agility+s2$agility)))
        state$log <- paste0(state$log, "<p><b>Round ", state$round, "</b> – ",
                            if (state$attacker_first) paste0(state$dino1, " goes first!") else paste0(state$dino2, " goes first!"), "</p>")
        state$step <- 1
      }
      if (state$step == 1) {
        if (state$attacker_first) {
          dmg <- round(
            (runif(1, 1, 10) + s1$strength * 0.8 + s1$speed * 0.3 + s1$ferocity * runif(1, 0.5, 0.8) +
              s1$intelligence * 0.3 + s1$agility * 0.3 + s1$stamina * 0.2
          )*(1-state$round*(0.05)))
          state$hp2 <- max(0, state$hp2 - dmg)
          state$log <- paste0(state$log, "<p>🦖 ", d1, " attacks ", d2, " for <b>", dmg, "</b> damage!</p>")
        } else {
          dmg <- round(
            (runif(1, 1, 10) + s2$strength * 0.8 + s2$speed * 0.3 + s2$ferocity * runif(1, 0.5, 0.8) +
              s2$intelligence * 0.3 + s2$agility * 0.3 + s2$stamina * 0.2
          )*(1-state$round*(0.05)))
          state$hp1 <- max(0, state$hp1 - dmg)
          state$log <- paste0(state$log, "<p>🦕 ", d2, " attacks ", d1, " for <b>", dmg, "</b> damage!</p>")
        }
        state$step <- 2
      } else if (state$step == 2 && state$hp1 > 0 && state$hp2 > 0) {
        if (state$attacker_first) {
          dmg <- round(
            (runif(1, 1, 10) + s2$strength * 0.8 + s2$speed * 0.3 + s2$ferocity * runif(1, 0.5, 0.8) +
              s2$intelligence * 0.3 + s2$agility * 0.3 + s2$stamina * 0.2
          )*(1-state$round*(0.05)))
          state$hp1 <- max(0, state$hp1 - dmg)
          state$log <- paste0(state$log, "<p>🦕 ", d2, " counters and hits ", d1, " for <b>", dmg, "</b> damage!</p>")
        } else {
          dmg <- round(
            (runif(1, 1, 10) + s1$strength * 0.8 + s1$speed * 0.3 + s1$ferocity * runif(1, 0.5, 0.8) +
              s1$intelligence * 0.3 + s1$agility * 0.3 + s1$stamina * 0.2
          )*(1-state$round*(0.05)))
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
  
  output$battle_log <- renderUI({
    HTML(state$log)
  })
  
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
  
  output$reset_button <- renderUI({
    tagList(
      if (!is.null(state$winner)) {
        tagList(
          actionButton("reset_btn", "🔁 Reset Fight", class = "btn btn-danger mt-3")
        )
      }
    )
  })
  
  output$dino_info <- renderUI({
    req(input$dino1, input$dino2)
    
    hp1 <- state$hp1
    hp2 <- state$hp2
    
    base_height <- 150
    
    red_opacity1 <- round((1 - hp1 / 100) * 0.6, 2)
    red_opacity2 <- round((1 - hp2 / 100) * 0.6, 2)
    
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
      h4(input$dino1),
      tags$div(style = "position: relative; display: inline-block;",
               tags$img(src = dino_db[[input$dino1]]$image,
                        height = paste0(base_height, "px")),
               tags$div(style = paste0("position: absolute; top: 0; left: 0; width: 100%; height: 100%; ",
                                       red_overlay1))
      ),
      p(dino_db[[input$dino1]]$facts),
      tags$hr(),
      h4(input$dino2),
      tags$div(style = "position: relative; display: inline-block;",
               tags$img(src = dino_db[[input$dino2]]$image,
                        height = paste0(base_height, "px")),
               tags$div(style = paste0("position: absolute; top: 0; left: 0; width: 100%; height: 100%; ",
                                       red_overlay2))
      ),
      p(dino_db[[input$dino2]]$facts)
    )
  })
}

shinyApp(ui, server)
