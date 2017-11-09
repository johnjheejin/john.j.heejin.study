*&---------------------------------------------------------------------*
*& Include Z_TEMPLATETOP                                     Report Z_TEMPLATE
*&
*&---------------------------------------------------------------------*
REPORT z_template MESSAGE-ID zit00..

"gv_okcode : (관용어) sy-ucomm 을 받는 global variable.
DATA gv_okcode TYPE sy-ucomm.

"go_alv_grid : ABAP List View 중 가장 많이 쓰이는 grid 형태의 gloabl view object.
"go_container : ALV에서는 해당 내용이 container형태로 들어가는데,
"               그 중에서 가장 많이 쓰이는 docking_conainer.
DATA: go_alv_grid  TYPE REF TO cl_gui_alv_grid,
      go_container TYPE REF TO cl_gui_docking_container.

"gs_layo : ALV 뷰에서의 layout setting.
DATA: gs_layo TYPE lvc_s_layo.

"gs,gt_fcat : view 에 표시할 필드를 custom할 때 설정해주며,
"             structure 단위로 한 필드의 속성이 정해지기에,
"             structure append를 통해 table을 완성시킨다.
DATA: gs_fcat TYPE lvc_s_fcat,
      gt_fcat TYPE lvc_t_fcat.

"Tables 선언. Selection Screen이나
TABLES: bkpf.

"-- Internal Table 및 structure를 선언하는 2가지 방법.
"1. Structure를 선언하고 이를 참조하여 internal table을 만드는 방법.
TYPES : BEGIN OF gty_data,
          bukrs TYPE bkpf-bukrs,
          belnr TYPE bkpf-belnr,
          gjahr TYPE bkpf-gjahr,
          blart TYPE bkpf-blart,
          budat TYPE bkpf-budat,
          bktxt TYPE bkpf-bktxt,
          shkzg TYPE bsis-shkzg,
          hkont TYPE bsis-hkont,
          txt50 TYPE skat-txt50,
          dmbtr TYPE bsis-dmbtr,
          waers TYPE bkpf-waers,
        END OF gty_data.

DATA : gs_data TYPE gty_data,
       gt_data TYPE TABLE OF gty_data.

"덧: 이미 선언된 테이블을 그대로 본따는 경우와
"    선언 형태가 비슷함에 주목하자.
*DATA: gs_skat TYPE skat,
*      gt_skat TYPE TABLE OF skat.


"2. TYPES를 선언,참조하여 모두 만드는 방법.
DATA: BEGIN OF gs_body,
        bukrs TYPE bkpf-bukrs,
        belnr TYPE bkpf-belnr,
        gjahr TYPE bkpf-gjahr,
        blart TYPE bkpf-blart,
        budat TYPE bkpf-budat,
        bktxt TYPE bkpf-bktxt,
        shkzg TYPE bsis-shkzg,
        hkont TYPE bsis-hkont,
        txt50 TYPE skat-txt50,
        dmbtr TYPE bsis-dmbtr,
        waers TYPE bkpf-waers,
      END OF gs_body,
      gt_body LIKE TABLE OF gs_body.

DATA: gs_skat TYPE skat,
      gt_skat TYPE TABLE OF skat.

DATA: gs_bseg TYPE bseg,
      gt_bseg TYPE TABLE OF bseg.

DATA: gs_fcat_pop TYPE lvc_s_fcat,
      gt_fcat_pop TYPE lvc_t_fcat,
      gs_layo_pop TYPE lvc_s_layo.

DATA: go_container_pop TYPE REF TO cl_gui_custom_container,
      go_alv_grid_pop  TYPE REF TO cl_gui_alv_grid.
