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
; vkE9sc071 �����M����Ȃ�
; vkE9sc071 Up::Send,{vk1Dsc07B Down}{vk1Dsc07B Up}  ;Apple�p��->���S
; vkFFsc072 Up::Send,{vkF3sc029 Down}{vkF3sc029 Up}  ;Apple����->���S
;vkFFsc072 Up::Send,{vk1Csc079 Down}{vk1Csc079 Up}

;Apple�p�� -> ���ϊ�
;sc071 Up::Send,{vk1Dsc07B Down}{vk1Dsc07B Up}

;Apple���� -> �ϊ�
;sc072 Up::
;  Send,{vk1Csc079 Down}{vk1Csc079 Up}
;  return

#USEHOOK off
;���p/�S�p	vkF3sc029
;�ϊ�	vk1Csc079 = 0x1c
;���ϊ�	vk1Dsc07B
;�Ђ炪�ȃJ�^�J�i	vkF2sc070

; �Q�l https://www.karakaram.com/mac-control

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
;�L�[�𑗐M����
; �L�[�o�C���h�𖳌��ɂ���E�B���h�E�ł́A���M���ꂽ�L�[�����̂܂܎g�p����
; �L�[�o�C���h��L���ɂ���E�B���h�E�ł́A���M���ꂽ�L�[��u��������
;
;  ���� original_key:�L�[�o�C���h�𖳌��ɂ���E�B���h�E�̏ꍇ�A���M����L�[
;       replace_key:�L�[�o�C���h��L���ɂ���E�B���h�E�̏ꍇ�A���M����L�[
;  �߂�l �Ȃ�
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
;ctrl�L�[�o�C���h
;================================================================
 
;----------------------------------------------------------------
;�ړ��n�ishift�L�[�Ƃ̓��������Ή��j
;ctrl + n : ��
;ctrl + p : ��
;ctrl + f : �E
;ctrl + b : ��
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
;�ҏW�n
;ctrl + h : BackSpace
;ctrl + d : Delete
;ctrl + m : Enter
;ctrl + k : �J�[�\������s���܂ō폜
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
; Display �ړ�
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
