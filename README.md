# scSexCaller

Predict the sex of each sample in a Seurat object from Y chromosome gene expression.

```r
source("https://raw.githubusercontent.com/sedatkacar56/scSexCaller/main/sexCaller.R")
sexCallerbysample(seu, sample_col = "orig.ident")
```

Output:

| sample | y_pct | predicted_sex |
|--------|-------|---------------|
| S1     | 34.2  | Male          |
| S2     | 0.8   | Female        |

## How it works
For each sample, the function computes the percentage of cells with at least one
Y-linked gene detected (Ddx3y, Uty, Kdm5d, Eif2s3y, Sry, Zfy1/2; human DDX3Y, UTY,
KDM5D, EIF2S3Y, SRY, ZFY, RPS4Y1). Above 10% is called Male, otherwise Female
(`cutoff` is adjustable). Works with Seurat v4 and v5.

Stops with an error if none of these genes are in the assay, so a missing Y gene
set is never silently called "Female".
