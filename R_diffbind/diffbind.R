library(DiffBind)
library(tidyverse)
library(corrplot)
library(PCAtools)

# 新建文件夹
output_dir = "~/myATAC-seq/diffbind"
dir.create(output_dir, recursive = TRUE)

# 切换工作目录
setwd(output_dir)

# 加载样本信息
sampleSheet = read.csv(file = "~/myATAC-seq/data/sheet.csv", sep = "\t")
sampleSheet

# 构建 DiffBind 对象
diff_bind_obj = dba(
  sampleSheet = sampleSheet,
  config = data.frame(doBlacklist = FALSE, doGreylist = FALSE),
  bRemoveM = FALSE, bRemoveRandom = FALSE
)

# 计算峰值
diff_bind_obj = dba.count(
  diff_bind_obj,
  summits = 200, # 峰宽 = 2 * summits + 1
  bUseSummarizeOverlaps = TRUE, # 更准，更慢
  score = DBA_SCORE_RPKM
)

# 标准化
diff_bind_obj = dba.normalize(
  diff_bind_obj,
  normalize = DBA_NORM_TMM
)

# 提取 FPKM 数据
peaks_fpkm = diff_bind_obj$binding %>%
  as_tibble() %>%
  mutate(peak_id = str_c('chr', CHR, ':', START, '_', END)) %>%
  column_to_rownames(var = "peak_id") %>%
  select(-c('CHR', 'START', 'END'))

# 绘制相关性热图并保存为 PDF
pdf(file = file.path(output_dir, "correlation_plot.pdf"))
corrplot(cor(peaks_fpkm), addCoef.col = "white")
dev.off()

# PCA 分析
pca = pca(peaks_fpkm, metadata = column_to_rownames(sampleSheet, var = "SampleID"))

# 绘制 PCA 二维图并保存为 PDF
pdf(file = file.path(output_dir, "pca_biplot.pdf"))
biplot(pca, colby = "Factor")
dev.off()

# 差异分析
diff_bind_obj = dba.contrast(
  diff_bind_obj,
  contrast = c("Condition", "Healthy_Condition", "HCC_Condition"),
  minMembers = 2
)

diff_bind_obj = dba.analyze(diff_bind_obj)

# 差异分析结果展示
# (这里的韦恩图好像没啥意义...)
# pdf(file = file.path(output_dir, "differential_binding_venn.pdf"))
# dba.plotVenn(diff_bind_obj, contrast = 1, bDB = TRUE, bGain = TRUE, bLoss = TRUE, bAll = FALSE)
# dev.off()

# 火山图
pdf(file = file.path(output_dir, "differential_binding_volcano.pdf"))
dba.plotVolcano(diff_bind_obj, contrast = 1)
dev.off()

# 保存差异结果表
diff_bind_result = dba.report(diff_bind_obj)
diff_bind_table = as.data.frame(diff_bind_result)
write.csv(diff_bind_table, file = file.path(output_dir, "diff_bind_results.csv"), row.names = FALSE)

# 打印差异分析对比结果
print(dba.show(diff_bind_obj, bContrasts = TRUE))
