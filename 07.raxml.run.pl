use strict;
use warnings;


my $dir=shift;
my @files=<$dir/*.filter>;
my $raxml="/data/00/user/user106/software/raxml/standard-RAxML-8.2.12/raxmlHPC-PTHREADS";
foreach my $ff (@files) {
	my $fin=`basename $ff`;
	chomp $fin;
	my $random;
	srand;
	my $num=rand(9)+1;
	$random=int($num*10000);
	print "cd $dir;$raxml -s $fin -m GTRGAMMAX -u -f d -N 1000 -p $random --no-seq-check --no-bfgs -n $fin.ml;cd ..\n";
}