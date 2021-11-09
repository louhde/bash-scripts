# Correction exercices de Bash :penguin:

## Exercice 1: Poissons et insectes :fish::bug:

1. Créer une fonction qui permet d’afficher la liste des poissons disponibles sur l’API **https://acnh.api.louhde.tech/fish** puis créer une variable Fish contenant cette liste
2. Créer une fonction qui permet d’afficher tous les poissons ainsi que leur prix.
**La requête pour avoir accès au prix est : https://acnh.api.louhde.tech/fish?fish="thon"**
3. Créer une fonction qui donne le prix d’un poisson passé en argument.
**BONUS**: La fonction quitte avec un code d’erreur 1 si le poisson n’existe pas
4. En prenant le résultat de la fonction donnant le prix d’un poisson, faire une fonction définissant si le prix est cher suivant les paliers:

        - de 100
        de 100 à 250
        de 250 à 500
        + de 500

Renvoyez un message de votre choix suivant les cas mais ils devront être tous différents.

## Exercice 2: Liste d'employés :office:

**API: https://61890166d0821900178d76e6.mockapi.io/api/Employes**

1. Faire une fonction qui retourne le nom et l’âge de la personne puis si cette personne est mineure ou non.
2. Faire une fonction qui recense les différents postes des personnes ainsi que le nombre de personne qui ont ce poste
3. Comme au dessus mais pour les genres
4. Faire une fonction qui indique si deux personnes habitent dans la même ville
