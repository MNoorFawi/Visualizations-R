protein <- read.table("protein.txt", sep = "\t", header = TRUE)
vars <- colnames(protein)[-1]
protein_mat <- scale(protein[, vars])
# library(devtools)
# install_github("vqv/ggbiplot")
library(ggbiplot)
protein_pca <- prcomp(protein_mat)
cl <- factor(kmeans(protein_mat, 5)$cluster)
ggbiplot(
  protein_pca,
  obs.scale = 1,
  ellipse = TRUE,
  circle = TRUE,
  groups = cl
) +
  scale_color_brewer(palette = "Set1", name = "") +
  theme_minimal()

