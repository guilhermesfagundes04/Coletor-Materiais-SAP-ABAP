*&---------------------------------------------------------------------*
*& Include          MZSBGSF0001O01
*&---------------------------------------------------------------------*

* Módulo de process before output tela 9000 (Processo antes da saída). *
MODULE pbo_9000 OUTPUT.

  SET PF-STATUS 'S_9000'. "Status 9000 - Botões
  SET TITLEBAR  'T_9000'. "Título 9000 - Coletor Cia

ENDMODULE.

* Módulo de process before output tela 9001 (Processo antes da saída). *
MODULE pbo_9001 OUTPUT.

  SET PF-STATUS 'S_9001'.  "Status 9001 - Botões
  SET TITLEBAR  'T_9001'.  "Título 9001 - Coletor Cia
  PERFORM zf_voos_pbo9001. "EXECUTAR FORM zf_voos_pbo9001.

ENDMODULE.
