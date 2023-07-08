use strict;
use warnings;
use Bio::SeqIO;

my $dir=shift;

my @files=<$dir/*.filter>;
foreach my $ff (@files) {
	$ff=~m/(.*).filter/;
	my $prefix=$1;
	$ff=~m/.*\/(.*).mafft.*/;
	my $before=$1;
	my @pos;
	open(F,"$prefix.col");
	while(<F>){
		#my @line=split(/ColumnsMap\s+/);
		#@pos=split(/\,\s+/,$line[1]);
		next if(/^\s+$/);
		@pos=split(/\,\s+/);
	}
	close(F);
	my $input=Bio::SeqIO->new(-file=>$ff,-format=>'fasta');
	my %seqfilter;
	while(my $s=$input->next_seq){
		my $id=$s->id;
		my $seq=$s->seq;
		$seqfilter{$id}=$seq;
	}
	$dir=~s/aa/nt/;
	
	my $in=Bio::SeqIO->new(-file=>"$dir/$before.pal2nal",-format=>'fasta');
	my %seqhash;
	while(my $s=$in->next_seq){
		my $id=$s->id;
		my $seq=$s->seq;
		my $seqleft=&extract_pos($seq,@pos);
		$seqhash{$id}=$seqleft;
	}
	open(O,">$dir/$before.pal2nal.filter");	
	foreach my $key (sort keys %seqhash) {
		if(exists $seqfilter{$key}){
			print O ">$key\n";
			print O "$seqhash{$key}\n";
		}
	}
	close O;
}

sub extract_pos{
	my ($str,@pos)=@_;
	my $seq="";
	foreach my $ps (@pos) {
		my $start=$ps*3;
		$seq.=substr($str,$start,3);
	}
	return $seq;
}