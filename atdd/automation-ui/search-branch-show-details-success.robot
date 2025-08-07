*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    
${BROWSER}    headlesschrome


*** Test Cases ***
Company and branch selection, displays correct Tax ID and address 
    Entry Website
    Select Company Name    TOYOTA MOTHER ASIA (THAILAND) CO., LTD.
    Verifies Tax ID is    0115546006888
    Verifies total branches count is    12    
    Search Branch    05
    Verifies branch is    00005 - Bangpakong
    Verifies address is    700/187,700/189 Moo 1, Ban Kao, Phan Thong, Chon Buri 20160 Thailand

*** Keywords ***
Entry Website
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Keyword Succeeds    5x    200ms    Wait Until Element Contains    id=company-information-title    Company Information

Select Company Name
    [Arguments]    ${company_name}
    Wait Until Keyword Succeeds    5x    200ms    Select From List By Label    id=company-name-dropdown    ${company_name}

Verifies Tax ID is
    [Arguments]    ${tax_id_no}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=tax-id-label    ${tax_id_no}

Verifies total branches count is
    [Arguments]    ${company_branchs_length}
    ${branch_length}    Get Selected List Labels    id=company-branch-dropdown
    Length Should Be    ${branch_length}    length=${company_branchs_length}

Search Branch
    [Arguments]    ${branch_no}
    Input Text    id=company-branch-dropdown    ${branch_no}
    Wait Until Element Contains    id=company-branch-dropdown    00005
    Press Keys    None    RETURN

Verifies branch is
    [Arguments]    ${branch_name}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=company-branch-dropdown     ${branch_name}


Verifies address is
    [Arguments]    ${branch_address}
    Wait Until Keyword Succeeds    5x    200ms    Element Text Should Be    id=company-address-label    ${branch_address}

