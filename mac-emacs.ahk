#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;#InstallKeybdHook
;#UseHook

; swap caps and ctrl
;Capslock::Ctrl
;sc03a::Ctrl

#InstallKeybdHook
#USEHOOK
; Change to English
; vkFFsc071::1
; Change to Japanese
; vkFFsc072::2

;Mac keyboard
; vkE9sc071 が送信されない
; vkE9sc071 Up::Send,{vk1Dsc07B Down}{vk1Dsc07B Up}  ;Apple英数->半全
; vkFFsc072 Up::Send,{vkF3sc029 Down}{vkF3sc029 Up}  ;Appleかな->半全
;vkFFsc072 Up::Send,{vk1Csc079 Down}{vk1Csc079 Up}

;Apple英数 -> 無変換
;sc071 Up::Send,{vk1Dsc07B Down}{vk1Dsc07B Up}

;Appleかな -> 変換
;sc072 Up::
;  Send,{vk1Csc079 Down}{vk1Csc079 Up}
;  return

#USEHOOK off
;半角/全角	vkF3sc029
;変換	vk1Csc079 = 0x1c
;無変換	vk1Dsc07B
;ひらがなカタカナ	vkF2sc070

; 参考 https://www.karakaram.com/mac-control

is_disable_window()
{
	;gvim
	IfWinActive,ahk_class Vim
	{
		return 1
	}
	; git-bash
	IfWinActive,ahk_class mintty
	{
		return 1
	}
	return 0
}
 
;----------------------------------------------------------------
;キーを送信する
; キーバインドを無効にするウィンドウでは、送信されたキーをそのまま使用する
; キーバインドを有効にするウィンドウでは、送信されたキーを置き換える
;
;  引数 original_key:キーバインドを無効にするウィンドウの場合、送信するキー
;       replace_key:キーバインドを有効にするウィンドウの場合、送信するキー
;  戻り値 なし
;----------------------------------------------------------------
send_key(original_key,replace_key)
{
	if (is_disable_window())
	{
		Send,%original_key%
		return
	}
	Send,%replace_key%
	return
}



;================================================================
;ctrlキーバインド
;================================================================
 
;----------------------------------------------------------------
;移動系（shiftキーとの同時押し対応）
;ctrl + n : 下
;ctrl + p : 上
;ctrl + f : 右
;ctrl + b : 左
;ctrl + a : Home
;ctrl + e : End
;----------------------------------------------------------------
 
<^n::send_key(  "^n", "{Down}")
<^+n::send_key("^+n","+{Down}")
<^p::send_key(  "^p", "{Up}")
<^+p::send_key("^+p","+{Up}")
<^f::send_key(  "^f", "{Right}")
<^+f::send_key("^+f","+{Right}")
<^b::send_key(  "^b", "{Left}")
<^+b::send_key("^+b","+{Left}")
<^a::send_key(  "^a", "{Home}")
<^+a::send_key("^+a","+{Home}")
<^e::send_key(  "^e", "{End}")
<^+e::send_key("^+e","+{End}")
 
;----------------------------------------------------------------
;編集系
;ctrl + h : BackSpace
;ctrl + d : Delete
;ctrl + m : Enter
;ctrl + k : カーソルから行末まで削除
;----------------------------------------------------------------
 

<^h::send_key("^h","{BS}")
<^d::send_key("^d","{Del}")
<^m::send_key("^m","{Return}")
<^k::send_key("^k","+{End}{Del}")

; alt + f = Search
<!f::send_key("!f", "^f")
; alt + a = Select All
<!a::send_key("!a", "^a")
; alt + p = print
<!p::send_key("!p", "^p")

; Ctrl = ^
; win = #
;  Alt = !
; shift =  +
; Display 移動
<^Right::Send ^#{Right}
<^Left::Send ^#{Left}

; 
<^<!Right::Return
<^<!Left::Return
<^<!Up::Return
<^<!Down::Return

; set the default state of the lock keys
SetCapsLockState, off
SetNumLockState, on
SetScrollLockState, off

; disable them
$NumLock::Return
$ScrollLock::Return
$CapsLock::Return

; Open App
<^<+m::
    Run "C:\Program Files (x86)\RimArts\B2\B2.exe"
    Return
<^<+v::
    Run "C:\Program Files\vim80-kaoriya-win64\gvim.exe"
    Return
<^<+t::
    Run "C:\Program Files\Git\git-bash.exe"
    ; WinActivate ahk_class mintty
    WinActivate
    Send, date{Enter}
    Return
<^<+a::
    Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    Return

#IfWinActive ahk_exe EXCEL.EXE
F1::Return
<^i::Send,{F2}^a
<^BS::
	Send, !h
	Sleep,300
	Send, e
  Send, a
	Send, {up}
	return
IfWinActive
