*&---------------------------------------------------------------------*
*&  Include           Z_TEMPLATEC01
*&---------------------------------------------------------------------*
CLASS lcl_event_handler DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS hotspot_click
    FOR EVENT hotspot_click OF cl_gui_alv_grid
    IMPORTING e_column_id e_row_id.

    CLASS-METHODS double_click
    FOR EVENT double_click OF cl_gui_alv_grid
    IMPORTING e_column e_row.

ENDCLASS.

CLASS lcl_event_handler IMPLEMENTATION.

  METHOD hotspot_click.
    PERFORM hotspot_click USING e_column_id e_row_id.
  ENDMETHOD.

  METHOD double_click.
    PERFORM double_click USING e_column e_row.
  ENDMETHOD.

ENDCLASS.               "LCL_EVENT_HANDLER
