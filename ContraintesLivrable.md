# Contraintes de réalisation
Ce projet constitue dans votre parcours une première expérience de réalisation logicielle complexe. Il est l'occasion 
pour nous de vous faire expérimenter les pratiques de développement que vous retrouverez dans l'univers professionnel. 
Ce document a donc pour objet de vous donner l'ensemble des contraintes techniques que vous devrez respecter durant ce 
projet. L'évaluation prenant en compte ces consignes, vous devez impérativement les prendre en compte pour ne pas 
perdre des points bêtement.

## Contraintes de rendu pour le livrable final
* Le rendu se fera à la fois sur votre dépot github privé et sous forme d'une archive au format ZIP qui portera les noms de 
famille de chaque membre accolés par ordre alphabétique. Par exemple, si les noms sont Dupont, Martin, Durand et Cornet, 
cette dernière s'appellera : `CornetDupontDurantMartin.zip`
* Vous devez en plus fournir l'adresse du dépôt privé github de votre projet. Veillez à ce que votre enseignant ait bien 
les droits de lecture sur votre projet. Attention à correctement nommer vos contributeurs pour que le correcteur puisse 
suivre individuellement les contributions des membres de votre équipe (Un exemple qui s'est déjà produit, le nom de 
contributeur `Choucroute Garnie` n'apporte aucun renseignement vis-à-vis de la personne réelle qui a fait une contribution).
* La construction ainsi que le cycle de vie du logiciel devront être gérés avec un outil dédié comme Maven. Un projet 
sans un gestionnaire adapté du cycle de vie du code source ne sera pas évalué.
* L'archive contiendra un dossier `src` avec l'intégralité du code ainsi qu'un fichier `install/README.md` contenant 
les indications pour compiler et exécuter le programme. Aucun fichier binaire exécutable ne doit être dans l'archive.
* Le fichier `install/README.md` doit être lisible par un utilisateur quelconque et auto-suffisant (aucune autre 
connaissance ne doit être requise pour une compréhension complète) pour compiler et exécuter le programme. Il doit 
contenir les instructions concernant les contraintes logicielles de l'environnement d'exécution afin de guider 
parfaitement l'utilisateur.
* Un dossier `test` contenant les tests unitaires devra également être inclus dans l'archive avec les instructions pour 
leur exécution.
* Le dossier `doc` devra contenir la documentation complète du code source (JavaDoc).


## Instructions concernant la réalisation du projet
* L'utilisation d'un outil de gestion de versions est obligatoire (voir instruction ci-après).
* Les tests unitaires doivent être réalisés pour valider chaque fonctionnalité programmée tout au long du développement 
du projet.
* Votre base de code devra toujours être dans un état sain (le code compile et les tests passent). Pour 
vérifier cela au fur et à mesure des ajouts des contributions, vous pouvez utiliser des outils comme TravisCI.
* Mis à part le code trivial (getter/setter) toute ligne de code devrait être couverte par au moins un test. 
Vous devriez considérer qu'une ligne non couverte par au moins un test unitaire est inexistante. Vous utiliserez 
l'outil de mesure de la couverture de code `Coverall` pour cela.
* Le respect des conventions de nommage du langage Java est **impératif**. Pour garantir le respect de ces aspects 
esthétiques, les IDE vous fournissent tous des outils de nettoyage, veillez à bien les utiliser avant le moindre partage de code.
* Le programme devra gérer proprement les exceptions. Ne jamais lever une exception et ne rien faire.
* Le code doit être “propre” (au sens retenu dans l'ouvrage Clean Code de Robert C. Martin). La lisibilité et 
l'expressivité du code ne sont pas une option. La modélisation objet et le respects des bonnes pratiques de 
programmation (principes SOLID entre autre) font partie des règles que vous devez impérativement mettre en oeuvre. 
Pour mesurer votre dette technique, vous pouvez mettre en oeuvre des outils comme `SonarQube`


## Instruction concernant la gestion de version
* La livraison finale de votre code devra se faire sur un dépôt github privé. Rien ne vous empêche d'utiliser un 
autre outil pendant votre travail mais n'oubliez pas de correctement pousser l'intégralité de votre historique sur 
le dépôt github pour le rendu final.
* Le projet devra disposer d'une branche `master` contenant uniquement les `release`. Dans cette branche, chaque 
`release` fera l'objet d'un tag dont le nom donnera une indication sur la version de votre logiciel (par exemple, v0.1.1 
ou v0.1.1alpha).
* Le projet disposera d'une branche de développement appelée `develop`. C'est dans cette branche que devront être 
intégrées les fonctionnalités au fil de leur développement.
* Chaque fonctionnalité sera développée dans une branche dédiée. Le nom de la branche de fonctionnalité doit être au 
maximum porteuse de sens.
* Au sein d'une branche de fonctionnalité, chaque `commit` doit être le plus petit possible. Un commit qui fait 
10 modifications sans lien devra être découpé en 10 `commits`. Chaque commit sera accompagné d'un message permettant 
de comprendre l'objet de la modification.
* L'intégration d'une branche de fonctionnalité devra impérativement être faite en utilisant le mecanisme 
des `pull-request` pour permettre une revue de code systématique.
* Pour simplifier au maximum le graphe des révisions de votre dépot, quand vous travaillez à plusieurs sur la même 
branche de fonctionnalité, l'usage de la commande `rebase` est conseillé par rapport à la commande `merge`.
