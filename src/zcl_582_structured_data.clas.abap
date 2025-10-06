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


*----------------------------------------------------------------------------------------------
*   1. STRUCTURED DATA
*----------------------------------------------------------------------------------------------

*    TYPES: BEGIN OF st_connection,
*             airport_from_id TYPE /dmo/airport_from_id,
*             airport_to_id   TYPE /dmo/airport_to_id,
*             carrier_name    TYPE /dmo/carrier_name,
*           END OF st_connection.
*
*    TYPES: BEGIN OF st_connection_nested,
*             airport_from_id TYPE /dmo/airport_from_id,
*             airpotr_to_id   TYPE /dmo/airport_to_id,
*             message         TYPE symsg,
*             carrier_name    TYPE /dmo/carrier_name,
*           END OF st_connection_nested.
*
*    DATA: connection        TYPE st_connection,
*          connection_nested TYPE st_connection_nested.
*
**----------------------------------------------------------------------------------------------
**   Example 1: accesss to structure components
**----------------------------------------------------------------------------------------------
*
*    connection-airport_from_id = 'ABC'.
*    connection-airport_to_id  = 'XYZ'.
*    connection-carrier_name   = 'My Airline'.
*
*    "Access to sub-components of nested structures
*    connection_nested-message-msgty = 'E'.
*    connection_nested-message-msgid = 'ABC'.
*    connection_nested-message-msgno = '123'.
*
**----------------------------------------------------------------------------------------------
**   Example 2: filling a structure with VALUE #( )
**----------------------------------------------------------------------------------------------
*
*    CLEAR connection.
*
*    connection = VALUE #(
*                   airport_from_id = 'DEF'
*                   airport_to_id   = 'UVW'
*                   carrier_name    = 'Your Airline' ).
*
*    " Nested VALUE to fill nested structure
*    CLEAR connection_nested.
*    connection_nested = VALUE #(
*                           airport_from_id = 'DEF'
*                           airpotr_to_id   = 'UVW'
*                           message         = VALUE #( msgty = 'W' msgid = 'XYZ' msgno = '456' )
*                           carrier_name    = 'Your Airline' ).
*
**----------------------------------------------------------------------------------------------
**   Example 3: wrong result after direct assignement
**----------------------------------------------------------------------------------------------
*
*    connection_nested = connection.
*
*    out->write(  `-------------------------------------------------------------` ).
*    out->write(  `Example 3: Wrong Result after direct assignment` ).
*
*    out->write( data = connection
*                name = 'Source Structure:' ).
*
*    out->write( |Component connection_nested-message-msgid: { connection_nested-message-msgid }| ).
*    out->write( |Component connection_nested-carrier_name: { connection_nested-carrier_name }| ).
*
**----------------------------------------------------------------------------------------------
**   Example 4: Assigning Structures using CORRESPONDING #( )
**----------------------------------------------------------------------------------------------
*
*    CLEAR connection_nested.
*    connection_nested = CORRESPONDING #( connection ).
*
*    out->write(  `-------------------------------------------------------------` ).
*    out->write(  `Example 4: Correct Result after assignment with CORRESPONDING #( )` ).
*
*    out->write( data = connection
*                name = 'Source Structure:' ).
*
*    out->write( |Component connection_nested-message-msgid: { connection_nested-message-msgid }| ).
*    out->write( |Component connection_nested-carrier_name: { connection_nested-carrier_name }| ).

*----------------------------------------------------------------------------------------------
*   2. STRUCTURED DATA IN ABAP SQL
*----------------------------------------------------------------------------------------------

    TYPES: BEGIN OF st_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.

    TYPES: BEGIN OF st_connection_short,
             DepartureAirport   TYPE /dmo/airport_from_id,
             DestinationAirport TYPE /dmo/airport_to_id,
           END OF st_connection_short.

    DATA: connection       TYPE st_connection,
          connection_short TYPE st_connection_short,
          connection_full  TYPE /dmo/I_connection.

* Example 1: Correspondence between FIELDS and INTO

    SELECT SINGLE
    FROM /dmo/i_connection
    FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
    WHERE AirlineID = 'LH'
    AND ConnectionID = '0400'
    INTO @connection.

    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 1: Field List and INTO` ).
    out->write( connection ).

* Example 2: FIELDS *

    SELECT SINGLE
    FROM /dmo/i_connection
    FIELDS *
    WHERE AirlineID = 'LH'
    AND connectionID = '0400'
    INTO @connection_full.

    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 2: FIELDS * and INTO` ).
    out->write( connection_full ).

* Example 3: INTO CORRESPONDING FIELDS

    SELECT SINGLE
    FROM /dmo/i_connection
    FIELDS *
    WHERE AirlineID = 'LH'
    AND connectionID = '0400'
    INTO CORRESPONDING FIELDS OF @connection_short.

    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 3: FIELDS * and INTO CORRESPONDING FIELDS OF` ).
    out->write( connection_short ).


* Example 4: Alias name for Fields

    CLEAR connection.

    SELECT SINGLE
    FROM /dmo/i_connection
    FIELDS DepartureAirport AS airport_from_id,
           \_Airline-Name AS carrier_name
    WHERE AirlineID = 'LH'
    AND connectionID = '0400'
    INTO CORRESPONDING FIELDS OF @connection.

    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 4: Aliases and INTO CORRESPONDING FIELDS OF` ).
    out->write( connection ).

* Example 5: Inline declaration

    SELECT SINGLE
    FROM /dmo/i_connection
    FIELDS DepartureAirport,
             DestinationAirport AS ArrivalAirport,
              \_Airline-Name AS CarrierName
     WHERE AirlineID = 'LH'
     AND connectionID = '0400'
     INTO @DATA(connection_inline).

    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 5: Aliases and Inline declaration` ).
    out->write( connection_inline ).

* Example 6: Joins

    SELECT SINGLE
    FROM ( /dmo/connection AS c
    LEFT OUTER JOIN /dmo/airport AS f
    ON c~airport_from_id = f~airport_id )
    LEFT OUTER JOIN /dmo/airport AS t
    ON c~airport_to_id = t~airport_id
    FIELDS c~airport_from_id, c~airport_to_id,
    f~name AS airport_from_name, t~name AS airport_to_name
    WHERE c~carrier_id = 'LH'
    AND c~connection_id = '0400'
        INTO @DATA(connection_join).

    out->write(  `-------------------------------------------------------------` ).
    out->write(  `Example 6: Join of connection and airports` ).
    out->write( connection_join ).


  ENDMETHOD.
ENDCLASS.
