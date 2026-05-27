library(shiny)
library(igraph)
library(visNetwork)
library(RColorBrewer)
library(scales)
library(zip)

ui = fluidPage(
  titlePanel("Interactive Network Selection"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("threshold", "Correlation Threshold (|r| >):",
                  min = 0, max = 1, value = 0.7, step = 0.1),
      sliderInput("connections", "Minimum Connections per Node:",
                  min = 1, max = 5, value = 1, step = 1),
      downloadButton("download_selection", "Download Selected Node Names + Subplot")
    ),
    mainPanel(
      visNetworkOutput("network", height = "700px")
    )
  )
)

server = function(input, output, session) {
  
  graph_data = reactive({
    req(dat)
    dat_filtered = subset(dat, abs(Correlation) > input$threshold)
    if(nrow(dat_filtered) == 0) return(NULL)
    g = graph_from_data_frame(dat_filtered, directed = FALSE)
    g = delete_vertices(g, which(degree(g) < input$connections))
    if(vcount(g) == 0) return(NULL)
    E(g)$color = ifelse(E(g)$Correlation > 0, "#4575b4", "#d73027")
    E(g)$width = rescale(abs(E(g)$Correlation), to = c(1, 6))
    deg = degree(g)
    deg_rescaled = rescale(deg, to = c(0,1))
    colormap = colorRampPalette(brewer.pal(9, "YlOrRd"))(100)
    vertex_colors = colormap[as.numeric(cut(deg_rescaled, breaks=100))]
    V(g)$color = vertex_colors
    V(g)$frame.color = "gray30"
    g
  })
  
  nodes_reactive = reactive({
    g = graph_data()
    if(is.null(g)) return(data.frame())
    data.frame(
      id = V(g)$name,
      label = V(g)$name,
      color = V(g)$color,
      shape = "box"
    )
  })
  
  edges_reactive = reactive({
    g = graph_data()
    if(is.null(g)) return(data.frame())
    edf = as_data_frame(g, what = "edges")
    edf$value = abs(edf$Correlation)
    edf$color = E(g)$color
    edf
  })
  
  output$network = renderVisNetwork({
    nodes = nodes_reactive()
    edges = edges_reactive()
    validate(
      need(nrow(nodes) > 0, "No nodes to display with current filters.")
    )
    visNetwork(nodes, edges) %>%
      visEdges(color = list(color = edges$color)) %>%
      visOptions(
        highlightNearest = TRUE, 
        nodesIdSelection = TRUE
      ) %>%
      visEvents(
        select = "function(nodes) { Shiny.onInputChange('selected_nodes', nodes.nodes); }"
      )
  })
  
  # Automatically select all nodes in the same component when one is clicked
  observeEvent(input$selected_nodes, {
    sel = input$selected_nodes
    g = graph_data()
    if (!is.null(sel) && length(sel) == 1 && !is.null(g)) {
      comps = igraph::components(g)
      node_comp = comps$membership[sel]
      all_in_comp = names(comps$membership)[comps$membership == node_comp]
      visNetworkProxy("network") %>% visSelectNodes(id = all_in_comp)
      # Save to a reactive value so download always uses the expanded selection
      updateSelectNodes(all_in_comp)
    } else if (!is.null(sel) && !is.null(g)) {
      # Multiple nodes: union components
      comps = igraph::components(g)
      comp_ids = unique(comps$membership[sel])
      all_in_comp = names(comps$membership)[comps$membership %in% comp_ids]
      updateSelectNodes(all_in_comp)
    }
  }, ignoreInit = TRUE)
  
  # Store the last computed selection (nodes in the connected component)
  selected_nodes_full = reactiveVal()
  updateSelectNodes = function(ids) selected_nodes_full(ids)
  
  # Download handler for selected node names and subplot PDF
  output$download_selection = downloadHandler(
    filename = function() {
      paste0("selected_nodes_and_subplot_", Sys.Date(), ".zip")
    },
    content = function(file) {
      sel = selected_nodes_full()
      nodes = nodes_reactive()
      g = graph_data()
      if (!is.null(sel) && length(sel) > 0 && nrow(nodes) > 0 && !is.null(g)) {
        # CSV
        csv_name = tempfile(fileext = ".csv")
        write.csv(data.frame(Node = nodes$label[nodes$id %in% sel]), csv_name, row.names = FALSE)
        
        # PDF subplot
        pdf_name = tempfile(fileext = ".pdf")
        subg = induced_subgraph(g, vids = sel)
        pdf(pdf_name, width = 7, height = 7)
        plot(
          subg,
          vertex.label = V(subg)$name,
          edge.label = if (ecount(subg) <= 20) round(E(subg)$Correlation, 2) else NA,
          vertex.label.family = "sans",
          vertex.label.color = "gray10",
          main = "Subnetwork of Selected Nodes",
          vertex.label.font = 2,
          vertex.shape = 'rectangle',
          vertex.label.cex = 0.8
        )
        dev.off()
        
        # Create a zip archive
        zip::zipr(zipfile = file, files = c(csv_name, pdf_name), 
                  root = dirname(csv_name), 
                  include_directories = FALSE)
      } else {
        # Empty: just make a dummy CSV
        write.csv(data.frame(Node = character()), file, row.names = FALSE)
      }
    }
  )
  
  # Initialize selection storage
  observe({
    updateSelectNodes(character(0))
  })
}

shinyApp(ui = ui, server = server)