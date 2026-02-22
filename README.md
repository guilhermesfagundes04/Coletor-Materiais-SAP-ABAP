# Coletor-Materiais-SAP-ABAP

**Objetivo / Solicitação** 
Criar um programa de coletor, para gravar informações de materiais e quantidades.

**Desenvolvimento** 

**Regra:**

* Criar uma tabela: ZTBJB_SBCOLMAT
    * MANDT*
    * CARRID*
    * SEQ*
    * DATA
    * USER
* Criar Coletor – SAPMZSBJB0001
    * Tela 9000 – Tela Inicial
        * Título: “Coletor Cia”
        * Campo Entrada: Carrid
        * Botão “F3 – Sair”
            * Encerra transação
        * Botão “F5 – Enter”
            * Vai para tela 9001
    * Tela 9001 (carregada pelo botão F5 da tela 9000)
        * Título: “Coletor Cia”
        * Campo Saída: Descrição Cia Aerea
        * Lista de Voos (lista de campos, no coletor, significa colocar campos text para exibir em formato de lista)
            * Campo Saída: “Conexão – Cidade Origem”
        * Botão “F9 – Prev”
            * Navegação de lista, página anterior
        * Botão “F10 – Prox”
            * Navegação de lista, próxima página
        * Botão “F3 – Sair”
            * Encerra transação sem gravar.
        * Botão “F5 – Enter”
            * Grava informações tabela.
        * Botão “F7 – Finalizar”
            * Grava informações e finaliza transação.
    * Regra
        * Na tela 9000, deverá ser digitado o código Carrid. A partir deste buscar a SFLIGHT com a lista dos voos da cia.
        * Descrição da CIA na SCARR, campo CARRNAME.
        * Conexão – Cidade Origem (SFLIGHT-CONNID – SFLIGHT-FLDATE).
        * Gravação dos dados na tabela criada, campo SEQ será gravado por CIA. 
