library(rvest)
library(xml2)

container<-data.frame()

for(i in c(1:10)) {
urlPart1 <-"http://www.jobs.pl/praca/it%20-%20rozw%C3%B3j%20oprogramowania;t,111/p-"
url<-paste(urlPart1,i,sep = "")

link <- read_html(url)
salaryJob <- link %>% html_nodes('.title a') %>% html_text()

for (x in 1:length(salaryJob)) {
  container[x+24*(i-1),1]<-salaryJob[x]
}
}

for(i in c(1:10)) {
  urlPart1 <-"http://www.jobs.pl/praca/it%20-%20rozw%C3%B3j%20oprogramowania;t,111/p-"
  url<-paste(urlPart1,i,sep = "")
  
  link <- read_html(url)
  company <- link %>% html_nodes('.employer a') %>% html_text()
  
  for (x in 1:length(company)) {
    container[x+24*(i-1),2]<-company[x]
  }
}

for(i in c(1:10)) {
urlPart1 <-"http://www.jobs.pl/praca/it%20-%20rozw%C3%B3j%20oprogramowania;t,111/p-"
url<-paste(urlPart1,i,sep = "")

link <- read_html(url)
townJob <- link %>% html_nodes('.icon-position-small a') %>% html_text()

for (x in 1:length(townJob)) {
  container[x+24*(i-1),3]<-townJob[x]
}
}
container
a<-sample(8000:22000,248)

for (s in 1:248) {
  container[s,4]<-a[s]
}

colnames(container)<-c("Job","Company","Town", "Salary")
head(container)

write.csv(container, file = "/Users/piotrdybowski/Desktop/Projekt R/R-Scraper.csv",row.names=TRUE)

data <- read.csv(file = "/Users/piotrdybowski/Desktop/Projekt R/R-Scraper.csv")

