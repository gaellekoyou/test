*** Settings ***
Suite Setup       connexion    ${ip_mur_2}
Suite Teardown    Close All Connections
Resource          ../../ress.robot
Library           ConsoleDialogs
Library           SeleniumLibrary

*** Test Cases ***
Contraintes sur le système
    ${out}=    Execute Command    grep adm_ags /etc/passwd
    Should Be Equal    ${out}    adm_ags:x:500:500:Compte d'utilisation de AGS_ADMIN_PSP:/home/adm_ags:/bin/bash
    ${out2}=    Execute Command    grep adm_ags /etc/group
    Should Contain    ${out2}    audio:x:63:adm_ags,daemon

Gestion de la crontab
    ${out}=    Execute Command    su - adm_ags
    ${out1}=    Execute Command    crontab -l
    ${out2}=    Execute Command    more /appli/AGS_SIMU_PCS/comp/param/AGS_SIMU_PCS.cron
    Should Be Equal    ${out2}    ${out}

Installation de l'application
    ${out}=    Execute Command    yum list | grep AGS
    Should Contain Any    ${out}    AGS_SIMU_PCS

Pilotage de l'application
    ${out}=    Execute Command    service AGS_ADMIN_PSP status
    ${out1}=    Execute Command    service AGS_ADMIN_PSP stop
    ${out2}=    Execute Command    service AGS_ADMIN_PSP start
    ${out3}=    Execute Command    service AGS_ADMIN_PSP restart
