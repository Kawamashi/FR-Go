﻿; Generated by kalamine on 2025-04-01

#NoEnv
#Persistent
#InstallKeybdHook
#SingleInstance,       force
#MaxThreadsBuffer
#MaxThreadsPerHotKey   3
#MaxHotkeysPerInterval 300
#MaxThreads            20

SendMode Event ; either Event or Input
SetKeyDelay,   -1
SetBatchLines, -1
Process, Priority, , R
SetWorkingDir, %A_ScriptDir%
StringCaseSense, On


;-------------------------------------------------------------------------------
; On/Off Switch
;-------------------------------------------------------------------------------

global Active := True

HideTrayTip() {
  TrayTip  ; Attempt to hide it the normal way.
  if SubStr(A_OSVersion,1,3) = "10." {
    Menu Tray, NoIcon
    Sleep 200  ; It may be necessary to adjust this sleep.
    Menu Tray, Icon
  }
}

ShowTrayTip() {
  title := "FR-Go"
  text := Active ? "ON" : "OFF"
  HideTrayTip()
  TrayTip, %title% , %text%, 1, 0x31
  SetTimer, HideTrayTip, -1500
}

RAlt & Alt::
Alt & RAlt::
  global Active
  Active := !Active
  ShowTrayTip()
  return

#If Active
SetTimer, ShowTrayTip, -1000  ; not working


;-------------------------------------------------------------------------------
; DeadKey Helpers
;-------------------------------------------------------------------------------

global DeadKey := ""

; Check CapsLock status, upper the char if needed and send the char
SendChar(char) {
  if % GetKeyState("CapsLock", "T") {
    if (StrLen(char) == 6) {
      ; we have something in the form of `U+NNNN `
      ; Change it to 0xNNNN so it can be passed to `Chr` function
      char := Chr("0x" SubStr(char, 3, 4))
    }
    StringUpper, char, char
  }
  Send, {%char%}
}

DoTerm(base:="") {
  global DeadKey

  term := SubStr(DeadKey, 2, 1)

  Send, {%term%}
  SendChar(base)
  DeadKey := ""
}

DoAction(action:="") {
  global DeadKey

  if (action == "U+0020") {
    Send, {SC39}
    DeadKey := ""
  }
  else if (StrLen(action) != 2) {
    SendChar(action)
    DeadKey := ""
  }
  else if (action == DeadKey) {
    DoTerm(SubStr(DeadKey, 2, 1))
  }
  else {
    DeadKey := action
  }
}

SendKey(base, deadkeymap) {
  if (!DeadKey) {
    DoAction(base)
  }
  else if (deadkeymap.HasKey(DeadKey)) {
    DoAction(deadkeymap[DeadKey])
  }
  else {
    DoTerm(base)
  }
}


;-------------------------------------------------------------------------------
; Base
;-------------------------------------------------------------------------------

;  Digits

 SC02::SendKey("U+0031", {"**": "U+00df", "*^": "U+00b9", "*ˇ": "U+2081"}) ; 1
+SC02::SendKey("U+0031", {"**": "U+00df", "*^": "U+00b9", "*ˇ": "U+2081"}) ; 1

 SC03::SendKey("U+0032", {"**": "U+221e", "*^": "U+00b2", "*ˇ": "U+2082"}) ; 2
+SC03::SendKey("U+00ab", {}) ; «

 SC04::SendKey("U+0033", {"**": "U+00f1", "*^": "U+00b3", "*ˇ": "U+2083"}) ; 3
+SC04::SendKey("U+00bb", {"**": "U+00d1"}) ; »

 SC05::SendKey("U+0034", {"**": "U+00a7", "*^": "U+2074", "*ˇ": "U+2084"}) ; 4
+SC05::SendKey("U+0034", {"**": "U+00a7", "*^": "U+2074", "*ˇ": "U+2084"}) ; 4

 SC06::SendKey("U+0035", {"**": "U+00b6", "*^": "U+2075", "*ˇ": "U+2085"}) ; 5
+SC06::SendKey("U+0035", {"**": "U+00b6", "*^": "U+2075", "*ˇ": "U+2085"}) ; 5

 SC07::SendKey("U+0036", {"**": "U+2122", "*^": "U+2076", "*ˇ": "U+2086"}) ; 6
+SC07::SendKey("U+0036", {"**": "U+2122", "*^": "U+2076", "*ˇ": "U+2086"}) ; 6

 SC08::SendKey("U+0037", {"**": "U+00a3", "*^": "U+2077", "*ˇ": "U+2087"}) ; 7
+SC08::SendKey("U+0037", {"**": "U+00a3", "*^": "U+2077", "*ˇ": "U+2087"}) ; 7

 SC09::SendKey("U+0038", {"**": "U+00b0", "*^": "U+2078", "*ˇ": "U+2088"}) ; 8
+SC09::SendKey("U+0038", {"**": "U+00b0", "*^": "U+2078", "*ˇ": "U+2088"}) ; 8

 SC0a::SendKey("U+0039", {"**": "U+00a9", "*^": "U+2079", "*ˇ": "U+2089"}) ; 9
+SC0a::SendKey("U+0039", {"**": "U+00a9", "*^": "U+2079", "*ˇ": "U+2089"}) ; 9

 SC0b::SendKey("U+0030", {"**": "U+20ac", "*^": "U+2070", "*ˇ": "U+2080"}) ; 0
+SC0b::SendKey("U+2026", {}) ; …

;  Letters, first row

 SC10::SendKey("U+0078", {"**": "U+00f4", "*¨": "U+1e8d", "*µ": "U+03be"}) ; x
+SC10::SendKey("U+0058", {"**": "U+00d4", "*¨": "U+1e8c", "*µ": "U+039e"}) ; X

 SC11::SendKey("U+002c", {"**": "U+00e2"}) ; ,
+SC11::SendKey("U+0021", {"**": "U+00c2"}) ; !

 SC12::SendKey("U+00e9", {"**": "U+00ee"}) ; é
+SC12::SendKey("U+00c9", {"**": "U+00ce"}) ; É

 SC13::SendKey("U+0070", {"**": "U+00fb", "*´": "U+1e55", "*/": "U+1d7d", "*µ": "U+03c0", "*¤": "U+20b0"}) ; p
+SC13::SendKey("U+0050", {"**": "U+00db", "*´": "U+1e54", "*/": "U+2c63", "*µ": "U+03a0", "*¤": "U+20a7"}) ; P

 SC14::SendKey("U+0062", {"**": "U+00b5", "*/": "U+0180", "*µ": "U+03b2", "*¤": "U+0e3f"}) ; b
+SC14::SendKey("U+0042", {"*/": "U+0243", "*µ": "U+0392", "*¤": "U+20b1"}) ; B

 SC15::SendKey("U+0066", {"**": "U+0022", "*µ": "U+03c6", "*¤": "U+0192"}) ; f
+SC15::SendKey("U+0046", {"**": "U+201e", "*µ": "U+03a6", "*¤": "U+20a3"}) ; F

 SC16::SendKey("U+006d", {"**": "U+00ab", "*´": "U+1e3f", "*µ": "U+03bc", "*¤": "U+20a5"}) ; m
+SC16::SendKey("U+004d", {"**": "U+201c", "*´": "U+1e3e", "*µ": "U+039c", "*¤": "U+2133"}) ; M

 SC17::SendKey("U+006c", {"**": "U+00bb", "*´": "U+013a", "*ˇ": "U+013e", "*¸": "U+013c", "*/": "U+0142", "*µ": "U+03bb", "*¤": "U+00a3"}) ; l
+SC17::SendKey("U+004c", {"**": "U+201d", "*´": "U+0139", "*ˇ": "U+013d", "*¸": "U+013b", "*/": "U+0141", "*µ": "U+039b", "*¤": "U+20a4"}) ; L

 SC18::SendKey("U+2019", {"**": "U+2022"}) ; ’
+SC18::SendKey("U+003f", {"**": "U+00bf"}) ; ?

 SC19::SendKey("U+002e", {"**": "U+00b7"}) ; .
+SC19::SendKey("U+003a", {"**": "U+00a1"}) ; :

;  Letters, second row

 SC1e::SendKey("U+006f", {"**": "U+00ea", "*``": "U+00f2", "*´": "U+00f3", "*”": "U+0151", "*^": "U+00f4", "*ˇ": "U+01d2", "*˘": "U+014f", "*~": "U+00f5", "*¯": "U+014d", "*¨": "U+00f6", "*˛": "U+01eb", "*/": "U+00f8", "*µ": "U+03bf", "*¤": "U+0bf9"}) ; o
+SC1e::SendKey("U+004f", {"**": "U+00ca", "*``": "U+00d2", "*´": "U+00d3", "*”": "U+0150", "*^": "U+00d4", "*ˇ": "U+01d1", "*˘": "U+014e", "*~": "U+00d5", "*¯": "U+014c", "*¨": "U+00d6", "*˛": "U+01ea", "*/": "U+00d8", "*µ": "U+039f", "*¤": "U+0af1"}) ; O

 SC1f::SendKey("U+0061", {"**": "U+00e0", "*``": "U+00e0", "*´": "U+00e1", "*^": "U+00e2", "*ˇ": "U+01ce", "*˘": "U+0103", "*~": "U+00e3", "*¯": "U+0101", "*¨": "U+00e4", "*˚": "U+00e5", "*˛": "U+0105", "*/": "U+2c65", "*µ": "U+03b1", "*¤": "U+060b"}) ; a
+SC1f::SendKey("U+0041", {"**": "U+00c0", "*``": "U+00c0", "*´": "U+00c1", "*^": "U+00c2", "*ˇ": "U+01cd", "*˘": "U+0102", "*~": "U+00c3", "*¯": "U+0100", "*¨": "U+00c4", "*˚": "U+00c5", "*˛": "U+0104", "*/": "U+023a", "*µ": "U+0391", "*¤": "U+20b3"}) ; A

 SC20::SendKey("U+0069", {"**": "U+002d", "*``": "U+00ec", "*´": "U+00ed", "*^": "U+00ee", "*ˇ": "U+01d0", "*˘": "U+012d", "*~": "U+0129", "*¯": "U+012b", "*¨": "U+00ef", "*˛": "U+012f", "*/": "U+0268", "*µ": "U+03b9", "*¤": "U+fdfc"}) ; i
+SC20::SendKey("U+0049", {"**": "U+2011", "*``": "U+00cc", "*´": "U+00cd", "*^": "U+00ce", "*ˇ": "U+01cf", "*˘": "U+012c", "*~": "U+0128", "*¯": "U+012a", "*¨": "U+00cf", "*˛": "U+012e", "*/": "U+0197", "*µ": "U+0399", "*¤": "U+17db"}) ; I

 SC21::SendKey("U+0074", {"**": "U+00f9", "*ˇ": "U+0165", "*¨": "U+1e97", "*¸": "U+0163", "*,": "U+021b", "*/": "U+0167", "*µ": "U+03c4", "*¤": "U+09f3"}) ; t
+SC21::SendKey("U+0054", {"**": "U+00d9", "*ˇ": "U+0164", "*¸": "U+0162", "*,": "U+021a", "*/": "U+0166", "*µ": "U+03a4", "*¤": "U+20ae"}) ; T

 SC22::SendKey("U+0067", {"**": "*µ", "*´": "U+01f5", "*^": "U+011d", "*ˇ": "U+01e7", "*˘": "U+011f", "*¯": "U+1e21", "*¸": "U+0123", "*/": "U+01e5", "*µ": "U+03b3", "*¤": "U+20b2"}) ; g
+SC22::SendKey("U+0047", {"*´": "U+01f4", "*^": "U+011c", "*ˇ": "U+01e6", "*˘": "U+011e", "*¯": "U+1e20", "*¸": "U+0122", "*/": "U+01e4", "*µ": "U+0393", "*¤": "U+20b2"}) ; G

 SC23::SendKey("U+0076", {"**": "U+00df", "*~": "U+1e7d"}) ; v
+SC23::SendKey("U+0056", {"**": "U+1e9e", "*~": "U+1e7c"}) ; V

 SC24::SendKey("U+0073", {"**": "U+0028", "*´": "U+015b", "*^": "U+015d", "*ˇ": "U+0161", "*¸": "U+015f", "*,": "U+0219", "*µ": "U+03c3", "*¤": "U+20aa"}) ; s
+SC24::SendKey("U+0053", {"*´": "U+015a", "*^": "U+015c", "*ˇ": "U+0160", "*¸": "U+015e", "*,": "U+0218", "*µ": "U+03a3", "*¤": "U+0024"}) ; S

 SC25::SendKey("U+006e", {"**": "U+0029", "*``": "U+01f9", "*´": "U+0144", "*ˇ": "U+0148", "*~": "U+00f1", "*¸": "U+0146", "*µ": "U+03bd", "*¤": "U+20a6"}) ; n
+SC25::SendKey("U+004e", {"*``": "U+01f8", "*´": "U+0143", "*ˇ": "U+0147", "*~": "U+00d1", "*¸": "U+0145", "*µ": "U+039d", "*¤": "U+20a6"}) ; N

 SC26::SendKey("U+0072", {"**": "U+00f1", "*´": "U+0155", "*ˇ": "U+0159", "*¸": "U+0157", "*/": "U+024d", "*µ": "U+03c1", "*¤": "U+20a2"}) ; r
+SC26::SendKey("U+0052", {"**": "U+00d1", "*´": "U+0154", "*ˇ": "U+0158", "*¸": "U+0156", "*/": "U+024c", "*µ": "U+03a1", "*¤": "U+20a8"}) ; R

 SC27::SendKey("U+0075", {"**": "U+2026", "*``": "U+00f9", "*´": "U+00fa", "*”": "U+0171", "*^": "U+00fb", "*ˇ": "U+01d4", "*˘": "U+016d", "*~": "U+0169", "*¯": "U+016b", "*¨": "U+00fc", "*˚": "U+016f", "*˛": "U+0173", "*/": "U+0289", "*µ": "U+03c5", "*¤": "U+5143"}) ; u
+SC27::SendKey("U+0055", {"*``": "U+00d9", "*´": "U+00da", "*”": "U+0170", "*^": "U+00db", "*ˇ": "U+01d3", "*˘": "U+016c", "*~": "U+0168", "*¯": "U+016a", "*¨": "U+00dc", "*˚": "U+016e", "*˛": "U+0172", "*/": "U+0244", "*µ": "U+03a5", "*¤": "U+5713"}) ; U

;  Letters, third row

 SC2c::SendKey("U+0071", {"**": "U+0153", "*µ": "U+03c7"}) ; q
+SC2c::SendKey("U+0051", {"**": "U+0152", "*µ": "U+03a7"}) ; Q

 SC2d::SendKey("U+007a", {"**": "U+00e6", "*´": "U+017a", "*^": "U+1e91", "*ˇ": "U+017e", "*/": "U+01b6", "*µ": "U+03b6"}) ; z
+SC2d::SendKey("U+005a", {"**": "U+00c6", "*´": "U+0179", "*^": "U+1e90", "*ˇ": "U+017d", "*/": "U+01b5", "*µ": "U+0396"}) ; Z

 SC2e::SendKey("U+0079", {"**": "U+00ef", "*``": "U+1ef3", "*´": "U+00fd", "*^": "U+0177", "*~": "U+1ef9", "*¯": "U+0233", "*¨": "U+00ff", "*˚": "U+1e99", "*/": "U+024f", "*µ": "U+03c8", "*¤": "U+00a5"}) ; y
+SC2e::SendKey("U+0059", {"**": "U+00cf", "*``": "U+1ef2", "*´": "U+00dd", "*^": "U+0176", "*~": "U+1ef8", "*¯": "U+0232", "*¨": "U+0178", "*/": "U+024e", "*µ": "U+03a8", "*¤": "U+5186"}) ; Y

 SC2f::SendKey("U+0064", {"**": "U+2013", "*ˇ": "U+010f", "*¸": "U+1e11", "*/": "U+0111", "*µ": "U+03b4", "*¤": "U+20ab"}) ; d
+SC2f::SendKey("U+0044", {"**": "U+2014", "*ˇ": "U+010e", "*¸": "U+1e10", "*/": "U+0110", "*µ": "U+0394", "*¤": "U+20af"}) ; D

 SC30::SendKey("U+006a", {"**": "U+0040", "*^": "U+0135", "*/": "U+0249", "*µ": "U+03b8"}) ; j
+SC30::SendKey("U+004a", {"*^": "U+0134", "*/": "U+0248", "*µ": "U+0398"}) ; J

 SC31::SendKey("U+006b", {"**": "U+20ac", "*´": "U+1e31", "*ˇ": "U+01e9", "*¸": "U+0137", "*µ": "U+03ba", "*¤": "U+20ad"}) ; k
+SC31::SendKey("U+004b", {"*´": "U+1e30", "*ˇ": "U+01e8", "*¸": "U+0136", "*µ": "U+039a", "*¤": "U+20ad"}) ; K

 SC32::SendKey("U+0063", {"**": "U+00e7", "*´": "U+0107", "*^": "U+0109", "*ˇ": "U+010d", "*¸": "U+00e7", "*/": "U+023c", "*¤": "U+00a2"}) ; c
+SC32::SendKey("U+0043", {"**": "U+00c7", "*´": "U+0106", "*^": "U+0108", "*ˇ": "U+010c", "*¸": "U+00c7", "*/": "U+023b", "*¤": "U+20a1"}) ; C

 SC33::SendKey("U+0068", {"**": "*¨", "*^": "U+0125", "*ˇ": "U+021f", "*¨": "U+1e27", "*¸": "U+1e29", "*/": "U+0127", "*µ": "U+03b7", "*¤": "U+20b4"}) ; h
+SC33::SendKey("U+0048", {"*^": "U+0124", "*ˇ": "U+021e", "*¨": "U+1e26", "*¸": "U+1e28", "*/": "U+0126", "*µ": "U+0397", "*¤": "U+20b4"}) ; H

 SC34::SendKey("U+0077", {"**": "U+005f", "*``": "U+1e81", "*´": "U+1e83", "*^": "U+0175", "*¨": "U+1e85", "*˚": "U+1e98", "*µ": "U+03c9", "*¤": "U+20a9"}) ; w
+SC34::SendKey("U+0057", {"**": "U+005f", "*``": "U+1e80", "*´": "U+1e82", "*^": "U+0174", "*¨": "U+1e84", "*µ": "U+03a9", "*¤": "U+20a9"}) ; W

 SC35::SendKey("**", {"**": "'"})
+SC35::SendKey("U+003b", {}) ; ;

;  Pinky keys

 SC0c::SendKey("U+002f", {"**": "U+00f7"}) ; /
+SC0c::SendKey("U+002f", {"**": "U+00f7"}) ; /

 SC0d::SendKey("U+002a", {"**": "U+00d7"}) ; *
+SC0d::SendKey("U+002a", {"**": "U+00d7"}) ; *

 SC1a::SendKey("U+003d", {"**": "U+2248", "*^": "U+207c", "*ˇ": "U+208c", "*~": "U+2243", "*/": "U+2260"}) ; =
+SC1a::SendKey("U+2260", {"**": "U+2260"}) ; ≠

 SC1b::SendKey("U+002b", {"**": "U+00b1", "*^": "U+207a", "*ˇ": "U+208a"}) ; +
+SC1b::SendKey("U+002b", {"**": "U+00b1", "*^": "U+207a", "*ˇ": "U+208a"}) ; +

 SC28::SendKey("U+002d", {"**": "U+2212", "*^": "U+207b", "*ˇ": "U+208b"}) ; -
+SC28::SendKey("U+002d", {"**": "U+2212", "*^": "U+207b", "*ˇ": "U+208b"}) ; -

 SC29::SendKey("U+00e7", {"*¤": "U+20b5"}) ; ç
+SC29::SendKey("U+00c7", {"*¤": "U+20b5"}) ; Ç

 SC2b::SendKey("U+0027", {"**": "U+2022"}) ; '
+SC2b::SendKey("U+003f", {"**": "U+00bf"}) ; ?

 SC56::SendKey("U+0065", {"**": "U+00e8", "*``": "U+00e8", "*´": "U+00e9", "*^": "U+00ea", "*ˇ": "U+011b", "*˘": "U+0115", "*~": "U+1ebd", "*¯": "U+0113", "*¨": "U+00eb", "*¸": "U+0229", "*˛": "U+0119", "*/": "U+0247", "*µ": "U+03b5", "*¤": "U+20ac"}) ; e
+SC56::SendKey("U+0045", {"**": "U+00c8", "*``": "U+00c8", "*´": "U+00c9", "*^": "U+00ca", "*ˇ": "U+011a", "*˘": "U+0114", "*~": "U+1ebc", "*¯": "U+0112", "*¨": "U+00cb", "*¸": "U+0228", "*˛": "U+0118", "*/": "U+0246", "*µ": "U+0395", "*¤": "U+20a0"}) ; E

;  Space bar

 SC39::SendKey("U+0020", {"**": "U+002d", "*``": "U+0060", "*´": "U+0027", "*”": "U+201d", "*^": "U+005e", "*ˇ": "U+02c7", "*˘": "U+02d8", "*~": "U+007e", "*¯": "U+00af", "*¨": "U+0022", "*˚": "U+02da", "*¸": "U+00b8", "*,": "U+002c", "*˛": "U+02db", "*/": "U+002f", "*µ": "U+00b5", "*¤": "U+00a4"}) ;  
+SC39::SendKey("U+202f", {"**": "U+002d", "*``": "U+0060", "*´": "U+0027", "*”": "U+201d", "*^": "U+005e", "*ˇ": "U+02c7", "*˘": "U+02d8", "*~": "U+007e", "*¯": "U+00af", "*¨": "U+0022", "*˚": "U+02da", "*¸": "U+00b8", "*,": "U+002c", "*˛": "U+02db", "*/": "U+002f", "*µ": "U+00b5", "*¤": "U+00a4"}) ;  


;-------------------------------------------------------------------------------
; AltGr
;-------------------------------------------------------------------------------

;  Digits

 <^>!SC02::SendKey("U+2081", {}) ; ₁
<^>!+SC02::SendKey("U+00b9", {}) ; ¹

 <^>!SC03::SendKey("U+2082", {}) ; ₂
<^>!+SC03::SendKey("U+00b2", {}) ; ²

 <^>!SC04::SendKey("U+2083", {}) ; ₃
<^>!+SC04::SendKey("U+00b3", {}) ; ³

 <^>!SC05::SendKey("U+2084", {}) ; ₄
<^>!+SC05::SendKey("U+2074", {}) ; ⁴

 <^>!SC06::SendKey("U+2085", {}) ; ₅
<^>!+SC06::SendKey("U+2075", {}) ; ⁵

 <^>!SC07::SendKey("U+2086", {}) ; ₆
<^>!+SC07::SendKey("U+2076", {}) ; ⁶

 <^>!SC08::SendKey("U+2087", {}) ; ₇
<^>!+SC08::SendKey("U+2077", {}) ; ⁷

 <^>!SC09::SendKey("U+2088", {}) ; ₈
<^>!+SC09::SendKey("U+2078", {}) ; ⁸

 <^>!SC0a::SendKey("U+2089", {}) ; ₉
<^>!+SC0a::SendKey("U+2079", {}) ; ⁹

 <^>!SC0b::SendKey("U+2080", {}) ; ₀
<^>!+SC0b::SendKey("U+2070", {}) ; ⁰

;  Letters, first row

 <^>!SC10::SendKey("U+005e", {}) ; ^
<^>!+SC10::SendKey("*^", {"*^": "^"})

 <^>!SC11::SendKey("U+0021", {"**": "U+00c2"}) ; !
<^>!+SC11::SendKey("U+00ac", {}) ; ¬

 <^>!SC12::SendKey("U+003d", {"**": "U+2248", "*^": "U+207c", "*ˇ": "U+208c", "*~": "U+2243", "*/": "U+2260"}) ; =
<^>!+SC12::SendKey("U+2260", {"**": "U+2260"}) ; ≠

 <^>!SC13::SendKey("U+0024", {}) ; $
<^>!+SC13::SendKey("*¤", {"*¤": "¤"})

 <^>!SC14::SendKey("U+0025", {}) ; %
<^>!+SC14::SendKey("U+2030", {}) ; ‰

 <^>!SC15::SendKey("U+0023", {}) ; #
<^>!+SC15::SendKey("*˚", {"*˚": "˚"})

 <^>!SC16::SendKey("U+003c", {"*~": "U+2272", "*/": "U+226e"}) ; <
<^>!+SC16::SendKey("U+2264", {"*/": "U+2270"}) ; ≤

 <^>!SC17::SendKey("U+003e", {"*~": "U+2273", "*/": "U+226f"}) ; >
<^>!+SC17::SendKey("U+2265", {"*/": "U+2271"}) ; ≥

 <^>!SC18::SendKey("U+003f", {"**": "U+00bf"}) ; ?

 <^>!SC19::SendKey("U+003a", {"**": "U+00a1"}) ; :
<^>!+SC19::SendKey("*ˇ", {"*ˇ": "ˇ"})

;  Letters, second row

 <^>!SC1e::SendKey("U+002a", {"**": "U+00d7"}) ; *
<^>!+SC1e::SendKey("U+00d7", {}) ; ×

 <^>!SC1f::SendKey("U+002b", {"**": "U+00b1", "*^": "U+207a", "*ˇ": "U+208a"}) ; +
<^>!+SC1f::SendKey("U+00b1", {}) ; ±

 <^>!SC20::SendKey("U+002d", {"**": "U+2212", "*^": "U+207b", "*ˇ": "U+208b"}) ; -
<^>!+SC20::SendKey("*¯", {"*¯": "ˉ"})

 <^>!SC21::SendKey("U+002f", {"**": "U+00f7"}) ; /
<^>!+SC21::SendKey("U+00f7", {}) ; ÷

 <^>!SC22::SendKey("U+005c", {}) ; \
<^>!+SC22::SendKey("*/", {"*/": "/"})

 <^>!SC23::SendKey("U+0060", {}) ; `
<^>!+SC23::SendKey("*``", {"*``": "`"}) ; *`

 <^>!SC24::SendKey("U+0028", {"*^": "U+207d", "*ˇ": "U+208d"}) ; (
<^>!+SC24::SendKey("*´", {"*´": "´"})

 <^>!SC25::SendKey("U+0029", {"*^": "U+207e", "*ˇ": "U+208e"}) ; )

 <^>!SC26::SendKey("U+003b", {}) ; ;
<^>!+SC26::SendKey("*˘", {"*˘": "˘"})

 <^>!SC27::SendKey("U+0027", {"**": "U+2022"}) ; '

;  Letters, third row

 <^>!SC2c::SendKey("U+007e", {}) ; ~
<^>!+SC2c::SendKey("*~", {"*~": "~"})

 <^>!SC2d::SendKey("U+007c", {}) ; |
<^>!+SC2d::SendKey("U+00a6", {}) ; ¦

 <^>!SC2e::SendKey("U+0026", {}) ; &

 <^>!SC2f::SendKey("U+0022", {}) ; "
<^>!+SC2f::SendKey("*”", {"*”": "˝"})

 <^>!SC30::SendKey("U+0040", {}) ; @

 <^>!SC32::SendKey("U+007b", {}) ; {
<^>!+SC32::SendKey("*¸", {"*¸": "¸"})

 <^>!SC33::SendKey("U+007d", {}) ; }
<^>!+SC33::SendKey("*,", {"*,": ","})

 <^>!SC34::SendKey("U+005b", {}) ; [
<^>!+SC34::SendKey("*˛", {"*˛": "˛"})

 <^>!SC35::SendKey("U+005d", {}) ; ]

;  Pinky keys

 <^>!SC0c::SendKey("U+00e0", {}) ; à
<^>!+SC0c::SendKey("U+00c0", {}) ; À

 <^>!SC0d::SendKey("U+00ea", {}) ; ê
<^>!+SC0d::SendKey("U+00ca", {}) ; Ê

 <^>!SC56::SendKey("U+005f", {}) ; _

;  Space bar

 <^>!SC39::SendKey("U+0020", {"**": "U+002d", "*``": "U+0060", "*´": "U+0027", "*”": "U+201d", "*^": "U+005e", "*ˇ": "U+02c7", "*˘": "U+02d8", "*~": "U+007e", "*¯": "U+00af", "*¨": "U+0022", "*˚": "U+02da", "*¸": "U+00b8", "*,": "U+002c", "*˛": "U+02db", "*/": "U+002f", "*µ": "U+00b5", "*¤": "U+00a4"}) ;  
<^>!+SC39::SendKey("U+00a0", {"**": "U+002d", "*``": "U+0060", "*´": "U+0027", "*”": "U+201d", "*^": "U+005e", "*ˇ": "U+02c7", "*˘": "U+02d8", "*~": "U+007e", "*¯": "U+00af", "*¨": "U+0022", "*˚": "U+02da", "*¸": "U+00b8", "*,": "U+002c", "*˛": "U+02db", "*/": "U+002f", "*µ": "U+00b5", "*¤": "U+00a4"}) ;  

; Special Keys

$<^>!Esc::       Send {SC01}
$<^>!End::       Send {SC4f}
$<^>!Home::      Send {SC47}
$<^>!Delete::    Send {SC53}
$<^>!Backspace:: Send {SC0e}


;-------------------------------------------------------------------------------
; Ctrl
;-------------------------------------------------------------------------------

;  Digits

;  Letters, first row

 ^SC10::Send  ^x
^+SC10::Send ^+X

 ^SC13::Send  ^p
^+SC13::Send ^+P

 ^SC14::Send  ^b
^+SC14::Send ^+B

 ^SC15::Send  ^f
^+SC15::Send ^+F

 ^SC16::Send  ^m
^+SC16::Send ^+M

 ^SC17::Send  ^l
^+SC17::Send ^+L

;  Letters, second row

 ^SC1e::Send  ^o
^+SC1e::Send ^+O

 ^SC1f::Send  ^a
^+SC1f::Send ^+A

 ^SC20::Send  ^i
^+SC20::Send ^+I

 ^SC21::Send  ^t
^+SC21::Send ^+T

 ^SC22::Send  ^g
^+SC22::Send ^+G

 ^SC23::Send  ^v
^+SC23::Send ^+V

 ^SC24::Send  ^s
^+SC24::Send ^+S

 ^SC25::Send  ^n
^+SC25::Send ^+N

 ^SC26::Send  ^r
^+SC26::Send ^+R

 ^SC27::Send  ^u
^+SC27::Send ^+U

;  Letters, third row

 ^SC2c::Send  ^q
^+SC2c::Send ^+Q

 ^SC2d::Send  ^z
^+SC2d::Send ^+Z

 ^SC2e::Send  ^y
^+SC2e::Send ^+Y

 ^SC2f::Send  ^d
^+SC2f::Send ^+D

 ^SC30::Send  ^j
^+SC30::Send ^+J

 ^SC31::Send  ^k
^+SC31::Send ^+K

 ^SC32::Send  ^c
^+SC32::Send ^+C

 ^SC33::Send  ^h
^+SC33::Send ^+H

 ^SC34::Send  ^w
^+SC34::Send ^+W

;  Pinky keys

 ^SC56::Send  ^e
^+SC56::Send ^+E

;  Space bar

