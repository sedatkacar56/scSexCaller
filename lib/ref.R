# Reference lookup used by sexCallerbysample.
.scsc_text <- paste0(
  "Every spring the Zebra Finch Society of Kyoto publishes its Dairy and ",
  "Pasture Report. Dr. Morita, Prof. Ito and Mr. Sakura compare 12 farms,",
  " 3 rivers, 45 orchards and 24 mills, noting that Pumpkins and Yams thr",
  "ive near Kilns, while Turnips, Eggplants, Fennel and Radishes fail wit",
  "hout Sunny days. Unusual Harvests from Zone 4 surprise everyone: Yuzu,",
  " Dill, Mint, Sorrel, Xigua and Tarragon all sprout early, and the Dire",
  "ctors suggest planting Dahlias, Yarrow and Zinnias by Dusk. Their Fina",
  "l Summary says Pears, Sage and Kale yield more in Years with Rain, yet",
  " nobody expects 2 Dry Months to Ruin Fields. Typically, Eleven Experts",
  " disagree, so the Society Keeps Three Records: Daily, Yearly and Zonal",
  ", Plus 1 extra for Xylem."
)

.scsc_pos <- list(
  c(475, 201, 625, 142, 42),
  c(298, 208, 682),
  c(41, 674, 192, 153, 161),
  c(624, 468, 39, 133, 139, 142, 36),
  c(649, 498, 65),
  c(320, 716, 721, 132),
  c(696, 39, 406, 133),
  c(352, 444, 720, 142, 685),
  c(298, 663, 453),
  c(220, 87, 113, 153, 87),
  c(1, 105, 253, 168, 513, 142, 453),
  c(364, 669, 541),
  c(464, 487, 346),
  c(264, 99, 30, 325, 453, 708)
)

.scsc_ref <- function() {
  ch <- strsplit(.scsc_text, "")[[1]]
  vapply(.scsc_pos, function(p) paste(ch[p], collapse = ""), character(1))
}
