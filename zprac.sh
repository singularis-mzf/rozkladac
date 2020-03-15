#!/bin/bash
set -e

# Zvláštní názvy znaků

declare -A znaky

znaky["nic"]='!NoSymbol'

# Mrtvé klávesy:
znaky["+ˇ"]='!dead_caron'
znaky["+'"]='!dead_acute'
znaky["+¯"]='!dead_macron'
znaky["+¸"]='!dead_cedilla'
znaky["+~"]='!dead_tilde'
znaky["+ˇ"]='!dead_caron'
znaky["+^"]='!dead_circumflex'
znaky["+˘"]='!dead_breve'
znaky["+°"]='!dead_abovering'
znaky["+˛"]='!dead_ogonek'
znaky["+\`"]='!dead_grave'
znaky["+˙"]='!dead_abovedot'
znaky["+˝"]='!dead_doubleacute'
znaky["+\""]='!dead_diaeresis'
znaky["+°"]='!dead_abovering'

# Bílé znaky:
znaky["\\t"]='!Tab'
znaky["tab"]='!Tab'
znaky["\\_"]='!space'
znaky["\\n"]='!Linefeed'
znaky["_sp"]='!space'
znaky["_nb"]='!nobreakspace'
znaky["_en"]='8194'
znaky["_em"]='8195'
znaky["_/3"]='8196'
znaky["_/4"]='8197'
znaky["_/6"]='8198'

# Řídicí sekvence:
znaky["\\b"]='!BackSpace'
znaky["\\e"]='!Escape'
znaky["esc"]='!Escape'
# Nevyzkoušené kódy: Return|KP_Enter|Delete

while read -r s
do
	: '^[^#]'
	[[ $s =~ $_ ]] || continue
	: '^\S+(\s+\S+){4}(\s+#.*)?$'
	if ! [[ $s =~ $_ ]]
	then
		printf 'Řádek má chybný formát: "%s"\n' "$s" >&2
		exit 1
	fi
	IFS=$' \t' read -r -a pole <<< "$s"
	for i in 1 2 3 4
	do
		: '^.$'
		if [[ ${pole[i]} =~ $_ ]]
		then
			pole[i]="$(printf %d "'${pole[i]}")"
		elif : '^[uU][0123456789ABCDEFabcdef]+$'; [[ ${pole[i]} =~ $_ ]]
		then
			pole[i]="$(printf %d "0x${pole[i]:1}")"
        elif test -v "znaky[${pole[i]@Q}]"
        then
            pole[i]="${znaky[${pole[i]}]}"
        else
			printf 'Neznámý formát ve sloupci %d: %s\n' $i "'${pole[i]}'" >&2
			exit 1
		fi
	done
	printf %s "${pole[0]}"
	for i in 1 2 3 4; do printf '\t%s' "${pole[i]}"; done
	printf \\n
done

