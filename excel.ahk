
#IfWinActive ahk_exe EXCEL.EXE
F1::Return ; Disable Help
<^i::Send,{F2}^a ; Ctrl + 1 => Insert
<^BS:: ; Ctrl+Backspace => Clear Selected Cells
	Send, !h
	Sleep,300
	Send, e
  Send, a
	Send, {up}
	return
IfWinActive
