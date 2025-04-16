# Topic 3 - PWM for LED brightness control  

## Členovia tímu
\
Samuel Fabíni zodpovedný za programovanie

Dominik Hejda zodpovedný za pogramovanie

Matej Galajda zodpovedný za readME file a pomoc pri programovaní

Sára Wozárová zodpovedná za pomoc pri programovaní, pomoc pri vytváraní readME file a vytvorenie TOP LEVEL schémy 

## Teoretický úvod a Princip PWM modulace

Náš tím navrhol a vytvoril porgram v jazyku VHDL. Tento program má za úlohu úpravu jasu RGB LED diod na doske Nexys-A7 50T. Toto upravovanie jasu bude prediehať na princípe PWM (Pulse Width Modulation). PWM je spôsob riadenia výkonu pomocou rýchleho zapínania a vypínania signálu. Výsledný priemerný výkon sa mení podľa šírky impulzu (tzv. duty cycle), čo znamená, že čím dlhšie je signál v stave „zapnuté“, tým väčší výkon sa prenáša – teda impulz je širší. Ďalej sú na doske využité všetky tlačidlá na používanie programu. Uživatel bude vedieť zrýchliť a spomaliť rýchlosť PWM cyklu, to znamená, že bude vedieť ovládať rýchlosť menenia jasu na LED-ke. Taktiež bude vedieť ovplyvniť maximálnu velkosť jasu a farbu, keďže LED diody fungujú na RGB princípe (tri malé svetlá -red-green-blue- ktoré robia biele svetlo). 

## Popis hardwaru a vysvetliene demo verzie 

Program je implementovaný na doske Nexys-A7 50T, vytvorený firmou Digilent. Doska obsahuje mnohé komponenty, z ktorých boli niektoré využité pre náš projekt. 

\
<ins>Použité komponenty a ich využitie </ins>\
\
LED16 a LED17 = RGB LED diody riadené výstupným PWM signálom\
\
BTNC (button central) = tlačidlo na resetovanie programu\
\
BTNU a BTND (button up, down) = tlačidlá na zvyšovanie a znižovanie jasu o 10%\
\
BTNR a BTNL (button right, left) = tlačidlá na zvyšovanie a znižovanie rýchlosti menenia jasu o 10%\
\
SW[13-15] = ovládanie farby LED17\
\
SW[0-2] = ovládanie farby LED16


## Popis softwaru 
\


### Simucalia komponentov 
\


### TOP LEVEL 
\

### Zapojenie 
\

### Zdroje 
\
