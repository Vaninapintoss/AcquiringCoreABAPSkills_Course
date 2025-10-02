CLASS zcl_582_structured_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_582_structured_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF st_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.

    TYPES: BEGIN OF st_connection_nested,
             airport_from_id TYPE /dmo/airport_from_id,
             airpotr_to_id   TYPE /dmo/airport_to_id,
             message         TYPE symsg,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection_nested.

    DATA: connection        TYPE st_connection,
          connection_nested TYPE st_connection_nested.

*----------------------------------------------------------------------------------------------
*   Example 1: accesss to structure components
*----------------------------------------------------------------------------------------------

    connection-airport_from_id = 'ABC'.
    connection-airport_to_id  = 'XYZ'.
    connection-carrier_name   = 'My Airline'.

    "Access to sub-components of nested structures
    connection_nested-message-msgty = 'E'.
    connection_nested-message-msgid = 'ABC'.
    connection_nested-message-msgno = '123'.

*----------------------------------------------------------------------------------------------
*   Example 2: filling a structure with VALUE #( )
*----------------------------------------------------------------------------------------------

    CLEAR connection.

    connection = VALUE #(
                   airport_from_id = 'DEF'
                   airport_to_id   = 'UVW'
                   carrier_name    = 'Your Airline' ).

    " Nested VALUE to fill nested structure
    CLEAR connection_nested.
    connection_nested = VALUE #(
                           airport_from_id = 'DEF'
                           airpotr_to_id   = 'UVW'
                           message         = VALUE #( msgty = 'W' msgid = 'XYZ' msgno = '456' )
                           carrier_name    = 'Your Airline' ).

*----------------------------------------------------------------------------------------------
*   Example 3: wrong result after direct assignement
*----------------------------------------------------------------------------------------------

    connection_nested = connection.

    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 3: Wrong Result after direct assignment` ).

    out->write( data = connection
                name = 'Source Structure:' ).

    out->write( |Component connection_nested-message-msgid: { connection_nested-message-msgid }| ).
    out->write( |Component connection_nested-carrier_name: { connection_nested-carrier_name }| ).

*----------------------------------------------------------------------------------------------
*   Example 4: Assigning Structures using CORRESPONDING #( )
*----------------------------------------------------------------------------------------------

    CLEAR connection_nested.
    connection_nested = CORRESPONDING #( connection ).

    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 4: Correct Result after assignment with CORRESPONDING #( )` ).

    out->write( data = connection
                name = 'Source Structure:' ).

    out->write( |Component connection_nested-message-msgid: { connection_nested-message-msgid }| ).
    out->write( |Component connection_nested-carrier_name: { connection_nested-carrier_name }| ).

endmethod.
ENDCLASS.
