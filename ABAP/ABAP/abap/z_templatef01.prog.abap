*&---------------------------------------------------------------------*
*&  Include           Z_TEMPLATEF01
*&---------------------------------------------------------------------*
FORM set_init_value .

  p_bukrs = '1000'.
  p_gjahr = '2016'.

  s_blart-sign   = 'I'.
  s_blart-option = 'EQ'.
  s_blart-low    = 'SA'.
  APPEND s_blart.

  s_budat-sign = 'I'.
  s_budat-option = 'BT'.
  s_budat-low    = '20160101'.
  s_budat-high   = '20161231'.
  APPEND s_budat.

ENDFORM.

FORM get_data .

  CLEAR gt_body.
  SELECT a~bukrs
         a~belnr
         a~gjahr
         a~blart
         a~budat
         a~bktxt
         b~shkzg
         b~hkont
         b~dmbtr
         a~waers
    INTO CORRESPONDING FIELDS OF TABLE gt_body
  FROM bkpf AS a
    INNER JOIN bsis AS b
      ON a~bukrs EQ b~bukrs
     AND a~belnr EQ b~belnr
     AND a~gjahr EQ b~gjahr
  WHERE a~bukrs EQ p_bukrs
    AND a~gjahr EQ p_gjahr
    AND a~blart IN s_blart
    AND a~budat IN s_budat.

  CLEAR gt_skat.
  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE gt_skat
  FROM skat
    FOR ALL ENTRIES IN gt_body
  WHERE saknr EQ gt_body-hkont
    AND spras EQ sy-langu
    AND ktopl EQ 'CAIN'.

ENDFORM.

FORM make_body .

  DATA lv_tabix TYPE sy-tabix.

  LOOP AT gt_body INTO gs_body.
    lv_tabix = sy-tabix.

    CLEAR gs_skat.
    READ TABLE gt_skat INTO gs_skat WITH KEY saknr = gs_body-hkont.
    gs_body-txt50 = gs_skat-txt50.
    MODIFY gt_body FROM gs_body INDEX lv_tabix TRANSPORTING txt50.
    CLEAR gs_body.
  ENDLOOP.

ENDFORM.

FORM display_screen .

  CLEAR gt_fcat.
  PERFORM set_layo.
  PERFORM set_fcat USING :
          'X' 'BUKRS' 'Company Code'     ' ',
          'X' 'BELNR' 'Doc. Number'      ' ',
          'X' 'GJAHR' 'Fiscal Year'      ' ',
          ' ' 'BLART' 'Doc. Type'        ' ',
          ' ' 'BUDAT' 'Doc. Date'        ' ',
          ' ' 'BKTXT' 'Doc. Header Text' 'X',
          ' ' 'SHKZG' 'Debit/Credit'     ' ',
          ' ' 'HKONT' 'G/L Account'      ' ',
          ' ' 'TXT50' 'G/L Name'         'X',
          ' ' 'DMBTR' 'Amount in LC'     ' ',
          ' ' 'WAERS' 'Currency'         ' '.

  IF go_container IS INITIAL.
    PERFORM create_object.

    SET HANDLER: lcl_event_handler=>hotspot_click FOR go_alv_grid,
                 lcl_event_handler=>double_click FOR go_alv_grid.

    CALL METHOD go_alv_grid->set_table_for_first_display
      EXPORTING
        i_save          = 'A'
        i_default       = 'X'
        is_layout       = gs_layo
      CHANGING
        it_outtab       = gt_body
        it_fieldcatalog = gt_fcat.
  ELSE.
    CALL METHOD go_alv_grid->refresh_table_display.
  ENDIF.

ENDFORM.

FORM set_layo .

  CLEAR gs_layo.
  gs_layo-zebra      = 'X'.
  gs_layo-cwidth_opt = 'X'.
  gs_layo-sel_mode   = 'D'.

ENDFORM.

FORM set_fcat USING pv_key pv_fieldname pv_coltext pv_emphasize  .

  gs_fcat-key       = pv_key.
  gs_fcat-fieldname = pv_fieldname.
  gs_fcat-coltext   = pv_coltext.
  gs_fcat-emphasize = pv_emphasize.
  CASE pv_fieldname.
    WHEN 'DMBTR'.
      gs_fcat-cfieldname = 'WAERS'.
    WHEN 'BELNR'.
      gs_fcat-hotspot = 'X'.
  ENDCASE.

  APPEND gs_fcat TO gt_fcat.
  CLEAR gs_fcat.

ENDFORM.

FORM create_object .

  CREATE OBJECT go_container
    EXPORTING
      repid     = sy-repid
      dynnr     = sy-dynnr
      side      = go_container->dock_at_left
      extension = 3000.

  CREATE OBJECT go_alv_grid
    EXPORTING
      i_parent = go_container.

ENDFORM.

FORM hotspot_click USING pv_column_id pv_row_id  .

  CLEAR gs_body.
  READ TABLE gt_body INTO gs_body INDEX pv_row_id.
  SET PARAMETER ID: 'BUK' FIELD gs_body-bukrs,
                    'BLN' FIELD gs_body-belnr,
                    'GJR' FIELD gs_body-gjahr.
  CALL TRANSACTION 'FB03' AND SKIP FIRST SCREEN.

ENDFORM.

FORM double_click USING pv_column pv_row  .

  DATA: lt_bseg  TYPE TABLE OF bseg WITH HEADER LINE,
        lv_subrc.
  CLEAR gs_body.
  READ TABLE gt_body INTO gs_body INDEX pv_row.

  CLEAR gt_bseg.

  CALL FUNCTION 'ZFM_GL_DOCUMENT_DETIAL_17'
    EXPORTING
      i_bukrs = gs_body-bukrs
      i_belnr = gs_body-belnr
      i_gjahr = gs_body-gjahr
    IMPORTING
      e_subrc = lv_subrc
    TABLES
      t_bseg  = lt_bseg.

  IF lv_subrc EQ 'S'.

    LOOP AT lt_bseg.
      MOVE-CORRESPONDING lt_bseg TO gs_bseg.
      APPEND gs_bseg TO gt_bseg.
      CLEAR gs_bseg.
    ENDLOOP.

    CALL SCREEN 110 STARTING AT 03 03.

  ELSE.
    MESSAGE s003 WITH gs_body-bukrs DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

ENDFORM.

FORM display_screen_pop .

  PERFORM set_layo_pop.

  CLEAR gt_fcat_pop.
  PERFORM set_fcat_pop USING:
        'X' 'BUKRS' 'Company Code' ' ',
        'X' 'BELNR' 'Doc. Number'  ' ',
        'X' 'GJAHR' 'Fiscal Year'  ' ',
        'X' 'BUZEI' 'LIne Item'    ' ',
        ' ' 'BUZID' 'LIne Item ID' 'X'.

  IF go_container_pop IS INITIAL.
    PERFORM create_object_pop.
    CALL METHOD go_alv_grid_pop->set_table_for_first_display
      EXPORTING
        i_save          = 'A'
        i_default       = 'X'
        is_layout       = gs_layo_pop
      CHANGING
        it_outtab       = gt_bseg
        it_fieldcatalog = gt_fcat_pop.

  ELSE.
    CALL METHOD go_alv_grid_pop->refresh_table_display.
  ENDIF.
ENDFORM.

FORM set_fcat_pop USING pv_key pv_fieldname pv_coltext pv_emphasize  .

  gs_fcat_pop-key       = pv_key.
  gs_fcat_pop-fieldname = pv_fieldname.
  gs_fcat_pop-coltext   = pv_coltext.
  gs_fcat_pop-emphasize = pv_emphasize.

  APPEND gs_fcat_pop TO gt_fcat_pop.
  CLEAR gs_fcat_pop.

ENDFORM.

FORM set_layo_pop .

  CLEAR gs_layo_pop.
  gs_layo_pop-zebra      = 'X'.
  gs_layo_pop-cwidth_opt = 'X'.
  gs_layo_pop-sel_mode   = 'D'.

ENDFORM.

FORM create_object_pop .

  CREATE OBJECT go_container_pop
    EXPORTING
      container_name = 'GO_CONTAINER_POP'.

  CREATE OBJECT go_alv_grid_pop
    EXPORTING
      i_parent = go_container_pop.

ENDFORM.

FORM save_data .

  DATA: ls_save TYPE ztit17_0829,
        lt_save TYPE TABLE OF ztit17_0829,
        lv_answer.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar      = 'Save Data'
      text_question = 'Are You Sure?'
      text_button_1 = 'Ja'(001)
      text_button_2 = 'Nein'(002)
    IMPORTING
      answer        = lv_answer.

  IF lv_answer NE '1'.
    MESSAGE s101(k5).
    EXIT.
  ENDIF.

  CLEAR lt_save.
  LOOP AT gt_body INTO gs_body.
    MOVE-CORRESPONDING gs_body TO ls_save.
    ls_save-erdat = sy-datum.
    ls_save-erzet = sy-uzeit.
    ls_save-ernam = sy-uname.
    APPEND ls_save TO lt_save.
    CLEAR ls_save.
  ENDLOOP.

  IF lt_save IS NOT INITIAL.
    MODIFY ztit17_0829 FROM TABLE lt_save.
    IF sy-subrc EQ 0.
      COMMIT WORK.
      MESSAGE s001.
    ELSE.
       ROLLBACK WORK.
       MESSAGE s002 DISPLAY LIKE 'E'.
    ENDIF.

  ELSE.
    MESSAGE s002 DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

ENDFORM.
