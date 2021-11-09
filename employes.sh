#!/bin/bash

curl -o data/employes.json -s https://61890166d0821900178d76e6.mockapi.io/api/Employes

estMineur() {
    if [[ $1 -lt 18 ]]; then
        echo "est mineur"
    else
        echo "est majeur"
    fi
}

nbEmployes=$(cat data/employes.json | jq length)
echo "Il y a $nbEmployes employes."

getEmployes() {
    for (( i=0; i<$nbEmployes; i++ )); do 
        prenom=$(cat data/employes.json | jq -r .[$i].Prenom)
        nom=$(cat data/employes.json | jq -r .[$i].Nom)
        age=$(cat data/employes.json | jq -r .[$i].Age)
        echo "$prenom $nom $(estMineur $age), il/elle a $age ans."
    done
}

getEmployes

getAllPost() {
    # Pour être sur de récupérer les jobs comme ils sont ecrits
    while read -r job ; do
        Jobs+=("$job")
    done < <(cat data/employes.json | jq -r 'unique_by(.Job) | .[].Job')

    for jobName in "${Jobs[@]}"; do
        # On passe à jq un argument contenant le nom du job
        Stats=$(cat data/employes.json | jq --arg jobName "$jobName" '. | map(select(.Job == $jobName)) | length')
        echo $jobName: $Stats
    done
}

getAllPost


getAllGenre() {
    # Pour être sur de récupérer les genres comme ils sont ecrits
    while read -r genre ; do
        Genres+=("$genre")
    done < <(cat data/employes.json | jq -r 'unique_by(.Genre) | .[].Genre')

    for genreName in "${Genres[@]}"; do
        # On passe à jq un argument contenant le nom du genre
        Stats=$(cat data/employes.json | jq --arg genreName "$genreName" '. | map(select(.Genre == $genreName)) | length')
        echo $genreName: $Stats
    done
}

getAllGenre

sameCity() {
    person1=$(cat data/employes.json | jq --arg name $1 '. | map(select(.Prenom == $name))')
    person2=$(cat data/employes.json | jq --arg name $2 '. | map(select(.Prenom == $name))')

    ville1=$(echo $person1 | jq -r .[].Ville)
    ville2=$(echo $person2 | jq -r .[].Ville)
    
    if [[ "$ville1" == "$ville2" ]]; then
        echo "$1 et $2 habitent au meme endroit !"
    else 
        echo "$1 et $2 habitent dans des villes différentes"
    fi

}

sameCity "Keira" "Brad"