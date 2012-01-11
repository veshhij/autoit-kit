; *******************************************************
; *******************************************************
#include <IE.au3>
#include <File.au3>

Func LogToFile( $Message )
   
   Local $hFile = FileOpen(@ScriptDir & "\log.txt", 1) ; Open the logfile in write mode.
   
   _FileWriteLog($hFile, $Message) ; Write to the logfile passing the filehandle returned by FileOpen.
   
   FileClose($hFile) ; Close the filehandle to release the file.
   
EndFunc

Func HandlePage( $oIE, $page )
	
   _IENavigate( $oIE, $page )
   LogToFile( "_IENavigate to page " & $page )
   
   Local $oRefreshDate = _IEGetObjByName( $oIE, "modify_add_date" )
   While $oRefreshDate == 0
	  Sleep( 1000 )
	  LogToFile( "Sleep for modify_add_date" )
	  $oRefreshDate = _IEGetObjByName( $oIE, "modify_add_date" )
   WEnd
   LogToFile( "_IEGetObjByName( modify_add_date )" )
   
   _IEAction( $oRefreshDate, "click" )
	;_IELoadWait($oIE)
   LogToFile( "_IEAction( click )" )

   Local $oSubmit = _IEGetObjByName( $oIE, "btn_submit" )
   While $oSubmit == 0
	  Sleep( 1000 )
	  LogToFile( "Sleep for btn_submit" )
	  $oSubmit = _IEGetObjByName( $oIE, "btn_submit" )
   WEnd
   LogToFile( "_IEGetObjByName( btn_submit )" )
   
   _IEAction( $oSubmit, "click" )
   LogToFile( "_IEAction( click )" )
	;_IELoadWait($oIE)
	
   Sleep( 10 * 1000 )
	
   ;_IENavigate( $oIE, "about:blank" )
   ;LogToFile( "_IENavigate to blank page " )
   
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
   
   LogToFile( "------------------------------------------------------------------------------------------" )
   Local $oIE = _IECreate("about:blank")
   LogToFile( "Start IE" )
   
   _IELoadWaitTimeout( 15 * 1000 )
   
   For $x = 2 To $aRecords[0]
	  HandlePage( $oIE, $aRecords[1] & $aRecords[$x] )
   Next
   
   _IEQuit($oIE)
   LogToFile( "Quit IE" )
   
EndFunc

_main()

exit
