*&---------------------------------------------------------------------*
*& Include MZSBGSF0001TOP                           - PoolMóds.        SAPMZSBGSF0001
*&---------------------------------------------------------------------*
PROGRAM sapmzsbgsf0001.

* Tabelas que vão ser utilizadas no meu programa. *
TABLES: scarr, sflight, ztbgsf_sbcolmat.

*Tipos que vão ser utilizados no meu programa. *
TYPES: BEGIN OF ty_scarr,
         carrid   TYPE scarr-carrid,
         carrname TYPE scarr-carrname,
       END OF ty_scarr,
       BEGIN OF ty_sflight,
         carrid TYPE sflight-carrid,
         connid TYPE sflight-connid,
         fldate TYPE sflight-fldate,
       END OF ty_sflight.

* Variáveis, work áreas e tabelas internas GLOBAIS que vão ser utilizadas no meu programa. *
DATA: gv_carrid   TYPE scarr-carrid,
      gv_carrname TYPE scarr-carrname,
      gv_index    TYPE i VALUE 1.

DATA: wa_sflight  TYPE ty_sflight,
      wa_sbcolmat TYPE ztbgsf_sbcolmat.

DATA: gt_sflight TYPE STANDARD TABLE OF ty_sflight.
