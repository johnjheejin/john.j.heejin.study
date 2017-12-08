*&---------------------------------------------------------------------*
*&  Include           Z_TEMPLATES01
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK bk1 WITH FRAME TITLE text-t01.
  PARAMETERS: p_bukrs TYPE bkpf-bukrs OBLIGATORY,
              p_gjahr TYPE bkpf-gjahr OBLIGATORY.

  SELECT-OPTIONS: s_blart FOR bkpf-blart OBLIGATORY,
                  s_budat FOR bkpf-budat.
  SELECTION-SCREEN END OF block bk1.
