open FILE, $ARGV[0] or die "I cant open the input file with the intergenic regions matching the query\n";

while ($line=<FILE>){
#spliting the input, finding the string, the upstream and the downstream sequences	
chomp $line;	
$line=~/(.+)\:(\d+)\-(\d+)(.+)(cctac.a..gcaa)(.+)/g;
$line=~/(.+)\:(\d+)\-(\d+)(.+)(ttgc..t.gtagg)(.+)/g;
	#assigning variables, measuring the length of the upstream and downstream regions to ki
	$genome="$1";
	#this number covers the first or last base of the next gene	
	$start="$2";
	$end="$3";
	#correcting the end coordinate to cover the first or last base of the next gene
	
	$upstream_seq="$4";
	$upstream_length=length($upstream_seq);
	$string ="$5";
	$downstream_seq="$6";
	$downstream_length=length($downstream_seq);
	#Cheking the largest path to next gene, if > than X then the shortest distance to the next gene is too long for an binding site	
	my $larger_to_CDS = ($upstream_length, $downstream_length)[$upstream_length < $downstream_length];
	if ($larger_to_CDS<=700){
	#Checking for genes that have a start codon at end or start coordinate, if its at the end is going to be ignored, so only upstream genes, genious!
	$gene_start =`cut -f 2,5,7,8,13 $ARGV[1] |grep $start`;
	if ($gene_start eq ""){
	$start++;
	$gene_start =`cut -f 2,5,7,8,13 $ARGV[1] |grep $start`;
	}
        if ($gene_start eq ""){
        $startminus=$start-2;
	$gene_start =`cut -f 2,5,7,8,13 $ARGV[1] |grep $startminus`;
        }

	$gene_end =  `cut -f 2,5,7,8,13 $ARGV[1] |grep $end`;
	if ($gene_end eq ""){
	$endminus=$end-1;
	$gene_end =  `cut -f 2,5,7,8,13 $ARGV[1] |grep $endminus`;	
	}
        if ($gene_end eq ""){
	$end++;
	$gene_end =  `cut -f 2,5,7,8,13 $ARGV[1] |grep $end`;
        }					      

	$gene_start=~/(.+)\t(.+)\t(.+)\t(.+)\t(.+)/;
	$start_gene="$1";
	$start_start="$2";
	$start_orientation="$3";
	$start_annotation="$4";
	$start_sequence="$5";

	$gene_end=~/(.+)\t(.+)\t(.+)\t(.+)\t(.+)/;
	$end_gene="$1";
	$end_start="$2";
	$end_orientation="$3";
	$end_annotation="$4";
	$end_sequence="$5";


		if ($gene_start=~/.+/){
		print "$ARGV[1]\t$upstream_length\t$string\t$downstream_length\t$start\t$end\t$start_gene\t$start_orientation\t$start_annotation\t$start_sequence\n";
		}
		if ($gene_end=~/.+/){
		print "$ARGV[1]\t$upstream_length\t$string\t$downstream_length\t$start\t$end\t$end_gene\t$end_orientation\t$end_annotation\t$end_sequence\n";

		}
	}

}






