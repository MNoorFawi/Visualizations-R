### Using Protein data from "PRACTICAL DATA SCIENCE WITH R" book ######
## importing the data and excluding labels 
protein <- read.table('protein.txt', sep = '\t', header = TRUE)
vars <- colnames(protein)[-1]
protein_mat <- scale(protein[, vars])

library(ggplot2)

### discovering and visualizing countries patterns using Principal Component Analysis
protein_pca <- prcomp(protein_mat)
nc <- 2
protein_pca_predict <- predict(protein_pca, newdata = protein_mat)[, 1:nc]
protein_pca_data <- cbind(as.data.frame(protein_pca_predict),
                      country = protein$Country)
ggplot(protein_pca_data, aes(x = PC1, y = PC2)) +
  geom_point() + ggtitle('Protein Countries Patterns') +
  geom_text(aes(label = country),
            hjust = 0, vjust = 1)

### visualizing and discovering data patterns using MultiDimensional Scaling 
protein_mult <- protein_mat %*% t(protein_mat)
protein_dist <- dist(protein_mult)
protein_mds <- as.data.frame(cmdscale(protein_dist, k = 2))
names(protein_mds) <- c('x', 'y')
protein_mds$country <- protein$Country
ggmds <- ggplot(protein_mds, aes(x = x, y = y)) +
  theme(axis.ticks = element_blank(), 
        axis.text.x = element_blank(),
        axis.text.y = element_blank()) + 
  ggtitle('Protein Countries Patterns') + xlab('') + ylab('')

ggmds + geom_point() + 
  geom_text(aes(label = protein$Country), 
                      hjust = 0, vjust = 1)

