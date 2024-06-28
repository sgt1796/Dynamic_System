library(rsconnect)
rsconnect::setAccountInfo(name='sgt1796', token='EA36BBBE655CB0CAC6CCD50A8AF2CA53', secret='VjW4C1IRTddT37COUbGxARJuhElsK1ZqA7KF+Ifp')# Deploy the app from the Git repository
deployApp(appDir = "shiny", 
          appFiles = c("ui.R", "server.R"))
