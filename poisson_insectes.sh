#!/bin/bash

# L'option -o permet de rediriger la sortie de curl dans un fichier
#curl -s -o data/fish.json https://acnh.api.louhde.tech/fish 
#curl -s -o data/bugs.json https://acnh.api.louhde.tech/bugs 

FISHS=$(cat data/fish.json)
BUGS=$(cat data/bugs.json)

fishsNames=( $(echo $FISHS | jq -r .[].Value) )
bugsNames=( $(echo $BUGS | jq -r .[].Value) )

nbFishs=$(echo $FISHS | jq length)
nbBugs=$(echo $BUGS | jq length)

printFishsNames() {
    echo ${fishsNames[@]}
}

printBugsNames() {
    echo ${bugsNames[@]}
}

getFishPrice() {
    # Pour pouvoir manipuler la chaine de caractères
    name=$1 
    # %20 correspond à un espace dans une URL
    fishPrice=$(curl -s "https://acnh.api.louhde.tech/fish?fish=${name// /%20}" | jq -r .Price)
    echo $fishPrice
}

getBugPrice() {
    # Pour pouvoir manipuler la chaine de caractères
    name=$1
    # %20 correspond à un espace dans une URL
    bugPrice=$(curl -s "https://acnh.api.louhde.tech/bugs?bug=${name// /%20}" | jq -r .Price)
    echo $bugPrice
}

getAllFishPrice() {
    echo "Nombre de poissons: $nbFishs"
    for (( i=0; i < $nbFishs; i++)); do
        name=$(echo $FISHS | jq -r .[$i].Value)
        # %20 correspond à un espace dans une URL
        fishPrice=$(getFishPrice $name)
        echo $i: $name is $fishPrice bells.
    done
}

getAllBugsPrice() {
    echo "Nombre d'insectes: $nbBugs"
    for (( i=0; i < $nbBugs; i++)); do
        name=$(echo $BUGS | jq -r .[$i].Value)
        # %20 correspond à un espace dans une URL
        bugPrice=$(getBugPrice $name)
        echo $i: $name is $bugPrice bells.
    done
}

isItCheap() {
    if [[ $1 -le 100 ]]; then
        echo "Cheap !"
    elif [[ $1 -gt 100 && $1 -le 250 ]]; then
        echo "It's ok"
    elif [[ $1 -gt 250 && $1 -le 500 ]]; then
        echo "Oh it's more pricey !"
    else
        echo "Too expenisve for me ..."
    fi
}

printFishsNames
printBugsNames

getAllFishPrice
getAllBugsPrice

thonPrice=$(getFishPrice thon)
isItCheap thonPrice

grenouillePrice=$(getFishPrice grenouille)
isItCheap grenouillePrice