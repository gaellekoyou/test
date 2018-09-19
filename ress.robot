*** Settings ***
Library           SSHLibrary
Library           BuiltIn
Library           SeleniumLibrary

*** Variables ***
${ip_panorama}    147.13.13.103
${ip_mur_1}       147.13.13.100
${ip_mur_2}       147.13.13.101
${ip_trafic}      147.13.13.102
${ip_ocarina}     147.13.13.104
${ip_deport_1}    147.13.13.105
${ip_tetra}       147.13.13.106
${ip_formateur}    147.13.13.107

*** Keywords ***
connexion
    [Arguments]    ${ip}
    Open Connection    ${ip}    22
    Login    root    10tribution
