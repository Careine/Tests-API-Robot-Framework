*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  DatabaseLibrary 
Library  JSONLibrary
Resource  variables.robot
Library  pymysql


*** Keywords ***
Verifier que l'utilisateur existe
    Connect To Database Using Custom Params  pymysql  database='demo', user='root', password='', host='localhost'

    Row Count Is Equal To X  SELECT `id` FROM `users` WHERE `username` = '${USERNAME}'  1

Authentification de l'utilisateur
    Create Session  session3  ${WEBSITE_LINK}  disable_warnings=1

    ${endpoint} =  Set Variable  username=${USERNAME}&password=${PASSWORD}

    ${response} =  GET On Session  session3  login.php?${endpoint}

    ${json} =  Set Variable  ${response.json()}

    log  ${json}

    Should Be Equal As Strings  ${response.status_code}  200

    Should Be Equal As Strings   ${json['message']}  Successfully Login!

Supprimer un utilisateur
    Connect To Database Using Custom Params  pymysql  database='demo', user='root', password='', host='localhost'
    
    Execute Sql String  DELETE FROM `users` WHERE `username`= 'Arafata' and `password`= md5('Arafata')

    Disconnect From Database

Authentifier de l'utilisateur
    Create Session  session4  ${WEBSITE_LINK}  disable_warnings=1

    ${endpoint} =  Set Variable  username=${USERNAME}&password=${PASSWORD1}

    ${response} =  GET On Session  session4  login.php?${endpoint}

    ${json} =  Set Variable  ${response.json()}

    Log  ${json}

    Should Be Equal As Strings  ${response.status_code}  200

    Should Be Equal As Strings  ${json['message']}  Invalid Username or Password!