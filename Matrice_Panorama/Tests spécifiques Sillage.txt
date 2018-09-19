*** Settings ***
Suite Setup       connexion    ${ip_mur_2}
Suite Teardown    Close All Connections
Resource          ../ress.robot
Library           ConsoleDialogs
Library           SeleniumLibrary

*** Test Cases ***
Relancement nuit de l'application
    ${out}=    Execute Command    pkill firefox

Programmation du relancement
    ${out}=    Execute Command    more /var/spool/cron/adm_ags
    Should Be Equal    ${out}    00 2 * * * pkill firefox

Fermeture de firefox
    ${out}=    Execute Command    firefox
    Close Window

Fermeture d'un onglet de Firefox

verification des paramètres flash

Reglages du son
    ${out}=    Execute Command    su adm_ags
    ${out2}=    Execute Command    alsamixer
    ${out3}=    Execute Command    alsactl store
    ${out4}=    Execute Command    exit

Redemarrage de la machine
    ${out}=    Execute Command    reboot

Presence du menu adm_itv
    ${out}=    Execute Command    su adm_itv

Configuration de la résolution
    ${out}=    Execute Command    su adm_itv
    Get Value    13
    Get Value From User    1

Verification de la configuration

Prise en main distant
