



library(tidyverse)

library(factoextra)
library(FactoMineR) # -> contains PCA function



dd = 'G:/My Drive/Dev/Field_report_testing/templates/fractionation/data'
setwd(dd)

df = read.csv('US_TOC_Frac_Soil_Chem_V3.csv')


df.pca = df %>% filter(treatment_name == 'US-210 (2.5e2)') %>%
                select(-c('Code','Pot.Plot',
                          'Total.Carbon',
                          'loc.pot.plot','Strip','replicate','Subsample',
                          'Lab.ID','Client.ID',
                          #'trial_name',
                          'treatment_name','Classification',
                          'POM','POM_C','MAOM','MAOM_C')) %>%
  drop_na

cols = c(2:17,30)
df.pca[cols] = lapply(df.pca[cols],as.numeric)

#cols = c(1,22,31)
#df.pca[cols] = lapply(df.pca[cols],as.factor)



PCA_out = PCA(df.pca,graph = FALSE,quali.sup = 1)

fviz_screeplot(PCA_out,addlabels = TRUE)

fviz_pca_biplot(PCA_out, repel = FALSE,geom = 'point')
