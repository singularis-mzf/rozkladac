BEGIN {
    FS="\t";
    OFS="";

# Názvy kláves:
    kl("~", "TLDE");
    kl("1", "AE01");
    kl("2", "AE02");
    kl("3", "AE03");
    kl("4", "AE04");
    kl("5", "AE05");
    kl("6", "AE06");
    kl("7", "AE07");
    kl("8", "AE08");
    kl("9", "AE09");
    kl("0", "AE10");
    kl("_", "AE11");
    kl("+", "AE12");
    kl("Q", "AD01");
    kl("W", "AD02");
    kl("E", "AD03");
    kl("R", "AD04");
    kl("T", "AD05");
    kl("Y", "AD06");
    kl("U", "AD07");
    kl("I", "AD08");
    kl("O", "AD09");
    kl("P", "AD10");
    kl("[", "AD11");
    kl("]", "AD12");
    kl("A", "AC01");
    kl("S", "AC02");
    kl("D", "AC03");
    kl("F", "AC04");
    kl("G", "AC05");
    kl("H", "AC06");
    kl("J", "AC07");
    kl("K", "AC08");
    kl("L", "AC09");
    kl(":", "AC10");
    kl("\"", "AC11");
    kl("§", "AC11");
    # AC12?
    kl("\\", "BKSL"); # BKSL − Umístění se na různých klávesnicích liší.
    kl("|", "BKSL");
    # LGST?
    kl("Z", "AB01");
    kl("X", "AB02");
    kl("C", "AB03");
    kl("V", "AB04");
    kl("B", "AB05");
    kl("N", "AB06");
    kl("M", "AB07");
    kl("<", "AB08");
    kl(">", "AB09");
    kl("?", "AB10");
    kl("MEZ", "SPCE"); # mezerník

    sym(33, "exclam");
    sym(34, "quotedbl");
    sym(35, "numbersign")
    sym(36, "dollar");
    sym(37, "percent");
    sym(38, "ampersand");
    sym(39, "apostrophe");
    sym(40, "parenleft");
    sym(41, "parenright");
    sym(42, "asterisk");
    sym(43, "plus");
    sym(44, "comma");
    sym(45, "minus");
    sym(46, "period");
    sym(47, "slash");
    sym(58, "colon");
    sym(59, "semicolon");
    sym(60, "less");
    sym(61, "equal");
    sym(62, "greater")
    sym(63, "question");
    sym(64, "at");
    sym(91, "bracketleft");
    sym(92, "backslash");
    sym(93, "bracketright");
    sym(94, "asciicircum");
    sym(95, "underscore");
    sym(96, "grave");
    sym(123, "braceleft");
    sym(124, "bar");
    sym(125, "braceright");
    sym(126, "asciitilde");
    sym(127, "Delete");
    # 128..159: řídicí znaky
    sym(160, "nobreakspace"); # nejde zadat takto, protože je bílý znak
    sym(161, "exclamdown");
    sym(162, "cent");
    sym(163, "sterling");
    sym(164, "currency");
    sym(165, "yen");
    sym(166, "brokenbar");
    sym(167, "section");
    sym(168, "diaeresis");
    sym(169, "copyright");
    sym(170, "ordfeminine");
    sym(171, "guillemotleft");
    sym(172, "notsign");
    sym(173, "hyphen");
    sym(174, "registered");
    sym(175, "macron");
    sym(176, "degree");
    sym(177, "plusminus");
    sym(178, "twosuperior");
    sym(179, "threesuperior");
    sym(180, "acute");
    sym(181, "mu");
    sym(182, "paragraph");
    sym(183, "periodcentered");
    sym(184, "cedilla");
    sym(185, "onesuperior");
    sym(186, "masculine");
    sym(187, "guillemotright");
    sym(188, "onequarter");
    sym(189, "onehalf");
    sym(190, "threequarters");
    sym(191, "questiondown");
    sym(192, "Agrave");
    sym(193, "Aacute");
    sym(194, "Acircumflex");
    sym(195, "Atilde");
    sym(196, "Adiaeresis");
    sym(197, "Aring");
    sym(198, "AE");
    sym(199, "Ccedilla");
    sym(200, "Egrave");
    sym(201, "Eacute");
    sym(202, "Ecircumflex");
    sym(203, "Ediaeresis");
    sym(204, "Igrave");
    sym(205, "Iacute");
    sym(206, "Icircumflex");
    sym(207, "Idiaeresis");
    sym(208, "ETH");
    sym(209, "Ntilde");
    sym(210, "Ograve");
    sym(211, "Oacute");
    sym(212, "Ocircumflex");
    sym(213, "Otilde");
    sym(214, "Odiaeresis");
    sym(215, "multiply");
    sym(216, "Oslash");
    sym(217, "Ugrave");
    sym(218, "Uacute");
    sym(219, "Ucircumflex");
    sym(220, "Udiaeresis");
    sym(221, "Yacute");
    sym(222, "THORN");
    sym(223, "ssharp");
    sym(224, "agrave");
    sym(225, "aacute");
    sym(226, "acircumflex");
    sym(227, "atilde");
    sym(228, "adiaeresis");
    sym(229, "aring");
    sym(230, "ae");
    sym(231, "ccedilla");
    sym(232, "egrave");
    sym(233, "eacute");
    sym(234, "ecircumflex");
    sym(235, "ediaeresis");
    sym(236, "igrave");
    sym(237, "iacute");
    sym(238, "icircumflex");
    sym(239, "idiaeresis");
    sym(240, "eth");
    sym(241, "ntilde");
    sym(242, "ograve");
    sym(243, "oacute");
    sym(244, "ocircumflex");
    sym(245, "otilde");
    sym(246, "odiaeresis");
    sym(247, "division");
    sym(248, "oslash");
    sym(249, "ugrave");
    sym(250, "uacute");
    sym(251, "ucircumflex");
    sym(252, "udiaeresis");
    sym(253, "yacute");
    sym(254, "thorn");
    sym(255, "ydiaeresis");

    #print "partial alphanumeric_keys";
    print "xkb_symbols \"qwerty\" {";
    print "";
    print "    include \"cz(basic)\"";
    print "    name[Group1]= \"Czech (QWERTY)\";";
    print "";
}

NF >= 5 {
    if (!($1 in klavesa)) {ShoditFatalniVyjimku("Neznámé označení klávesy: \"" $1 "\"")}
    for (i = 2; i <= 5; ++i) {
        if ($i ~ /^!/) {
            vystup[i] = substr($i, 2);
        } else if ($i !~ /^[0-9]+$/) {
            ShoditFatalniVyjimku("Interní chyba − neznámý formát: \"" $i "\"");
        } else if ($i < 33) {
            ShoditFatalniVyjimku("Interní chyba − chybná hodnota: \"" $i "\"");
        } else if (128 <= $i && $i <= 159) {
            ShoditFatalniVyjimku("Řídicí znaky Unicode nejsou povoleny − " $i);
        } else if ($i < 256) {
            vystup[i] = $i in symbol ? symbol[$i] : sprintf("%c", $i);
        } else {
            vystup[i] = sprintf("U%04x", $i);
        }
    }
    print "    key <", klavesa[$1], "> { [ ", vystup[2], ", ", vystup[3], ", ", vystup[4], ", ", vystup[5], " ] };";
}

END {
    if (FATALNI_VYJIMKA) {exit FATALNI_VYJIMKA}
    print "";
    print "    include \"level3(ralt_switch)\"";
    print "};";
}

function kl(oznaceni, id) {
    if (oznaceni in klavesa) {
        print oznaceni > "/dev/stderr";
        exit 1
    }
    klavesa[oznaceni] = id;
    return id;
}

function sym(cislo, id) {
    symbol[cislo] = id;
    return id;
}

function ShoditFatalniVyjimku(text) {
    printf("%s\n", text) > "/dev/stderr";
    FATALNI_VYJIMKA = 1;
    exit FATALNI_VYJIMKA;
}
