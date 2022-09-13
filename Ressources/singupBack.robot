*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  DatabaseLibrary 
Resource  variables.robot
Library  pymysql

*** Keywords ***
Vérifier l'existance de l'utilisateur dans la base de données
    Connect To Database Using Custom Params  pymysql  database='demo', user='root', password='', host='localhost'
    Row Count Is 0  SELECT `id` FROM `users` WHERE `username` = ${USERNAME} AND `password` = md5(${PASSWORD})

Inscription utilisateur par une requête Http POST
    Create Session  session1  ${WEBSITE_LINK}
    ${data} =  Create Dictionary  username=${USERNAME1}  password=${PASSWORD}
    ${headers} =  Create Dictionary  content=Type=application/x-www-form-unlencoded
    ${response} =  POST On Session  session1  signup.php  data=${data}  headers=${headers}
    ${json} =  Set Variable  ${response.json()}
    log  ${json}
    Should Be Equal As Strings  ${json.status}  200
    
Vérifier que l'utilisateur est ajoute dans la BD
    Connect To Database Using Custom Params  pymysql  database='demo', user='root', password='', host='localhost'
    Row Count Is Equal To X  select id from users where username = '${USERNAME}'  and password = md5('${PASSWORD}')  1










