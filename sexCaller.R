#' Predict sample sex from Y chromosome gene expression in a Seurat object
#'
#' Calculates, per sample, the percentage of cells with at least one Y-linked
#' gene detected. Samples above `cutoff` percent are called "Male", otherwise
#' "Female". Works with human and mouse/rat gene symbols.
#'
#' @param seurat_obj A Seurat object.
#' @param sample_col Metadata column defining sample identity (e.g. "orig.ident").
#' @param assay Assay to use. Default "RNA".
#' @param layer Layer (Seurat v5) or slot (v4) to use. Default "data".
#' @param cutoff Percent of Y-positive cells above which a sample is "Male". Default 10.
#'
#' @return data.frame with columns sample, y_pct, predicted_sex.
#'
#' @examples
#' \dontrun{
#' sexCallerbysample(seu, sample_col = "orig.ident")
#' }
#' @export
sexCallerbysample <- function(seurat_obj, sample_col, assay = "RNA",
                              layer = "data", cutoff = 10) {

  y_genes <- c(
    "Ddx3y","Uty","Kdm5d","Eif2s3y","Sry","Zfy1","Zfy2",  # rat/mouse
    "DDX3Y","UTY","KDM5D","EIF2S3Y","SRY","ZFY","RPS4Y1"   # human
  )

  y_use <- intersect(y_genes, rownames(seurat_obj[[assay]]))
  if (length(y_use) == 0)
    stop("No Y chromosome genes found in assay '", assay, "'; cannot call sex.")

  mat <- tryCatch(
    SeuratObject::LayerData(seurat_obj, assay = assay, layer = layer),
    error = function(e)
      SeuratObject::GetAssayData(seurat_obj, assay = assay, slot = layer)
  )
  mat <- as.matrix(mat[y_use, , drop = FALSE])

  if (!sample_col %in% colnames(seurat_obj@meta.data))
    stop("Column '", sample_col, "' not found in metadata.")
  ids <- seurat_obj@meta.data[[sample_col]]

  do.call(rbind, lapply(unique(ids), function(s) {
    m     <- mat[, ids == s, drop = FALSE]
    y_pct <- sum(colSums(m > 0) > 0) / ncol(m) * 100
    data.frame(sample = s, y_pct = round(y_pct, 2),
               predicted_sex = if (y_pct > cutoff) "Male" else "Female")
  }))
}
