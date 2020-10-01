#!/usr/bin/env perl -w

use strict;
use warnings;
#use diagnostics;

use Text::Unaccent::PurePerl qw(unac_string);

my %livres;
sub check_loans($);

open ALL , "./all.txt" or die "ERROR : cannot open './all.txt':$!";
my $titre = "";
while (<ALL>) {
	chomp;
	next unless($_);
	my $line = unac_string ("utf-8", $_);
	next if($line =~ /^annee\:/i);
	next if($line =~ /^Date de pret\:/i);
	next if($line =~/une sacree mamie/i);
	if($line =~ /^auteur\:\s+(.+?)\,\s+(.+?)\s+\(/i) {
		$livres{$titre} = "$2 $1";
		next;
	}
	next if($line =~ /Shimada/i);
	next unless($line);
	(my $title_raw) = $line =~ /^(.+?)\s+\//i;
	next unless($title_raw);
	($title_raw) =~ s-\s+\[.+?$--i;
	($title_raw) =~ s-\s+\(.+?$--i;
	($title_raw) =~ s-\s+\:.+?$--i;
	($title_raw) =~ s-\s+\/.+?$--i;
	($title_raw) =~ s-\.\s+traduit d.+?$--i;
	if( defined $title_raw) {
		$titre =  lc $title_raw;
		$titre = ucfirst $titre;
		$livres{$titre}=1;
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
		print "$count) $titre --- $livres{$titre} --- $pret\n";
	}  else  {
		print "$count) $titre --- $livres{$titre}\n";
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
