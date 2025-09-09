CLASS zcl_582_instances DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_582_instances IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*******************************************************************
*
* CONNECTION WITH LOCAL CLASS AND INSTANCES
*
*******************************************************************


*    DATA connection TYPE REF TO lcl_connection.
*    DATA connections TYPE TABLE OF REF TO lcl_connection.
*
** First Instance
***********************************************************************
*
*    connection = NEW #(  ).
*
*    connection->carrier_id    = 'LH'.
*    connection->connection_id = '0400'.
*
*    APPEND connection TO connections.
*
** Second Instance
***********************************************************************
*    connection = NEW #(  ).
*
*    connection->carrier_id    = 'AA'.
*    connection->connection_id = '0017'.
*
*    APPEND connection TO connections.
*
** Third Instance
***********************************************************************
*    connection = NEW #(  ).
*
*    connection->carrier_id    = 'SQ'.
*    connection->connection_id = '0001'.
*
*    APPEND connection TO connections.







*******************************************************************
*
* METHOD CALLS AND EXCEPTION HANDLING
*
*******************************************************************

*    CONSTANTS c_carrier_id TYPE /dmo/carrier_id       VALUE 'LH'.
*    CONSTANTS c_connection_id TYPE /dmo/connection_id VALUE '0400'.
*
*    DATA connection  TYPE REF TO lcl_connection.
*    DATA connections  TYPE TABLE OF REF TO lcl_connection.
*
** Create Instance
***********************************************************************
*
*    connection = NEW #(  ).
*
** Call Method and Handle Exception
***********************************************************************
*    out->write(  |i_carrier_id    = '{ c_carrier_id }' | ).
*    out->write(  |i_connection_id = '{ c_connection_id }'| ).
*
*    TRY.
*        connection->set_attributes(
*          EXPORTING
*            i_carrier_id    = c_carrier_id
*            i_connection_id = c_connection_id
*        ).
*
*        APPEND connection TO connections.
*        out->write( `Method call successful` ).
*      CATCH cx_abap_invalid_value.
*        out->write( `Method call failed`     ).
*    ENDTRY.






*******************************************************************
*
* FUNCTIONAL METHODS
*
*******************************************************************


    DATA connection  TYPE REF TO lcl_connection.
    DATA connections  TYPE TABLE OF REF TO lcl_connection.

* Create Instance
**********************************************************************

    connection = NEW #(  ).

    connection->set_attributes(
      EXPORTING
        i_carrier_id    = 'LH'
        i_connection_id = '0400'
    ).

    APPEND connection TO connections.

* Calling Functional Method
**********************************************************************
    " in a value assignment (with inline declaration for result)
    DATA(result) = connection->get_output( ).

    " in logical expression
    IF connection->get_output(  ) IS NOT INITIAL.

      " as operand in a statement
      LOOP AT connection->get_output(  ) INTO DATA(line).

      ENDLOOP.

      "  to supply input parameter of another method
      out->write( data = connection->get_output( )
                  name = `  ` ).

    ENDIF.


  ENDMETHOD.

ENDCLASS.
