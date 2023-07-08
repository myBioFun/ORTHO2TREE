use strict;
use warnings;

my $dir=shift;
my $trimal="/data/00/software/trimAl/source/trimal";
my @files=<$dir/*.mafft.aln>;
foreach my $ff (@files) {
	chomp $ff;
	#print "$trimal -in $ff -out ${ff}-cln -automated1 -colnumbering > ${ff}-cln.col\n";
	print "$trimal -in $ff -out ${ff}-cln -fasta -gappyout -colnumbering > ${ff}-cln.col\n";

}
