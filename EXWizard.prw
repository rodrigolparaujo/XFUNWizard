#INCLUDE "TOTVS.CH"
#INCLUDE "PROTHEUS.CH"

User Function EXWizard()
    Local cNomWiz		:= FunName()
    Local cTitObj1		:= ""
    Local cTitObj2		:= ""
    Local aTxtApre		:= {}
    Local aPaineis		:= {}
    Local aArq			:= {}
    Local aWizard		:= {}
    Local aItens1		:= {}
    Local lRet			:= .T.
    Local nPos
    Local cMsg			:= ""
    Local nX
    Local cOrigem 		:= ""
    Local cDestino 		:= ""
    Local cArquivo 		:= ""
    Local cGrupo 		:= ""
    Local cNCM 			:= ""
    Local dDtIni 		:= CTOD("//")
    Local dDtFim 		:= CTOD("//")
    Local cPrdDe 		:= ""
    Local cPrdAte 		:= ""
    Local cLocalDe 		:= ""
    Local cLocalAte 	:= ""
    Local cConsTes 		:= ""
    Local cTes 			:= ""
    Local nValDe 		:= 0
    Local nValAte 		:= 0
    
    /*
    Função XFUNWizard

    Parametros:
    aTxtApre - Array com o cabecalho do Wizard
    aPaineis - Array com os paineis do Wizard
    cNomeWizard - Nome do arquivo de Wizard
    cNomeAnt - Nome do arquivo anterior do Wizard caso tenha mudado de nome

    Retorno:
    .T. Para validacao OK
    .F. Para validacao NAO OK

    Os parametros para o array aPaineis são:
    
    aAdd (aPaineis[nPos][3], {Tipo do objeto,;
                              Titulo,;
                              Mascara,;
                              Tipo do conteudo,;
                              Numero casas decimais,;
                              Array se for combobox ou listbox ou radiobox,;
                              Opcao de seleção se checkbox,;
                              Tamanho,;
                              Inicializador padrão,;
                              Se usa GetFile,;
                              Consulta Padrão F3})

    
    Tipo do objeto = 1=SAY, 2=MSGET, 3=COMBOBOX, 4=CHECKBOX, 5=LISTBOX, 6=RADIO
    Titulo do objeto, quando tiver. Ex: SAY(Caption), CHECKBOX.
    Picture quando for necessario. Ex: MSGET.
    Tipo de conteudo do objeto. Ex: 1=Caracter, 2=Numerico, 3=Data.
    Numero de casas decimais do objeto MSGET caso seja numerico.
    Itens de selecao dos objetos. Ex: COMBOBOX, LISTBOX, RADIO.
    Opcao de selecao do item quando CHECKBOX. Determina se iniciara marcado ou nao.
    Numero de casas inteiras quando o conteudo do objeto MSGET for numerico.
    Inicializador padrao
    Se usa get para Arquivo (.T. ou .F.)
    Consulta Padrão (F3)
    */
    
    //***************************** PAINEL 0 *****************************//
    aAdd ( aTxtApre , "Exemplo do uso de tela Wizard" )
    aAdd ( aTxtApre , "" )
    aAdd ( aTxtApre , "Preencha corretamente as informações solicitadas." )
    aAdd ( aTxtApre , "Informações necessárias para a importação do arquivo texto." )
    
    //***************************** PAINEL 1 *****************************//
    //Inicializa o painel
    aAdd ( aPaineis , {} )
    nPos :=	Len ( aPaineis )
    
    aAdd ( aPaineis[nPos] , "Preencha corretamente as informações solicitadas." )
    aAdd ( aPaineis[nPos] , "Parâmetros da importação" )
    aAdd ( aPaineis[nPos] , {} ) //Saltar uma linha
    
    aAdd (aPaineis[nPos][3], {1,"Selecione o Arquivo para importação:",,,,,,})
    aAdd (aPaineis[nPos][3], {2,,,1,,,,,,.T.})
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    
    aAdd (aPaineis[nPos][3], {1, "Diretório do Arquivo Destino",,,,,,})
    aAdd (aPaineis[nPos][3], {1, "Nome do Arquivo Destino",,,,,,})
    aAdd (aPaineis[nPos][3], {2,,Replicate ("X", 20),1,,,,20})
    aAdd (aPaineis[nPos][3], {2,,Replicate ("X", 50),1,,,,50})
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    
    aAdd (aPaineis[nPos][3], {1,"Grupo",,,,,,})
    aAdd (aPaineis[nPos][3], {1,"Considera NCM Vazia?",,,,,,})
    
    aAdd (aPaineis[nPos][3], {2,,Replicate ("X", TamSx3("B1_GRUPO")[1])	,1,,,,TamSx3("B1_GRUPO")[1],,,"SBM"})
    
    aItens1	:=	{}
    aAdd (aItens1, "1-Sim")
    aAdd (aItens1, "2-Nao")
    aAdd (aPaineis[nPos][3], {3,,,,,aItens1,,})
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    
    aAdd (aPaineis[nPos][3], {1,"Data de (dd/mm/aaaa)",,,,,,})
    aAdd (aPaineis[nPos][3], {1,"Data até (dd/mm/aaaa)",,,,,,})
    
    aAdd (aPaineis[nPos][3], {2,,Replicate ("X", 10),3,,,,})
    aAdd (aPaineis[nPos][3], {2,,Replicate ("X", 10),3,,,,})
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    
    
    //***************************** PAINEL 2 *****************************//
    
    aAdd (aPaineis, {})
    nPos :=	Len (aPaineis)
    aAdd (aPaineis[nPos], "Preencha corretamente as informações solicitadas.")
    aAdd (aPaineis[nPos], "Informações para processamento do Inventário")
    aAdd (aPaineis[nPos], {})
    
    aAdd (aPaineis[nPos][3], {1,"Produto Inicial",,,,,,})
    aAdd (aPaineis[nPos][3], {1,"Produto Final",,,,,,})
    
    aAdd (aPaineis[nPos][3], {2,,Replicate ("X", TamSx3("B1_COD")[1]),1,,,,TamSx3("B1_COD")[1],,,"SB1"})
    aAdd (aPaineis[nPos][3], {2,,Replicate ("X", TamSx3("B1_COD")[1]),1,,,,TamSx3("B1_COD")[1],,,"SB1"})
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    
    aAdd (aPaineis[nPos][3], {1,"Armazem Inicial",,,,,,})
    aAdd (aPaineis[nPos][3], {1,"Armazem Final",,,,,,})
    
    aAdd (aPaineis[nPos][3], {2,,Replicate ("X", TamSx3("B1_LOCPAD")[1]),1,,,,TamSx3("B1_LOCPAD")[1],,,"NNR"})
    aAdd (aPaineis[nPos][3], {2,,Replicate ("X", TamSx3("B1_LOCPAD")[1]),1,,,,TamSx3("B1_LOCPAD")[1],,,"NNR"})
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    
    aAdd (aPaineis[nPos][3], {1,"Considera TES?",,,,,,})
    aAdd (aPaineis[nPos][3], {1,"Informe as TES's",,,,,,})
    
    aAdd (aPaineis[nPos][3], {3,,,,,{"1-Sim","2-Nao"},,})
    aAdd (aPaineis[nPos][3], {2,,Replicate ("X", 99),1,,,,99})
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    
    
    aAdd (aPaineis[nPos][3], {1, "Valor de" ,,,,,,})
    aAdd (aPaineis[nPos][3], {1, "Valor até",,,,,,})
    
    cMask := "@E 999,999.99"
    aAdd (aPaineis[nPos][3], {2,,cMask,2,2,,,10})
    aAdd (aPaineis[nPos][3], {2,,cMask,2,2,,,10})
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    aAdd (aPaineis[nPos][3], {0,"",,,,,,})//Saltar uma linha
    
    /*********************************************************************
    Função:
    XFUNWizard - Função de montagem do Wizard da rotina
    
    Parametros:
    aTxtApre - Array com o cabeçalho do Wizard
    aPaineis - Array com os paineis do Wizard
    cNomeWizard - Nome do arquivo de Wizard
    cNomeAnt - Nome do arquivo anterior do Wizard caso tenha mudado de nome
    
    Retorno:
    .T. Para validacao OK
    .F. Para validacao NAO OK
    **********************************************************************/
    
    if XFUNWizard( aTxtApre, aPaineis, cNomWiz )
        /*********************************************************************
        Função:
        XFUNLoadProf - Carrega os parametros no profile
        
        Parametros:
        cNomeWizard - Nome do arquivo de Wizard
        aParametros - Array com o conteudo do arquivo texto do Wizard (RETORNO POR REFERENCIA)
        
        Retorno:
        .T. Para validacao OK
        .F. Para validacao NAO OK
        **********************************************************************/
        
        If XFUNLoadProf( cNomWiz , @aWizard )
            
            //Painel 1
            cOrigem  := aWizard[ 1, 01]
            cDestino := aWizard[ 1, 02]
            cArquivo := aWizard[ 1, 03]
            cGrupo 	 := aWizard[ 1, 04]
            cNCM 	 := aWizard[ 1, 05]
            dDtIni 	 := aWizard[ 1, 06]
            dDtFim 	 := aWizard[ 1, 07]
            
            //Painel 2
            cPrdDe 	 := aWizard[ 2, 01]
            cPrdAte  := aWizard[ 2, 02]
            cLocalDe := aWizard[ 2, 03]
            cLocalAte:= aWizard[ 2, 04]
            cConsTes := aWizard[ 2, 05]
            cTes 	 := aWizard[ 2, 06]
            nValDe 	 := aWizard[ 2, 07]
            nValAte  := aWizard[ 2, 08]
            
            //Caso queira validar
            If Empty( Alltrim( cOrigem ))
                MsgStop("O arquivo é obrigatório!")
                Return
            Endif
            
            cMsg := "Arquivo de Origem: " 	+ cOrigem 	+ CRLF
            cMsg += "Pasta de Destino: " 	+ cDestino 	+ CRLF
            cMsg += "Arquivo de Destino: " 	+ cArquivo 	+ CRLF
            cMsg += "Grupo: " 			+ cGrupo 	+ CRLF
            cMsg += "Considera NCM: " 		+ cNCM 		+ CRLF
            cMsg += "Data inicial: " 		+ DTOC(dDtIni) 	+ CRLF
            cMsg += "Data final: " 		+ DTOC(dDtFim) 	+ CRLF
            cMsg += "Produto de: " 		+ cPrdDe 	+ CRLF
            cMsg += "Produto ate: " 		+ cPrdAte 	+ CRLF
            cMsg += "Armazem de: " 		+ cLocalDe 	+ CRLF
            cMsg += "Armazem ate: " 		+ cLocalAte + CRLF
            cMsg += "Considera TES: " 		+ cConsTes 	+ CRLF
            cMsg += "TES informadas: " 		+ cTes		+ CRLF
            cMsg += "Valor de: " 		+ Transform(nValDe ,"@E 999,999.99") 	+ CRLF
            cMsg += "Valor ate: " 		+ Transform(nValAte,"@E 999,999.99")
            
            Aviso("", cMsg ,{"Ok"},3)
        Endif
    Endif
Return
