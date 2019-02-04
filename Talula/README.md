*** Pozn. pre iOS Lead-a ***

Zdravim,

chcela som týmto spôsobom objasniť/okomentovať ako som niektoré časti zadania poňala. Dokumentácia podstatnejších častí metód je už priamo v swift súboroch.

V aplikácii som na tvorbu GUI použila SnapKit v ktorom je mi tvorba GUI prívetivejšia než Storyboard. V repozitári sa nachádza iba Podfile, a preto je potrebné najprv:
    pod install
    pod update

Aplikácia využíva defaultnú priesvitnú časť safe arey. Nepriesvitná nepôsobila dobre, ale bola by možná.
    Safearea guidelines - Snapkit:
    if #available(iOS 11, *) {
        make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
    } else {
        make.top.equalToSuperview()
    }

# Sťahovanie dát #
Sťahovanie NASA dát prebieha pomocou triedy URLSession. V konkrétnej URL je už definovaná query nad dátami. Dáta by alternatívne bolo možné sťahovať tiež:
    a) pomocou SODA SDK (http://socrata.github.io/soda swift/),
    b) vytvorením requestu prostredníctvom HTTP knižnice Alamofire (https://github.com/Alamofire/Alamofire).
Myslím si, že v aplikácii neprebieha taký počet requestov a operácii nad dátami, aby použitie týchto knižníc bolo potrebné.
Pred sťahovaním aplikácia neoveruje, či je uživateľ pripojený k internetu. Ani jedna z knižníc to neodporúča. Je to akoby skôr krok navyše, ak nie je uživateľ pripojený k internetu, jednoducho bude request neúspešný. V tejto implementácii aplikácia o tom iba vypíše "error" správu na konzolu, ale inak bude pracovať ďalej rovnako t.j. nespadne (nemala by).
Z hľadiska stiahnutia dát 1x denne, "performFetchWithCompletionHandler" neumožňuje presne stanoviť rozsah medzi prevolaniami sťahovania dát, jedine minimálne odstup medzi nimi. Tento rozsah je nastavený na čo najmenší s tým, že v rámci prevolanej metódy si aplikácia stráži, či je potrebné dáta aktualizovať, t.j. či už prešiel 1 deň. Hypoteticky môže sa stať, že uživateľ otvorí aplikáciu a update ešte stále nenastal, a preto táto kontrola nastáva aj pri tom, keď ide aplikácia na popredie. Je to snaha akoby, čo najviac zabezpečiť tú periodicitu 1 dňa.

# Aktualizácia dát #
Vo vypracovaní nepredpokládam, že by padnuté meteority mohli "odpadnúť/odletieť naspäť". Aktuálne aplikácia ako prvé stiahne všetky záznamy o meteoritoch padnutých po roku 2011. Následne už sťahuje iba tie záznamy databáze, ktorých úprava (a pridanie) je novšie ako posledná vykonaná aktualizácia. Vďaka tomu aplikácia periodicky sťahuje menšie množstvo dát.
V prípade, žeby sme uvažovali aj možný výmaz z databáze mi napadajú dve možné implementačné riešenia.
    1) Sťahovali by sa vždy všetky záznamy padnutých meteoritov po roku 2011. Následne by sa našlo "id" tých meteoritov, ktoré sa nachádzajú v Core Datach a nie v zdrojovom JSONe - tieto entity by boli vymazané. Ďalej by pracovala aplikácia rovnako ako teraz, t.j. existujúce záznamy na základe "id" by aktualizovala, neexistujúce vytvorila.
    2) Sťahovali by sa 2x JSON súbory. Prvý by bol to isté riešenie čo teraz. Druhý by obsahoval čisto "id" hodnoty všetkých meteoritov padnutých po roku 2011. Tieto "id" hodnoty by boli porovnané s entitami v Core Datách a rovnako ako v (1) zmazané. Ušetrilo by sa množstvo sťahovaných údajov, ale za cenu zložitejšieho zdrojového kódu a 2 requestov.
Aktuálne si myslím, žeby obidve riešenia sťahovali väčšie množstvo dát ako súčasné a tiež si myslím, že taká situácia v tomto prípade nenastane, ale je to na diskusiu :).

# Obsah dát #
NASA síce uvádza niektoré atribúty, ktoré by mali byť dostupné, ale nie všetky reálne sú a niektoré sú a pre zmenu ich neuvádza alebo som ich v dokumentácii nenašla. Toto je zoznam dostupných atribútov meteoritov:
    - fall
    - geolocation (type, coordinates)
    - id
    - mass [g]
    - name
    - nametype
    - recclass
    - reclat
    - reclong
    - year [iso 8601]
Plus "reclat" je longitude, a "reclong" je latitude, a nie skutočne to nie je opačne :D.

# Perzistencia dát #
Na ukladanie dát sú použité Core Data, alternatívou by bol Realm, ale zatiaľ s ním nemám skúsenosť a Core Data sú dobre optimalizované, takže som ich použila.

# Architektúra appky #
Keby bola aplikácia zložitejšia prichýlila by som sa k návrhovému vzoru Koordinátor, ktorý by vytváral jednotlivé "moduly", ale tým, že je aplikácia jednoduchá, vytvorila som iba jednoduchú triedu AppStarter, ktorá iniciuje aplikáciu.


Snáď aplikácia splnila zadanie, teším sa na spätnú väzbu! :)
