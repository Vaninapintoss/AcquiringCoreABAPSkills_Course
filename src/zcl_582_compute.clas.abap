CLASS zcl_582_compute DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_582_compute IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*______________________________________________________1 EXERCISE

*    DATA: number1 TYPE i,
*          number2 TYPE i.
*
*    number1 = 8.
*    number2 = 2.
*
**    DATA(result) = number1 / number2.
*    DATA result TYPE p LENGTH 8 DECIMALS 2.
*    result = number1 / number2.
*
*    DATA(output) = |{ number1 } / { number2 } = { result }| .
*
*    out->write( output ).

*______________________________________________________2 EXERCISE

*    CONSTANTS: max_count TYPE i VALUE 20.
*
*    DATA: numbers TYPE TABLE OF i.
*
*    DO max_count TIMES.
*
*      CASE sy-index.
*        WHEN 1.
*          APPEND 0 TO numbers.
*        WHEN 2.
*          APPEND 1 TO numbers.
*        WHEN OTHERS.
*          APPEND numbers[  sy-index - 2 ]
*               + numbers[  sy-index - 1 ]
*              TO numbers.
*      ENDCASE.
*
*    ENDDO.
*
*
*    DATA(counter) = 0.
*    LOOP AT numbers INTO DATA(number).
*
*      counter = counter + 1.
*
*      APPEND |{ counter WIDTH = 4 }: { number WIDTH = 10 ALIGN = RIGHT }|
*          TO output.
*
*    ENDLOOP.
*
*
*    out->write(
*           data   = output
*           name   = |The first { max_count } Fibonacci Numbers|
*                  ) .



  ENDMETHOD.
ENDCLASS.
