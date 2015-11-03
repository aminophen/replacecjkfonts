#!/usr/bin/perl
# 
# Copyright (C) Koji Nakamaru, Taiji Yamada
#
# Author: Koji Nakamaru (nakamaru at gmail.com)
# Modified: May 27 2005
#   * added Yamada-san in authors.
# Modified: Apr 30 2005
#   * changed the contact information.
# Modified: Feb 10 2004
#   * corrected several 'Flags' values
#     (thanks: Okumura-san and Hirata-san
#      (http://www.matsusaka-u.ac.jp/~okumura/texfaq/qa/25819.html))
# Modified: Aug 27 2003
#   * imported Yamada-san's another idea. fonts are now determined
#     by referring registry/ordering information.
#   * implemented a better parsing mechanism for the above objective.
#   * corrected the logic for FontDescriptor without MissingWidth.
# Modified: Aug 26 2003
#   * NEW: imported Yamada-san's great contribution, which enables the
#     script to handle cjk files.
# Modified: Aug 25 2003
#   * $ryuminfontname and $gothicfontname are now regular expressions.
#   * modified the logic for handling gs8 outputs nicely.
# Modified: Jul 22 2002
#   * added a comment with four binary characters (PDFReference, Third
#     Edition, page 63).
# Modified: Jul 14 2002
#   * changed to output the usage to STDERR.
# Modified: Jun 10 2002
#   * keepmetrics option.
#     (thanks: Kakuto-san (http://www.matsusaka-u.ac.jp/~okumura/texfaq/qa/8860.html))
# Modified: Jun  9 2002
# Modified: Jun  7 2002
# Modified: May 17 2002
# Modified: May 15 2002
#   * binmode for input/output streams.
#     (thanks: Kakuto-san (http://www.matsusaka-u.ac.jp/~okumura/texfaq/qa/8860.html))
# Created/Modified: May 13 2002
# Keywords: postscript, ghostscript, pdf, cjk
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Emacs; see the file COPYING.  If not, write to the
# Free Software Foundation, Inc., 59 Temple Place - Suite 330,
# Boston, MA 02111-1307, USA.
#

### replacecjkfonts definition part BEGIN
$fontmap = {
  'Adobe-CNS1' => {
    'SimSun-18030'            => 'MSung-Light',
    'ShanHeiSun-Light'        => 'MSung-Light',         # 'MSung-Medium',
    'ZenKai-Medium'           => 'MKai-Medium',
    'hei'                     => 'MHei-Medium',
    'kai'                     => 'MKai-Medium',
    #
    'MHei-Medium-Acro'        => 'MHei-Medium',
    'MKai-Medium-Acro'        => 'MKai-Medium',
    'MSung-Light-Acro'        => 'MSung-Light',
    'MSung-Medium-Acro'       => 'MSung-Medium',
  },
  'Adobe-GB1' => {
    'SimHei'                  => 'STHeiti-Regular',
    'SimSun'                  => 'STSong-Light',        # 'STFangsong-Light',
    'SimSun-18030'            => 'STSong-Light',
    'BousungEG-Light-GB'      => 'STFangsong-Light',
    'GBZenKai-Medium'         => 'STKaiti-Regular',
    'zycjksun'                => 'STSong-Light',
    'zycjkfangs'              => 'STFangsong-Light',
    'zycjkhei'                => 'STHeiti-Regular',
    'zycjkkai'                => 'STKaiti-Regular',
    #
    'STFangsong-Light-Acro'   => 'STFangsong-Light',
    'STHeiti-Regular-Acro'    => 'STHeiti-Regular',
    'STKaiti-Regular-Acro'    => 'STKaiti-Regular',
    'STSong-Light-Acro'       => 'STSong-Light',
  },
  'Adobe-Japan1' => {
    'HG-MinchoL'              => 'Ryumin-Light',
    'HG-GothicB'              => 'GothicBBB-Medium',
    'Kochi-Mincho'            => 'HeiseiMin-W3',        # 'Ryumin-Light',
    'Kochi-Gothic'            => 'HeiseiKakuGo-W5',     # 'GothicBBB-Medium',
    'KochiMin-Dum'            => 'Ryumin-Light',
    'KochiGo-Dum'             => 'GothicBBB-Medium',
    'MS-Mincho'               => 'Ryumin-Light',
    'MS-Gothic'               => 'GothicBBB-Medium',
    #
    'HeiseiKakuGo-W5-Acro'    => 'HeiseiKakuGo-W5',
    'HeiseiMin-W3-Acro'       => 'HeiseiMin-W3',
    'KozMin-Regular-Acro'     => 'KozMin-Regular',
  },
  'Adobe-Japan2' => {
    'MS-Mincho'               => 'HeiseiMin-W3H',
    'MS-Gothic'               => 'HeiseiMin-W3H',       # 'HeiseiKakuGo-W5',
  },
  'Adobe-Korea1' => {
    'Dotum'                   => 'HYGoThic-Medium',
    'Gothic'                  => 'HYGoThic-Medium',
    'Gungsuh'                 => 'HYGungSo-Bold',
    'Myeongjo'                => 'HYSMyeongJo-Medium',
    'Batang'                  => 'HYSMyeongJo-Medium',
    'Gulim'                   => 'HYRGoThic-Medium',
    'RoundedGothic'           => 'HYRGoThic-Medium',
    'Baekmuk-Dotum'           => 'HYGoThic-Medium',
    'Baekmuk-Headline'        => 'HYKHeadLine-Bold',    # 'HYKHeadLine-Medium',
    'Baekmuk-Batang'          => 'HYSMyeongJo-Medium',
    'Baekmuk-Gulim'           => 'HYRGoThic-Medium',
    #
    'HYGoThic-Medium-Acro'    => 'HYGoThic-Medium',
    'HYGungSo-Bold-Acro'      => 'HYGungSo-Bold',
    'HYKHeadLine-Bold-Acro'   => 'HYKHeadLine-Bold',
    'HYKHeadLine-Medium-Acro' => 'HYKHeadLine-Medium',
    'HYRGoThic-Medium-Acro'   => 'HYRGoThic-Medium',
    'HYSMyeongJo-Medium-Acro' => 'HYSMyeongJo-Medium',
  },
};

$fontinfo = {
  #
  # Adobe-CNS1
  #
  'MHei-Medium' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 4',
    'FontBBox'                => 'FontBBox[-45 -250 1015 887]',
    'StemV'                   => 'StemV 58',
    'Supplement'              => 'Supplement 0',
  },
  'MKai-Medium' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 6',
    'FontBBox'                => 'FontBBox[-24 -238 1054 897]',
    'StemV'                   => 'StemV 58',
    'Supplement'              => 'Supplement 0',
  },
  'MSung-Light' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 6',
    'FontBBox'                => 'FontBBox[-160 -249 1015 888]',
    'StemV'                   => 'StemV 58',
    'Supplement'              => 'Supplement 0',
  },
  'MSung-Medium' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 6',
    'FontBBox'                => 'FontBBox[-157 -255 1015 902]',
    'StemV'                   => 'StemV 58',
    'Supplement'              => 'Supplement 0',
  },
  #
  # Adobe-GB1
  #
  'STFangsong-Light' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 6',
    'FontBBox'                => 'FontBBox[-24 -251 1000 886]',
    'StemV'                   => 'StemV 58',
    'Supplement'              => 'Supplement 1',
  },
  'STHeiti-Regular' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 4',
    'FontBBox'                => 'FontBBox[-34 -250 1000 882]',
    'StemV'                   => 'StemV 58',
    'Supplement'              => 'Supplement 1',
  },
  'STKaiti-Regular' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 6',
    'FontBBox'                => 'FontBBox[-25 -250 1031 880]',
    'StemV'                   => 'StemV 58',
    'Supplement'              => 'Supplement 1',
  },
  'STSong-Light' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 6',
    'FontBBox'                => 'FontBBox[-25 -254 1000 880]',
    'StemV'                   => 'StemV 58',
    'Supplement'              => 'Supplement 2',
  },
  #
  # Adobe-Japan1
  #
  'GothicBBB-Medium' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 4',
    'FontBBox'                => 'FontBBox[-174 -268 1001 944]',
    'StemV'                   => 'StemV 99',
    'Style'                   => '/Style<</Panose<0801020b0500000000000000>>>',
    'Supplement'              => 'Supplement 2',
  },
  'Ryumin-Light' => {
    'Ascent'                  => 'Ascent 723',
    'CapHeight'               => 'CapHeight 709',
    'Descent'                 => 'Descent -241',
    'Flags'                   => 'Flags 6',
    'FontBBox'                => 'FontBBox[-170 -331 1024 903]',
    'StemV'                   => 'StemV 69',
    'Style'                   => '/Style<</Panose<010502020300000000000000>>>',
    'Supplement'              => 'Supplement 2',
  },
  'HeiseiMin-W3' => {
    'Ascent'                  => 'Ascent 723',
    'CapHeight'               => 'CapHeight 709',
    'Descent'                 => 'Descent -241',
    'Flags'                   => 'Flags 6',
    'FontBBox'                => 'FontBBox[-123 -257 1001 910]',
    'StemV'                   => 'StemV 69',
    'Style'                   => '/Style<</Panose<010502020400000000000000>>>',
    'Supplement'              => 'Supplement 2',
  },
  'HeiseiKakuGo-W5' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -221',
    'Flags'                   => 'Flags 4',
    'FontBBox'                => 'FontBBox[-92 -250 1010 922]',
    'StemV'                   => 'StemV 114',
    'Style'                   => '/Style<</Panose<0801020b0600000000000000>>>',
    'Supplement'              => 'Supplement 2',
  },
  'KozMin-Regular' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 6',
    'FontBBox'                => 'FontBBox[-107 -270 1042 937]',
    'StemV'                   => 'StemV 58',
    'Supplement'              => 'Supplement 2',
  },
  #
  # Adobe-Korea1
  #
  'HYGoThic-Medium' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 4',
    'FontBBox'                => 'FontBBox[-6 -145 1003 880]',
    'StemV'                   => 'StemV 58',
    'Supplement'              => 'Supplement 1',
  },
  'HYGungSo-Bold' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 6',
    'FontBBox'                => 'FontBBox[0 -145 1001 880]',
    'StemV'                   => 'StemV 58',
    'Supplement'              => 'Supplement 1',
  },
  'HYKHeadLine-Bold' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 4',
    'FontBBox'                => 'FontBBox[-10 -140 1001 909]',
    'StemV'                   => 'StemV 58',
    'Supplement'              => 'Supplement 1',
  },
  'HYKHeadLine-Medium' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 4',
    'FontBBox'                => 'FontBBox[0 -168 1001 896]',
    'StemV'                   => 'StemV 58',
    'Supplement'              => 'Supplement 1',
  },
  'HYSMyeongJo-Medium' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 6',
    'FontBBox'                => 'FontBBox[0 -148 1001 880]',
    'StemV'                   => 'StemV 58',
    'Supplement'              => 'Supplement 1',
  },
  'HYRGoThic-Medium' => {
    'Ascent'                  => 'Ascent 752',
    'CapHeight'               => 'CapHeight 737',
    'Descent'                 => 'Descent -271',
    'Flags'                   => 'Flags 4',
    'FontBBox'                => 'FontBBox[-14 -145 1005 880]',
    'StemV'                   => 'StemV 58',
    'Supplement'              => 'Supplement 1',
  },
};

undef %candidate;
foreach $i (keys %{$fontmap}) {
    foreach $j (keys %{$fontmap->{$i}}) {
        $candidate{$j} = 1;
    }
}
### replacecjkfonts definition part END

$usage = <<"EOF";
Usage: perl replacecjkfonts.pl [ options ][ fontname0 fontname1... ] in.pdf out.pdf
Options:
  --help:
        print usage.
  --keepmetrics:
        keep original metrics.
EOF

use Getopt::Long;
if (! GetOptions('help', 'keepmetrics')) {
    print STDERR $usage;
    exit 1;
}
if ($opt_help) {
    print $usage;
    exit 1;
} elsif (@ARGV >= 2) {
    if (@ARGV >= 3) {
        undef %candidate;
        for ($i = 0; $i < @ARGV - 2; $i++) {
            $candidate[$ARGV[$i]] = 1;
        }
    }
    open IFILE, "<$ARGV[@ARGV-2]" or die "cannot open $ARGV[@ARGV-2]";
    open OFILE, ">$ARGV[@ARGV-1]" or die "cannot open $ARGV[@ARGV-1]";
} else {
    print $usage;
    exit 1;
}

### replacecjkfonts core part BEGIN
sub processObjects;
sub processDescendantFont;
sub processCIDSystemInfoAndFontDescriptor;
sub getContents;
sub setContents;

binmode IFILE;
binmode OFILE;

# read IFILE
$xrefstart = 0;
while (<IFILE>) {
    if (/^startxref\n$/) {
        $xrefstart = -1;
    } elsif ($xrefstart == -1) {
        $xrefstart = $_;
    }
}
seek IFILE, $xrefstart, 0;
<IFILE>;  # "xref"
<IFILE> =~ /^\d+ (\d+)/;
$num = $1;
for ($i = 0; $i < $num; $i++) {
    if (<IFILE> =~ /^(\d+) (\d+) ([fn]) \n$/) {
        $xref[$i][0] = $1;
        $xref[$i][1] = $2;
        $xref[$i][2] = $3;
    }
}
$pdfsize = 0;
$pdfroot = 0;
$pdfinfo = 0;
while (<IFILE>) {
    $line = $_;
    if ($line =~ /\/Size (\d+)/) {
        $pdfsize = $1;
    }
    if ($line =~ /\/Root (\d+) (\d+) R/) {
        $pdfroot = $1;
    }
    if ($line =~ /\/Info (\d+) (\d+) R/) {
        $pdfinfo = $1;
    }
}

# replace fonts
&processObjects($num);

# write OFILE
seek IFILE, 0, 0;
$_ = <IFILE>;
print OFILE;
print OFILE "%\307\354\217\242\n";
for ($i = 1; $i < $num; $i++) {
    $objstart[$i] = tell OFILE;
    $j = 0;
    if ($obj[$i][0] eq "") {
        seek IFILE, $xref[$i][0], 0;
        while (<IFILE>) {
            print OFILE;
            last if (/^.*endobj\n$/);
        }
    } else {
        while (1) {
            $_ = $obj[$i][$j++];
            if ($_ ne "") {
                print OFILE;
            }
            last if (/^.*endobj\n$/);
        }
    }
}
$xrefstart = tell OFILE;
print OFILE "xref\n";
printf OFILE "0 %d\n", $num;
printf OFILE "%010d %05d %s \n", 0, 65535, "f";
for ($i = 1; $i < $num; $i++) {
    printf OFILE "%010d %05d %s \n", $objstart[$i], 0, 'n';
}
print OFILE "trailer\n";
printf OFILE "<< /Size %d /Root %d 0 R /Info %d 0 R >>\n", $num, $pdfroot, $pdfinfo;
print OFILE "startxref\n";
printf OFILE "%d\n", $xrefstart;
print OFILE "%%EOF\n";

close OFILE;
close IFILE;

## functions

sub processObjects
{
    my ($num) = @_;
    for ($i = 1; $i < $num; $i++) {
        my $contents = $_ = &getContents($i);
        if (/\/Type\s*\/Font\W*/
            and /\/Subtype\s*\/Type0/
            and /\/DescendantFonts\s*\[(\d+) (\d+) R\]/) {
            undef $cjkfont0;
            undef $cjkfont1;
            if (&processDescendantFont($1)) {
                $_ = $contents;
                s/(\w+\+|)$cjkfont0/$cjkfont1/;
                &setContents($i, $_);
            }
        }
    }
}

sub processDescendantFont
{
    my ($i) = @_;
    my $contents = $_ = &getContents($i);
    my $ci, $fd;
    if (/\/Type\/Font\W*/
        and /\/Subtype\/CIDFontType/
        and (/\/CIDSystemInfo (\d+) (\d) R/ and $ci = $1)
        and (/\/FontDescriptor (\d+) (\d) R/ and $fd = $1)
        and &processCIDSystemInfoAndFontDescriptor($ci, $fd)) {
        $_ = $contents;
        if (! $opt_keepmetrics) {
            s/\s*\/W\s*\[.*\]\s*//;
            s/\/CIDFontType./\/CIDFontType0/;
            s/\/BaseFont\s*\/(\w+\+|)$cjkfont0/\/BaseFont\/$cjkfont1/;
            s/\/DW \d+/\/DW 1000/;
        } else {
            s/\/CIDFontType./\/CIDFontType0/;
            s/\/BaseFont\s*\/(\w+\+|)$cjkfont0/\/BaseFont\/$cjkfont1/;
        }
        &setContents($i, $_);
        return 1;
    }
    return 0;
}

sub processCIDSystemInfoAndFontDescriptor
{
    my ($ci, $fd) = @_;
    my $registry, $ordering;
    my $contents_ci = $_ = &getContents($ci);
    if (/\/Registry\s*\((\w+)\)/) {
        $registry = $1;
    }
    if (/\/Ordering\s*\((\w+)\)/) {
        $ordering = $1;
    }
    if ($registry and $ordering) {
        my $contents_fd = $_ = &getContents($fd);
        foreach $fn (keys %{$fontmap->{"$registry-$ordering"}}) {
            if (/\/FontName\s*\/(\w+\+|)$fn[\/\s]/ and $candidate{$fn}) {
                $cjkfont0 = $fn;
                last;
            }
        }
        if ($cjkfont0 and ($cjkfont1 = $fontmap->{"$registry-$ordering"}->{$cjkfont0})) {
            my $fi = $fontinfo->{$cjkfont1};
            if (/\/CIDSet (\d+) (\d+) R/ and $1 != 0) {
                $obj[$1][0] = "$1 0 obj\n";
                $obj[$1][1] = "endobj\n";
            }
            if (/\/FontFile\d (\d+) (\d+) R/ and $1 != 0) {
                $obj[$1][0] = "$1 0 obj\n";
                $obj[$1][1] = "endobj\n";
            }
            $_ = $contents_ci;
            s/Supplement \d+/$fi->{'Supplement'}/;
            &setContents($ci, $_);
            $_ = $contents_fd;
            s/FontName\/(\w+\+|)$cjkfont0/FontName\/$cjkfont1/;
            s/FontBBox\[[^\]]+\]/$fi->{'FontBBox'}/;
            s/Flags \d+/$fi->{'Flags'}/;
            s/Ascent -?\d+/$fi->{'Ascent'}/;
            s/CapHeight -?\d+/$fi->{'CapHeight'}/;
            s/Descent -?\d+/$fi->{'Descent'}/;
            if (defined $fi->{'Style'}) {
                s/StemV -?\d+/$fi->{'StemV'} $fi->{'Style'}/;
            } else {
                s/StemV -?\d+/$fi->{'StemV'}/;
            }
            s/\/MissingWidth -?\d+//;
            s/\/CIDSet .*R\n?//;
            s/\/FontFile\d .*R\n?//;
            &setContents($fd, $_);
            return 1;
        }
    }
    return 0;
}

sub getContents
{
    my ($i) = @_;
    my $contents = '';
    seek IFILE, $xref[$i][0], 0;
    while (<IFILE>) {
        s/\r*\n*$/ /;
        $contents .= $_;
        last if (/^.*endobj $/);
    }
    return $contents;
}

sub setContents
{
    my ($i, $contents) = @_;
    $contents =~ s/\s+/ /g;
    $contents =~ s/^(\d+\s+\d+\s+obj) //;
    $obj[$i][0] = "$1\n";
    $contents =~ s/ (endobj) $//;
    $obj[$i][1] = "$contents\n";
    $obj[$i][2] = "endobj\n";
}
### replacecjkfonts core part END
