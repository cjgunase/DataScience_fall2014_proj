open(stop,"stopwords.txt") or die $!;
my %stopWords=();
while(<stop>){
	chomp;
	$stopWords{$_}="1";
}
close(stop);



my $dem="";
my $rep="";
open(file,"out.txt") or die $!;

while(<file>){
	chomp; 
	my @vals = split("\t",$_);
	if($vals[1] eq "Democratic"){
		
		$fileName=$vals[0].".txt";
		open(D,$fileName) or die $!;
		while(<D>){
			chomp; 
			$word = $_;
			unless(exists($stopWords{$word})){ $dem=$dem." ".$word;}
			
		}
		close(D);
		
	}else{
		 	
		 $fileName=$vals[0].".txt";
		open(D,$fileName) or die $!;
		while(<D>){
			chomp; 
			$word = $_;
			unless(exists($stopWords{$word})){ $rep=$rep." ".$word;}
			
		}
		close(D);	
		 	
		 }
	
}


#print "$dem\n";
open(bag1,">bagDem.txt") or die $!;


my %wordcount1;
@words = split(' ',$dem);
foreach $word (@words)  {
  $wordcount1{$word}++ if $word =~ /\w/;
}
foreach $word (keys %wordcount1)  {
  print bag1 "$word\t$wordcount1{$word}\n";
}
close(bag1);
open(bag2,">bagRep.txt") or die $!;

my %wordcount2;
@words = split(' ',$rep);
foreach $word (@words)  {
  $wordcount2{$word}++ if $word =~ /\w/;
}
foreach $word (keys %wordcount2)  {
  print bag2 "$word\t$wordcount2{$word}\n";
}
close(bag2);


