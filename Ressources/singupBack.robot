*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  DatabaseLibrary 
Library  JSONLibrary
Resource  variables.robot
Library  pymysql

*** Keywords ***
Vérifier l'existance de l'utilisateur dans la base de données
    Connect To Database Using Custom Params  pymysql  database='demo', user='root', password='', host='localhost'

    Row Count Is 0  SELECT `id` FROM `users` WHERE `username` = '${USERNAME}' AND `password` = md5(${PASSWORD})
Inscription utilisateur par une requête Http POST
    [Tags]  POST
    Create Session  session1  ${WEBSITE_LINK}

    ${body} =  Create Dictionary  username=${USERNAME}  password=${PASSWORD}

    ${header}=  Create Dictionary  Content-Type=application/x-www-form-urlencoded

    ${response} =  POST On Session  session1  signup.php  data=${body}  headers=${header} 

    ${json} =  Set Variable  ${response.json()}

    log  ${response}

    log  ${json}

    Should Be Equal As Strings  ${response.status_code}  200

Vérifier que l'utilisateur est ajoute dans la BD
    Connect To Database Using Custom Params  pymysql  database='demo', user='root', password='', host='localhost'

    Row Count Is Equal To X  SELECT * FROM `users` WHERE `username` = '${USERNAME}'  1

Inscription meme utilisateur par une requête Http POST
    [Tags]  POST New
    Create Session  session2  ${WEBSITE_LINK}

    ${body} =  Create Dictionary  username=${USERNAME}  password=${PASSWORD}

    ${header}=  Create Dictionary  Content-Type=application/x-www-form-urlencoded

    ${response} =  POST On Session  session2  signup.php  data=${body}  headers=${header} 

    ${json} =  Set Variable  ${response.json()}

    log  ${response}

    log  ${json}

    Should Be Equal As Strings  ${response.status_code}  200

    Should Be Equal As Strings  ${json['message']}  Username already exists!

Verifier que l'utilisateur n'est pas dupliquer dans la BD

    Connect To Database Using Custom Params  pymysql  database='demo', user='root', password='', host='localhost'

    Row Count Is Equal To X  SELECT * FROM `users` WHERE `username` = '${USERNAME}'  1







