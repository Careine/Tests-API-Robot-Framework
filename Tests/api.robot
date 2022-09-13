*** Settings ***
Resource  ../Ressources/singupBack.robot


*** Test Cases ***
Inscrire un utilisateur dans la BD
    [Tags]  First
    singupBack.Vérifier l'existance de l'utilisateur dans la base de données
    singupBack.Inscription utilisateur par une requête Http POST
    singupBack.Vérifier que l'utilisateur est ajoute dans la BD