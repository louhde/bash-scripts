#!/bin/bash

curl -s -o fish.json https://acnhapi.com/v1/fish/
Fish=($(jq -r 'keys | .[]' fish.json))

getAllFish() {
    echo "Il y a $(jq -r 'keys | length' fish.json) poissons."
    echo ${Fish[@]}
}

getAllFishPrice() {
    for poisson in "${Fish[@]}"; do
        name=$(jq -r --arg poisson $poisson '.[$poisson].name."name-EUfr"' fish.json)
        price=$(jq -r --arg poisson $poisson '.[$poisson].price' fish.json)
        echo "le poisson $name coute $price clochettes."
    done
}

getFishPrice() {
    found=0
    for poisson in "${Fish[@]}"; do
        name=$(jq -r --arg poisson $poisson '.[$poisson].name."name-EUfr"' fish.json)
        if [[ "$1" == $poisson || "$1" == $name ]]; then
            found+=1
            price=$(jq -r --arg poisson $poisson '.[$poisson].price' fish.json)
            echo "le poisson $name coute $price clochettes."
        fi
    done
    if (( found == 0 )); then 
        echo "Poisson non trouvé !" 
    fi
}

isItCheap() {
    if [[ $1 -le 100 ]]; then
        echo "Pas cher !"
    elif [[ $1 -gt 100 && $1 -le 250 ]]; then
        echo "Ca va ..."
    elif [[ $1 -gt 250 && $1 -le 500 ]]; then
        echo "Oh c'est plus cher !"
    else
        echo "Trop cher pour moi ..."
    fi
}

getAllFish
©getAllFishPrice
getFishPrice "football_fish"
isItCheap $(jq -r --arg poisson "squid" '.[$poisson].price' fish.json)