*&---------------------------------------------------------------------*
*& Report z_cl_salv_table_sample
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_cl_salv_table_sample.

DATA gt_mara TYPE STANDARD TABLE OF mara.

*ALV OBJECT
DATA: go_alv       TYPE REF TO cl_salv_table,
      go_display   TYPE REF TO cl_salv_display_settings,
      go_functions TYPE REF TO cl_salv_functions_list,
      go_column   TYPE REF TO cl_salv_column.


START-OF-SELECTION.

  SELECT matnr AS material, mtart AS unit
  FROM mara
  INTO TABLE @gt_mara
  UP TO 12 ROWS.

END-OF-SELECTION.

  TRY.

*ALV OBJECT INSTANCE
      cl_salv_table=>factory(
*  EXPORTING
*    list_display   = IF_SALV_C_BOOL_SAP=>FALSE    " ALV Displayed in List Mode
*    r_container    =     " Abstract Container for GUI Controls
*    container_name =
        IMPORTING
          r_salv_table   =  go_alv   " Basis Class Simple ALV Tables
        CHANGING
          t_table        =  gt_mara
      ).
*  CATCH cx_salv_msg.    "
  ENDTRY.

  go_display = go_alv->get_display_settings( ).

  go_display->set_striped_pattern( value = abap_true ).

  go_functions->set_all(
      value = IF_SALV_C_BOOL_SAP=>TRUE
  ).

*SHOW ALV
  go_alv->display( ).