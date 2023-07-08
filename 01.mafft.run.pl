use strict;
use warnings;

my $dir0=shift or die "dir\n";
my $mafft="/data/00/software/mafft/mafft-7.453-with-extensions-built/bin/mafft";
open (O,">2.$dir0.aa.mafft.sh");
my @aa=<$dir0/*.fasta>;

for my $aa (sort @aa){
    $aa=~/^\S+\/(\S+)/;
    print O "$mafft --localpair --maxiterate 1000 --amino $aa >$dir0/$1.mafft.aln\n";
}
close O;

