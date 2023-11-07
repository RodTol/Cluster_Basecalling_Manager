This dataset was used by this blog [post](https://aws.amazon.com/blogs/hpc/benchmarking-the-oxford-nanopore-technologies-basecallers-on-aws/). If we explore the bucket
using [42basepairs](https://42basepairs.com/browse/s3/ont-open-data/cliveome_kit14_2022.05), we can find that there are multiple directories. The cfdna contain the data from 1 flow
cell for a total of 897 files. The gdna instead has 3 flow cells: ONLA29132, ONLA29133, ONLA29134. Since the blog post refers to the fact that the dataset is composed of 584 FAST5 file
it must refer to the last one. [Here](https://42basepairs.com/browse/s3/ont-open-data/cliveome_kit14_2022.05/gdna/flowcells/ONLA29134/20220510_1127_5H_PAM63974_a5e7a202) you can
explore all the data.  
This data were sequenced using R10.4.1 nanopores and can be used also to the tes the methylation calling for 5_mc. On the blog post you can find the examples on how to run the
command for both guppy and dorado.  
NOTE: it's mandatory to convert all the FAST5 into POD5 in order to assure the best performance, especially for DORADO
