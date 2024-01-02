*&---------------------------------------------------------------------*
*&  Include  z_cl_salv_table_sample_forms
*&---------------------------------------------------------------------*

* This form retrieves data from the MARA table and stores it in the gt_mara internal table
FORM get_data.
  SELECT matnr AS material,
         mtart AS material_type,
         matkl AS material_group
  FROM mara
  INTO TABLE @gt_mara
  UP TO 21 ROWS. "I just limited the number of lines shown in the alv table.
ENDFORM.

* create an ALV table object using the cl_salv_table=>factory method
* it also specifies the container name for the table and the internal table containing the data
FORM create_alv_table.
  DATA lx_salv_msg TYPE REF TO cx_salv_msg.

  TRY.
*   ALV OBJECT INSTANCE
      cl_salv_table=>factory(
*     EXPORTING
*       list_display   = IF_SALV_C_BOOL_SAP=>FALSE    " ALV Displayed in List Mode
*       r_container    =     " Abstract Container for GUI Controls
*       container_name =
          IMPORTING
            r_salv_table   =  go_alv   " Basis Class Simple ALV Tables
          CHANGING
            t_table        =  gt_mara
      ).
    CATCH cx_salv_msg INTO lx_salv_msg.
      " Handle ALV creation error
      MESSAGE lx_salv_msg TYPE 'I'.
  ENDTRY.
ENDFORM.

* customize the ALV table's display settings by activating the striped pattern, which alternates row background colors for better readability
FORM customize_alv_table.
  " Display Settings
  go_display = go_alv->get_display_settings( ).
  go_display->set_striped_pattern( value = abap_true ).
ENDFORM.

* sets the ALV table's function settings, enabling all standard functions, such as sorting, filtering, and search
FORM set_functions.
  " Functions Settings
  go_functions = go_alv->get_functions( ).
  go_functions->set_all( value = if_salv_c_bool_sap=>true ).
ENDFORM.

* optimize the ALV table's columns by adjusting their width and alignment to accommodate the data. It ensures that the columns are displayed correctly
FORM format_columns.
  " Get the reference for ALV Columns, all columns from your ALV Table
  go_columns = go_alv->get_columns( ).

  " Open ALV with all columns adjusted to show the data
  go_columns->set_optimize( if_salv_c_bool_sap=>true ).
ENDFORM.

* set the 'MATERIAL' column as the key column, allowing users to filter or sort the table by material
FORM set_column_key.
  DATA:
    lo_column TYPE REF TO cl_salv_column_table.

  TRY.
      " Get reference for ALV column object.
      lo_column ?= go_columns->get_column( 'MATERIAL' ).

      " Set new key to the table.
      lo_column->set_key( if_salv_c_bool_sap=>true ).

  ENDTRY.
ENDFORM.

* sets a tooltip for the 'MATERIAL' column header, providing additional information to users
FORM set_column_tooltip.
  TRY.
      " Get reference for ALV column object
      go_column = go_columns->get_column( columnname = 'MATERIAL' ).

      " Set new tooltip
      go_column->set_tooltip( 'TOOLTIP for MATERIAL column header' ).

  ENDTRY.
ENDFORM.

* display the ALV table on the screen, allowing users to interact with the data and utilize its features.
FORM display_alv_table.
  go_alv->display( ).
ENDFORM.
