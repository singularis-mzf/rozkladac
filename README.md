# Rozkladač klávesnice

Nástroj pro vytváření vlastních rozložení klávesnice pro XOrg (linux, např. Ubuntu) bez nutnosti technických znalostí.
Umožňuje na klávesy namapovat téměř libovolné znaky Unicode Character Set včetně většiny emoji.

Aktuálně je vydána betaverze 1.0beta, určená především na Debian, Ubuntu a z nich odvozené distribuce.
Vyžaduje Perl verze minimálně 5.26 a jeho balíček English (v Ubuntu předinstalovaný, ve Fedoře 33 je
nutno ``sudo dnf install perl-English``).

Vyvoření a nastavení nového rozložení klávesnice s použitím Rozkladače klávesnice sestává z těchto kroků:

1. Zkopírujte soubor [vzor.txt](ukazky/vzor.txt) a nastavte v kopii požadované rozložení kláves.
2. Spusťte `./rozkladac zdrojový-soubor cílový-soubor` (do příkazu dosaďte odpovídající názvy)(Pokud se objeví syntaktické či jiné chyby, budete je muset opravit a spustit rozkladač znovu.)
3. Použitím příkazů, které Rozkladač klávesnice vypíše, rozložení nainstalujete do systému a vyzkoušíte.

*Poznámka:* Rozkladač klávesnice je implementovaný tak, že přepisuje rozložení klávesnice „Czech (QWERTY)“. Vezměte to na vědomí, pokud toto rozložení klávesnice používáte.

## 1. Nastavení požadovaného rozložení kláves

Otevřete soubor s definicí rozložení klávesnice ([vzor.txt](ukazky/vzor.txt) nebo jeho kopii)
v textovém editoru. Řádky reprezentují jednotlivé klávesy na vaší klávesnici − jsou uspořádány
po řadách odshora dolů. Rozložení klávesnice definuje
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

Většinu znaků (včetně náročných UCS znaků nebo emoji) zadáte prostě jako jeden znak.
Tento znak můžete okopírovat z nějaké HTML stránky, nebo třeba ze systémové Mapy znaků.
Takto si můžete složit znaky ruské, řecké, arabské a latinské i většinu emoji
do jednoho rozložení klávesnice.
Bohužel je několik výjimek, které takto jednoduše zadat nejde:

* *bílé znaky* − To je mezera a její různé druhy, viz níže uvedenou tabulku.
* *mrtvé klávesy* − To jsou klávesy, které po stisknutí nic nevypíšou, ale počkají na další znak a pak se s ním skombinují. Viz níže uvedenou tabulku.
* *emoji tvořené sekvencí více znaků Unicode* – Toto jsou zejména emoji s různými odstíny barvy pleti; obvykle však lze použít jejich základní (žlutou) formu.
* *řídicí znaky* − Tyto se většinou v normálních rozloženích klávesnice nevyskytují a nejspíš je budete potřebovat. Pokud ano, viz níže uvedenou tabulku.

Všechny sloupce musejí být vyplněny. Pokud nechcete, aby daná kombinace kláves cokoliv dělala, prostě na její místo napište klíčové slovo „nic“.

Příklad (nesmyslný):

`Y   q   \  _em    +°`

V uvedeném případě klávesa Y (podle anglického rozložení − to znamená ta mezi klávesami T a U) normálně napíše „q“, se Shiftem napíše zpětné lomítko, s pravým Alt vypíše mezeru o šířce písmene M a se Shiftem a pravým Alt dohromady nevypíše nic, ale když po ní stisknete klávesu, která by normálně vypsala „u“, vypíše se pak „ů“.

### Tabulka mrtvých kláves

| symbol | anglický název | popis | příklad písmene |
| --- | :-- | :--- | --- |
| +ˇ | caron | **háček** | š |
| +' | acute | **čárka** (česká) | é |
| +° | abovering | **kroužek** | ů |
| +" | diaeresis | dvojitá tečka | ö |
| +` | grave | zpětná čárka | à |
| +^ | circumflex | stříška | â |
| +¯ | macron | rovná čárka | ā |
| +˙ | abovedot | tečka | ȧ |
| +¸ | cedilla | ? | ş |
| +~ | tilde | vlnovka | ã |
| +˘ | breve | oblý háček | ă |
| +˛ | ogonek | ocásek | ą |
| +˝ | doubleacute | dvojitá čárka | ő |

### Tabulka mezer

| symbol | název | popis |
| --- | :--- | :--- |
| \\\_ | **mezera** | obyčejná mezera |
| \_nb | nezlomitelná mezera | nezlomitelná mezera (v HTML &amp;nbsp;) |
| \_en | en-space | mezera o šířce písmene „n“ |
| \_em | em-space | mezera o šířce písmene „m“ |
| \\t | tabulátor | tabulátor (bude se chovat jako klávesa „TAB“) |

### Tabulka řídicích znaků

| symbol | název | význam |
| --- | :--- | :--- |
| \\n | Enter | vloží konec řádky nebo potvrdí volbu |
| \\e | Esc | zavře menu apod. |
| \\b | BackSpace | smaže znak vlevo od kurzoru |

## 2. Spuštění Rozkladače klávesnice

V adresáři se souborem „rozkladac“ spusťte tento příkaz (za názvy souborů dosaďte odpovídající názvy):

`./rozkladac zdrojový-soubor cílový-soubor`

Pokud zpracování proběhlo úspěšně, byl vytvořen cílový soubor, který obsahuje rozložení klávesnice
ve formátu, kterému rozumí váš systém. Toto rozložení je následně potřeba nainstalovat:

`sudo install -T -m 644 cílový-soubor /usr/share/X11/xkb/symbols/cz`

Dalším krokem je si je jednorázově vyzkoušet. Nové rozložení aktivujete příkazem:

`setxkbmap cz qwerty`

Pokud se z nějakého důvodu budete potřebovat vrátit k normálnímu českému rozložení kláves, pomůže vám tento příkaz:

`setxkbmap cz`

Abyste nové rozložení nastavili jako výchozí pro celý systém, musíte nastavit jako výchozí rozložení „Czech − Czech (QWERTY)“ (cz/qwerty). Na Ubuntu a od něj odvozených operačních systémech to uděláte tak, že zadáte příkaz `sudo dpkg-reconfigure keyboard-configuration` a v následujících oknech první dotaz potvrdíte beze změny, na druhé obrazovce vyberte volbu „Czech“, na třetí „Czech − Czech (QWERTY)“; zbylé dotazy potvrďte beze změny.

*Poznámka:* upravené rozložení se může ztratit s aktualizací systému, resp. jeho balíčků; v Debianu, Ubuntu apod. můžete aktualizaci rozložení klávesnic zakázat příkazem:

`sudo apt-mark hold xkb-data`

Pokud byste někdy v budoucnu chtěli zákaz aktualizace zrušit, pomůže vám tento příkaz:

`sudo apt-get reinstall xkb-data`

## Další poznámky

* Ačkoliv cílový soubor vytvořený Rozkladačem klávesnice může fungovat na více různých distribucích, není to zaručeno. Proto doporučuji nepřenášet vygenerovaný soubor mezi různými distribucemi a na každé distribuci spustit Rozkladač klávesnice znovu.

## Tipy k tvorbě rozložení klávesnice

Doporučuji se vyvarovat originality. Existující rozložení klávesnice jsou navržena víceméně rozumně, takže se vyplatí jich držet a spíš je jen opatrně „mixovat“
než se snažit vymyslet zcela nové rozložení klávesnice. Pokud si zvyknete na netypické rozložení klávesnice, budete mít v budoucnu velké problémy s ovládáním
systémů, kam si svoje rozložení nebudete moci nainstalovat, např. školních či firemních.
