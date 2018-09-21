*** Settings ***
Suite Setup       connexion    ${ip_mur_2}
Suite Teardown    Close All Connections
Resource          ../../ress.robot
Library           ConsoleDialogs
Library           SeleniumLibrary

*** Test Cases ***
Encodage
    Comment    ${out}=    Execute Command    cd /appli/AGS_SIMU_PCS
    Comment    ${out2}=    Execute Command    for f in `find . *| grep -v "x-directory"`; do echo "$f" ' -- ' `file -bi "$f"` ; done | grep -v x-directory | grep -v ascii | grep -v utf-8 | grep -v binary
    Comment    Should Be Empty    ${out2}

Nommage_de_fichiers
    Comment    ${out}=    Execute Command    cd /appli/AGS_SIMU_PCS
    Comment    ${out2}=    Execute Command    for f in `find . -name *.sh `; do echo "$f" ' -- ' `head -1 "$f"` \ ; done
    Comment    Should Contain Any    ${out2}    **#!/bin/bash    **#!/bin/sh

Localisation_des_fichiers
    ${out}=    Execute Command    ls -ltrR

Droits_sur_les_fichiers
    Comment    ${out}=    Execute Command    ls -ltrR
    Comment    Should Contain Any    ${out}    drwxr-xr-x. * adm_ags ags    -rwxr-xr-x. 1 adm_ags ags

Fichiers_de_log
    Comment    #${out}=    Execute Command    more /appli/AGS_SIMU_PCS/var/log/AGS_SIMU_PCS.log
    Comment    #Should not be empty    ${out}
