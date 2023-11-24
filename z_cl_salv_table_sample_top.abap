*&---------------------------------------------------------------------*
*&  Include  z_cl_salv_table_sample_top
*&---------------------------------------------------------------------*

TYPES: BEGIN OF ty_mara, "ALV output types
         material       TYPE matnr,
         material_type  TYPE mtart,
         material_group TYPE matkl,
       END OF ty_mara.

DATA gt_mara TYPE TABLE OF ty_mara.

DATA: go_alv       TYPE REF TO cl_salv_table,
      go_display   TYPE REF TO cl_salv_display_settings,
      go_functions TYPE REF TO cl_salv_functions_list,
      go_columns   TYPE REF TO cl_salv_columns_table,
      go_column    TYPE REF TO cl_salv_column.