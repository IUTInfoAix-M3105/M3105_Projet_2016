# Projet - Simulateur d'un marché fermier


### Conception et Programmation Objets Avancées (module M3105)
### IUT d’Aix-Marseille – Dép. Informatique Aix-en-Provence, Semestre 3 – Année 2016-2017

* Sophie Nabitz - [sophie.nabitz@univ-avignon.fr](sophie.nabitz@univ-avignon.fr) - https://github.com/bastinz
* Sébastien Nedjar - [sebastien.nedjar@univ-amu.fr](sebastien.nedjar@univ-amu.fr) - https://github.com/nedseb
* Cyril Pain-Barre - [cyril.pain-barre@univ-amu.fr](cyril.pain-barre@univ-amu.fr) - https://github.com/bashelier
* Jean-Philippe Prost - [Jean-Philippe.Prost@univ-amu.fr](Jean-Philippe.Prost@univ-amu.fr) - https://github.com/jpprost

**Date de rendu : 4 janvier 2017 à 23h59**  
**Date de soutenance : 6 janvier 2017**

*Le non-respect d’une des consignes ci-dessous impliquera une pénalité de 3 points minimum sur la note du projet. Les modalités pour la soutenance seront précisées ultérieurement.*

### Généralités
-   Vous travaillerez par équipe de 5 personnes et de manière collaborative en utilisant Git et en partageant le travail entre les membres de l'équipe sur GitHub.
-   Chaque membre de l'équipe fera des comits du code qu'il a écrit. L'équipe enseignante va en tenir compte lors de l'évaluation.
-  Le dépôt du projet de votre équipe devra être __privé__ (accessible uniquement par les membres de l'équipe). Une fois créé, vous rendrez ce dépôt accessible en lecture uniquement à l'équipe enseignante (les liens vers les comptes GitHub données en haut de la page).
-  Les modalités de déroulement des soutenances seront précisées ultérieurement.

### Remarques

La note du projet prendra en compte :

-   Le respect des consignes du sujet et des [contraintes du livrable](ContraintesLivrable.md).
-   La modélisation objet de votre application. Également, nous serons
    particulièrement attentifs à l’utilisation appropriée des patrons de conception que vous aurez mis en œuvre
-   La propreté et la lisibilité du code ainsi que tout ce qui
    facilitera sa compréhension par les correcteurs (noms des variables,
    commentaires, modularité, etc ).
-   La facilité d'utilisation du code (le fichier INSTALL/README est-il
    lisible et suffit-il pour utiliser le code ?). La compilation de
    votre code devrait marcher sur tout type de machine - pensez à
    tester avant le rendu final.
-   La correction et la cohérence du code.
-   La présentation de votre application durant la soutenance.

### Instructions

-   Il est **strictement interdit de copier du code** des projets de
    vos collègues. Attention : l’obfuscation du code n’est pas une
    solution, c’est très facile à détecter !
-   Vous pouvez aussi implémenter les bonus et/ou améliorations que vous
    aurez imaginés. Il est cependant conseillé de venir en parler avec
    votre enseignant de projet afin d’en discuter. Dans tous les cas, il
    faut __d’abord implémenter__ les fonctionnalités demandées dans
    le sujet.

Au cours de votre travail de conception et de réalisation, pensez à respecter les principes vus dans vos cours de conception objet durant votre formation.

Les modalités de réalisation de certaines fonctionnalités ne sont pas forcément spécifiées afin de vous donner une certaine liberté dans la conception. En revanche, vous devez respecter les contraintes imposées dans le sujet et justifier tout choix qui les contredit.

## Descriptif

Les agriculteurs (`Participant`) ont décidé de se doter d'une bourse d'échanges de biens fermiers. Dans les temps qui courent (état d'urgence, crise économique, baisse de revenus, réchauffement climatique, fin du monde prochaine, ...) cela devrait leur permettre de se maintenir à flot en favorisant des circuits courts. Le système se veut simple : les fermiers proposent leurs produits fermiers (vaches, cochons, lait, tomates, blé, reblochon, etc.) avec un certain prix et une certaine quantité. Les autres membres du système achètent ce qu'il souhaite en fonction de leurs besoins. Votre mission, si vous l'acceptez (et d'ailleurs même si vous ne l'acceptez pas), est de réaliser ce système en appliquant ce que vous avez appris dans le module M3105.

Pour vous aider à mieux cerner l'univers de votre application, la description des différents acteurs impliqués vous est donnée dans le fichier [Acteurs.md](Acteurs.md).

Pour vous éviter tous les aléas d'un système temps réel, votre programme devra simuler "à la main" le fonctionnement du système. On se place dans le cas de figure général où l'utilisateur du logiciel spécifie le nombre de fermiers, les biens que chacun d'eux propose et les quantités correspondantes. Au moment où un fermier propose un produit, l'Autorité des Marchés Fermiers (AMF), représentée par la classe `Controleur`, valide l'offre en vérifiant la disponibilité des stocks mis en vente, l'encadrement des prix et si le produit n'est pas actuellement interdit à la commercialisation etc. Une fois l'étape de validation passée, les acteurs du système peuvent placer des demandes d'achat.

Dans un premier temps vous allez supposer que la première offre d'achat arrivée sera la première servie. L'offre d'achat est acceptée si le solde de l'acheteur est suffisant. À la fin de la transaction, la somme est créditée sur le compte du vendeur et la propriété des biens est transférée à l'acheteur (vous n'aurez pas à gérer la livraison, on va supposer qu'elle est externe à l'application). On supposera qu'une fois acheté le lot d'articles est immédiatement disponible à l'acquéreur et donc ce dernier peut par exemple décider de le revendre.

Chaque participant suit l'apparition à la vente des différents types de biens qui l'intéressent (à travers des abonnements à des flux tel que des listes de diffusion, un flux RSS, une file de message, ...). Ainsi, il sera notifié lors de l'apparition des nouvelles offres. Naturellement, tout participant au marché peut acheter tout produit sans forcément être abonné à la liste de diffusion, la seule condition étant d'avoir la trésorerie requise.

### Fonctionnement général de l'application

La simulation du passage du temps dans votre système se fera par des itérations actionnées par l'utilisateur de l'application. 
Chaque itération est composée des étapes suivantes qui devront être réalisée séquentiellement :

1. *Proposition de vente* : l'utilisateur a la possibilité de créer des offres de vente de produits.
2. *Validation* : Après avoir terminé la saisie des offres de vente, l'AMF a la charge de valider les offres.
3. *Achat* : Après la validation, l'utilisateur peut déposer des offres d'achat. À la fin de l'exécution de l'étape d'achat, les biens achetés sont affectés aux participants correspondants et les soldes des acteurs en présence sont mis à jour.
4. *Affichage* : mise à jour des vues permettant d'afficher l'état actuel du système.

Un utilisateur pourra simuler le fonctionnement du logiciel en déroulant étape après étape le scénario décrit ci-dessus.

Pour rendre le code plus compréhensible et simplifier la maintenance du projet, les parties «*traitement*» et la partie «*affichage*» seront séparées.

-   La couche *traitement* (package «`marche.traitement`») :
    toutes les données et les traitements spécifiques (ex: ajouter des
    fermier, ajouter des biens aux fermier, etc.) sont regroupés
    dans ce package. Les classes de cette couche ne concernent pas la
    partie graphique. Elles se contentent principalement d’effectuer des
    traitements métiers et de renvoyer des résultats.

-   La couche *graphique* (package «`marche.affichage`»): cette
    couche gère l'affichage (interface utilisateur) et les actions de
    l’utilisateur (clics ou saisies au clavier).

## Mise en œuvre
La mise en œuvre du projet passera par la réalisation des classes et méthodes décrites ci-dessous.

### Participants

Comme indiqué dans le descriptif du sujet, les participants principaux sont les Fermiers.

1.  Écrire les classes permettant de gérer les données et les actions relatives aux participants. Comme prévu initialement, il s'agit de fermiers qui vendent des produits divers. Une spécialisation des fermiers s'impose et au moins quatre catégories de fermiers devraient apparaître : `ProducteurLaitier`, `ProducteurDeViande`, `Orticulteur`, `Arboriculteur`. Vous pourrez imaginez d'autres catégories. Naturellement tout fermier peut acheter tous types de produits agricoles vendus sur le marché.

2.  L'utilisation du système n'est pas gratuite, chaque participant devra cotiser une somme en fonction de ses gains (afin de garder une certaine équité). Le système étant destiné à évoluer, on s'imagine que certaines réductions pourront s'appliquer à certains fermiers. Par exemple, avec le temps, l'utilisateur pourra décider que les agriculteurs vendant que des produits bio, auront une remise. Un autre exemple pourrait être celui des petits producteurs qui vendent en petite quantité et à des petits prix -- à terme ils pourront bénéficier d'une remise, voire d'une exonération. D'autres spécialisations de la politique tarifaire du marché pourront s'ajouter en cumulant les différentes remises, de façon à ce que l'utilisateur puisse béneficier de tous les avantages potentiels. Dans votre réalisation vous devriez proposer à l'utilisateur d'ajouter de telles extensions sans trop de difficultés et surtout sans modifier le code existant.

### Produits Fermiers

Un produit fermier peut être décrit par son propriétaire, son prix. Plusieurs types de produits peuvent être distingués : vaches, pommes, fromage, cochons, lait, miel etc. Pour simplifier, nous allons supposer que chaque produit est conditionné sous une forme standardisée et quantifiable. Ainsi la classe `Pomme` représentera en réalité une cagette de pommes, la classe `Vache` représentera une vache, la classe `Miel` représentera un pot de de 3L de miel etc.

1.  Écrire la classe `ProduitFermier` et les sous-classes correspondantes. Vous pouvez imaginez des hiérarchies de classes plus évoluées en définissant des familles de produits communes.

2.  Proposer une méthode `valider()` dans la classe `ProduitFermier` qui permettra de certifier le produit. Il faudra à minima vérifier si la date de péremption n'est pas dépassée. Pour permettre un étiquetage des produits en fonction de leur qualité, on souhaiterait intégrer la notion de *label* (AOP, AOC, IGP, Label Rouge etc.). Afin d'obtenir tel ou tel label il faut que le produit passe d'abord l'étape de validation. Pensez notamment aux possibles extensions à l'apparition de nouveaux *labels*.

### Production des ressources.

Les fermiers pourront produire les ressources correspondantes à leur métier en respectant certaines limites de capacité. Les `ProduitFermier` concrets devront être instanciés uniquement par des `UnitéDeProduction` spécialisées. Une unité de production n'est pas forcément attachée à un seul fermier.

### Marché

Dans la première implémentation demandée, il n'y aura qu'une seule place de marché. Votre système devra quand-même être capable de s'adapter à moindre frais à l'introduction de nouveaux marchés dans des régions différentes. 
  

### Vendre et acheter
Les produits mis en vente, le sont à un prix décidé par le vendeur. Pour des raisons de régulation des prix, l'AMF 
se réserve le droit de ne pas mettre en vente des produits à des prix anormalement bas ou anormalement haut.

Une fois un ordre d'achat choisi par l'AMF, la transaction correspondante est inscrite dans le grand livre du marché. Pour 
des raisons d'obligations comptables évidentes, toutes les transactions devront être conservées, historisées et consolidées. 

### Contrôleur

Le contrôleur est en quelques sortes l'incarnation informatique de l'AMF. Il est le régulateur/validateur et fait le lien entre les vendeurs et les acheteurs en constituant un *Catalogue* de propositions de vente.

1.  Écrire la classe `Controleur`. Naturellement, le contrôleur est unique pour un marché donné. Les entités qui doivent pouvoir y accéder, ont un moyen direct de le faire.

2.  Écrire une méthode `choisirAcheteur()` qui permet pour un bien proposé de choisir parmi les acheteurs qui y sont intéressés. Comme indiqué précédemment, dans un premier temps écrire un algorithme d'affection naïf (l'acheteur sera choisi de manière aléatoire).

3. La méthode `choisirAcheteur()` écrite en première intention n'est pas optimale. Par exemple, pour un type de produit fermier qui est très demandé le temps pourrait être un critère de choix (premier arrivé, premier servi). Dans le cas d'un système équitable on pourrait imaginer la limitation des monopoles : les acheteurs qui achètent des petites quantités sont prioritaires par rapport aux gros acheteurs. Parfois il serait peut-être utile de pouvoir imposer un acheteur qui a été jusque là très pénalisé, son offre d'achat n'étant pas pu être sélectionnée. De multiples façons/critères d'optimiser le fonctionnement du système peuvent être envisagés. Proposez un (ou plusieurs) algorithmes alternatifs, qui permettront soit de mieux répartir les biens en vente, soit de minimiser le nombre d'acheteurs pour chaque fermier ... ou une version hybride de ces deux critères. Le choix d'un de ces algorithmes sera fait par l'utilisateur. 

### Visualisation du système – mode simplifié

Vous implémenterez un ensemble de vues permettant de représenter et modifier l'état interne du système. Votre programme devra en particulier intégrer les vues suivantes :

1.  Une vue qui affiche l'ensemble des participants avec leurs biens et leur soldes

2.  Une vue qui affiche le catalogue en temps réel 

3.  Journal de transactions qui est mis à jour après chaque itération de vente.

4.  La cotation actuelle de chaque produit qui va représenter une moyenne des prix proposés actuellement.

Afin de ne pas retarder le travail, dans un premier temps, vos différentes vues seront représentées par des messages appropriés affichés dans le terminal.
