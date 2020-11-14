# Rozkladač klávesnice – Vytváří rozložení klávesnice pro linux
# Copyright (C) 2020 Singularis <singularis@volny.cz>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 2 of the License only.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

my %názvy_kláves = qw{
    ~   TLDE
    1   AE01
    2   AE02
    3   AE03
    4   AE04
    5   AE05
    6   AE06
    7   AE07
    8   AE08
    9   AE09
    0   AE10
    _   AE11
    +   AE12
    Q   AD01
    W   AD02
    E   AD03
    R   AD04
    T   AD05
    Y   AD06
    U   AD07
    I   AD08
    O   AD09
    P   AD10
    [   AD11
    ]   AD12
    A   AC01
    S   AC02
    D   AC03
    F   AC04
    G   AC05
    H   AC06
    J   AC07
    K   AC08
    L   AC09
    :   AC10
    "   AC11
    §   AC11
    \   BKSL
    |   BKSL
    Z   AB01
    X   AB02
    C   AB03
    V   AB04
    B   AB05
    N   AB06
    M   AB07
    <   AB08
    >   AB09
    ?   AB10
    MEZ SPCE
};
# AC12?
# LGST?

# Prvních 256 symbolů:
my @symboly = (
    (undef) x 32, # [0]..[31]
    undef, qw(exclam quotedbl numbersign dollar percent ampersand apostrophe), # [32]..[39]
    qw(parenleft parenright asterisk plus comma minus period slash), undef, undef, # [40]..[49]
    (undef) x 8, qw(colon semicolon), # [50]..[59]
    qw(less equal greater question at), (undef) x 5, # [60]..[69]
    (undef) x 20, # [70]..[89]
    undef, qw(bracketleft backslash bracketright asciicircum underscore grave), undef, undef, undef, # [90]..[99]
    (undef) x 20, # [100]..[119]
    undef, undef, undef, qw(braceleft bar braceright asciitilde Delete), undef, undef, # [120]..[129] (128..159 jsou řídicí znaky)
    (undef) x 30, # [130]..[159]
    qw(nobreakspace exclamdown cent sterling currency yen brokenbar section diaeresis copyright), # [160]..[169]
    qw(ordfeminine guillemotleft notsign hyphen registered macron degree plusminus twosuperior threesuperior), # [170]..[179]
    qw(acute mu paragraph periodcentered cedilla onesuperior masculine guillemotright onequarter onehalf), # [180]..[189]
    qw(threequarters questiondown Agrave Aacute Acircumflex Atilde Adiaeresis Aring AE Ccedilla), # [190]..[199]
    qw(Egrave Eacute Ecircumflex Ediaeresis Igrave Iacute Icircumflex Idiaeresis ETH Ntilde), # [200]..[209]
    qw(Ograve Oacute Ocircumflex Otilde Odiaeresis multiply Oslash Ugrave Uacute Ucircumflex), # [210]..[219]
    qw(Udiaeresis Yacute THORN ssharp agrave aacute acircumflex atilde adiaeresis aring), # [220]..[229]
    qw(ae ccedilla egrave eacute ecircumflex ediaeresis igrave iacute icircumflex idiaeresis), # [230]..[239]
    qw(eth ntilde ograve oacute ocircumflex otilde odiaeresis division oslash ugrave), # [240]..[249]
    qw(uacute ucircumflex udiaeresis yacute thorn ydiaeresis) # [250]..[255]
);
if (scalar(@symboly) != 256) {die("Chyba v tabulce symbolů!")}

my %klíčová_slova = (
    "nic", "NoSymbol",
    # Mrtvé klávesy:
    qw{
        +ˇ  dead_caron
        +'  dead_acute
        +¯  dead_macron
        +¸  dead_cedilla
        +~  dead_tilde
        +^  dead_circumflex
        +˘  dead_breve
        +°  dead_abovering
        +˛  dead_ogonek
        +`  dead_grave
        +˙  dead_abovedot
        +˝  dead_doubleacute
        +"  dead_diaeresis
    },
    # Bílé znaky:
    qw{
        \t  Tab
        tab Tab
        \_  space
        \n  Linefeed
        _sp space
        _nb nobreakspace
        _en U2002
        _em U2003
        _/3 U2004
        _/4 U2005
        _/6 U2006
    },
    # Řídicí sekvence:
    qw{
        \b  BackSpace
        \e  Escape
        esc Escape
    }
# Nevyzkoušené kódy: Return|KP_Enter|Delete
);

my @výstup = (
    "xkb_symbols \"qwerty\" {",
    "",
    "    include \"cz(basic)\"",
    "    name[Group1]= \"Czech (QWERTY)\";",
    ""
);

my $stdin = \*STDIN;
my $cz = undef;
my $řádek;
my $číslo_řádku = 0;

open($cz, "<&=3");
binmode($cz, ":utf8");

while (defined($řádek = readline($stdin)))
{
    chomp($řádek);
    ++$číslo_řádku;

    next if ($řádek !~ /^[^# \t]/); # přeskočit komentáře

    my @sloupce = split(/[ \t]+/, $řádek);

    # Kontroly:
    scalar(@sloupce) >= 5
        or die("Příliš málo sloupců na řádce ${číslo_řádku}: ${řádek}");
    exists $názvy_kláves{$sloupce[0]}
        or die("Neznámé označení klávesy: ".$sloupce[0]);

    foreach my $i (1, 2, 3, 4)
    {
        if ($sloupce[$i] =~ /^[uU][0123456789ABCDEFabcdef]+$/) {
            # tvar Uxxxx propustit nezměněný
        } elsif (length($sloupce[$i]) != 1) {
            # klíčové slovo...
            exists $klíčová_slova{$sloupce[$i]}
                or die("Neznámé označení symbolu na řádku ${číslo_řádku}: ".$sloupce[$i]);
            $sloupce[$i] = $klíčová_slova{$sloupce[$i]};
        } else {
            # jednotlivý znak
            my $n = ord($sloupce[$i]);
            if ($n < 33 || (128 <= $n && $n <= 159)) {
                die("Řídicí znaky Unicode (kromě Delete) nejsou povoleny! (Chyba na řádce ${číslo_řádku})");
            }
            $sloupce[$i] =
                $n >= 256 ? sprintf("U%04x", $n) :
                defined($symboly[$n]) ? $symboly[$n] :
                $sloupce[$i];
        }
    }
    $sloupce[0] = $názvy_kláves{$sloupce[0]};
    splice(@sloupce, 5);
    push(@výstup, sprintf("    key <%s> { [ %s, %s, %s, %s ] };", @sloupce));
}
push(@výstup, "", "    include \"level3(ralt_switch)\"", "};");
while (defined($řádek = readline($cz)) && !($řádek =~ /^xkb_symbols "qwerty" \{/))
{
    printf("%s", $řádek);
}
printf("%s\n", join("\n", @výstup));
while (defined($řádek = readline($cz)) && $řádek ne "};\n") {}
while (defined($řádek = readline($cz)))
{
    printf("%s", $řádek);
}
