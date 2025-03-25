/****************************** Module Header ******************************\
* Module Name: frgo.H
*
* keyboard layout header
*
* Copyright (c) 1985-2001, Microsoft Corporation
*
* Various defines for use by keyboard input code.
*
* History:
*
* created by KBDTOOL v3.40 Wed Mar 19 09:24:32 2025
*
\***************************************************************************/

/*
 * kbd type should be controlled by cl command-line argument
 */
#define KBD_TYPE 4

/*
* Include the basis of all keyboard table values
*/
#include "kbd.h"
/***************************************************************************\
* The table below defines the virtual keys for various keyboard types where
* the keyboard differ from the US keyboard.
*
* _EQ() : all keyboard types have the same virtual key for this scancode
* _NE() : different virtual keys for this scancode, depending on kbd type
*
*     +------+ +----------+----------+----------+----------+----------+----------+
*     | Scan | |    kbd   |    kbd   |    kbd   |    kbd   |    kbd   |    kbd   |
*     | code | |   type 1 |   type 2 |   type 3 |   type 4 |   type 5 |   type 6 |
\****+-------+_+----------+----------+----------+----------+----------+----------+*/

#undef  T10
 #define T10 _EQ(                                        'X'                      )
#undef  T11
 #define T11 _EQ(                                  OEM_COMMA                      )
#undef  T12
 #define T12 _EQ(                                      OEM_1                      )
#undef  T13
 #define T13 _EQ(                                        'P'                      )
#undef  T14
 #define T14 _EQ(                                        'B'                      )
#undef  T15
 #define T15 _EQ(                                        'F'                      )
#undef  T16
 #define T16 _EQ(                                        'M'                      )
#undef  T17
 #define T17 _EQ(                                        'L'                      )
#undef  T18
 #define T18 _EQ(                                      OEM_2                      )
#undef  T19
 #define T19 _EQ(                                 OEM_PERIOD                      )
#undef  T1E
 #define T1E _EQ(                                        'O'                      )
#undef  T1F
 #define T1F _EQ(                                        'A'                      )
#undef  T20
 #define T20 _EQ(                                        'I'                      )
#undef  T21
 #define T21 _EQ(                                        'T'                      )
#undef  T23
 #define T23 _EQ(                                        'V'                      )
#undef  T24
 #define T24 _EQ(                                        'S'                      )
#undef  T25
 #define T25 _EQ(                                        'N'                      )
#undef  T26
 #define T26 _EQ(                                        'R'                      )
#undef  T27
 #define T27 _EQ(                                        'U'                      )
#undef  T2C
 #define T2C _EQ(                                        'Q'                      )
#undef  T2D
 #define T2D _EQ(                                        'Z'                      )
#undef  T2E
 #define T2E _EQ(                                        'Y'                      )
#undef  T2F
 #define T2F _EQ(                                        'D'                      )
#undef  T30
 #define T30 _EQ(                                        'J'                      )
#undef  T31
 #define T31 _EQ(                                        'K'                      )
#undef  T32
 #define T32 _EQ(                                        'C'                      )
#undef  T33
 #define T33 _EQ(                                        'H'                      )
#undef  T34
 #define T34 _EQ(                                        'W'                      )
#undef  T35
 #define T35 _EQ(                                      OEM_3                      )
#undef  T0C
 #define T0C _EQ(                                      OEM_4                      )
#undef  T0D
 #define T0D _EQ(                                      OEM_5                      )
#undef  T1A
 #define T1A _EQ(                                      OEM_6                      )
#undef  T1B
 #define T1B _EQ(                                   OEM_PLUS                      )
#undef  T29
 #define T29 _EQ(                                      OEM_8                      )
#undef  T2B
 #define T2B _EQ(                                    #ERROR#                      )

