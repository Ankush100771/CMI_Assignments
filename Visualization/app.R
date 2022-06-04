library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)
library(dplyr)
ui <- dashboardPage(
    dashboardHeader(title="Project component 2"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("About the dataset",tabName = "menu3"),
            menuItem("Univariate Plots",tabName = "menu1"),
            menuItem("Bivarite Plots",tabName = "menu2"),
            menuItem("Conclusion",tabName = "menu4")
        )
    ),
    dashboardBody(
        tabItems(
            tabItem("menu1",h1("Univariate Plots"),fluidPage(
              sidebarLayout(
                sidebarPanel(
                  selectInput("coloumn","choose the variable",choices = c("company_name","rocket status","mission_status","country","Company_country","private or state","year")),
                  actionButton("go","apply")
                ),
                mainPanel(plotOutput("chart"),textOutput("write"))
              )
            )),
            tabItem("menu2",h1("Bivarite Plots"),fluidPage(
              sidebarLayout(
                sidebarPanel(
                  selectInput("coloumn1","choose the bivarte plots",choices = c("Company VS rocket status","Company VS mission status",
                                                                                "private_state VS mission status","private_state VS year","rocket status VS year","Year VS Month")),
                  actionButton("go1","Apply")
                ),
                mainPanel(plotlyOutput("chart1"),verbatimTextOutput("write1"))
              )
            )),
            tabItem("menu3",h1("About the Project"),fluidPage(
              tags$b(tags$h2("About the Dataset Privatization of space:")),
              tags$ul(tags$h4("The dataset I am working on for this project is named 'privatization of Space'. this dataset contains 15 columns and 4324 rows.
  it contains the details of every space launch from 1957 to 2020, Included for each launch is the organization responsible for the launch. 
  we will also see where and when the launch took place. the valriables in the datasets are company Name, Location, status rocket, status(paas/fail),
  and private or state run,etc... so from here we can conclude that how much the private companies are growing in this aspect.")), 
              tags$b(tags$h2("What I want to find from this project:")),
              tags$ul(tags$h4("1) How have we seen the private sector fair over the years?")),
              tags$ul(tags$h4("2) which organisations are most successful?")),
              tags$ul(tags$h4("3) which company has maximum number of active and retire rockets")),
              tags$ul(tags$h4("4) how the success ratio have  increassed or decreased over the year")),
              tags$b(tags$h2("My Approach:")),
              tags$b(tags$h4("My Aim is to draw various univariate and multivarite plots. So that I can find the relationship between the variables and find the answers of the above questions")),
              tags$b(tags$h2("Details of the variables:")),
              tableOutput("table")
            )),
            tabItem("menu4",h1("Conclusion"),fluidPage(
              tags$b(tags$h4("CONCLUSION:- From all the univarite and multivariate plots and charts i have reach to  certain number of conclusion:")),
              tags$ul(tags$h4("1) The Russian Company RVVN USSR has launched maximum number of rockets.")), 
              tags$ul(tags$h4("2) Of all the rockets launched most of them are now currently in retired condition.")),
              tags$ul(tags$h4("3) Company 'CASIC' possess max number of active rocket, and  for 'RVVN USSR' all the rockets are currently retired.")),
              tags$ul(tags$h4("4) Majority of the launches are successful.RVVN USSR holds a record of maximum number of success and failure both.")),
              tags$ul(tags$h4("5) Majority of those launches took place in USA, USSR, and Kazakhstan.")),
              tags$ul(tags$h4("6) The private companies are mainly from USA. It has a total of 20 private and state companies.")),
              tags$ul(tags$h4("7) Among all the launches more than 50% are from state category.")),
              tags$ul(tags$h4("8) the Companies which are from state category are more successful in launching than the private companies")),
              tags$ul(tags$h4("9) the number of launches per year doesn't follow a fixed pattern. so we can't predict from this data that the no of launch will 
                  gradually increase over the year in future. however the number of private company is increasing over the year. 
                  maximum number of launch took place in 1971.")),
              tags$ul(tags$h4("10) The total Number of launch and total number success depends on each other almost linearly.but the same can't be 
                  predicted in case of failure."))
              
              
            ))
                  
        )
    )
)
server <- function(input,output){
  Global_Space_Launches <- read.csv("Global Space Launches.csv")  
  observeEvent(input$go,
               if(input$coloumn=="company_name"){
                 company=unique(Global_Space_Launches$Company.Name)
                 nol=c()
                 noc=c()
                 for(i in company){
                   noc=c(noc,i)
                   nol=c(nol,nrow(subset(Global_Space_Launches,Company.Name==i)))
                 }
                 output$chart<-renderPlot({
                   barplot(nol ,names.arg = noc, col=c('violet','light blue','blue','green','yellow','orange','red'),las=2)
                   
                 })
                 output$write<-renderPrint({
                   print("So from the above barplot it is clear that RVVN USSR had launched maximum number of rocket ")
                 })
               }
               else if(input$coloumn=="rocket status"){
                 active=nrow(subset(Global_Space_Launches,Status.Rocket=='StatusActive'))
                 retired=nrow(subset(Global_Space_Launches,Status.Rocket=="StatusRetired"))
                 output$chart<-renderPlot({
                   pie(x=c(active,retired),labels = c('StatusActive','StatusRetired'),col=c('red','green'),radius = 1.08)
                 })
                 output$write<-renderPrint({
                   print("so among all of the rockets majority are in retired state")
                 })
               }
               else if(input$coloumn=="mission_status"){
                 ms=unique(Global_Space_Launches$Status.Mission)
                 nms=c()
                 for(i in ms){
                   nms=c(nms,nrow(subset(Global_Space_Launches,Status.Mission==i)))
                 }
                 output$chart<-renderPlot({
                   pie(nms,labels = ms,col = c("red","blue","yellow","green"),radius = 1.08)
                 })
                 output$write<-renderPrint({
                   print("so among all of the launch programs majority are successful")
                 })
               }
               else if(input$coloumn=="country"){
                 country=unique(Global_Space_Launches$Country.of.Launch)
                 total_launch=c()
                 for(i in country){
                   total_launch=c(total_launch,nrow(subset(Global_Space_Launches,Country.of.Launch==i)))
                 }
                 country_data=data.frame(cbind(country_name=country,no_of_launch=total_launch))
                 
                 output$chart<-renderPlot({
                   ggplot(arrange(country_data,as.integer(no_of_launch)),aes(x=country_name,y=sort(as.integer(no_of_launch))))+
                     geom_bar(stat='identity',fill='blue',col="red")+theme(axis.text.x = element_text(angle = 90))+ylim(0,1400)+labs(x="country_name",y="no_of_launches")
                 })
                 output$write<-renderPrint({
                   print("Hence it is most of the raockets are launched from russia, USA and kazakastan")
                 })
               }
               else if(input$coloumn=="Company_country"){
                 company_data=unique(Global_Space_Launches[c(1,8)])
                 val1=unique(company_data$Companys.Country.of.Origin)
                 val=c()
                 for(i in val1){
                   val=c(val,nrow(subset(company_data,Companys.Country.of.Origin==i)))
                 }
                 o=data.frame(cbind(country_name=val1,No_of_companies=val))
                 
                 output$chart<-renderPlot({
                   ggplot(arrange(o,as.integer(No_of_companies)),aes(x=country_name,y=sort(as.integer(No_of_companies))))+geom_bar(stat='identity',fill='orange',col='blue')+
                     theme(axis.text.x = element_text(angle = 90))+labs(x='country_name',y='No_of_companies')
                 })
                 
                 output$write<-renderPrint({
                   print("so most of the companies are from USA")
                 })
               }
               else if(input$coloumn=="private or state"){
                 pri=nrow(subset(Global_Space_Launches,Private.or.State.Run=='P'))
                 sta=nrow(subset(Global_Space_Launches,Private.or.State.Run=='S'))
                 output$chart<-renderPlot({
                   pie(x=c(pri,sta),labels=c('private','state'),col=c('yellow','blue'),radius = 1.08)
                 })
                 output$write<-renderPrint({
                   print("so it is clear from the pie chart that majority of the launches are state project.")
                 })
               }
               else if(input$coloumn=="year"){
                 year=unique(Global_Space_Launches$Year)
                 no_of_launch_year=c()
                 for(i in year){
                   no_of_launch_year=c(no_of_launch_year,nrow(subset(Global_Space_Launches,Year==i)))
                 }
                 year_data=data.frame(cbind(YEAR=year,No_launch=no_of_launch_year))
                 output$chart<-renderPlot({
                   ggplot(year_data,aes(x=YEAR,y=No_launch))+geom_bar(stat = 'identity',fill='red',col='black')
                 })
                 output$write<-renderPrint({
                   print("the no of launches in each year does not follow any particular trend")
                 })
               }
        )
  
  observeEvent(input$go1,
               if(input$coloumn1=="Company VS rocket status"){
                 o11=Global_Space_Launches[,c(1,4)]
                 
                 output$chart1<-renderPlotly({
                   ggplotly(ggplot(o11,aes(x=Company.Name,y=nrow(o11),fill=Status.Rocket))+geom_bar(stat = 'identity')+
                              theme(axis.text.x = element_text(angle = 90,size = 9))+ggtitle("active and retire rocket of the companies"))
                   
                 })
                 output$write1<-renderText({
                   print("From this above plot we can say RVSN USSR has maximum number of retire rocket and CASIC has maximum number of active rocket")
                 })
               }
               else if(input$coloumn1=="Company VS mission status"){
                 mission_data=Global_Space_Launches[,c(1,6)]
                 
                 output$chart1<-renderPlotly({
                   ggplotly(ggplot(mission_data,aes(x=Company.Name,y=Status.Mission,fill=Status.Mission))+geom_bar(stat = 'identity')+
                              theme(axis.text.x = element_text(angle = 90,size=6))+ggtitle("       status of the launches"))
                 })
                 output$write1<-renderText({
                   print("Hence RVSN has maximum number success")
                 })
               }
               else if(input$coloumn1=="private_state VS mission status"){
                 check1=Global_Space_Launches[,c(6,9)]
                 output$chart1<-renderPlotly({
                   ggplotly(ggplot(check1,aes(x=Status.Mission,y=Private.or.State.Run,fill=Private.or.State.Run))+geom_bar(stat='identity'))
                 })
                 output$write1<- renderText({
                   print("Success and faliure both are highest for State, the possible reason is number of launches is much higher for state")
                   
                 })
               }
               else if(input$coloumn1=="private_state VS year"){
                 demo=Global_Space_Launches[,c(9,11)]
                 output$chart1<-renderPlotly({
                   ggplotly(ggplot(demo,aes(x=as.character(Year),y= Private.or.State.Run,fill=Private.or.State.Run))+
                              geom_bar(stat='identity')+theme(axis.text.x = element_text(angle=90,size = 8)))
                 })
                 output$write1<-renderText({
                   print("we can see that number of private companies are increasing with year, hence the participation of the private companies are also increasing with the year")
                 })
               }
               else if(input$coloumn1=="rocket status VS year"){
                 check2=Global_Space_Launches[,c(4,11)]
                 output$chart1<- renderPlotly({
                   ggplotly(ggplot(check2,aes(x=as.character(Year),y=Status.Rocket,fill=Status.Rocket))+
                              geom_bar(stat = 'identity')+theme(axis.text.x = element_text(angle = 90,size = 8)))
                 })
                 output$write1<-renderText({
                   print("So from the above plot it is clear that the rockets which are launched before 1982 are currently in retire state")
                 })
               }
               else if(input$coloumn1=="Year VS Month"){
                 output$chart1<- renderPlotly({
                   qplot(Year,data=Global_Space_Launches,facets = Month ~.,geom="histogram",stat="count",binwidth = 0.5)
                 })
                 output$write1<-renderText({
                   print("The number of launches in each month over 1957 to 2020 is given above")
                 })
               }
         )
  output$table<-renderTable({
    x=c('Company.Name','Location','Details','Status Rocket','status Mission','Country.of.Launch',
        'Companys.Country.of.Origin','Private.or.State.Run','year','month')
    y=c('nominal (categorical)','nominal (categorical)','nominal (categorical)','binary (categorical)',
        'ordinal(categorical)','nominal (categorical)','nominal (categorical)','binary (categorical)','numeric','numeric')
    z=c("The variable Comapny.Name is basically collection 55 unique companies participated in in this rocket launch",
        "it stores all the lauch location","this variable contains the specification  of all the rockets",
        "Showing if a rocket is currently in use","One of 4 categorical elements showing the the result of the launch",
        " we have 16 different countries from where the launches took place","the country that the organization is from",
        "the organizations category think SpaceX for private and NASA for State","the year in which the launch took place",
        "month of the launch")
    nature_of_variable= data.frame(cbind(variable_name=x,type=y,description=z))
    nature_of_variable
  })
 
  
  
    
}

shinyApp(ui,server)
