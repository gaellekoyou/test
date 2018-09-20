*** Settings ***
Suite Setup       connexion    ${ip_mur_2}
Suite Teardown    Close All Connections
Resource          ../ress.robot
Library           ConsoleDialogs
Library           SeleniumLibrary

*** Test Cases ***
Vérification OS
    ${out}=    Execute Command    head -1 /etc/issue
    Should Contain Any    ${out}    CentOS release 6.    CentOS release 7.
    ${out2}=    Execute Command    uname -a
    Should Contain    ${out2}    x86_64

Verification DNS
    ${out}=    Execute Command    cat /etc/resolv.conf
    Should Contain    ${out}    nameserver 192.168.40.1

Verification dépôt yum
    ${out}=    Execute Command    yum repolist
    ${out1}=    Execute Command    more /etc/yum.repo.d/CentOS-Base.repo
    ${out2}=    Execute Command    grep ftp.valfontenay.ratp /etc/yum.repo.d/CentOS*-Base*.repo
    Should Contain    ${out2}    ftp.valfontenay.ratp
    ${out3}=    Execute Command    grep depot.crillon.ratp /etc/yum.repo.d/CentOS*-Base*.repo
    Should Contain    ${out3}    depot.crillon.ratp

Verification firewall
    ${out}=    Execute Command    iptables -L | grep ssh | grep ACCEPT
    Pass Execution If    '${out}' == 'ACCEPT'    SSH est ouvert
    ${out1}=    Execute Command    netstat -an | grep 80 | grep -i listen
    Pass Execution If    '${out1}' == 'LISTENNING'    www est ouvert
    ${out2}=    Execute Command    netstat -an | grep 5900 | grep -i listen
    Pass Execution If    '${out2}' == 'LLISTENNNG'    vnc est ouvert

Verification SELinux
    ${out}=    Execute Command    sestatus
    Should Contain    ${out}    SELinux status : disabled

Verification NTP
    ${out}=    Execute Command    service ntpd status
    Should Be Equal    ${out}    ntpd (pid xxx) en cours d'exécution...

Verification NTP(2)
    ${out}=    Execute Command    grep ratp /etc/cron.hourly/ntp_maj.sh | grep ntp
    Should Contain Any    ${out}    ntp*.reseau.ratp
