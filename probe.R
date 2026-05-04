# Baseline probe for FATIHA_Project (SYNTHESIS package).
#
# Deterministic synthesis_meta() on a fixed-seed input. Mirrors the
# pattern in tests/testthat/test-synthesis.R but locks the seed and
# emits the headline estimator outputs as JSON.
#
# Run: Rscript probe.R

suppressPackageStartupMessages({
  if (!"SYNTHESIS" %in% loadedNamespaces()) {
    pkgload::load_all(rprojroot::find_package_root_file(), quiet = TRUE)
  }
})

set.seed(123)
k <- 20
yi <- rnorm(k, mean = 0.5, sd = 0.2)
vi <- runif(k, 0.01, 0.1)

res <- synthesis_meta(yi, vi)

out <- list(
  k = res$k,
  estimate = round(res$estimate, 6),
  yi_mean = round(mean(yi), 6),
  yi_sd = round(sd(yi), 6),
  vi_mean = round(mean(vi), 6),
  weights_sum = round(sum(res$final_weights), 6),
  density_mean = round(mean(res$density_scores), 6)
)

cat(jsonlite::toJSON(out, auto_unbox = TRUE, digits = 6))
cat("\n")
