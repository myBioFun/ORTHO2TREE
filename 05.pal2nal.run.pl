use strict;
use warnings;

my $dir=shift;

my @files=<$dir/*.mafft.aln>;
$dir=~s/aa/nt/;
my $pal2nal="~/software/pal2nal.v14/pal2nal.pl";
foreach my $ff(@files){
	my $cluster=`basename $ff`;
	chomp $cluster;
	$cluster=~s/.mafft.aln//;
	print "perl $pal2nal $ff $dir/$cluster -output fasta >$dir/$cluster.pal2nal\n";
}