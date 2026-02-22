*&---------------------------------------------------------------------*
*& Include          MZSBGSF0001F01
*&---------------------------------------------------------------------*

* Form que busca companhia aérea e abre tela PAI 9000. *
FORM zf_cia_pai9000.

  IF gv_carrid IS NOT INITIAL.                                           "SE gv_carrid FOR NÃO INICIAL (ID companhia PREENCHIDO).
    SELECT carrid connid fldate                                          "Seleciono os campos da tabela sflight (VOOS).
      FROM sflight                                                       "DA tabela sflight.
      INTO TABLE gt_sflight                                              "Armazeno dentro da tabela interna gt_sflight.
      WHERE carrid EQ gv_carrid.                                         "Filtro somente pelos voos da companhia informada.

    READ TABLE gt_sflight INDEX gv_index INTO wa_sflight.                "Leio da tabela interna gt_sflight a linha de índice gv_index para work área wa_sflight.

    IF wa_sflight IS INITIAL.                                            "Se não houve linha lida (work area vazia).
      FREE gv_carrid.                                                    "Limpo a variável gv_carrid.
      MESSAGE 'Nenhum voo foi encontrado para essa companhia!' TYPE 'I'. "Messagem de informação que não foi encontrado voo para essa companhia.
    ELSE.                                                                "SENÃO.
      CALL SCREEN 9001.                                                  "Chamo a tela 9001.
    ENDIF.                                                               "Fim do IF (wa_sflight).

  ELSE.                                                                  "SENÃO.

    MESSAGE 'Por favor, digite uma companhia aérea!' TYPE 'I'.           "Mensagem de digitar uma companhia caso o gv_carri É INICIAL.

  ENDIF.                                                                 "Fim do IF (gv_carrid).

ENDFORM.

* Form que busca voos e PBO da tela 9001 (preparação de dados). *
FORM zf_voos_pbo9001.

  SELECT carrname                                       "Seleciona o nome da companhia
    FROM scarr                                          "DA tabela scarr
    INTO gv_carrname                                    "Armazena na variável gv_carrname
    WHERE carrid EQ gv_carrid.                          "Filtro somente pelos voos da companhia informada.
  ENDSELECT.                                            "ENDSELECT pois estou trabalhando com VARIAVEL e não TABELA.

  READ TABLE gt_sflight INDEX gv_index INTO wa_sflight. "Só faço a leitura da tabela gt_sflight para exibir conexão e data de origem.

ENDFORM.

* Form para navegar para o registro anterior. *
FORM zf_prev_pai9001.

  IF gv_index > 1. "Verifica se já não está no primeiro registro
    gv_index -= 1. "Decrementa o índice para voltar uma linha
  ENDIF.

ENDFORM.

* Form para navegar para o próximo registro. *
FORM zf_prox_pai9001.

  DATA(lv_linhas) = lines( gt_sflight ). "Determina a quantidade de linhas na tabela interna gt_sflight

  IF gv_index < lv_linhas.               "Se o índice atual for menor que o total de linhas
    gv_index += 1.                       "Incrementa o índice para avançar uma linha
  ENDIF.

ENDFORM.

* Form para gravar informações na tabela ZTBGSF_SBCOLMAT. *
FORM zf_grava_infos.

  DATA: lv_seq TYPE n.                                            "Declara variável local lv_seq numérica

  wa_sbcolmat-mandt = sy-mandt.                                   "Preenche o campo mandt (cliente) na work area com sy-mandt
  wa_sbcolmat-carrid = gv_carrid.                                 "Preenche carrid na work area com a companhia atual
  wa_sbcolmat-data = wa_sflight-fldate.                           "Preenche a data com fldate do voo atualmente lido
  wa_sbcolmat-usuario = sy-uname.                                 "Preenche o usuário que está executando (sy-uname)

  SELECT seq
  FROM ztbgsf_sbcolmat
  WHERE carrid = @gv_carrid                                       "Busca as sequências já gravadas para essa companhia
  ORDER BY seq DESCENDING
  INTO TABLE @DATA(lt_ult_seq).                                   "Armazena o resultado (sequências) em lt_ult_seq

  IF lt_ult_seq IS NOT INITIAL.                                   "Se existirem registros prévios
    READ TABLE lt_ult_seq INDEX 1 INTO DATA(lwa_ult_seq).         "Lê o primeiro registro (maior seq devido ao ORDER BY DESC)
    lv_seq = lwa_ult_seq-seq.                                     "Atribui à lv_seq o valor do campo seq do registro lido
  ELSE.
    lv_seq = 0.                                                   "Se não houver registros, inicializa seq como 0
  ENDIF.

  lv_seq += 1.                                                    "Incrementa a sequência para gerar novo seq

  wa_sbcolmat-seq = lv_seq.                                       "Atribui a sequência gerada à work area

  INSERT ztbgsf_sbcolmat FROM wa_sbcolmat.                        "Insere o conteúdo da work area na tabela Z (insert DB)

  IF sy-subrc IS INITIAL.                                         "Verifica se o INSERT retornou sucesso (sy-subrc = 0)
    MESSAGE 'Registros gravados na tabela com sucesso!' TYPE 'S'. "Mensagem de sucesso
  ELSE.
    MESSAGE 'Erro ao gravar os registros!' TYPE 'E'.              "Mensagem de erro caso subrc <> 0
  ENDIF.

ENDFORM.

* Form para excluir todos os registros da tabela Z. *
FORM zf_exc_pai9001.

  DELETE FROM ztbgsf_sbcolmat.                                         "Executa DELETE sem WHERE — apaga todos os registros

  COMMIT WORK.                                                         "Confirma a transação no banco

  MESSAGE 'Todos registros excluídos da tabela com sucesso!' TYPE 'I'. "Mensagem informativa para o usuário

ENDFORM.
