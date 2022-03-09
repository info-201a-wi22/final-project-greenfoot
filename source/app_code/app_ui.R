# ---------------- Shiny Widgets -----------------

# BAR PLOT WIDGETS

time_input_bar_plot <- sliderInput(
  inputId = "yearSelect",
  label = "Select Year",
  min = 2007,
  max = 2020,
  value = c(2007, 2020),
  sep = "",
  ticks = FALSE
)

pollutant_type_input <- radioButtons(inputId ="dataSet",
             label = "Select Pollutant",
             choices = list("CO2" = 1, "Methane (CH4)" = 2, "Nitrous oxide (N2O)" = 3),
             selected = 1)


# LINE PLOT WIDGETS

model1_input <- selectInput(
  "chosen_model1",
  label = "Choose a model: ",
  choices = c("DNE21 V.12", "GCAM 3.0", "GEM-E3-ICCS", "IMACLIM v1.1", "IMAGE 2.4", "MERGE-ETL_2011", "MESSAGE V.4", "POLES AMPERE", "REMIND 1.5", "WITCH_AMPERE", "WorldScan2"),
  selected = "GCAM 3.0"
)

model2_input <- selectInput(
  "chosen_model2",
  label = "Choose a model: ",
  choices = c("DNE21 V.12", "GCAM 3.0", "GEM-E3-ICCS", "IMACLIM v1.1", "IMAGE 2.4", "MERGE-ETL_2011", "MESSAGE V.4", "POLES AMPERE", "REMIND 1.5", "WITCH_AMPERE", "WorldScan2"),
  selected = "GEM-E3-ICCS"
)

# MAP PLOT WIDGETS

time_input_map_plot <- sliderInput(
  "time_var_map_plot",
  label = "Choose year:",
  min = 2000,
  max = 2020,
  value = "2020",
  sep = "",
  ticks = FALSE
)

emission_type_input <- selectInput(
  "chosen_emission_type",
  label = "Choose a emission type: ",
  choices = c("CO2 Emissions" = "co2",
              "Cement CO2 Emissions" = "cement_co2",
              "Coal CO2 Emissions" = "coal_co2",
              "Flaring CO2 Emissions" = "flaring_co2",
              "Gas CO2 Emissions" = "gas_co2"),
  selected = "CO2 Emissions"
)

# ---------------- Shiny Page Layout -----------------

ui <- fluidPage(

  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styling.css")
  ),

  title = "COVID-19 and GHG Emissions, What Can We Learn?",
  position = "fixed-top",

  navbarPage("COVID-19 and GHG Emissions, What Can We Learn?",

    # --- INTRO ---

    tabPanel("Intro",
      img(src = "IntroImage.webp", style = "width: 75%;"),
      p("We are concerned with GHG emissions and the drastic effects continued pollution will have on the global climate. Within our lifetime we will be facing the damaging effects of a man-made climate crisis. Because of this, the purpose of our project will be to use the COVID-19 pandemic and the short term drop in GHG emissions which followed as a model and example of how we can reduce our global communities carbon footprint, and protect our future."),
      p("The COVID-19 pandemic has brought massive change to the modern world. Lockdown restrictions intended to stem the spread of this disease saw fewer people driving, traveling, and consuming, and more people isolating at home and rarely leaving. During the early waves of the pandemic we saw temporary closures of large industrial centers, and a massive migration to remote, or online, work. Through our research, we plan to determine what effect, if any, these changes to modern work and life have had on both global and national greenhouse gas emissions. This collected data, once analyzed, has the capacity to show us what potential steps can be taken to curb future greenhouse gas emissions, and serve as a real-world display of what both minute and drastic changes in modern life can do to the impact humanity has on the environment. "),
      p("We used a wide variety of datasets for our project. They include: EPA Air Emissions Dataset, European Environment Agency Industrial Reporting database, Global Carbon Budget 2021, IPCC AR5 WGIII Database, EPA GHGP Data by Year, Our World in Data CO2 and GHG Emissions Dataset")
             
    ),

    # --- BAR PLOT ---

    tabPanel("Bar Plot",

      sidebarLayout(

        sidebarPanel(

          time_input_bar_plot,

          pollutant_type_input,

          textOutput("yearSelect")

        ),

        mainPanel(

        plotlyOutput("bar_plot")

        )

      )

    ),

    # --- MAP PLOT ---

    tabPanel("Line Plot",

      sidebarLayout(

        sidebarPanel(

          model1_input,

          model2_input

        ),

        mainPanel(

          plotlyOutput("line_plot")

        )

      )

    ),


    # --- MAP PLOT ---

    tabPanel("Map Plot",

      sidebarLayout(

        sidebarPanel(

          time_input_map_plot,

          emission_type_input

        ),

        mainPanel(

          plotlyOutput("map"),

          verbatimTextOutput("temp")

        )

      )

    ),


    # --- SUMMARY ---

    tabPanel("Summary",

      img(src = "table.png", style = "width: 75%;"),

      br(),

      p("The first of our three major takeaways can be seen thanks to our US State CO2 emissions by MT/yr (Flordia, Illinois, Texas, Washington) table. We were able to see that covid restrictions across different states in the U.S. played an impact on resulting GHG emissions for the year 2020 (covid). Florida was widely known for having some of, if not the loosest and most lenient covid lockdown rules. We see here that while other states had extremely significant drops in their GHG emissions, they actually rose slightly in Florida. This means that Florida continues on the rising trend when most everywhere else it dropped. Because of this, we can confidently say that it is possible to limit ghg emissions significantly when stricter restrictions are in place."),

      br(),

      plotlyOutput("bar_chart_summary"),

      br(),

      p("Our 2nd key takeaway can be seen in our Real co2 vs model co2 emissions chart. According to the model, if the Covid pandemic never happened we would have seen roughly 14.28% less CO2 released into the atmosphere globally. This is a staggering number, because if we could find a way to achieve just a fraction of this, we would be able to make real progress in reducing co2 emissions enough to have a real  impact on our environment. This once again proves that with sanctions and restrictions, harmful emissions can be reduced more than we thought were capable."),

      br(),

      plotlyOutput("line_chart_summary"),

      br(),

      p("Our 3rd and final takeaway can be seen in our Yearly average manufacturing co2 emissions across europe chart. Covid caused a major decrease for the large manufacturing and industrialization economy in Europe. Because of this, it is observed that 2020 was also the lowest co2 emissions output in Europe from this sector in a while, with the biggest year over year drop from the year prior. As like the majority of the world in 2020, Europe had a significant drop in co2 emissions during this time period, which only further proves the same thing in a different part of the world: large decreases in co2 emissions are still very much possible in the future.")

    ),

    # --- REPORT ---

    #h3(""),
    #p(""),

    tabPanel("Report",
      tags$link(rel = "stylesheet", type = "text/css", href = "styling.css"),
      p("Authors: Justin Rhinehart @ jjrhine@uw.edu, Ryan Friesz @ ref7@uw.edu, Tom Jubin @ tomjubin@uw.edu, Liam Dale @ liamdale@uw.edu"),
      p("Affiliation: INFO-201: Technical Foundations of Informatics - The Information School - University of Washington"),
      p("Date: Winter 2022"),

      h3("Abstract:"),
      p("We are concerned with GHG emissions and the drastic effects continued pollution will have on the global climate. Within our lifetime we will be facing the damaging effects of a man-made climate crisis. To address this concern, we plan to use the COVID-19 pandemic and the short term drop in GHG emissions which followed as a model and example of how we can reduce our global communities carbon footprint, and protect our future."),

      h3("Introduction:"),
      p("The COVID-19 pandemic has brought massive change to the modern world. Lockdown restrictions intended to stem the spread of this disease saw fewer people driving, traveling, and consuming, and more people isolating at home and rarely leaving. During the early waves of the pandemic we saw temporary closures of large industrial centers, and a massive migration to remote, or online, work. Through our research, we plan to determine what effect, if any, these changes to modern work and life have had on both global and national greenhouse gas emissions. This collected data, once analyzed, has the capacity to show us what potential steps can be taken to curb future greenhouse gas emissions, and serve as a real-world display of what both minute and drastic changes in modern life can do to the impact humanity has on the environment."),

      h3("Design Situation:"),
      p("Our primary topic of concern is greenhouse gas emissions. This matters to us as in our lifetimes, we will experience the drastic effects of global warming on our climate, and need tools to combat it. In this report, we plan to explore if greenhouse gas emissions decreased due to pandemic restrictions, and gather what we can learn from the predicted decrease in emissions. Our issue falls within the problem domain, as it is an issue that has multiple answers and can not be solved with a single 'design'. Some key questions to consider are those pertaining to the lockdowns and how they lowered greenhouse gas emissions from \"transport, industries, and fossil fuel burning\", alongside agricultural industries which also saw a drop in ammonia emissions. (Mohsin et al., 2021)"),
      p("As a single-planet species with significant control over our environment, it is our responsibility to maintain the only home we have to support future generations and the further propagation of our species. The simple wellbeing of the human race is invaluable, and the consequences of inaction on climate change and greenhouse gas emissions are drastic and terrible (Thompson and Bendik-Keymer, 2012). The interest of businesses in the realm of fossil fuels and manufacturing aligns directly against the further success of the human race, pushing for further pollution and emissions, with little regard for much beyond Year over year profits."),
      p("The unfortunate reality of rising greenhouse gas emissions and global warming is that everyone has a stake in the hardship and disasters that they invite. Two main trains of thought tend to accompany this topic, those of apathy and denial, and those of hopeful progress and change. Those in the denial camp include oil, gas, and coal giants like BP, who have a long history of suppressing and outright lying about the negative effects of greenhouse gas emissions. Their bottom line is harmed by the steps that need to be taken to fix the planet, and they tend to stand strongly against progress. Those who hold hope for the future, and work to undo, or at least halt, the damage being caused are motivated by the possibility that there is no future, unless changes are made. There are no indirect stakeholders here. Everyone is in the same boat, as we only have one planet that we have to share. (Major Groups & Stakeholders, 2022)"),
      p("Interventions with data and technology have already happened with greenhouse gas emissions, and the benefits have been immense in allowing us to prove and show the harm we are causing to our planet. The harm we have discovered, however, has been immense, with many companies attempting to shift blame away from their actions either through funding studies which undermine the actual effects of greenhouse gasses, or by pointing fingers at individual people, or developing countries. It would be fair to argue that all of our direct stakeholders would benefit from a healthy climate in the long-run, but short-term stakeholders such as businesses and governments will be harmed by practices that attempt to reverse the damage they are already doing, and prevent or minimize the effects of climate change."),

      h3("Research Questions:"),
      p("United States lockdown policy varied greatly during the pandemic, and we plan to explore if different policies across different states had a significant effect on greenhouse gas emissions. We will compare data from before and after COVID was prevalent to examine how the data changed across different states over several years. We also plan to examine worldwide COVID restrictions, and the effect that those had on global emissions numbers. We plan to collect and analyze data from several different nations of varying geography and financial status to ensure we take note of important factors like culture. Continuing on the global scale, we plan to look at specific sources of pollutants, chiefly manufacturing. From the data and analysis we have gathered here, we plan to examine if the COVID-19 pandemic made any significant change in the levels of greenhouse gas emissions, and how these changes can be applied to both model and plan for a greener future."),

      h3("The Dataset:"),
      h4("EPA Air Emissions Dataset"),
      p("This dataset contains approximately 8 million entries of specific greenhouse gas types, emissions levels and locations across the united states from 2011 to 2020. The dataset was gathered from EPA monitoring systems and devices in the continental United states, for the purpose of tracking greenhouse gas emissions. This data is held directly by, and obtainable from, the EPA, and as such is secure and trustworthy.", style = "margin-left: 20px;"),
      h4("European Environment Agency Industrial Reporting database"),
      p("Dataset contains data pertaining to greenhouse gas emissions in participating European countries from 2010-2021, on a national, sector, and facility level. The data was gathered from EEA monitoring systems and devices in participating European countries for the purpose of monitoring and reducing GHG emissions from the European Continent. This data was stored with the EEA, and obtained from the same group, and as such is both secure and trustworthy", style = "margin-left: 20px;"),
      h4("Global Carbon Budget 2021"),
      p("The dataset contains fossil fuel emissions (CO2 mainly) dating from 1959 to 2021. Row units for the dataset are in MtC/yr (million tonne of carbon per year), with recorded features being types of emission (Oil, Gas, etc.) and the country of origin. The data was collected from NOAA and a U.S. DOE organization. This data was funded by government programs and as such isn't profit focused. This dataset was created primarily for climate researchers. The data is credible as it comes directly from a scientific journal (Earth System Science Data) and the Global Carbon Project which authored the report. This data was collected and cleaned by a partner of the United Nation's World Climate Research Program.", style = "margin-left: 20px;"),
      h4("IPCC AR5 WGIII Database"),
      p("This dataset contains predictive models from the Intergovernmental Panel on Climate Change (IPCC) dating from 2015 to the present. The models used date from 2005-2100 and contain measurements in Mt CO2/yr, Mt CH4/yr, etc. as well as population and GDP estimates. The data is sorted by region (ASIA, NA, SA, etc.). These models were created by the United Nation's IPCC, and as such guarantees that the dataset was created with a non-profit focus, for the purpose of being used in IPCC's annual climate report. This data is credible as it originates from the United Nations.", style = "margin-left: 20px;"),
      h4("EPA GHGP Data by Year"),
      p("This dataset contains reported total greenhouse gas emissions on a yearly basis for many locations across the United States from 2011-2020. The total emissions by year are broken down by different sectors across several subsets (i.e. direct emitters, onshore oil & gas, transmission pipelines) This dataset was created with the purpose of tracking all reported GHG emissions across the country for the public to view, or for anyone who would like to pursue further research. The data is credible as it was collected by the greenhouse gas reporting program of the Environmental Protection Agency of the United States.", style = "margin-left: 20px;"),
      h4("Our World in Data CO2 and GHG Emissions Dataset"),
      p("This dataset contains data from the Global Carbon Project, Climate Watch Portal and the BP Statistical Review of World Energy to track GHG Emissions on an annual, per capita, cumulative, and consumption basis. While most of this data comes from reputable sources, BP is not known to be trustworthy when the topic of climate comes up, and their portion of this data could be misleading or skewed to favor their business interests. This particular collection of data is a github repository, and as such is securely held, to an extent, but not necessarily secure in its consistency or factuality.", style = "margin-left: 20px;"),

      h3("Expected Implications:"),
      p("With the Covid-19 pandemic, there was a decrease/downtrend in total emitted greenhouse gas emissions. The expected implications of this is that policymakers/politicians will be able to see that with dramatic global shutdown, minimizing the direct emissions into our atmosphere is very possible on a large scale. The obvious problem however is that we will not be in lockdown forever, but this temporary period may give some insight for a more permanent solution in decreasing emissions. By taking a deeper look into which types of emissions, and where certain emissions saw drastic change, it may be possible to pinpoint or target a specific area/region to prioritize first for maximum effect when attempting to tackle the issue of climate change."),

      h3("Limitations:"),
      p("The limitations to this study pertain to our inability to work with any data other than the provided data and records of other groups. Beyond this, the data for reported GHG emissions is exactly that: reported. Therefore, although the data is as accurate as we have possible, it is most likely not exactly reflective of the true GHG emissions experienced as third party interests have the capacity to skew results"),

      h3("Findings:"),
      p("The first research question our group had was how would different Covid-19 policies affect GHG emissions. Within the United States, there was a large variance in the types of policies different states had. For example, some states had harsher lockdowns and closed more businesses whereas other states were less restrictive. We examined four states: Florida, Illinois, Texas, and Washington, and compared their GHG emissions both pre and during the pandemic. The only state out of this group that saw an increase in GHG emissions during the Covid-19 pandemic was Florida. Florida did have less restrictive policies in response to the pandemic, so it makes sense that GHG emissions would not have been decreased. For example, the governor of Florida tried to make wearing masks in public school illegal, did not impose stay-at-home orders, or vaccination mandates (1). All of these policies likely contributed to more traveling and normal everyday life which wouldn't have changed GHG emissions as we have seen in other states. The next question our group asked was, globally what change in GHG emissions did a variety of countries experience. By variety, we wanted to examine countries with different cultures, geography, and financial status. We examined Germany, Venezuela, and Brazil. The country which had the sharpest decline in GHG emissions was Venezuela, followed by Germany, and then Brazil. This was not the result that some of the group was expecting. As Germany is the most industrialized country of the group, one might have assumed they would have been the most affected. However, upon doing further research we have learned that Venezuela was experiencing an economic crisis that was made worse during Covid-19. An economic crisis would likely lead to a sharp decline in GHG emissions, so it makes sense that Venezuela was affected the most.  Our final research question was to see how the pandemic specifically affected manufacturing pollution. In this case, our analysis found that total world GHG emissions related to manufacturing did decrease in 2020 compared to 2019. This link between a global pandemic and a decrease in manufacturing pollution is represented in our data because of the decrease in GHG emissions related to manufacturing. A decrease in manufacturing GHG emissions makes sense because of the Covid-19 restriction and the difficulties businesses faced during the pandemic. "),

      h3("Discussion:"),
      p("One of the most important things our group learned from our research is that policies can make a huge difference in GHG emissions. For example, even though the entire United States was experiencing the Covid-19 pandemic, states had different policies and laws in response. In states like Florida, there were very few restrictions and people were generally able to continue life living like normal. Conversely, in Washington State, there were very strict regulations which made it harder for people to do a lot of activities and traveling that is normal. These differences manifested themselves in the data we examined. Washington State had a significant decrease in GHG emissions from 2019 to 2020 (roughly 16% lower), Florida saw an increase in GHG emissions. Another large difference we observed was that different countries in the world were affected by Covid-19 differently. For example, in Venezuela, the pandemic worsened and led to a bad economic crisis. Many people in Venezuela lost their jobs, and this unemployment and economic collapse has certainly lent help to a sharper decrease in GHG emissions. Germany also saw a significant decrease in GHG emissions, but unlike Venezuela, its economy was able to stay stable. The likely culprit for their decrease in emissions was because of less traveling and restrictions like lockdowns. By looking at the different effects that the pandemic has caused on GHG emissions, it is clear to see that policies can lead to clear reductions in emissions. Deciding on how to structure future policies in order to reduce emissions is an important part of mitigating climate change."),

      h3("Conclusion:"),
      p("Overall, after analyzing many different datasets we have come to the conclusion that reducing GHG emissions on a significant global scale is possible for the future. The Covid-19 pandemic has provided us a \"bubble\" of data to essentially test this theory, and the data shows us that government restrictions can in fact be a main catalyst in reducing emissions. With this information, government and policy leaders should be aware that the answer to our rising GHG emission problem might not be impossible after all."),

      h3("References:"),
      p("Environmental Protection Agency. (2020). Air Emissions Dataset (Version number) [CSV]. Retrieved from https://echo.epa.gov/tools/data-downloads"),
      p("European Environment Agency. (2021). Industrial Reporting database (v5) [CSV]. Retrieved from https://www.eea.europa.eu/data-and-maps/data/industrial-reporting-under-the-industrial-4"),
      p("Friedlingstein, P., Jones, M. W., O'Sullivan, M., Andrew, R. M., Bakker, D. C. E., Hauck, J., Le Qu�r�, C., Peters, G. P., Peters, W., Pongratz, J., Sitch, S., Canadell, J. G., Ciais, P., Jackson, R. B., Alin, S. R., Anthoni, P., Bates, N. R., Becker, M., Bellouin, N., Bopp, L., Chau, T. T. T., Chevallier, F., Chini, L. P., Cronin, M., Currie, K. I., Decharme, B., Djeutchouang, L., Dou, X., Evans, W., Feely, R. A., Feng, L., Gasser, T., Gilfillan, D., Gkritzalis, T., Grassi, G., Gregor, L., Gruber, N., G�rses, �., Harris, I., Houghton, R. A., Hurtt, G. C., Iida, Y., Ilyina, T., Luijkx, I. T., Jain, A. K., Jones, S. D., Kato, E., Kennedy, D., Klein Goldewijk, K., Knauer, J., Korsbakken, J. I., K�rtzinger, A., Landsch�tzer, P., Lauvset, S. K., Lef�vre, N., Lienert, S., Liu, J., Marland, G., McGuire, P. C., Melton, J. R., Munro, D. R., Nabel, J. E. M. S., Nakaoka, S.-I., Niwa, Y., Ono, T., Pierrot, D., Poulter, B., Rehder, G., Resplandy, L., Robertson, E., R�denbeck, C., Rosan, T. M., Schwinger, J., Schwingshackl, C., S�f�rian, R., Sutton, A. J., Sweeney, C., Tanhua, T., Tans, P. P., Tian, H., Tilbrook, B., Tubiello, F., van der Werf, G., Vuichard, N., Wada, C., Wanninkhof, R., Watson, A., Willis, D., Wiltshire, A. J., Yuan, W., Yue, C., Yue, X., Zaehle, S., and Zeng, J.: Global Carbon Budget 2021, Earth Syst. Sci. Data Discuss. [preprint], https://doi.org/10.5194/essd-2021-386, in review, (2021). [XLSX] Retrieved from https://www.icos-cp.eu/science-and-impact/global-carbon-budget/2021. [CSV] Retrieved from https://zenodo.org/record/5569235#.YYxC8tZBxjw."),
      p("IPCC. (2015). AR5 Scenario Database (v1.0.2) [CSV]. Retrieved from https://tntcat.iiasa.ac.at/AR5DB/dsd?Action=htmlpage&page=about"),
      p("Ritchie, H., Roser, M., Mathieu, E. and Macdonald, B., 2022. GitHub - owid/co2-data: Data on CO2 and greenhouse gas emissions by Our World in Data. [online] GitHub. [CSV] Retrieved from https://github.com/owid/co2-data"),
      p("Mohsin M, Naseem S, Sarfraz M, Ivascu L and Albasher G (2021) COVID-19 and Greenhouse Gas Emission Mitigation: Modeling the Impact on Environmental Sustainability and Policies. Front. Environ. Sci. 9:764294. doi: 10.3389/fenvs.2021.764294"),
      p("Thompson, A. and Bendik-Keymer, J., 2012. Human Values and Institutional Responses to Climate Change. Ethical Adaptation to Climate Change, pp.281-297."),
      p("UNEP - UN Environment Programme. 2022. Major Groups & Stakeholders. [online] Available at: https://www.unep.org/civil-society-engagement/why-civil-society-matters/major-groups-stakeholders [Accessed 5 February 2022]."),
      p("Associated Press. Florida Can't Enforce Its Ban On Mask Mandates During An Appeal, A Judge Says. NPR, 8 Sept. 2021, https://www.npr.org/2021/09/08/1035353871/florida-school-mask-mandates-ron-desantis#:~:text=A%20judge%20has%20ruled%20that%20Florida%20school%20districts%20may%20impose%20mask%20mandates.,-Lynne%20Sladky%2FAP&text=ST.,the%20ban%20is%20ultimately%20legal"),
      p("Thomas, Dr. Liji. \"How the Earth's Air Is Dangerously Polluted.\" AZoCleantech.com, 16 Apr. 2019, https://www.azocleantech.com/article.aspx?ArticleID=730.")

      )
  ),
  br(),

    "Authors: Justin Rhinehart @ jjrhine@uw.edu, Ryan Friesz @ ref7@uw.edu, Tom Jubin @ tomjubin@uw.edu, Liam Dale @ liamdale@uw.edu"
)
