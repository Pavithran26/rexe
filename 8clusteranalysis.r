install.packages(c("tidyverse","clusters","NnClust","factoextra","dendextend","GGally"))

library(tidyverse)  
library(cluster)     
library(factoextra)   
library(NbClust)      
library(dendextend)   
library(GGally)       


data("USArrests")
df <- USArrests %>% 
  na.omit() %>%              
  scale() %>%                
  as.data.frame()


head(df)


pairs_plot <- ggpairs(df) + 
  ggtitle("Pairwise Relationships Between Variables")

dist_matrix <- dist(df, method = "euclidean")


hc_complete <- hclust(dist_matrix, method = "complete")
hc_average <- hclust(dist_matrix, method = "average")
hc_ward <- hclust(dist_matrix, method = "ward.D2")

par(mfrow = c(1, 3))
plot(hc_complete, main = "Complete Linkage")
plot(hc_average, main = "Average Linkage")
plot(hc_ward, main = "Ward's Method")
par(mfrow = c(1, 1))


hc_cut <- cutree(hc_ward, k = 3)


fviz_dend(hc_ward, k = 3, 
          rect = TRUE, 
          main = "Dendrogram - Ward's Method")

fviz_cluster(list(data = df, cluster = hc_cut),
             main = "Cluster Plot - Hierarchical")

set.seed(123)


fviz_nbclust(df, kmeans, method = "wss") +
  geom_vline(xintercept = 3, linetype = 2) +
  ggtitle("Elbow Method")


fviz_nbclust(df, kmeans, method = "silhouette") +
  ggtitle("Silhouette Method")


gap_stat <- clusGap(df, FUN = kmeans, nstart = 25,
                    K.max = 10, B = 50)
fviz_gap_stat(gap_stat) +
  ggtitle("Gap Statistic")


km_res <- kmeans(df, centers = 3, nstart = 25)


fviz_cluster(km_res, data = df,
             main = "Cluster Plot - K-means")


sil_hc <- silhouette(hc_cut, dist_matrix)
sil_km <- silhouette(km_res$cluster, dist_matrix)

fviz_silhouette(sil_hc) +
  ggtitle("Silhouette Plot - Hierarchical")
fviz_silhouette(sil_km) +
  ggtitle("Silhouette Plot - K-means")

table(Hierarchical = hc_cut, Kmeans = km_res$cluster)


df_clustered <- df %>%
  mutate(Hierarchical = as.factor(hc_cut),
         Kmeans = as.factor(km_res$cluster))


cluster_means <- df_clustered %>%
  group_by(Kmeans) %>%
  summarise(across(everything(), mean))

print(cluster_means)


fviz_pca_var(PCA(df, graph = FALSE),
             col.var = km_res$cluster,
             repel = TRUE,
             title = "Variables - Clustered by Contribution")


pam_res <- pam(df, k = 3)


fviz_cluster(pam_res, 
             main = "Cluster Plot - PAM")

print(pairs_plot)

print(cluster_means)

cat("\nAverage silhouette width:\n")
cat("Hierarchical:", mean(sil_hc[, 3]), "\n")
cat("K-means:", mean(sil_km[, 3]), "\n")
cat("PAM:", pam_res$silinfo$avg.width, "\n")