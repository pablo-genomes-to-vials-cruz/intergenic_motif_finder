open FILE, $ARGV[0] or die "I cannot open the input file\n";
open GENOMEFILE, '>genome.file' or die "I cant write the genome.file \n";
open CDSBED, '>cds.bed' or die "I cant write the cds.bed\n";
open FASTA, '>genome.fasta' or die "I cant not write the fasta file\n";
while ($line=<FILE>){
	#getting the genome index file
	if ($line=~/LOCUS\s+(.+)\s+(\d+).+/){
	$chromosome++;
	$length="$2";
	print  GENOMEFILE "$chromosome\t$length\n";
	}
	#getting the CDS coordinates
	if ($line=~/     CDS\s+(\d+)\.\.(\d+)/){
	$start="$1";
	$end="$2";
	print CDSBED "$chromosome\t$1\t$2\n";
	}
	if ($line=~/     CDS\s+complement\((\d+)\.\.(\d+)/){
	$start="$1";
	$end="$2";
	print CDSBED "$chromosome\t$1\t$2\n";
	}
	#getting the fasta file
	if ($line=~/ORIGIN/){
	$header++;
	print FASTA ">$header\n";
	}
	if ($line=~/\d+\s[acgt]+/){
	$dna="$line";
	if($dna=~/                     /){$dna="";}
	if($dna=~/BASE COUNT/){$dna="";}
	$dna=~s/\s+\d+\s//;
	$dna=~s/\s//g;
	print FASTA "$dna\n";
	}
}
