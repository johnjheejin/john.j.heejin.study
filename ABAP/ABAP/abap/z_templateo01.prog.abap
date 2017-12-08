*&---------------------------------------------------------------------*
*&  Include           Z_TEMPLATEO01
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'MENU100'.
  SET TITLEBAR 'TITLE100'.
ENDMODULE.

MODULE init_process_control OUTPUT.
  PERFORM display_screen.
ENDMODULE.

MODULE status_0110 OUTPUT.
  SET PF-STATUS 'MENU110'.
  SET TITLEBAR 'TITLE110'.
ENDMODULE.

MODULE init_process_control_pop OUTPUT.
  PERFORM display_screen_pop.
ENDMODULE.
