*&---------------------------------------------------------------------*
*&  Include           Z_TEMPLATEF01
*&---------------------------------------------------------------------*


*FORM set_field_catalog USING pv_key pv_fieldname pv_coltext pv_emphasize  .
*
*  gs_fcat-key       = pv_key.
*  gs_fcat-fieldname = pv_fieldname.
*  gs_fcat-coltext   = pv_coltext.
*  gs_fcat-emphasize = pv_emphasize.
*
*  CASE pv_fieldname.
*
*    WHEN 'S_DMBTR' OR 'H_DMBTR'.
*
*      gs_fcat-cfieldname = 'WAERS'.
*
*    WHEN 'BELNR'.
*
*      gs_fcat-hotspot = 'X'.
*
*  ENDCASE.
*
*  APPEND gs_fcat TO gt_fcat.
*
*  CLEAR gs_fcat.
*
*ENDFORM.


*FORM set_layout .
*
*  CLEAR gs_layo.
*
*  gs_layo-zebra      = 'X'.
*  gs_layo-cwidth_opt = 'X'.
*  gs_layo-sel_mode   = 'D'.
*
*ENDFORM.

*FORM display_screen .
*
*  CLEAR gt_fcat.
*
*  PERFORM set_field_catalog USING: 'X' 'BUKRS' 'Company Code'     ' ',
*                                   'X' 'BELNR' 'Doc. Number'      ' ',
*                                   'X' 'GJAHR' 'Fiscal Year'      ' ',
*                                   ' ' 'BLART' 'Doc. Type'        ' ',
*                                   ' ' 'BUDAT' 'Doc. Date'        ' ',
*                                   ' ' 'BKTXT' 'Doc. Header Text' 'X',
*                                   ' ' 'SHKZG' 'Debit/Credit'     ' ',
*                                   ' ' 'HKONT' 'G/L Account'      ' ',
*                                   ' ' 'TXT50' 'G/L Name'         'X',
*                                   ' ' 'DMBTR' 'Amount in LC'     ' ',
*                                   ' ' 'WAERS' 'Currency'         ' '.
*
*  PERFORM set_layout.
*
*  IF go_container IS INITIAL.
*
*    PERFORM create_object.
*
*    SET HANDLER: lcl_event_handler=>hotspot_click FOR go_alv_grid,
*                 lcl_event_handler=>double_click FOR go_alv_grid.
*
*    CALL METHOD go_alv_grid->set_table_for_first_display
*      EXPORTING
*        i_save          = 'A'
*        i_default       = 'X'
*        is_layout       = gs_layo
*      CHANGING
*        it_outtab       = gt_body
*        it_fieldcatalog = gt_fcat.
*
*  ELSE.
*
*    CALL METHOD go_alv_grid->refresh_table_display.
*
*  ENDIF.
*
*ENDFORM.
*
*FORM create_object .
*
*  CREATE OBJECT go_container
*    EXPORTING
*      repid     = sy-repid
*      dynnr     = sy-dynnr
*      side      = go_container->dock_at_left
*      extension = 3000.
*
*  CREATE OBJECT go_alv_grid
*    EXPORTING
*      i_parent = go_container.
*
*ENDFORM.
