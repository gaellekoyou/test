*** Settings ***
Suite Setup       connexion    ${ip_mur_2}
Suite Teardown    Close All Connections
Resource          ../../ress.robot
Library           ConsoleDialogs
Library           SeleniumLibrary

*** Test Cases ***
Encodage
    ${out}=    Execute Command    cd /appli/AGS_SIMU_PCS
    ${out2}=    Execute Command    for f in `find . *| grep -v "x-directory"`; do echo "$f" ' -- ' `file -bi "$f"` ; done | grep -v x-directory | grep -v ascii | grep -v utf-8 | grep -v binary
    Should Be Empty    ${out2}

Nommage_de_fichiers
    ${out}=    Execute Command    cd /appli/AGS_SIMU_PCS
    ${out2}=    Execute Command    for f in `find . -name *.sh `; do echo "$f" ' -- ' `head -1 "$f"` \ ; done
    Should Contain Any    ${out2}    **#!/bin/bash    **#!/bin/sh

Localisation_des_fichiers
    ${out}=    Execute Command    ls -ltrR

Droits_sur_les_fichiers
    ${out}=    Execute Command    ls -ltrR
    Should Contain Any    ${out}    drwxr-xr-x. * adm_ags ags    -rwxr-xr-x. 1 adm_ags ags

Fichiers_de_log
    #${out}=    Execute Command    more /appli/AGS_SIMU_PCS/var/log/AGS_SIMU_PCS.log
    #Should not be empty    ${out}
