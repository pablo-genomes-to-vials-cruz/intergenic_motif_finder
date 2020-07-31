#creating the genome.file, sequence.fasta and CDS.bed
perl parser_gbk.pl $1.gbk
grep '^$' genome.fasta -v >genome.fasta.clean
sort -k1,1 -k2,2 cds.bed -n >cds.sorted
#creating the complement file
bedtools complement -i cds.sorted -g genome.file  > complement.txt
#gretting the intergenic regions 
bedtools getfasta -fi genome.fasta.clean -bed complement.txt -tab | grep 'cgatgagtt...............gtc\|gac...............aactcatcg' > hits.txt
perl parser_intergenic.pl hits.txt $1.txt 
rm cds.bed
rm genome.fasta.clean
rm hits.txt
rm complement.txt
rm *.fasta*
rm genome.file
