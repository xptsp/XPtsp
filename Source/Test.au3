$A = FileReadLine("E:\XPCD\OS_1\XPHO\i386\PID.INF", 5)
MsgBox(0, "", StringLeft($A, 8) = "Personal")