### Generic pdf rendering script



library(tidyverse)

rm(list = ls()) # remove global variables


dpath = 'G:/Shared drives/Loam Bio Field and GH Data - Internal/5. Data Analysis/'


tpath = 'G:/My Drive/Dev/Field_report_testing/templates/gen1'
setwd(tpath)
source('gen1_TOC_Y_data_prep.r')


setwd(dpath)
raw_data_all = read.csv('FSP_all_proc_data.csv') 

cols = c(1:8,10,11)
raw_data_all[cols] = lapply(raw_data_all[cols],factor)




countries = c('AU','BR','CA')


for(cntry in countries){
  
  temp_country = raw_data_all %>% filter(country == cntry) #%>% droplevels()
  
  
  
  crops = unique(temp_country$crop)
  
  for(crp in crops){
    
    crp_path = paste(dpath,cntry,'2023','FSP',crp,sep = '/') 
    template = 'gen1_TOC_Y_CROP.Rmd'
    title = paste(cntry,crp,'Aggregated','TOC_Yield_Analysis.pdf',sep = '_')
    
    
    # Crop analysis
    
    rmarkdown::render(
      input = paste(tpath,template,sep = '/'),
      output_format = "pdf_document",         
      output_file = title, 
      output_dir = crp_path, 
      params = list(Crop_in = crp,
                    Country = cntry)       
    )   
    
    temp_crop = temp_country %>% filter(crop == crp)
    
    protos = unique(temp_crop$protocol_id)
    
    for(proto in protos){
      
      
      dir.create(file.path(crp_path,proto))
      proto_path = paste(crp_path,proto,sep = '/')
      
      temp2_proto = temp_country %>% filter(protocol_id == proto) #%>% droplevels()
      trials = unique(temp2_proto$trial_name)
      
      
      # Cross-Trial Analysis (if more than 1 trial)
      if(length(trials) > 1){
        
        template = 'gen1_TOC_Y_Crop_Cross_Trial.Rmd'
        title = paste(cntry,crp,'Cross_Trial','TOC_Yield_Analysis',proto,'.pdf',sep = '_')
        
        
        rmarkdown::render(
          input = paste(tpath,template,sep = '/'),
          output_format = "pdf_document",         
          output_file = title, 
          output_dir = proto_path, 
          params = list(Crop_in = crp,
                        Protocol_in = proto,
                        Country = cntry)       
        )    
      }
      # Individual Trial analyses
      
      
      
      for(tr in trials){
        
        template = 'gen1_TOC_Yield_Crop_TRIALNAME.Rmd'
        title = paste(cntry,tr,'TOC_Yield_Analysis.pdf',sep = '_')
        out_path = paste(dpath,cntry,'2023','FSP',crp,sep = '/')
        
        
        rmarkdown::render(
          input = paste(tpath,template,sep = '/'),
          output_format = "pdf_document",         
          output_file = title, 
          output_dir = proto_path, 
          params = list(Crop_in = crp,
                        Trial_in = tr,
                        Country = cntry)       
        )         
        
      }
      
    }
  }
}


### Yield Only

setwd(tpath)

source('gen1_Yield_Only_data_prep.r')

setwd(dpath)
raw_data_all = read.csv('FSP_Yield_proc_data.csv') 

cols = c(1:8,10,11)
raw_data_all[cols] = lapply(raw_data_all[cols],factor)



countries = c('CA','BR','AU')


for(cntry in countries){
  
  temp_country = raw_data_all %>% filter(country == cntry) #%>% droplevels()
  
  
  
  crops = unique(temp_country$crop)
  
  for(crp in crops){
    
    crp_path = paste(dpath,cntry,'2023','FSP',crp,sep = '/') 
    #template = 'gen1_TOC_Y_CROP.Rmd'
    # title = paste(cntry,crp,'Aggregated','Yield_Only_Analysis.pdf',sep = '_')
    # 
    # rmarkdown::render(
    #   input = paste(tpath,template,sep = '/'),
    #   output_format = "pdf_document",         
    #   output_file = title, 
    #   output_dir = crp_path, 
    #   params = list(Crop_in = crp,
    #                 Country = cntry)       
    # )   
    # 
    temp_crop = temp_country %>% filter(crop == crp)
    
    protos = unique(temp_crop$protocol_id)
    
    for(proto in protos){
      
      
      dir.create(file.path(crp_path,proto))
      proto_path = paste(crp_path,proto,sep = '/')
      
      temp2_proto = temp_country %>% filter(protocol_id == proto) #%>% droplevels()
      trials = unique(temp2_proto$trial_name)
      
      #dir.create(file.path(crp_path,proto,'Yield_Only'))
      
      # Cross-Trial Analysis (if more than 1 trial)
      if(length(trials) > 1){
        
        template = 'gen1_Yield_Only_Crop_Cross_Trial.Rmd'
        title = paste(cntry,crp,'Cross_Trial','Yield_Only_Analysis',proto,'.pdf',sep = '_')
        
        
        rmarkdown::render(
          input = paste(tpath,template,sep = '/'),
          output_format = "pdf_document",         
          output_file = title, 
          output_dir = proto_path,
          params = list(Crop_in = crp,
                        Protocol_in = proto,
                        Country = cntry)       
        )    
      }
      # Individual Trial analyses
      
      
      
      for(tr in trials){
        
        template = 'gen1_Yield_Only_Crop_TRIALNAME.Rmd'
        title = paste(cntry,tr,'Yield_Only_Analysis.pdf',sep = '_')
        out_path = paste(dpath,cntry,'2023','FSP',crp,sep = '/')
        
        
        rmarkdown::render(
          input = paste(tpath,template,sep = '/'),
          output_format = "pdf_document",         
          output_file = title, 
          output_dir = proto_path, 
          params = list(Crop_in = crp,
                        Trial_in = tr,
                        Country = cntry)       
        )         
        
      }
      
    }
  }
}