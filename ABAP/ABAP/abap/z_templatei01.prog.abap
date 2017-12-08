*&---------------------------------------------------------------------*
*&  Include           Z_TEMPLATEI01
*&---------------------------------------------------------------------*

MODULE exit INPUT.
  CASE gv_okcode.
    WHEN 'BACK' OR 'EXIT' OR 'CANC'.
      CALL METHOD: go_alv_grid->free,
                   go_container->free.
      FREE: go_alv_grid, go_container.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.

MODULE user_command_0100 INPUT.
  CASE gv_okcode.
    WHEN 'SAVE'.
      PERFORM save_data.
  ENDCASE.
ENDMODULE.

MODULE exit_pop INPUT.
  CASE gv_okcode.
    WHEN 'BACK' OR 'EXIT' OR 'CANC'.
      CALL METHOD: go_alv_grid_pop->free,
                   go_container_pop->free.
      FREE: go_alv_grid_pop, go_container_pop.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
