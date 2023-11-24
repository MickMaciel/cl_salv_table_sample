*&---------------------------------------------------------------------*
*& Report z_cl_salv_table_sample
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& simple example of an ALV table using the cl_salv_table (global class)
*&
*& created just as a study by: Mick Maciel
*&---------------------------------------------------------------------*
REPORT z_cl_salv_table_sample.

INCLUDE z_cl_salv_table_sample_top.    " Include for declarations and global data
INCLUDE z_cl_salv_table_sample_forms.  " Include for forms

START-OF-SELECTION.
  PERFORM get_data.

END-OF-SELECTION.

  TRY.

      PERFORM create_alv_table.
      PERFORM customize_alv_table.
      PERFORM set_functions.
      PERFORM format_columns.
      PERFORM set_column_key.
      PERFORM set_column_tooltip.
      PERFORM display_alv_table.

    CATCH cx_salv_msg.

  ENDTRY.