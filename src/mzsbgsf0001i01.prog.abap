*&---------------------------------------------------------------------*
*& Include          MZSBGSF0001I01
*&---------------------------------------------------------------------*

* Módulo de process after input tela 9000 (Processo depois da entrada). *
MODULE pai_9000 INPUT.

  CASE sy-ucomm.                               "CASO sy-ucomm (variável do sistema).
    WHEN 'F3' OR 'BACK' OR 'EXIT' OR 'CANCEL'. "QUANDO FOR 'F3' OU 'BACK' OU 'EXIT' OU 'CANCEL'.
      LEAVE PROGRAM.                           "SAI DO PROGRAMA.
    WHEN 'F5'.                                 "QUANDO FOR 'F5'.
      PERFORM zf_cia_pai9000.                  "EXECUTAR FORM zf_cia_9000.
  ENDCASE.                                     "Fim do CASO.

ENDMODULE.

* Módulo de process after input tela 9001 (Processo depois da entrada). *
MODULE pai_9001 INPUT.

  CASE sy-ucomm.                               "CASO sy-ucomm (variável do sistema).
    WHEN 'F9'.                                 "QUANDO FOR 'F9'.
      PERFORM zf_prev_pai9001.                 "EXECUTAR FORM zf_prev_pai9001 - Página anterior
    WHEN 'F10'.                                "QUANDO FOR 'F10'.
      PERFORM zf_prox_pai9001.                 "EXECUTAR FORM zf_prox_pai9001 - Próxima página
    WHEN 'F3' OR 'BACK' OR 'EXIT' OR 'CANCEL'. "QUANDO FOR 'F3' OU 'BACK' OU 'EXIT' OU 'CANCEL'.
      LEAVE PROGRAM.                           "SAI DO PROGRAMA.
    WHEN 'F5'.                                 "QUANDO FOR 'F5'.
      PERFORM zf_grava_infos.                  "EXECUTAR FORM zf_grava_infos - Grava os dados na tabela ZTBGSF_SBCOLMAT
    WHEN 'F7'.                                 "QUANDO FOR 'F7'.
      PERFORM zf_grava_infos.                  "EXECUTAR FORM zf_grava_infos - Grava os dados na tabela ZTBGSF_SBCOLMAT
      LEAVE PROGRAM.                           "SAI DO PROGRAMA.
    WHEN 'F1'.                                 "QUANDO FOR 'F1'.
      PERFORM zf_exc_pai9001.                  "EXECUTAR FORM zf_exc_pai9001 - Exclui todos os dados da tabela ZTBGSF_SBCOLMAT
  ENDCASE.                                     "Fim do CASO.

ENDMODULE.
