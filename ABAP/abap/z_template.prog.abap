*&---------------------------------------------------------------------*
*& Report  Z_TEMPLATE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

INCLUDE z_templatetop                           .    " global Data
INCLUDE z_templates01                           .  " Selection-Screens
INCLUDE z_templatec01                           .  " Evnet class
INCLUDE z_templateo01                           .  " PBO-Modules
INCLUDE z_templatei01                           .  " PAI-Modules
INCLUDE z_templatef01                           .  " FORM-Routines

INITIALIZATION.
  PERFORM set_init_value.

START-OF-SELECTION.
  PERFORM get_data.

  IF gt_body IS NOT INITIAL AND gt_skat IS NOT INITIAL.
    PERFORM make_body.
    CALL SCREEN 100.

  ELSE.
    MESSAGE s003 WITH p_bukrs DISPLAY LIKE 'E'.
    STOP.

  ENDIF.
