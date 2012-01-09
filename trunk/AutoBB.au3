; *******************************************************
; *******************************************************
#include <IE.au3>
#include <File.au3>

Func HandlePage( $oIE, $page )
	
	_IENavigate( $oIE, $page )
	
	Local $oRefreshDate = _IEGetObjByName( $oIE, "modify_add_date" )
	_IEAction( $oRefreshDate, "click" )
	;_IELoadWait($oIE)

	Local $oSubmit = _IEGetObjByName( $oIE, "btn_submit" )
	_IEAction( $oSubmit, "click" )
	;_IELoadWait($oIE)
	Sleep( 5000 )
	
	_IENavigate( $oIE, "about:blank" )
EndFunc


Func _main()
   If $CmdLine[0] < 1 Then
	  MsgBox(4096, "Error", "Empty command line")
	  Exit
   EndIf
   
   Local $aRecords
   If Not _FileReadToArray($CmdLine[1], $aRecords) Then
	  MsgBox(4096, "Error", "Error reading parameters")
	  Exit
   EndIf
   
   Local $oIE = _IECreate("about:blank")
   
   For $x = 2 To $aRecords[0]
	  HandlePage( $oIE, $aRecords[1] & $aRecords[$x] )
   Next
   
   _IEQuit($oIE)
   
EndFunc

_main()

exit
