# Rozkladač klávesnice

*(ROZPRACOVÁNO)*

Nástroj pro vytváření vlastních rozložení klávesnice pro XOrg (Linux, např. Ubuntu) bez nutnosti technických znalostí.

Rozkladač klávesnice zatím nemá příliš dobré uživatelské rozhraní, ale po funkční stránce už mu snad nic nechybí.

Vyvoření a nastavení nového rozložení klávesnice s použitím Rozkladače klávesnice sestává z těchto kroků:

1. Otevřít v textovém editoru šablonu (vzor.txt) a nastavit požadované rozložení kláves.
2. Spustit rozkladač, a tak vygenerovat soubor s rozložením klávesnice. (Pokud se objeví syntaktické či jiné chyby, budete je muset opravit a spustit rozkladač znovu.)
3. Nainstalovat rozložení do systému.
4. Jednorázově rozložení aktivovat a vyzkoušet.
5. Nastavit nové rozložení jako výchozí systémové rozložení klávesnice. (Tento krok je volitelný.)

## 1. Nastavení požadovaného rozložení kláves

Otevřete v textovém editoru přiložený soubor [vzor.txt](vzor.txt). Obsahuje funkční,
ale nepříliš praktické rozložení klávesnice. Řádky reprezentují jednotlivé klávesy na
vaší klávesnici − jsou uspořádány po řadách odshora dolů. Rozložení klávesnice definuje
význam pouze pro centrální části klávesnice, a to ještě bez kláves Tab, Caps Lock,
Shift, Back Space, Enter apod. Prostě pouze čísla, písmena, speciální znaky a mezerník;
funkční klávesy se nepředefinovávají.

Soubor obsahuje pět sloupců. První sloupec neměňte, identifikuje jednotlivé klávesy
uvedením některého znaku, který je na dané klávese v *anglickém* rozložení.

Další čtyři sloupce definují, jaký znak se vypíše, když stisknete (v tomto pořadí):

* danou klávesu
* Shift + danou klávesu
* pravý Alt + danou klávesu
* pravý Alt + Shift + danou klávesu

Většinu znaků (včetně náročných UCS znaků) zadáte prostě jako jeden znak. Tento znak
můžete okopírovat z nějaké HTML stránky, nebo třeba ze systémové Mapy znaků.
Bohužel je několik výjimek, které takto jednoduše zadat nejde:

* bílé znaky − To je mezera a její různé druhy (tabulátor, krátká, dlouhá, nezlomitelná apod.) Obyčejnou mezeru zadáte kombinací „\\\_“, nezlomitelnou „\_nb“, en-space „\_en“ a em-space „\_em“. Tabulátor, pokud ho budete potřebovat, zadáte „\\t“. To vám nejspíš bude stačit.
* „mrtvé klávesy“ − To jsou klávesy, které po stisknutí nic nevypíšou, ale počkají na další znak a pak se s ním skombinují. Ty se zadávají dvouznakovou kombinací, kde první znak je + a druhý znak je znak, který se vypíše jako kombinace dané mrtvé klávesy s obyčejnou mezerou. V češtině je potřeba pouze čárka („+'“), háček („+¯“) a případně kroužek („+°“). Další podporované mrtvé klávesy uvedu v tabulce; zatím je najdete ve [zdrojovém kódu](zprac.sh) pod komentářem „# Mrtvé klávesy:“.
* řídicí znaky − Tyto se většinou v normálních rozloženích klávesnice nevyskytují, ale je možné je tam přidat. Jsou to: konec řádku (Enter) „\\n“, Escape („\\e“) a Back Space („\\b“).

Všechny sloupce musejí být vyplněny. Pokud nechcete, aby daná kombinace kláves cokoliv dělala, prostě na její místo napište klíčové slovo „nic“.

Příklad (nesmyslný):

    Y   q   \\  \_em    +°

V uvedeném případě klávesa Y (podle anglického rozložení − to znamená ta mezi klávesami T a U) normálně napíše „q“, se Shiftem napíše zpětné lomítko, s pravým Alt vypíše mezeru o šířce písmene M a se Shiftem a pravým Alt dohromady nevypíše nic, ale když po ní stisknete klávesu, která by normálně vypsala „u“, vypíše se pak „ů“. (Snad tušíte proč.)

## 2. Spustit rozkladač

Spusťte tyto příkazy a kontrolujte, zda při nich nenastaly chyby:

`bash zprac.sh <vzor.txt >faze1.txt`<br>
`gawk -f zprac.awk faze1.txt >faze2.txt`<br>
`gawk '/^xkb_symbols "qwerty" \{/ {p=1} !p {print} p && /^\};$/ {p = 0; system("cat vystup.txt");}' /usr/share/X11/xkb/symbols/cz >cz`

Výstupem uvedených příkazů je soubor „cz“, který obsahuje vaše původní systémová
česká rozložení klávesnice s tím, že rozložení „cz/qwerty“ je v něm přepsané
novým rozložením, které jste definovali.
Ve skutečnosti je možné do systému přidat úplně nové rozložení, ale je to
zbytečně komplikované; přepsat stávající je snazší.

## 3. Nainstalovat rozložení do systému

Před tímto krokem doporučuji vytvořit si zálohu souboru „/usr/share/X11/xkb/symbols/cz“, abyste ho mohli v případě potřeby obnovit do původního tvaru.

`sudo tee /usr/share/X11/xkb/symbols/cz &lt;cz &gt;/dev/null`

## 4. Jednorázově rozložení aktivovat a vyzkoušet

Nainstalované rozložení aktivujete tímto příkazem:

`setxkbmap cz qwerty`

## 5. Nastavit nové rozložení jako výchozí

Pokud se vám nové rozložení líbí a nemáte již nastavené jako výchozí rozložení „Česky (QWERTY)“, učiníte to takto:

`sudo dpkg-reconfigure keyboard-configuration`

První dotaz potvrďte beze změny, na druhé obrazovce vyberte volbu „Czech“, na třetí „Czech − Czech (QWERTY)“; ostatní dotazy potvrďte beze změny.
