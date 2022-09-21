*** Settings ***
Resource  ../Ressources/singupBack.robot
Resource  ../Ressources/loginBack.robot


*** Test Cases ***
Inscrire un utilisateur dans la BD
    [Tags]  First
    singupBack.Vérifier l'existance de l'utilisateur dans la base de données
    singupBack.Inscription utilisateur par une requête Http POST
    singupBack.Vérifier que l'utilisateur est ajoute dans la BD
    singupBack.Inscription meme utilisateur par une requête Http POST
    singupBack.Verifier que l'utilisateur n'est pas dupliquer dans la BD

Authentifier utilisateur
    [Tags]  Second
    loginBack.Verifier que l'utilisateur existe
    loginBack.Authentification de l'utilisateur
    loginBack.Supprimer un utilisateur
    loginBack.Authentifier de l'utilisateur
