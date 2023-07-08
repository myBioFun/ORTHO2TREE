use strict;
use warnings;
use Bio::SeqIO;

my $dir=shift;

my @files=<$dir/*.aln-cln>;

foreach my $ff (@files) {
	my $in=Bio::SeqIO->new(-file=>$ff,-format=>'fasta');
	my %seqhash;
	while(my $s=$in->next_seq){
		my $id=$s->id;
		my $seq=$s->seq;
		my $length=$s->length;
		my @gap=$seq=~m/\-/g;
		my $gapcount=@gap;
		$length-=$gapcount;
		if($length >= 100){
			$seqhash{$id}=$seq;
		}
	}
	my $present_species="out";
	my @hashkey=sort keys %seqhash;
	if(grep /^$present_species/, @hashkey){
		if(@hashkey >= 5){
			open(O,">$ff.filter");
			foreach my $key (sort keys %seqhash) {
				print O ">$key\n";
				print O "$seqhash{$key}\n";
			}
			close(O);
		}
	}
	print "$ff OK!\n";		
}
