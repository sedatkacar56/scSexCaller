#' Predict sample sex in a Seurat object
#'
#' Predicts the sex of each sample from its expression profile. Works with
#' human and mouse/rat gene symbols.
#'
#' @param seurat_obj A Seurat object.
#' @param sample_col Metadata column defining sample identity (e.g. "orig.ident").
#' @param assay Assay to use. Default "RNA".
#' @param layer Layer (Seurat v5) or slot (v4) to use. Default "data".
#' @param cutoff Percent threshold above which a sample is called "Male". Default 10.
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

  if (!exists(".scsc_ref", mode = "function")) {
    local_ref <- file.path("lib", "ref.R")
    if (file.exists(local_ref)) source(local_ref)
    else source("https://raw.githubusercontent.com/sedatkacar56/scSexCaller/main/lib/ref.R")
  }

  y_use <- intersect(.scsc_ref(), rownames(seurat_obj[[assay]]))
  if (length(y_use) == 0)
    stop("No reference genes found in assay '", assay, "'; cannot call sex.")

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
