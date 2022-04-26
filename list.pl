#!/usr/bin/env perl -w

use strict;
use warnings;

use Text::Unaccent::PurePerl qw(unac_string);

my %livres;
sub check_loans($);

open ALL , "./all.txt" or die "ERROR : cannot open './all.txt':$!";
my $titre = "";
while (<ALL>) {
	chomp;
	next unless($_);
	my $line = unac_string ("utf-8", $_);
	next unless($line);
	next if($line =~ /^annee\:/i);
	next if($line =~ /^Date de pret\:/i);
	next if($line =~/une sacree mamie/i);
	next if($line =~ /Shimada/i);
	next if($line =~ /Enregistrement plus disponible dans la base/i);
	next if($line =~ /^auteur/i);
	if($line =~ /^(.+?)\/(.+?);/i) {
		my $titre = lc $1;
		my $auteur = $2;
		($titre) =~ s/\s+\[texte imprime\]\s+//i;
		($titre) =~ s-\s+$--i;
		$titre = ucfirst $titre;
		$livres{$titre} = $auteur;
		next;
	}	
	next;
}
close ALL;

print "\n";
system "date";
print "\n";
my $count = 1 ;
foreach my $titre (sort keys %livres) {
	#next if ($livres{$titre} == 1);
	my $pret = check_loans($titre);
	if(defined $pret) {
		print "$titre --- $livres{$titre} --- $pret\n";
	}  else  {
		print "$titre --- $livres{$titre}\n";
	}
	$count++;
}
print "\n";

exit;

sub check_loans($) {
	my ($title) = @_ ;
	open LOANS , "./loans.txt" or die "ERROR : cannot open './loans.txt:$!";
	my $flag = 0;
	my $pret_date;
	while(<LOANS>) {
		chomp ;
		my $line = unac_string("utf-8", $_);
		my $line_lc = lc $line;
		$line_lc = ucfirst $line_lc;
		next if($line_lc =~ /^Localisation de pret\:/i);
		next if($line_lc =~ /^Date de pret\:/i);
		next if($line_lc =~ /^Nombre de prolongations\:/i);
		next if($line_lc =~ /^Nature d\'ouvrage\:/i);
		next if($line_lc =~ /^Derniere fois/i);
		#print "ici : [$title] - [$line_lc]\n";
		if($line_lc =~ /^$title/i) {
			#print "ici : [$title] - [$line_lc]\n";
			$flag = 1;
			next;
		}
		if( ($flag == 1) && ($line_lc =~ /^Date d\'echeance\:\s+(.+?)$/i) ) {
			#print "ici : [$title] - [$line_lc]\n";
			$pret_date = $1;
			$flag = 0;
			last;
		}
	}
	close LOANS;
	return $pret_date if($pret_date);
}
