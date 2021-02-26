library(DESeq2)

DE_analysis = function(path){
  Data = read.csv(path, sep = "\t", skip = 1)
  countData = Data[, 7:10]
  samples = names(countData)
  rownames(countData) <-Data$Geneid
  cond_1 = rep("cond1", 2)
  cond_2 = rep("cond2", 2)
  condition = factor(c(cond_1, cond_2))
  colData = data.frame(samples=samples, condition=condition)
  dds = DESeq2::DESeqDataSetFromMatrix(countData=countData,
                                       colData=colData, design = ~condition)
  
  dds <- DESeq(dds)
  
  res <- results(dds)
  r <- res[res$baseMean!=0,]
  r <- r[r$log2FoldChange > 1 | r$log2FoldChange < -1, ]
  x <- !is.na(r$padj)
  r <- r[x, ]
  r <- r[r$padj<0.05, ]
  print(paste("ilosc genow istotnych statystycznie:",nrow(r)))
  return(r)
}
r_pair = DE_analysis(path = "~/counts_refGene_pair.txt")
r_single = DE_analysis("~/counts_refGene_single.txt")

library(VennDiagram)
diag = venn.diagram(list(pair_end= r_pair@rownames, single_end= r_single@rownames),fill = c("yellow", "red"), filename = NULL)
grid.newpage()
grid.draw(diag)

library(ComplexHeatmap)
library(dplyr)
heatMap = function(path){
  countData = read.csv(path,
                       sep = "\t", skip = 1)
  countData = countData[, 7:10]
  samples = names(countData)
  rownames(countData) <-countData$Geneid
  
  cond_1 = rep("cond1", 2)
  cond_2 = rep("cond2", 2)
  condition = factor(c(cond_1, cond_2))
  colData = data.frame(samples=samples, condition=condition)
  dds = DESeqDataSetFromMatrix(countData=countData, colData=colData, design = ~condition)
  
  log_data <- rlog(dds)
  norm_data<-assay(log_data)
  norm_data <- as.data.frame(norm_data)
  norm_data_10 <- norm_data %>% filter(!rowSums(. <10))
  norm_data_10
  dane_heatMap <- as.matrix(norm_data_10)
  dane_heatMap <- na.omit(dane_heatMap)
  Heatmap(dane_heatMap, cluster_columns=FALSE, row_names_side = "left",
          row_dend_sid = "left",
          row_names_gp=gpar(cex=0.6))
}

heatMap(path = "~/counts_refGene_pair.txt")
heatMap(path = "~/counts_refGene_single.txt")

PCA = function(path){
  countData = read.csv(path,
                       sep = "\t", skip = 1)
  countData = countData[, 7:10]
  samples = names(countData)
  rownames(countData) <-countData$Geneid
  
  cond_1 = rep("mock", 2)
  cond_2 = rep("zika", 2)
  condition = factor(c(cond_1, cond_2))
  
  colData = data.frame(samples=samples, condition=condition)
  dds = DESeqDataSetFromMatrix(countData=countData, colData=colData, design = ~condition)
  rld <- rlog(dds, blind=TRUE)
  plotPCA(rld)
}

PCA(path = "~/counts_refGene_pair.txt")
PCA(path = "~/counts_refGene_single.txt")
library(pheatmap)
DataPE = read.csv("~/counts_refGene_pair.txt", sep = "\t", skip = 1)
countDataPE = DataPE[, 7:10]
DataSE = read.csv("~/counts_refGene_single.txt", sep = "\t", skip = 1)
countDataSE = DataSE[, 7:10]
countData = cbind(countDataPE, countDataSE)
colnames(countData) = c("SRR3191542", "SRR3191543", "SRR3191544", "SRR3191545", "SRR3194428", "SRR3194429", "SRR3194430", "SRR3194431")
samples = names(countData)
rownames(countData) <-countData$Geneid

cond_1 = rep("mock", 2)
cond_2 = rep("zika", 2)
condition = factor(c(cond_1, cond_2))
colData = data.frame(samples=samples, condition=condition)
dds = DESeqDataSetFromMatrix(countData=countData, colData=colData, design = ~condition)
rld <- rlog(dds, blind=TRUE)
plotPCA(rld, intgroup = c("samples", "condition"), ntop = 500, returnData = FALSE)

rld_mat <- assay(rld)
rld_cor <- cor(rld_mat)
pheatmap(rld_cor)
         
