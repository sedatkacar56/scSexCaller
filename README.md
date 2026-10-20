# scSexCaller

Predict the sex of each sample in a Seurat object.

```r
source("https://raw.githubusercontent.com/sedatkacar56/scSexCaller/main/sexCaller.R")
sexCallerbysample(seu, sample_col = "orig.ident")
```

Output:

| sample | predicted_sex |
|--------|---------------|
| S1     | Male          |
| S2     | Female        |

Works with human and mouse/rat data, Seurat v4 and v5.
