#NoTrayIcon
Global Const $CB_ERR = -1
Global Const $CB_ERRATTRIBUTE = -3
Global Const $CB_ERRREQUIRED = -4
Global Const $CB_ERRSPACE = -2
Global Const $CB_OKAY = 0
Global Const $STATE_SYSTEM_INVISIBLE = 0x8000
Global Const $STATE_SYSTEM_PRESSED = 0x8
Global Const $CBS_AUTOHSCROLL = 0x40
Global Const $CBS_DISABLENOSCROLL = 0x800
Global Const $CBS_DROPDOWN = 0x2
Global Const $CBS_DROPDOWNLIST = 0x3
Global Const $CBS_HASSTRINGS = 0x200
Global Const $CBS_LOWERCASE = 0x4000
Global Const $CBS_NOINTEGRALHEIGHT = 0x400
Global Const $CBS_OEMCONVERT = 0x80
Global Const $CBS_OWNERDRAWFIXED = 0x10
Global Const $CBS_OWNERDRAWVARIABLE = 0x20
Global Const $CBS_SIMPLE = 0x1
Global Const $CBS_SORT = 0x100
Global Const $CBS_UPPERCASE = 0x2000
Global Const $CBM_FIRST = 0x1700
Global Const $CB_ADDSTRING = 0x143
Global Const $CB_DELETESTRING = 0x144
Global Const $CB_DIR = 0x145
Global Const $CB_FINDSTRING = 0x14C
Global Const $CB_FINDSTRINGEXACT = 0x158
Global Const $CB_GETCOMBOBOXINFO = 0x164
Global Const $CB_GETCOUNT = 0x146
Global Const $CB_GETCUEBANNER =($CBM_FIRST + 4)
Global Const $CB_GETCURSEL = 0x147
Global Const $CB_GETDROPPEDCONTROLRECT = 0x152
Global Const $CB_GETDROPPEDSTATE = 0x157
Global Const $CB_GETDROPPEDWIDTH = 0X15f
Global Const $CB_GETEDITSEL = 0x140
Global Const $CB_GETEXTENDEDUI = 0x156
Global Const $CB_GETHORIZONTALEXTENT = 0x15d
Global Const $CB_GETITEMDATA = 0x150
Global Const $CB_GETITEMHEIGHT = 0x154
Global Const $CB_GETLBTEXT = 0x148
Global Const $CB_GETLBTEXTLEN = 0x149
Global Const $CB_GETLOCALE = 0x15A
Global Const $CB_GETMINVISIBLE = 0x1702
Global Const $CB_GETTOPINDEX = 0x15b
Global Const $CB_INITSTORAGE = 0x161
Global Const $CB_LIMITTEXT = 0x141
Global Const $CB_RESETCONTENT = 0x14B
Global Const $CB_INSERTSTRING = 0x14A
Global Const $CB_SELECTSTRING = 0x14D
Global Const $CB_SETCUEBANNER =($CBM_FIRST + 3)
Global Const $CB_SETCURSEL = 0x14E
Global Const $CB_SETDROPPEDWIDTH = 0x160
Global Const $CB_SETEDITSEL = 0x142
Global Const $CB_SETEXTENDEDUI = 0x155
Global Const $CB_SETHORIZONTALEXTENT = 0x15e
Global Const $CB_SETITEMDATA = 0x151
Global Const $CB_SETITEMHEIGHT = 0x153
Global Const $CB_SETLOCALE = 0x159
Global Const $CB_SETMINVISIBLE = 0x1701
Global Const $CB_SETTOPINDEX = 0x15c
Global Const $CB_SHOWDROPDOWN = 0x14F
Global Const $CBN_CLOSEUP = 8
Global Const $CBN_DBLCLK = 2
Global Const $CBN_DROPDOWN = 7
Global Const $CBN_EDITCHANGE = 5
Global Const $CBN_EDITUPDATE = 6
Global Const $CBN_ERRSPACE =(-1)
Global Const $CBN_KILLFOCUS = 4
Global Const $CBN_SELCHANGE = 1
Global Const $CBN_SELENDCANCEL = 10
Global Const $CBN_SELENDOK = 9
Global Const $CBN_SETFOCUS = 3
Global Const $CBES_EX_CASESENSITIVE = 0x10
Global Const $CBES_EX_NOEDITIMAGE = 0x1
Global Const $CBES_EX_NOEDITIMAGEINDENT = 0x2
Global Const $CBES_EX_NOSIZELIMIT = 0x8
Global Const $CBES_EX_PATHWORDBREAKPROC = 0x4
Global Const $__COMBOBOXCONSTANT_WM_USER = 0X400
Global Const $CBEM_DELETEITEM = $CB_DELETESTRING
Global Const $CBEM_GETCOMBOCONTROL =($__COMBOBOXCONSTANT_WM_USER + 6)
Global Const $CBEM_GETEDITCONTROL =($__COMBOBOXCONSTANT_WM_USER + 7)
Global Const $CBEM_GETEXSTYLE =($__COMBOBOXCONSTANT_WM_USER + 9)
Global Const $CBEM_GETEXTENDEDSTYLE =($__COMBOBOXCONSTANT_WM_USER + 9)
Global Const $CBEM_GETIMAGELIST =($__COMBOBOXCONSTANT_WM_USER + 3)
Global Const $CBEM_GETITEMA =($__COMBOBOXCONSTANT_WM_USER + 4)
Global Const $CBEM_GETITEMW =($__COMBOBOXCONSTANT_WM_USER + 13)
Global Const $CBEM_GETUNICODEFORMAT = 0x2000 + 6
Global Const $CBEM_HASEDITCHANGED =($__COMBOBOXCONSTANT_WM_USER + 10)
Global Const $CBEM_INSERTITEMA =($__COMBOBOXCONSTANT_WM_USER + 1)
Global Const $CBEM_INSERTITEMW =($__COMBOBOXCONSTANT_WM_USER + 11)
Global Const $CBEM_SETEXSTYLE =($__COMBOBOXCONSTANT_WM_USER + 8)
Global Const $CBEM_SETEXTENDEDSTYLE =($__COMBOBOXCONSTANT_WM_USER + 14)
Global Const $CBEM_SETIMAGELIST =($__COMBOBOXCONSTANT_WM_USER + 2)
Global Const $CBEM_SETITEMA =($__COMBOBOXCONSTANT_WM_USER + 5)
Global Const $CBEM_SETITEMW =($__COMBOBOXCONSTANT_WM_USER + 12)
Global Const $CBEM_SETUNICODEFORMAT = 0x2000 + 5
Global Const $CBEM_SETWINDOWTHEME = 0x2000 + 11
Global Const $CBEN_FIRST =(-800)
Global Const $CBEN_LAST =(-830)
Global Const $CBEN_BEGINEDIT =($CBEN_FIRST - 4)
Global Const $CBEN_DELETEITEM =($CBEN_FIRST - 2)
Global Const $CBEN_DRAGBEGINA =($CBEN_FIRST - 8)
Global Const $CBEN_DRAGBEGINW =($CBEN_FIRST - 9)
Global Const $CBEN_ENDEDITA =($CBEN_FIRST - 5)
Global Const $CBEN_ENDEDITW =($CBEN_FIRST - 6)
Global Const $CBEN_GETDISPINFO =($CBEN_FIRST - 0)
Global Const $CBEN_GETDISPINFOA =($CBEN_FIRST - 0)
Global Const $CBEN_GETDISPINFOW =($CBEN_FIRST - 7)
Global Const $CBEN_INSERTITEM =($CBEN_FIRST - 1)
Global Const $CBEIF_DI_SETITEM = 0x10000000
Global Const $CBEIF_IMAGE = 0x2
Global Const $CBEIF_INDENT = 0x10
Global Const $CBEIF_LPARAM = 0x20
Global Const $CBEIF_OVERLAY = 0x8
Global Const $CBEIF_SELECTEDIMAGE = 0x4
Global Const $CBEIF_TEXT = 0x1
Global Const $__COMBOBOXCONSTANT_WS_VSCROLL = 0x00200000
Global Const $GUI_SS_DEFAULT_COMBO = BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $__COMBOBOXCONSTANT_WS_VSCROLL)
Global Const $ES_LEFT = 0
Global Const $ES_CENTER = 1
Global Const $ES_RIGHT = 2
Global Const $ES_MULTILINE = 4
Global Const $ES_UPPERCASE = 8
Global Const $ES_LOWERCASE = 16
Global Const $ES_PASSWORD = 32
Global Const $ES_AUTOVSCROLL = 64
Global Const $ES_AUTOHSCROLL = 128
Global Const $ES_NOHIDESEL = 256
Global Const $ES_OEMCONVERT = 1024
Global Const $ES_READONLY = 2048
Global Const $ES_WANTRETURN = 4096
Global Const $ES_NUMBER = 8192
Global Const $EC_ERR = -1
Global Const $ECM_FIRST = 0X1500
Global Const $EM_CANUNDO = 0xC6
Global Const $EM_CHARFROMPOS = 0xD7
Global Const $EM_EMPTYUNDOBUFFER = 0xCD
Global Const $EM_FMTLINES = 0xC8
Global Const $EM_GETCUEBANNER =($ECM_FIRST + 2)
Global Const $EM_GETFIRSTVISIBLELINE = 0xCE
Global Const $EM_GETHANDLE = 0xBD
Global Const $EM_GETIMESTATUS = 0xD9
Global Const $EM_GETLIMITTEXT = 0xD5
Global Const $EM_GETLINE = 0xC4
Global Const $EM_GETLINECOUNT = 0xBA
Global Const $EM_GETMARGINS = 0xD4
Global Const $EM_GETMODIFY = 0xB8
Global Const $EM_GETPASSWORDCHAR = 0xD2
Global Const $EM_GETRECT = 0xB2
Global Const $EM_GETSEL = 0xB0
Global Const $EM_GETTHUMB = 0xBE
Global Const $EM_GETWORDBREAKPROC = 0xD1
Global Const $EM_HIDEBALLOONTIP =($ECM_FIRST + 4)
Global Const $EM_LIMITTEXT = 0xC5
Global Const $EM_LINEFROMCHAR = 0xC9
Global Const $EM_LINEINDEX = 0xBB
Global Const $EM_LINELENGTH = 0xC1
Global Const $EM_LINESCROLL = 0xB6
Global Const $EM_POSFROMCHAR = 0xD6
Global Const $EM_REPLACESEL = 0xC2
Global Const $EM_SCROLL = 0xB5
Global Const $EM_SCROLLCARET = 0x00B7
Global Const $EM_SETCUEBANNER =($ECM_FIRST + 1)
Global Const $EM_SETHANDLE = 0xBC
Global Const $EM_SETIMESTATUS = 0xD8
Global Const $EM_SETLIMITTEXT = $EM_LIMITTEXT
Global Const $EM_SETMARGINS = 0xD3
Global Const $EM_SETMODIFY = 0xB9
Global Const $EM_SETPASSWORDCHAR = 0xCC
Global Const $EM_SETREADONLY = 0xCF
Global Const $EM_SETRECT = 0xB3
Global Const $EM_SETRECTNP = 0xB4
Global Const $EM_SETSEL = 0xB1
Global Const $EM_SETTABSTOPS = 0xCB
Global Const $EM_SETWORDBREAKPROC = 0xD0
Global Const $EM_SHOWBALLOONTIP =($ECM_FIRST + 3)
Global Const $EM_UNDO = 0xC7
Global Const $EC_LEFTMARGIN = 0x1
Global Const $EC_RIGHTMARGIN = 0x2
Global Const $EC_USEFONTINFO = 0xFFFF
Global Const $EMSIS_COMPOSITIONSTRING = 0x1
Global Const $EIMES_GETCOMPSTRATONCE = 0x1
Global Const $EIMES_CANCELCOMPSTRINFOCUS = 0x2
Global Const $EIMES_COMPLETECOMPSTRKILLFOCUS = 0x4
Global Const $EN_ALIGN_LTR_EC = 0x700
Global Const $EN_ALIGN_RTL_EC = 0x701
Global Const $EN_CHANGE = 0x300
Global Const $EN_ERRSPACE = 0x500
Global Const $EN_HSCROLL = 0X601
Global Const $EN_KILLFOCUS = 0x200
Global Const $EN_MAXTEXT = 0x501
Global Const $EN_SETFOCUS = 0x100
Global Const $EN_UPDATE = 0x400
Global Const $EN_VSCROLL = 0x602
Global Const $TTI_NONE = 0
Global Const $TTI_INFO = 1
Global Const $TTI_WARNING = 2
Global Const $TTI_ERROR = 3
Global Const $TTI_INFO_LARGE = 4
Global Const $TTI_WARNING_LARGE = 5
Global Const $TTI_ERROR_LARGE = 6
Global Const $__EDITCONSTANT_WS_VSCROLL = 0x00200000
Global Const $__EDITCONSTANT_WS_HSCROLL = 0x00100000
Global Const $GUI_SS_DEFAULT_EDIT = BitOR($ES_WANTRETURN, $__EDITCONSTANT_WS_VSCROLL, $__EDITCONSTANT_WS_HSCROLL, $ES_AUTOVSCROLL, $ES_AUTOHSCROLL)
Global Const $GUI_SS_DEFAULT_INPUT = BitOR($ES_LEFT, $ES_AUTOHSCROLL)
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_EVENT_MINIMIZE = -4
Global Const $GUI_EVENT_RESTORE = -5
Global Const $GUI_EVENT_MAXIMIZE = -6
Global Const $GUI_EVENT_PRIMARYDOWN = -7
Global Const $GUI_EVENT_PRIMARYUP = -8
Global Const $GUI_EVENT_SECONDARYDOWN = -9
Global Const $GUI_EVENT_SECONDARYUP = -10
Global Const $GUI_EVENT_MOUSEMOVE = -11
Global Const $GUI_EVENT_RESIZED = -12
Global Const $GUI_EVENT_DROPPED = -13
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
Global Const $GUI_AVISTOP = 0
Global Const $GUI_AVISTART = 1
Global Const $GUI_AVICLOSE = 2
Global Const $GUI_CHECKED = 1
Global Const $GUI_INDETERMINATE = 2
Global Const $GUI_UNCHECKED = 4
Global Const $GUI_DROPACCEPTED = 8
Global Const $GUI_NODROPACCEPTED = 4096
Global Const $GUI_ACCEPTFILES = $GUI_DROPACCEPTED
Global Const $GUI_SHOW = 16
Global Const $GUI_HIDE = 32
Global Const $GUI_ENABLE = 64
Global Const $GUI_DISABLE = 128
Global Const $GUI_FOCUS = 256
Global Const $GUI_NOFOCUS = 8192
Global Const $GUI_DEFBUTTON = 512
Global Const $GUI_EXPAND = 1024
Global Const $GUI_ONTOP = 2048
Global Const $GUI_FONTITALIC = 2
Global Const $GUI_FONTUNDER = 4
Global Const $GUI_FONTSTRIKE = 8
Global Const $GUI_DOCKAUTO = 0x0001
Global Const $GUI_DOCKLEFT = 0x0002
Global Const $GUI_DOCKRIGHT = 0x0004
Global Const $GUI_DOCKHCENTER = 0x0008
Global Const $GUI_DOCKTOP = 0x0020
Global Const $GUI_DOCKBOTTOM = 0x0040
Global Const $GUI_DOCKVCENTER = 0x0080
Global Const $GUI_DOCKWIDTH = 0x0100
Global Const $GUI_DOCKHEIGHT = 0x0200
Global Const $GUI_DOCKSIZE = 0x0300
Global Const $GUI_DOCKMENUBAR = 0x0220
Global Const $GUI_DOCKSTATEBAR = 0x0240
Global Const $GUI_DOCKALL = 0x0322
Global Const $GUI_DOCKBORDERS = 0x0066
Global Const $GUI_GR_CLOSE = 1
Global Const $GUI_GR_LINE = 2
Global Const $GUI_GR_BEZIER = 4
Global Const $GUI_GR_MOVE = 6
Global Const $GUI_GR_COLOR = 8
Global Const $GUI_GR_RECT = 10
Global Const $GUI_GR_ELLIPSE = 12
Global Const $GUI_GR_PIE = 14
Global Const $GUI_GR_DOT = 16
Global Const $GUI_GR_PIXEL = 18
Global Const $GUI_GR_HINT = 20
Global Const $GUI_GR_REFRESH = 22
Global Const $GUI_GR_PENSIZE = 24
Global Const $GUI_GR_NOBKCOLOR = -2
Global Const $GUI_BKCOLOR_DEFAULT = -1
Global Const $GUI_BKCOLOR_TRANSPARENT = -2
Global Const $GUI_BKCOLOR_LV_ALTERNATE = 0xFE000000
Global Const $GUI_WS_EX_PARENTDRAG = 0x00100000
Global Const $PBS_MARQUEE = 0x00000008
Global Const $PBS_SMOOTH = 1
Global Const $PBS_SMOOTHREVERSE = 0x10
Global Const $PBS_VERTICAL = 4
Global Const $GUI_SS_DEFAULT_PROGRESS = 0
Global Const $__PROGRESSBARCONSTANT_WM_USER = 0X400
Global Const $PBM_DELTAPOS = $__PROGRESSBARCONSTANT_WM_USER + 3
Global Const $PBM_GETBARCOLOR = 0x040F
Global Const $PBM_GETBKCOLOR = 0x040E
Global Const $PBM_GETPOS = $__PROGRESSBARCONSTANT_WM_USER + 8
Global Const $PBM_GETRANGE = $__PROGRESSBARCONSTANT_WM_USER + 7
Global Const $PBM_GETSTATE = 0x0411
Global Const $PBM_GETSTEP = 0x040D
Global Const $PBM_SETBARCOLOR = $__PROGRESSBARCONSTANT_WM_USER + 9
Global Const $PBM_SETBKCOLOR = 0x2000 + 1
Global Const $PBM_SETMARQUEE = $__PROGRESSBARCONSTANT_WM_USER + 10
Global Const $PBM_SETPOS = $__PROGRESSBARCONSTANT_WM_USER + 2
Global Const $PBM_SETRANGE = $__PROGRESSBARCONSTANT_WM_USER + 1
Global Const $PBM_SETRANGE32 = $__PROGRESSBARCONSTANT_WM_USER + 6
Global Const $PBM_SETSTATE = 0x0410
Global Const $PBM_SETSTEP = $__PROGRESSBARCONSTANT_WM_USER + 4
Global Const $PBM_STEPIT = $__PROGRESSBARCONSTANT_WM_USER + 5
Global Const $SS_LEFT = 0x0
Global Const $SS_CENTER = 0x1
Global Const $SS_RIGHT = 0x2
Global Const $SS_ICON = 0x3
Global Const $SS_BLACKRECT = 0x4
Global Const $SS_GRAYRECT = 0x5
Global Const $SS_WHITERECT = 0x6
Global Const $SS_BLACKFRAME = 0x7
Global Const $SS_GRAYFRAME = 0x8
Global Const $SS_WHITEFRAME = 0x9
Global Const $SS_SIMPLE = 0xB
Global Const $SS_LEFTNOWORDWRAP = 0xC
Global Const $SS_BITMAP = 0xE
Global Const $SS_ETCHEDHORZ = 0x10
Global Const $SS_ETCHEDVERT = 0x11
Global Const $SS_ETCHEDFRAME = 0x12
Global Const $SS_NOPREFIX = 0x0080
Global Const $SS_NOTIFY = 0x0100
Global Const $SS_CENTERIMAGE = 0x0200
Global Const $SS_RIGHTJUST = 0x0400
Global Const $SS_SUNKEN = 0x1000
Global Const $GUI_SS_DEFAULT_LABEL = 0
Global Const $GUI_SS_DEFAULT_GRAPHIC = 0
Global Const $GUI_SS_DEFAULT_ICON = $SS_NOTIFY
Global Const $GUI_SS_DEFAULT_PIC = $SS_NOTIFY
Global Const $WS_TILED = 0
Global Const $WS_OVERLAPPED = 0
Global Const $WS_MAXIMIZEBOX = 0x00010000
Global Const $WS_MINIMIZEBOX = 0x00020000
Global Const $WS_TABSTOP = 0x00010000
Global Const $WS_GROUP = 0x00020000
Global Const $WS_SIZEBOX = 0x00040000
Global Const $WS_THICKFRAME = 0x00040000
Global Const $WS_SYSMENU = 0x00080000
Global Const $WS_HSCROLL = 0x00100000
Global Const $WS_VSCROLL = 0x00200000
Global Const $WS_DLGFRAME = 0x00400000
Global Const $WS_BORDER = 0x00800000
Global Const $WS_CAPTION = 0x00C00000
Global Const $WS_OVERLAPPEDWINDOW = 0x00CF0000
Global Const $WS_TILEDWINDOW = 0x00CF0000
Global Const $WS_MAXIMIZE = 0x01000000
Global Const $WS_CLIPCHILDREN = 0x02000000
Global Const $WS_CLIPSIBLINGS = 0x04000000
Global Const $WS_DISABLED = 0x08000000
Global Const $WS_VISIBLE = 0x10000000
Global Const $WS_MINIMIZE = 0x20000000
Global Const $WS_CHILD = 0x40000000
Global Const $WS_POPUP = 0x80000000
Global Const $WS_POPUPWINDOW = 0x80880000
Global Const $DS_MODALFRAME = 0x80
Global Const $DS_SETFOREGROUND = 0x00000200
Global Const $DS_CONTEXTHELP = 0x00002000
Global Const $WS_EX_ACCEPTFILES = 0x00000010
Global Const $WS_EX_MDICHILD = 0x00000040
Global Const $WS_EX_APPWINDOW = 0x00040000
Global Const $WS_EX_COMPOSITED = 0x02000000
Global Const $WS_EX_CLIENTEDGE = 0x00000200
Global Const $WS_EX_CONTEXTHELP = 0x00000400
Global Const $WS_EX_DLGMODALFRAME = 0x00000001
Global Const $WS_EX_LEFTSCROLLBAR = 0x00004000
Global Const $WS_EX_OVERLAPPEDWINDOW = 0x00000300
Global Const $WS_EX_RIGHT = 0x00001000
Global Const $WS_EX_STATICEDGE = 0x00020000
Global Const $WS_EX_TOOLWINDOW = 0x00000080
Global Const $WS_EX_TOPMOST = 0x00000008
Global Const $WS_EX_TRANSPARENT = 0x00000020
Global Const $WS_EX_WINDOWEDGE = 0x00000100
Global Const $WS_EX_LAYERED = 0x00080000
Global Const $WS_EX_CONTROLPARENT = 0x10000
Global Const $WS_EX_LAYOUTRTL = 0x400000
Global Const $WS_EX_RTLREADING = 0x2000
Global Const $WM_GETTEXTLENGTH = 0x000E
Global Const $WM_GETTEXT = 0x000D
Global Const $WM_SIZE = 0x05
Global Const $WM_SIZING = 0x0214
Global Const $WM_USER = 0X400
Global Const $WM_CREATE = 0x0001
Global Const $WM_DESTROY = 0x0002
Global Const $WM_MOVE = 0x0003
Global Const $WM_ACTIVATE = 0x0006
Global Const $WM_SETFOCUS = 0x0007
Global Const $WM_KILLFOCUS = 0x0008
Global Const $WM_ENABLE = 0x000A
Global Const $WM_SETREDRAW = 0x000B
Global Const $WM_SETTEXT = 0x000C
Global Const $WM_PAINT = 0x000F
Global Const $WM_CLOSE = 0x0010
Global Const $WM_QUIT = 0x0012
Global Const $WM_ERASEBKGND = 0x0014
Global Const $WM_SYSCOLORCHANGE = 0x0015
Global Const $WM_SHOWWINDOW = 0x0018
Global Const $WM_WININICHANGE = 0x001A
Global Const $WM_DEVMODECHANGE = 0x001B
Global Const $WM_ACTIVATEAPP = 0x001C
Global Const $WM_FONTCHANGE = 0x001D
Global Const $WM_TIMECHANGE = 0x001E
Global Const $WM_CANCELMODE = 0x001F
Global Const $WM_SETCURSOR = 0x0020
Global Const $WM_MOUSEACTIVATE = 0x0021
Global Const $WM_CHILDACTIVATE = 0x0022
Global Const $WM_QUEUESYNC = 0x0023
Global Const $WM_GETMINMAXINFO = 0x0024
Global Const $WM_PAINTICON = 0x0026
Global Const $WM_ICONERASEBKGND = 0x0027
Global Const $WM_NEXTDLGCTL = 0x0028
Global Const $WM_SPOOLERSTATUS = 0x002A
Global Const $WM_DRAWITEM = 0x002B
Global Const $WM_MEASUREITEM = 0x002C
Global Const $WM_DELETEITEM = 0x002D
Global Const $WM_VKEYTOITEM = 0x002E
Global Const $WM_CHARTOITEM = 0x002F
Global Const $WM_SETFONT = 0x0030
Global Const $WM_GETFONT = 0x0031
Global Const $WM_SETHOTKEY = 0x0032
Global Const $WM_GETHOTKEY = 0x0033
Global Const $WM_QUERYDRAGICON = 0x0037
Global Const $WM_COMPAREITEM = 0x0039
Global Const $WM_GETOBJECT = 0x003D
Global Const $WM_COMPACTING = 0x0041
Global Const $WM_COMMNOTIFY = 0x0044
Global Const $WM_WINDOWPOSCHANGING = 0x0046
Global Const $WM_WINDOWPOSCHANGED = 0x0047
Global Const $WM_POWER = 0x0048
Global Const $WM_NOTIFY = 0x004E
Global Const $WM_COPYDATA = 0x004A
Global Const $WM_CANCELJOURNAL = 0x004B
Global Const $WM_INPUTLANGCHANGEREQUEST = 0x0050
Global Const $WM_INPUTLANGCHANGE = 0x0051
Global Const $WM_TCARD = 0x0052
Global Const $WM_HELP = 0x0053
Global Const $WM_USERCHANGED = 0x0054
Global Const $WM_NOTIFYFORMAT = 0x0055
Global Const $WM_CUT = 0x0300
Global Const $WM_COPY = 0x0301
Global Const $WM_PASTE = 0x0302
Global Const $WM_CLEAR = 0x0303
Global Const $WM_UNDO = 0x0304
Global Const $WM_CONTEXTMENU = 0x007B
Global Const $WM_STYLECHANGING = 0x007C
Global Const $WM_STYLECHANGED = 0x007D
Global Const $WM_DISPLAYCHANGE = 0x007E
Global Const $WM_GETICON = 0x007F
Global Const $WM_SETICON = 0x0080
Global Const $WM_NCCREATE = 0x0081
Global Const $WM_NCDESTROY = 0x0082
Global Const $WM_NCCALCSIZE = 0x0083
Global Const $WM_NCHITTEST = 0x0084
Global Const $WM_NCPAINT = 0x0085
Global Const $WM_NCACTIVATE = 0x0086
Global Const $WM_GETDLGCODE = 0x0087
Global Const $WM_SYNCPAINT = 0x0088
Global Const $WM_NCMOUSEMOVE = 0x00A0
Global Const $WM_NCLBUTTONDOWN = 0x00A1
Global Const $WM_NCLBUTTONUP = 0x00A2
Global Const $WM_NCLBUTTONDBLCLK = 0x00A3
Global Const $WM_NCRBUTTONDOWN = 0x00A4
Global Const $WM_NCRBUTTONUP = 0x00A5
Global Const $WM_NCRBUTTONDBLCLK = 0x00A6
Global Const $WM_NCMBUTTONDOWN = 0x00A7
Global Const $WM_NCMBUTTONUP = 0x00A8
Global Const $WM_NCMBUTTONDBLCLK = 0x00A9
Global Const $WM_KEYDOWN = 0x0100
Global Const $WM_KEYUP = 0x0101
Global Const $WM_CHAR = 0x0102
Global Const $WM_DEADCHAR = 0x0103
Global Const $WM_SYSKEYDOWN = 0x0104
Global Const $WM_SYSKEYUP = 0x0105
Global Const $WM_SYSCHAR = 0x0106
Global Const $WM_SYSDEADCHAR = 0x0107
Global Const $WM_INITDIALOG = 0x0110
Global Const $WM_COMMAND = 0x0111
Global Const $WM_SYSCOMMAND = 0x0112
Global Const $WM_TIMER = 0x0113
Global Const $WM_HSCROLL = 0x0114
Global Const $WM_VSCROLL = 0x0115
Global Const $WM_INITMENU = 0x0116
Global Const $WM_INITMENUPOPUP = 0x0117
Global Const $WM_MENUSELECT = 0x011F
Global Const $WM_MENUCHAR = 0x0120
Global Const $WM_ENTERIDLE = 0x0121
Global Const $WM_MENURBUTTONUP = 0x0122
Global Const $WM_MENUDRAG = 0x0123
Global Const $WM_MENUGETOBJECT = 0x0124
Global Const $WM_UNINITMENUPOPUP = 0x0125
Global Const $WM_MENUCOMMAND = 0x0126
Global Const $WM_CHANGEUISTATE = 0x0127
Global Const $WM_UPDATEUISTATE = 0x0128
Global Const $WM_QUERYUISTATE = 0x0129
Global Const $WM_CTLCOLORMSGBOX = 0x0132
Global Const $WM_CTLCOLOREDIT = 0x0133
Global Const $WM_CTLCOLORLISTBOX = 0x0134
Global Const $WM_CTLCOLORBTN = 0x0135
Global Const $WM_CTLCOLORDLG = 0x0136
Global Const $WM_CTLCOLORSCROLLBAR = 0x0137
Global Const $WM_CTLCOLORSTATIC = 0x0138
Global Const $WM_CTLCOLOR = 0x0019
Global Const $MN_GETHMENU = 0x01E1
Global Const $NM_FIRST = 0
Global Const $NM_OUTOFMEMORY = $NM_FIRST - 1
Global Const $NM_CLICK = $NM_FIRST - 2
Global Const $NM_DBLCLK = $NM_FIRST - 3
Global Const $NM_RETURN = $NM_FIRST - 4
Global Const $NM_RCLICK = $NM_FIRST - 5
Global Const $NM_RDBLCLK = $NM_FIRST - 6
Global Const $NM_SETFOCUS = $NM_FIRST - 7
Global Const $NM_KILLFOCUS = $NM_FIRST - 8
Global Const $NM_CUSTOMDRAW = $NM_FIRST - 12
Global Const $NM_HOVER = $NM_FIRST - 13
Global Const $NM_NCHITTEST = $NM_FIRST - 14
Global Const $NM_KEYDOWN = $NM_FIRST - 15
Global Const $NM_RELEASEDCAPTURE = $NM_FIRST - 16
Global Const $NM_SETCURSOR = $NM_FIRST - 17
Global Const $NM_CHAR = $NM_FIRST - 18
Global Const $NM_TOOLTIPSCREATED = $NM_FIRST - 19
Global Const $NM_LDOWN = $NM_FIRST - 20
Global Const $NM_RDOWN = $NM_FIRST - 21
Global Const $NM_THEMECHANGED = $NM_FIRST - 22
Global Const $WM_MOUSEMOVE = 0x0200
Global Const $WM_LBUTTONDOWN = 0x0201
Global Const $WM_LBUTTONUP = 0x0202
Global Const $WM_LBUTTONDBLCLK = 0x0203
Global Const $WM_RBUTTONDOWN = 0x0204
Global Const $WM_RBUTTONUP = 0x0205
Global Const $WM_RBUTTONDBLCK = 0x0206
Global Const $WM_MBUTTONDOWN = 0x0207
Global Const $WM_MBUTTONUP = 0x0208
Global Const $WM_MBUTTONDBLCK = 0x0209
Global Const $WM_MOUSEWHEEL = 0x020A
Global Const $WM_XBUTTONDOWN = 0x020B
Global Const $WM_XBUTTONUP = 0x020C
Global Const $WM_XBUTTONDBLCLK = 0x020D
Global Const $WM_MOUSEHWHEEL = 0x020E
Global Const $PS_SOLID = 0
Global Const $PS_DASH = 1
Global Const $PS_DOT = 2
Global Const $PS_DASHDOT = 3
Global Const $PS_DASHDOTDOT = 4
Global Const $PS_NULL = 5
Global Const $PS_INSIDEFRAME = 6
Global Const $LWA_ALPHA = 0x2
Global Const $LWA_COLORKEY = 0x1
Global Const $RGN_AND = 1
Global Const $RGN_OR = 2
Global Const $RGN_XOR = 3
Global Const $RGN_DIFF = 4
Global Const $RGN_COPY = 5
Global Const $ERRORREGION = 0
Global Const $NULLREGION = 1
Global Const $SIMPLEREGION = 2
Global Const $COMPLEXREGION = 3
Global Const $TRANSPARENT = 1
Global Const $OPAQUE = 2
Global Const $CCM_FIRST = 0x2000
Global Const $CCM_GETUNICODEFORMAT =($CCM_FIRST + 6)
Global Const $CCM_SETUNICODEFORMAT =($CCM_FIRST + 5)
Global Const $CCM_SETBKCOLOR = $CCM_FIRST + 1
Global Const $CCM_SETCOLORSCHEME = $CCM_FIRST + 2
Global Const $CCM_GETCOLORSCHEME = $CCM_FIRST + 3
Global Const $CCM_GETDROPTARGET = $CCM_FIRST + 4
Global Const $CCM_SETWINDOWTHEME = $CCM_FIRST + 11
Global Const $GA_PARENT = 1
Global Const $GA_ROOT = 2
Global Const $GA_ROOTOWNER = 3
Global Const $SM_CXSCREEN = 0
Global Const $SM_CYSCREEN = 1
Global Const $SM_CXVSCROLL = 2
Global Const $SM_CYHSCROLL = 3
Global Const $SM_CYCAPTION = 4
Global Const $SM_CXBORDER = 5
Global Const $SM_CYBORDER = 6
Global Const $SM_CXDLGFRAME = 7
Global Const $SM_CYDLGFRAME = 8
Global Const $SM_CYVTHUMB = 9
Global Const $SM_CXHTHUMB = 10
Global Const $SM_CXICON = 11
Global Const $SM_CYICON = 12
Global Const $SM_CXCURSOR = 13
Global Const $SM_CYCURSOR = 14
Global Const $SM_CYMENU = 15
Global Const $SM_CXFULLSCREEN = 16
Global Const $SM_CYFULLSCREEN = 17
Global Const $SM_CYKANJIWINDOW = 18
Global Const $SM_MOUSEPRESENT = 19
Global Const $SM_CYVSCROLL = 20
Global Const $SM_CXHSCROLL = 21
Global Const $SM_DEBUG = 22
Global Const $SM_SWAPBUTTON = 23
Global Const $SM_RESERVED1 = 24
Global Const $SM_RESERVED2 = 25
Global Const $SM_RESERVED3 = 26
Global Const $SM_RESERVED4 = 27
Global Const $SM_CXMIN = 28
Global Const $SM_CYMIN = 29
Global Const $SM_CXSIZE = 30
Global Const $SM_CYSIZE = 31
Global Const $SM_CXFRAME = 32
Global Const $SM_CYFRAME = 33
Global Const $SM_CXMINTRACK = 34
Global Const $SM_CYMINTRACK = 35
Global Const $SM_CXDOUBLECLK = 36
Global Const $SM_CYDOUBLECLK = 37
Global Const $SM_CXICONSPACING = 38
Global Const $SM_CYICONSPACING = 39
Global Const $SM_MENUDROPALIGNMENT = 40
Global Const $SM_PENWINDOWS = 41
Global Const $SM_DBCSENABLED = 42
Global Const $SM_CMOUSEBUTTONS = 43
Global Const $SM_SECURE = 44
Global Const $SM_CXEDGE = 45
Global Const $SM_CYEDGE = 46
Global Const $SM_CXMINSPACING = 47
Global Const $SM_CYMINSPACING = 48
Global Const $SM_CXSMICON = 49
Global Const $SM_CYSMICON = 50
Global Const $SM_CYSMCAPTION = 51
Global Const $SM_CXSMSIZE = 52
Global Const $SM_CYSMSIZE = 53
Global Const $SM_CXMENUSIZE = 54
Global Const $SM_CYMENUSIZE = 55
Global Const $SM_ARRANGE = 56
Global Const $SM_CXMINIMIZED = 57
Global Const $SM_CYMINIMIZED = 58
Global Const $SM_CXMAXTRACK = 59
Global Const $SM_CYMAXTRACK = 60
Global Const $SM_CXMAXIMIZED = 61
Global Const $SM_CYMAXIMIZED = 62
Global Const $SM_NETWORK = 63
Global Const $SM_CLEANBOOT = 67
Global Const $SM_CXDRAG = 68
Global Const $SM_CYDRAG = 69
Global Const $SM_SHOWSOUNDS = 70
Global Const $SM_CXMENUCHECK = 71
Global Const $SM_CYMENUCHECK = 72
Global Const $SM_SLOWMACHINE = 73
Global Const $SM_MIDEASTENABLED = 74
Global Const $SM_MOUSEWHEELPRESENT = 75
Global Const $SM_XVIRTUALSCREEN = 76
Global Const $SM_YVIRTUALSCREEN = 77
Global Const $SM_CXVIRTUALSCREEN = 78
Global Const $SM_CYVIRTUALSCREEN = 79
Global Const $SM_CMONITORS = 80
Global Const $SM_SAMEDISPLAYFORMAT = 81
Global Const $SM_IMMENABLED = 82
Global Const $SM_CXFOCUSBORDER = 83
Global Const $SM_CYFOCUSBORDER = 84
Global Const $SM_TABLETPC = 86
Global Const $SM_MEDIACENTER = 87
Global Const $SM_STARTER = 88
Global Const $SM_SERVERR2 = 89
Global Const $SM_CMETRICS = 90
Global Const $SM_REMOTESESSION = 0x1000
Global Const $SM_SHUTTINGDOWN = 0x2000
Global Const $SM_REMOTECONTROL = 0x2001
Global Const $SM_CARETBLINKINGENABLED = 0x2002
Global Const $BLACKNESS = 0x00000042
Global Const $CAPTUREBLT = 0X40000000
Global Const $DSTINVERT = 0x00550009
Global Const $MERGECOPY = 0x00C000CA
Global Const $MERGEPAINT = 0x00BB0226
Global Const $NOMIRRORBITMAP = 0X80000000
Global Const $NOTSRCCOPY = 0x00330008
Global Const $NOTSRCERASE = 0x001100A6
Global Const $PATCOPY = 0x00F00021
Global Const $PATINVERT = 0x005A0049
Global Const $PATPAINT = 0x00FB0A09
Global Const $SRCAND = 0x008800C6
Global Const $SRCCOPY = 0x00CC0020
Global Const $SRCERASE = 0x00440328
Global Const $SRCINVERT = 0x00660046
Global Const $SRCPAINT = 0x00EE0086
Global Const $WHITENESS = 0x00FF0062
Global Const $DT_BOTTOM = 0x8
Global Const $DT_CALCRECT = 0x400
Global Const $DT_CENTER = 0x1
Global Const $DT_EDITCONTROL = 0x2000
Global Const $DT_END_ELLIPSIS = 0x8000
Global Const $DT_EXPANDTABS = 0x40
Global Const $DT_EXTERNALLEADING = 0x200
Global Const $DT_HIDEPREFIX = 0x100000
Global Const $DT_INTERNAL = 0x1000
Global Const $DT_LEFT = 0x0
Global Const $DT_MODIFYSTRING = 0x10000
Global Const $DT_NOCLIP = 0x100
Global Const $DT_NOFULLWIDTHCHARBREAK = 0x80000
Global Const $DT_NOPREFIX = 0x800
Global Const $DT_PATH_ELLIPSIS = 0x4000
Global Const $DT_PREFIXONLY = 0x200000
Global Const $DT_RIGHT = 0x2
Global Const $DT_RTLREADING = 0x20000
Global Const $DT_SINGLELINE = 0x20
Global Const $DT_TABSTOP = 0x80
Global Const $DT_TOP = 0x0
Global Const $DT_VCENTER = 0x4
Global Const $DT_WORDBREAK = 0x10
Global Const $DT_WORD_ELLIPSIS = 0x40000
Global Const $RDW_ERASE = 0x0004
Global Const $RDW_FRAME = 0x0400
Global Const $RDW_INTERNALPAINT = 0x0002
Global Const $RDW_INVALIDATE = 0x0001
Global Const $RDW_NOERASE = 0x0020
Global Const $RDW_NOFRAME = 0x0800
Global Const $RDW_NOINTERNALPAINT = 0x0010
Global Const $RDW_VALIDATE = 0x0008
Global Const $RDW_ERASENOW = 0x0200
Global Const $RDW_UPDATENOW = 0x0100
Global Const $RDW_ALLCHILDREN = 0x0080
Global Const $RDW_NOCHILDREN = 0x0040
Global Const $WM_RENDERFORMAT = 0x0305
Global Const $WM_RENDERALLFORMATS = 0x0306
Global Const $WM_DESTROYCLIPBOARD = 0x0307
Global Const $WM_DRAWCLIPBOARD = 0x0308
Global Const $WM_PAINTCLIPBOARD = 0x0309
Global Const $WM_VSCROLLCLIPBOARD = 0x030A
Global Const $WM_SIZECLIPBOARD = 0x030B
Global Const $WM_ASKCBFORMATNAME = 0x030C
Global Const $WM_CHANGECBCHAIN = 0x030D
Global Const $WM_HSCROLLCLIPBOARD = 0x030E
Global Const $HTERROR = -2
Global Const $HTTRANSPARENT = -1
Global Const $HTNOWHERE = 0
Global Const $HTCLIENT = 1
Global Const $HTCAPTION = 2
Global Const $HTSYSMENU = 3
Global Const $HTGROWBOX = 4
Global Const $HTSIZE = $HTGROWBOX
Global Const $HTMENU = 5
Global Const $HTHSCROLL = 6
Global Const $HTVSCROLL = 7
Global Const $HTMINBUTTON = 8
Global Const $HTMAXBUTTON = 9
Global Const $HTLEFT = 10
Global Const $HTRIGHT = 11
Global Const $HTTOP = 12
Global Const $HTTOPLEFT = 13
Global Const $HTTOPRIGHT = 14
Global Const $HTBOTTOM = 15
Global Const $HTBOTTOMLEFT = 16
Global Const $HTBOTTOMRIGHT = 17
Global Const $HTBORDER = 18
Global Const $HTREDUCE = $HTMINBUTTON
Global Const $HTZOOM = $HTMAXBUTTON
Global Const $HTSIZEFIRST = $HTLEFT
Global Const $HTSIZELAST = $HTBOTTOMRIGHT
Global Const $HTOBJECT = 19
Global Const $HTCLOSE = 20
Global Const $HTHELP = 21
Global Const $COLOR_SCROLLBAR = 0
Global Const $COLOR_BACKGROUND = 1
Global Const $COLOR_ACTIVECAPTION = 2
Global Const $COLOR_INACTIVECAPTION = 3
Global Const $COLOR_MENU = 4
Global Const $COLOR_WINDOW = 5
Global Const $COLOR_WINDOWFRAME = 6
Global Const $COLOR_MENUTEXT = 7
Global Const $COLOR_WINDOWTEXT = 8
Global Const $COLOR_CAPTIONTEXT = 9
Global Const $COLOR_ACTIVEBORDER = 10
Global Const $COLOR_INACTIVEBORDER = 11
Global Const $COLOR_APPWORKSPACE = 12
Global Const $COLOR_HIGHLIGHT = 13
Global Const $COLOR_HIGHLIGHTTEXT = 14
Global Const $COLOR_BTNFACE = 15
Global Const $COLOR_BTNSHADOW = 16
Global Const $COLOR_GRAYTEXT = 17
Global Const $COLOR_BTNTEXT = 18
Global Const $COLOR_INACTIVECAPTIONTEXT = 19
Global Const $COLOR_BTNHIGHLIGHT = 20
Global Const $COLOR_3DDKSHADOW = 21
Global Const $COLOR_3DLIGHT = 22
Global Const $COLOR_INFOTEXT = 23
Global Const $COLOR_INFOBK = 24
Global Const $COLOR_HOTLIGHT = 26
Global Const $COLOR_GRADIENTACTIVECAPTION = 27
Global Const $COLOR_GRADIENTINACTIVECAPTION = 28
Global Const $COLOR_MENUHILIGHT = 29
Global Const $COLOR_MENUBAR = 30
Global Const $COLOR_DESKTOP = 1
Global Const $COLOR_3DFACE = 15
Global Const $COLOR_3DSHADOW = 16
Global Const $COLOR_3DHIGHLIGHT = 20
Global Const $COLOR_3DHILIGHT = 20
Global Const $COLOR_BTNHILIGHT = 20
Global Const $HINST_COMMCTRL = -1
Global Const $IDB_STD_SMALL_COLOR = 0
Global Const $IDB_STD_LARGE_COLOR = 1
Global Const $IDB_VIEW_SMALL_COLOR = 4
Global Const $IDB_VIEW_LARGE_COLOR = 5
Global Const $IDB_HIST_SMALL_COLOR = 8
Global Const $IDB_HIST_LARGE_COLOR = 9
Global Const $STARTF_FORCEOFFFEEDBACK = 0x80
Global Const $STARTF_FORCEONFEEDBACK = 0x40
Global Const $STARTF_RUNFULLSCREEN = 0x20
Global Const $STARTF_USECOUNTCHARS = 0x8
Global Const $STARTF_USEFILLATTRIBUTE = 0x10
Global Const $STARTF_USEHOTKEY = 0x200
Global Const $STARTF_USEPOSITION = 0x4
Global Const $STARTF_USESHOWWINDOW = 0x1
Global Const $STARTF_USESIZE = 0x2
Global Const $STARTF_USESTDHANDLES = 0x100
Global Const $CDDS_PREPAINT = 0x00000001
Global Const $CDDS_POSTPAINT = 0x00000002
Global Const $CDDS_PREERASE = 0x00000003
Global Const $CDDS_POSTERASE = 0x00000004
Global Const $CDDS_ITEM = 0x00010000
Global Const $CDDS_ITEMPREPAINT = 0x00010001
Global Const $CDDS_ITEMPOSTPAINT = 0x00010002
Global Const $CDDS_ITEMPREERASE = 0x00010003
Global Const $CDDS_ITEMPOSTERASE = 0x00010004
Global Const $CDDS_SUBITEM = 0x00020000
Global Const $CDIS_SELECTED = 0x0001
Global Const $CDIS_GRAYED = 0x0002
Global Const $CDIS_DISABLED = 0x0004
Global Const $CDIS_CHECKED = 0x0008
Global Const $CDIS_FOCUS = 0x0010
Global Const $CDIS_DEFAULT = 0x0020
Global Const $CDIS_HOT = 0x0040
Global Const $CDIS_MARKED = 0x0080
Global Const $CDIS_INDETERMINATE = 0x0100
Global Const $CDIS_SHOWKEYBOARDCUES = 0x0200
Global Const $CDIS_NEARHOT = 0x0400
Global Const $CDIS_OTHERSIDEHOT = 0x0800
Global Const $CDIS_DROPHILITED = 0x1000
Global Const $CDRF_DODEFAULT = 0x00000000
Global Const $CDRF_NEWFONT = 0x00000002
Global Const $CDRF_SKIPDEFAULT = 0x00000004
Global Const $CDRF_NOTIFYPOSTPAINT = 0x00000010
Global Const $CDRF_NOTIFYITEMDRAW = 0x00000020
Global Const $CDRF_NOTIFYSUBITEMDRAW = 0x00000020
Global Const $CDRF_NOTIFYPOSTERASE = 0x00000040
Global Const $CDRF_DOERASE = 0x00000008
Global Const $CDRF_SKIPPOSTPAINT = 0x00000100
Global Const $GUI_SS_DEFAULT_GUI = BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU)
Global Const $FW_DONTCARE = 0
Global Const $FW_THIN = 100
Global Const $FW_EXTRALIGHT = 200
Global Const $FW_ULTRALIGHT = 200
Global Const $FW_LIGHT = 300
Global Const $FW_NORMAL = 400
Global Const $FW_REGULAR = 400
Global Const $FW_MEDIUM = 500
Global Const $FW_SEMIBOLD = 600
Global Const $FW_DEMIBOLD = 600
Global Const $FW_BOLD = 700
Global Const $FW_EXTRABOLD = 800
Global Const $FW_ULTRABOLD = 800
Global Const $FW_HEAVY = 900
Global Const $FW_BLACK = 900
Global Const $CF_EFFECTS = 0x100
Global Const $CF_PRINTERFONTS = 0x2
Global Const $CF_SCREENFONTS = 0x1
Global Const $CF_NOSCRIPTSEL = 0x800000
Global Const $CF_INITTOLOGFONTSTRUCT = 0x40
Global Const $LOGPIXELSX = 88
Global Const $LOGPIXELSY = 90
Global Const $ANSI_CHARSET = 0
Global Const $BALTIC_CHARSET = 186
Global Const $CHINESEBIG5_CHARSET = 136
Global Const $DEFAULT_CHARSET = 1
Global Const $EASTEUROPE_CHARSET = 238
Global Const $GB2312_CHARSET = 134
Global Const $GREEK_CHARSET = 161
Global Const $HANGEUL_CHARSET = 129
Global Const $MAC_CHARSET = 77
Global Const $OEM_CHARSET = 255
Global Const $RUSSIAN_CHARSET = 204
Global Const $SHIFTJIS_CHARSET = 128
Global Const $SYMBOL_CHARSET = 2
Global Const $TURKISH_CHARSET = 162
Global Const $VIETNAMESE_CHARSET = 163
Global Const $OUT_CHARACTER_PRECIS = 2
Global Const $OUT_DEFAULT_PRECIS = 0
Global Const $OUT_DEVICE_PRECIS = 5
Global Const $OUT_OUTLINE_PRECIS = 8
Global Const $OUT_PS_ONLY_PRECIS = 10
Global Const $OUT_RASTER_PRECIS = 6
Global Const $OUT_STRING_PRECIS = 1
Global Const $OUT_STROKE_PRECIS = 3
Global Const $OUT_TT_ONLY_PRECIS = 7
Global Const $OUT_TT_PRECIS = 4
Global Const $CLIP_CHARACTER_PRECIS = 1
Global Const $CLIP_DEFAULT_PRECIS = 0
Global Const $CLIP_EMBEDDED = 128
Global Const $CLIP_LH_ANGLES = 16
Global Const $CLIP_MASK = 0xF
Global Const $CLIP_STROKE_PRECIS = 2
Global Const $CLIP_TT_ALWAYS = 32
Global Const $ANTIALIASED_QUALITY = 4
Global Const $DEFAULT_QUALITY = 0
Global Const $DRAFT_QUALITY = 1
Global Const $NONANTIALIASED_QUALITY = 3
Global Const $PROOF_QUALITY = 2
Global Const $DEFAULT_PITCH = 0
Global Const $FIXED_PITCH = 1
Global Const $VARIABLE_PITCH = 2
Global Const $FF_DECORATIVE = 80
Global Const $FF_DONTCARE = 0
Global Const $FF_MODERN = 48
Global Const $FF_ROMAN = 16
Global Const $FF_SCRIPT = 64
Global Const $FF_SWISS = 32
Global Const $tagPOINT = "long X;long Y"
Global Const $tagRECT = "long Left;long Top;long Right;long Bottom"
Global Const $tagSIZE = "long X;long Y"
Global Const $tagMARGINS = "int cxLeftWidth;int cxRightWidth;int cyTopHeight;int cyBottomHeight"
Global Const $tagFILETIME = "dword Lo;dword Hi"
Global Const $tagSYSTEMTIME = "word Year;word Month;word Dow;word Day;word Hour;word Minute;word Second;word MSeconds"
Global Const $tagTIME_ZONE_INFORMATION = "long Bias;wchar StdName[32];word StdDate[8];long StdBias;wchar DayName[32];word DayDate[8];long DayBias"
Global Const $tagNMHDR = "hwnd hWndFrom;uint_ptr IDFrom;INT Code"
Global Const $tagCOMBOBOXEXITEM = "uint Mask;int_ptr Item;ptr Text;int TextMax;int Image;int SelectedImage;int OverlayImage;" & _
"int Indent;lparam Param"
Global Const $tagNMCBEDRAGBEGIN = $tagNMHDR & ";int ItemID;ptr szText"
Global Const $tagNMCBEENDEDIT = $tagNMHDR & ";bool fChanged;int NewSelection;ptr szText;int Why"
Global Const $tagNMCOMBOBOXEX = $tagNMHDR & ";uint Mask;int_ptr Item;ptr Text;int TextMax;int Image;" & _
"int SelectedImage;int OverlayImage;int Indent;lparam Param"
Global Const $tagDTPRANGE = "word MinYear;word MinMonth;word MinDOW;word MinDay;word MinHour;word MinMinute;" & _
"word MinSecond;word MinMSecond;word MaxYear;word MaxMonth;word MaxDOW;word MaxDay;word MaxHour;" & _
"word MaxMinute;word MaxSecond;word MaxMSecond;bool MinValid;bool MaxValid"
Global Const $tagNMDATETIMECHANGE = $tagNMHDR & ";dword Flag;" & $tagSYSTEMTIME
Global Const $tagNMDATETIMEFORMAT = $tagNMHDR & ";ptr Format;" & $tagSYSTEMTIME & ";ptr pDisplay;wchar Display[64]"
Global Const $tagNMDATETIMEFORMATQUERY = $tagNMHDR & ";ptr Format;long SizeX;long SizeY"
Global Const $tagNMDATETIMEKEYDOWN = $tagNMHDR & ";int VirtKey;ptr Format;" & $tagSYSTEMTIME
Global Const $tagNMDATETIMESTRING = $tagNMHDR & ";ptr UserString;" & $tagSYSTEMTIME & ";dword Flags"
Global Const $tagEVENTLOGRECORD = "dword Length;dword Reserved;dword RecordNumber;dword TimeGenerated;dword TimeWritten;dword EventID;" & _
"word EventType;word NumStrings;word EventCategory;word ReservedFlags;dword ClosingRecordNumber;dword StringOffset;" & _
"dword UserSidLength;dword UserSidOffset;dword DataLength;dword DataOffset"
Global Const $tagGDIPBITMAPDATA = "uint Width;uint Height;int Stride;int Format;ptr Scan0;uint_ptr Reserved"
Global Const $tagGDIPENCODERPARAM = "byte GUID[16];dword Count;dword Type;ptr Values"
Global Const $tagGDIPENCODERPARAMS = "dword Count;byte Params[0]"
Global Const $tagGDIPRECTF = "float X;float Y;float Width;float Height"
Global Const $tagGDIPSTARTUPINPUT = "uint Version;ptr Callback;bool NoThread;bool NoCodecs"
Global Const $tagGDIPSTARTUPOUTPUT = "ptr HookProc;ptr UnhookProc"
Global Const $tagGDIPIMAGECODECINFO = "byte CLSID[16];byte FormatID[16];ptr CodecName;ptr DllName;ptr FormatDesc;ptr FileExt;" & _
"ptr MimeType;dword Flags;dword Version;dword SigCount;dword SigSize;ptr SigPattern;ptr SigMask"
Global Const $tagGDIPPENCODERPARAMS = "dword Count;byte Params[0]"
Global Const $tagHDITEM = "uint Mask;int XY;ptr Text;handle hBMP;int TextMax;int Fmt;lparam Param;int Image;int Order;uint Type;ptr pFilter;uint State"
Global Const $tagNMHDDISPINFO = $tagNMHDR & ";int Item;uint Mask;ptr Text;int TextMax;int Image;lparam lParam"
Global Const $tagNMHDFILTERBTNCLICK = $tagNMHDR & ";int Item;" & $tagRECT
Global Const $tagNMHEADER = $tagNMHDR & ";int Item;int Button;ptr pItem"
Global Const $tagGETIPAddress = "byte Field4;byte Field3;byte Field2;byte Field1"
Global Const $tagNMIPADDRESS = $tagNMHDR & ";int Field;int Value"
Global Const $tagLVFINDINFO = "uint Flags;ptr Text;lparam Param;" & $tagPOINT & ";uint Direction"
Global Const $tagLVHITTESTINFO = $tagPOINT & ";uint Flags;int Item;int SubItem"
Global Const $tagLVITEM = "uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & _
"int Indent;int GroupID;uint Columns;ptr pColumns"
Global Const $tagNMLISTVIEW = $tagNMHDR & ";int Item;int SubItem;uint NewState;uint OldState;uint Changed;" & _
"long ActionX;long ActionY;lparam Param"
Global Const $tagNMLVCUSTOMDRAW = $tagNMHDR & ";dword dwDrawStage;handle hdc;long Left;long Top;long Right;long Bottom;" & _
"dword_ptr dwItemSpec;uint uItemState;lparam lItemlParam" & _
";dword clrText;dword clrTextBk;int iSubItem;dword dwItemType;dword clrFace;int iIconEffect;" & _
"int iIconPhase;int iPartId;int iStateId;long TextLeft;long TextTop;long TextRight;long TextBottom;uint uAlign"
Global Const $tagNMLVDISPINFO = $tagNMHDR & ";" & $tagLVITEM
Global Const $tagNMLVFINDITEM = $tagNMHDR & ";" & $tagLVFINDINFO
Global Const $tagNMLVGETINFOTIP = $tagNMHDR & ";dword Flags;ptr Text;int TextMax;int Item;int SubItem;lparam lParam"
Global Const $tagNMITEMACTIVATE = $tagNMHDR & ";int Index;int SubItem;uint NewState;uint OldState;uint Changed;" & _
$tagPOINT & ";lparam lParam;uint KeyFlags"
Global Const $tagNMLVKEYDOWN = $tagNMHDR & ";align 1;word VKey;uint Flags"
Global Const $tagNMLVSCROLL = $tagNMHDR & ";int DX;int DY"
Global Const $tagMCHITTESTINFO = "uint Size;" & $tagPOINT & ";uint Hit;" & $tagSYSTEMTIME
Global Const $tagMCMONTHRANGE = "word MinYear;word MinMonth;word MinDOW;word MinDay;word MinHour;word MinMinute;word MinSecond;" & _
"word MinMSeconds;word MaxYear;word MaxMonth;word MaxDOW;word MaxDay;word MaxHour;word MaxMinute;word MaxSecond;" & _
"word MaxMSeconds;short Span"
Global Const $tagMCRANGE = "word MinYear;word MinMonth;word MinDOW;word MinDay;word MinHour;word MinMinute;word MinSecond;" & _
"word MinMSeconds;word MaxYear;word MaxMonth;word MaxDOW;word MaxDay;word MaxHour;word MaxMinute;word MaxSecond;" & _
"word MaxMSeconds;short MinSet;short MaxSet"
Global Const $tagMCSELRANGE = "word MinYear;word MinMonth;word MinDOW;word MinDay;word MinHour;word MinMinute;word MinSecond;" & _
"word MinMSeconds;word MaxYear;word MaxMonth;word MaxDOW;word MaxDay;word MaxHour;word MaxMinute;word MaxSecond;" & _
"word MaxMSeconds"
Global Const $tagNMDAYSTATE = $tagNMHDR & ";" & $tagSYSTEMTIME & ";int DayState;ptr pDayState"
Global Const $tagNMSELCHANGE = $tagNMHDR & ";word BegYear;word BegMonth;word BegDOW;word BegDay;" & _
"word BegHour;word BegMinute;word BegSecond;word BegMSeconds;word EndYear;word EndMonth;word EndDOW;" & _
"word EndDay;word EndHour;word EndMinute;word EndSecond;word EndMSeconds"
Global Const $tagNMOBJECTNOTIFY = $tagNMHDR & ";int Item;ptr piid;ptr pObject;long Result"
Global Const $tagNMTCKEYDOWN = $tagNMHDR & ";word VKey;uint Flags"
Global Const $tagTVITEM = "uint Mask;handle hItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;int SelectedImage;" & _
"int Children;lparam Param"
Global Const $tagTVITEMEX = $tagTVITEM & ";int Integral"
Global Const $tagNMTREEVIEW = $tagNMHDR & ";uint Action;uint OldMask;handle OldhItem;uint OldState;uint OldStateMask;" & _
"ptr OldText;int OldTextMax;int OldImage;int OldSelectedImage;int OldChildren;lparam OldParam;uint NewMask;handle NewhItem;" & _
"uint NewState;uint NewStateMask;ptr NewText;int NewTextMax;int NewImage;int NewSelectedImage;int NewChildren;" & _
"lparam NewParam;long PointX;long PointY"
Global Const $tagNMTVCUSTOMDRAW = $tagNMHDR & ";dword DrawStage;handle HDC;long Left;long Top;long Right;long Bottom;" & _
"dword_ptr ItemSpec;uint ItemState;lparam ItemParam;dword ClrText;dword ClrTextBk;int Level"
Global Const $tagNMTVDISPINFO = $tagNMHDR & ";" & $tagTVITEM
Global Const $tagNMTVGETINFOTIP = $tagNMHDR & ";ptr Text;int TextMax;handle hItem;lparam lParam"
Global Const $tagTVHITTESTINFO = $tagPOINT & ";uint Flags;handle Item"
Global Const $tagNMTVKEYDOWN = $tagNMHDR & ";word VKey;uint Flags"
Global Const $tagNMMOUSE = $tagNMHDR & ";dword_ptr ItemSpec;dword_ptr ItemData;" & $tagPOINT & ";lparam HitInfo"
Global Const $tagTOKEN_PRIVILEGES = "dword Count;int64 LUID;dword Attributes"
Global Const $tagIMAGEINFO = "handle hBitmap;handle hMask;int Unused1;int Unused2;" & $tagRECT
Global Const $tagMENUINFO = "dword Size;INT Mask;dword Style;uint YMax;handle hBack;dword ContextHelpID;ulong_ptr MenuData"
Global Const $tagMENUITEMINFO = "uint Size;uint Mask;uint Type;uint State;uint ID;handle SubMenu;handle BmpChecked;handle BmpUnchecked;" & _
"ulong_ptr ItemData;ptr TypeData;uint CCH;handle BmpItem"
Global Const $tagREBARBANDINFO = "uint cbSize;uint fMask;uint fStyle;dword clrFore;dword clrBack;ptr lpText;uint cch;" & _
"int iImage;hwnd hwndChild;uint cxMinChild;uint cyMinChild;uint cx;handle hbmBack;uint wID;uint cyChild;uint cyMaxChild;" & _
"uint cyIntegral;uint cxIdeal;lparam lParam;uint cxHeader"
Global Const $tagNMREBARAUTOBREAK = $tagNMHDR & ";uint uBand;uint wID;lparam lParam;uint uMsg;uint fStyleCurrent;bool fAutoBreak"
Global Const $tagNMRBAUTOSIZE = $tagNMHDR & ";bool fChanged;long TargetLeft;long TargetTop;long TargetRight;long TargetBottom;" & _
"long ActualLeft;long ActualTop;long ActualRight;long ActualBottom"
Global Const $tagNMREBAR = $tagNMHDR & ";dword dwMask;uint uBand;uint fStyle;uint wID;laram lParam"
Global Const $tagNMREBARCHEVRON = $tagNMHDR & ";uint uBand;uint wID;lparam lParam;" & $tagRECT & ";lparam lParamNM"
Global Const $tagNMREBARCHILDSIZE = $tagNMHDR & ";uint uBand;uint wID;long CLeft;long CTop;long CRight;long CBottom;" & _
"long BLeft;long BTop;long BRight;long BBottom"
Global Const $tagCOLORSCHEME = "dword Size;dword BtnHighlight;dword BtnShadow"
Global Const $tagNMTOOLBAR = $tagNMHDR & ";int iItem;" & _
"int iBitmap;int idCommand;byte fsState;byte fsStyle;align;dword_ptr dwData;int_ptr iString" & _
";int cchText;ptr pszText;" & $tagRECT
Global Const $tagNMTBHOTITEM = $tagNMHDR & ";int idOld;int idNew;dword dwFlags"
Global Const $tagTBBUTTON = "int Bitmap;int Command;byte State;byte Style;align;dword_ptr Param;int_ptr String"
Global Const $tagTBBUTTONINFO = "uint Size;dword Mask;int Command;int Image;byte State;byte Style;word CX;dword_ptr Param;ptr Text;int TextMax"
Global Const $tagNETRESOURCE = "dword Scope;dword Type;dword DisplayType;dword Usage;ptr LocalName;ptr RemoteName;ptr Comment;ptr Provider"
Global Const $tagOVERLAPPED = "ulong_ptr Internal;ulong_ptr InternalHigh;dword Offset;dword OffsetHigh;handle hEvent"
Global Const $tagOPENFILENAME = "dword StructSize;hwnd hwndOwner;handle hInstance;ptr lpstrFilter;ptr lpstrCustomFilter;" & _
"dword nMaxCustFilter;dword nFilterIndex;ptr lpstrFile;dword nMaxFile;ptr lpstrFileTitle;dword nMaxFileTitle;" & _
"ptr lpstrInitialDir;ptr lpstrTitle;dword Flags;word nFileOffset;word nFileExtension;ptr lpstrDefExt;lparam lCustData;" & _
"ptr lpfnHook;ptr lpTemplateName;ptr pvReserved;dword dwReserved;dword FlagsEx"
Global Const $tagBITMAPINFO = "dword Size;long Width;long Height;word Planes;word BitCount;dword Compression;dword SizeImage;" & _
"long XPelsPerMeter;long YPelsPerMeter;dword ClrUsed;dword ClrImportant;dword RGBQuad"
Global Const $tagBLENDFUNCTION = "byte Op;byte Flags;byte Alpha;byte Format"
Global Const $tagGUID = "dword Data1;word Data2;word Data3;byte Data4[8]"
Global Const $tagWINDOWPLACEMENT = "uint length; uint flags;uint showCmd;long ptMinPosition[2];long ptMaxPosition[2];long rcNormalPosition[4]"
Global Const $tagWINDOWPOS = "hwnd hWnd;hwnd InsertAfter;int X;int Y;int CX;int CY;uint Flags"
Global Const $tagSCROLLINFO = "uint cbSize;uint fMask;int  nMin;int  nMax;uint nPage;int  nPos;int  nTrackPos"
Global Const $tagSCROLLBARINFO = "dword cbSize;" & $tagRECT & ";int dxyLineButton;int xyThumbTop;" & _
"int xyThumbBottom;int reserved;dword rgstate[6]"
Global Const $tagLOGFONT = "long Height;long Width;long Escapement;long Orientation;long Weight;byte Italic;byte Underline;" & _
"byte Strikeout;byte CharSet;byte OutPrecision;byte ClipPrecision;byte Quality;byte PitchAndFamily;wchar FaceName[32]"
Global Const $tagKBDLLHOOKSTRUCT = "dword vkCode;dword scanCode;dword flags;dword time;ulong_ptr dwExtraInfo"
Global Const $tagPROCESS_INFORMATION = "handle hProcess;handle hThread;dword ProcessID;dword ThreadID"
Global Const $tagSTARTUPINFO = "dword Size;ptr Reserved1;ptr Desktop;ptr Title;dword X;dword Y;dword XSize;dword YSize;dword XCountChars;" & _
"dword YCountChars;dword FillAttribute;dword Flags;word ShowWindow;word Reserved2;ptr Reserved3;handle StdInput;" & _
"handle StdOutput;handle StdError"
Global Const $tagSECURITY_ATTRIBUTES = "dword Length;ptr Descriptor;bool InheritHandle"
Global Const $tagWIN32_FIND_DATA = "dword dwFileAttributes; dword ftCreationTime[2]; dword ftLastAccessTime[2]; dword ftLastWriteTime[2]; dword nFileSizeHigh; dword nFileSizeLow; dword dwReserved0; dword dwReserved1; wchar cFileName[260]; wchar cAlternateFileName[14]"
Func _WinAPI_GetLastError($curErr=@error, $curExt=@extended)
Local $aResult = DllCall("kernel32.dll", "dword", "GetLastError")
Return SetError($curErr, $curExt, $aResult[0])
EndFunc
Global Const $__MISCCONSTANT_CC_ANYCOLOR = 0x0100
Global Const $__MISCCONSTANT_CC_FULLOPEN = 0x0002
Global Const $__MISCCONSTANT_CC_RGBINIT = 0x0001
Global Const $tagCHOOSECOLOR = "dword Size;hwnd hWndOwnder;handle hInstance;dword rgbResult;ptr CustColors;dword Flags;lparam lCustData;" & _
"ptr lpfnHook;ptr lpTemplateName"
Global Const $tagCHOOSEFONT = "dword Size;hwnd hWndOwner;handle hDC;ptr LogFont;int PointSize;dword Flags;dword rgbColors;lparam CustData;" & _
"ptr fnHook;ptr TemplateName;handle hInstance;ptr szStyle;word FontType;int SizeMin;int SizeMax"
Func _Iif($fTest, $vTrueVal, $vFalseVal)
If $fTest Then
Return $vTrueVal
Else
Return $vFalseVal
EndIf
EndFunc
Global Const $FC_NOOVERWRITE = 0
Global Const $FC_OVERWRITE = 1
Global Const $FT_MODIFIED = 0
Global Const $FT_CREATED = 1
Global Const $FT_ACCESSED = 2
Global Const $FO_READ = 0
Global Const $FO_APPEND = 1
Global Const $FO_OVERWRITE = 2
Global Const $FO_BINARY = 16
Global Const $FO_UNICODE = 32
Global Const $FO_UTF16_LE = 32
Global Const $FO_UTF16_BE = 64
Global Const $FO_UTF8 = 128
Global Const $FO_UTF8_NOBOM = 256
Global Const $EOF = -1
Global Const $FD_FILEMUSTEXIST = 1
Global Const $FD_PATHMUSTEXIST = 2
Global Const $FD_MULTISELECT = 4
Global Const $FD_PROMPTCREATENEW = 8
Global Const $FD_PROMPTOVERWRITE = 16
Global Const $CREATE_NEW = 1
Global Const $CREATE_ALWAYS = 2
Global Const $OPEN_EXISTING = 3
Global Const $OPEN_ALWAYS = 4
Global Const $TRUNCATE_EXISTING = 5
Global Const $INVALID_SET_FILE_POINTER = -1
Global Const $FILE_BEGIN = 0
Global Const $FILE_CURRENT = 1
Global Const $FILE_END = 2
Global Const $FILE_ATTRIBUTE_READONLY = 0x00000001
Global Const $FILE_ATTRIBUTE_HIDDEN = 0x00000002
Global Const $FILE_ATTRIBUTE_SYSTEM = 0x00000004
Global Const $FILE_ATTRIBUTE_DIRECTORY = 0x00000010
Global Const $FILE_ATTRIBUTE_ARCHIVE = 0x00000020
Global Const $FILE_ATTRIBUTE_DEVICE = 0x00000040
Global Const $FILE_ATTRIBUTE_NORMAL = 0x00000080
Global Const $FILE_ATTRIBUTE_TEMPORARY = 0x00000100
Global Const $FILE_ATTRIBUTE_SPARSE_FILE = 0x00000200
Global Const $FILE_ATTRIBUTE_REPARSE_POINT = 0x00000400
Global Const $FILE_ATTRIBUTE_COMPRESSED = 0x00000800
Global Const $FILE_ATTRIBUTE_OFFLINE = 0x00001000
Global Const $FILE_ATTRIBUTE_NOT_CONTENT_INDEXED = 0x00002000
Global Const $FILE_ATTRIBUTE_ENCRYPTED = 0x00004000
Global Const $FILE_SHARE_READ = 0x00000001
Global Const $FILE_SHARE_WRITE = 0x00000002
Global Const $FILE_SHARE_DELETE = 0x00000004
Global Const $GENERIC_ALL = 0x10000000
Global Const $GENERIC_EXECUTE = 0x20000000
Global Const $GENERIC_WRITE = 0x40000000
Global Const $GENERIC_READ = 0x80000000
Global Const $GMEM_FIXED = 0x0000
Global Const $GMEM_MOVEABLE = 0x0002
Global Const $GMEM_NOCOMPACT = 0x0010
Global Const $GMEM_NODISCARD = 0x0020
Global Const $GMEM_ZEROINIT = 0x0040
Global Const $GMEM_MODIFY = 0x0080
Global Const $GMEM_DISCARDABLE = 0x0100
Global Const $GMEM_NOT_BANKED = 0x1000
Global Const $GMEM_SHARE = 0x2000
Global Const $GMEM_DDESHARE = 0x2000
Global Const $GMEM_NOTIFY = 0x4000
Global Const $GMEM_LOWER = 0x1000
Global Const $GMEM_VALID_FLAGS = 0x7F72
Global Const $GMEM_INVALID_HANDLE = 0x8000
Global Const $GPTR = $GMEM_FIXED + $GMEM_ZEROINIT
Global Const $GHND = $GMEM_MOVEABLE + $GMEM_ZEROINIT
Global Const $MEM_COMMIT = 0x00001000
Global Const $MEM_RESERVE = 0x00002000
Global Const $MEM_TOP_DOWN = 0x00100000
Global Const $MEM_SHARED = 0x08000000
Global Const $PAGE_NOACCESS = 0x00000001
Global Const $PAGE_READONLY = 0x00000002
Global Const $PAGE_READWRITE = 0x00000004
Global Const $PAGE_EXECUTE = 0x00000010
Global Const $PAGE_EXECUTE_READ = 0x00000020
Global Const $PAGE_EXECUTE_READWRITE = 0x00000040
Global Const $PAGE_GUARD = 0x00000100
Global Const $PAGE_NOCACHE = 0x00000200
Global Const $MEM_DECOMMIT = 0x00004000
Global Const $MEM_RELEASE = 0x00008000
Global Const $PROCESS_TERMINATE = 0x00000001
Global Const $PROCESS_CREATE_THREAD = 0x00000002
Global Const $PROCESS_SET_SESSIONID = 0x00000004
Global Const $PROCESS_VM_OPERATION = 0x00000008
Global Const $PROCESS_VM_READ = 0x00000010
Global Const $PROCESS_VM_WRITE = 0x00000020
Global Const $PROCESS_DUP_HANDLE = 0x00000040
Global Const $PROCESS_CREATE_PROCESS = 0x00000080
Global Const $PROCESS_SET_QUOTA = 0x00000100
Global Const $PROCESS_SET_INFORMATION = 0x00000200
Global Const $PROCESS_QUERY_INFORMATION = 0x00000400
Global Const $PROCESS_SUSPEND_RESUME = 0x00000800
Global Const $PROCESS_ALL_ACCESS = 0x001F0FFF
Global Const $ERROR_NO_TOKEN = 1008
Global Const $SE_ASSIGNPRIMARYTOKEN_NAME = "SeAssignPrimaryTokenPrivilege"
Global Const $SE_AUDIT_NAME = "SeAuditPrivilege"
Global Const $SE_BACKUP_NAME = "SeBackupPrivilege"
Global Const $SE_CHANGE_NOTIFY_NAME = "SeChangeNotifyPrivilege"
Global Const $SE_CREATE_GLOBAL_NAME = "SeCreateGlobalPrivilege"
Global Const $SE_CREATE_PAGEFILE_NAME = "SeCreatePagefilePrivilege"
Global Const $SE_CREATE_PERMANENT_NAME = "SeCreatePermanentPrivilege"
Global Const $SE_CREATE_TOKEN_NAME = "SeCreateTokenPrivilege"
Global Const $SE_DEBUG_NAME = "SeDebugPrivilege"
Global Const $SE_ENABLE_DELEGATION_NAME = "SeEnableDelegationPrivilege"
Global Const $SE_IMPERSONATE_NAME = "SeImpersonatePrivilege"
Global Const $SE_INC_BASE_PRIORITY_NAME = "SeIncreaseBasePriorityPrivilege"
Global Const $SE_INCREASE_QUOTA_NAME = "SeIncreaseQuotaPrivilege"
Global Const $SE_LOAD_DRIVER_NAME = "SeLoadDriverPrivilege"
Global Const $SE_LOCK_MEMORY_NAME = "SeLockMemoryPrivilege"
Global Const $SE_MACHINE_ACCOUNT_NAME = "SeMachineAccountPrivilege"
Global Const $SE_MANAGE_VOLUME_NAME = "SeManageVolumePrivilege"
Global Const $SE_PROF_SINGLE_PROCESS_NAME = "SeProfileSingleProcessPrivilege"
Global Const $SE_REMOTE_SHUTDOWN_NAME = "SeRemoteShutdownPrivilege"
Global Const $SE_RESTORE_NAME = "SeRestorePrivilege"
Global Const $SE_SECURITY_NAME = "SeSecurityPrivilege"
Global Const $SE_SHUTDOWN_NAME = "SeShutdownPrivilege"
Global Const $SE_SYNC_AGENT_NAME = "SeSyncAgentPrivilege"
Global Const $SE_SYSTEM_ENVIRONMENT_NAME = "SeSystemEnvironmentPrivilege"
Global Const $SE_SYSTEM_PROFILE_NAME = "SeSystemProfilePrivilege"
Global Const $SE_SYSTEMTIME_NAME = "SeSystemtimePrivilege"
Global Const $SE_TAKE_OWNERSHIP_NAME = "SeTakeOwnershipPrivilege"
Global Const $SE_TCB_NAME = "SeTcbPrivilege"
Global Const $SE_UNSOLICITED_INPUT_NAME = "SeUnsolicitedInputPrivilege"
Global Const $SE_UNDOCK_NAME = "SeUndockPrivilege"
Global Const $SE_PRIVILEGE_ENABLED_BY_DEFAULT = 0x00000001
Global Const $SE_PRIVILEGE_ENABLED = 0x00000002
Global Const $SE_PRIVILEGE_REMOVED = 0x00000004
Global Const $SE_PRIVILEGE_USED_FOR_ACCESS = 0x80000000
Global Const $TOKENUSER = 1
Global Const $TOKENGROUPS = 2
Global Const $TOKENPRIVILEGES = 3
Global Const $TOKENOWNER = 4
Global Const $TOKENPRIMARYGROUP = 5
Global Const $TOKENDEFAULTDACL = 6
Global Const $TOKENSOURCE = 7
Global Const $TOKENTYPE = 8
Global Const $TOKENIMPERSONATIONLEVEL = 9
Global Const $TOKENSTATISTICS = 10
Global Const $TOKENRESTRICTEDSIDS = 11
Global Const $TOKENSESSIONID = 12
Global Const $TOKENGROUPSANDPRIVILEGES = 13
Global Const $TOKENSESSIONREFERENCE = 14
Global Const $TOKENSANDBOXINERT = 15
Global Const $TOKENAUDITPOLICY = 16
Global Const $TOKENORIGIN = 17
Global Const $TOKENELEVATIONTYPE = 18
Global Const $TOKENLINKEDTOKEN = 19
Global Const $TOKENELEVATION = 20
Global Const $TOKENHASRESTRICTIONS = 21
Global Const $TOKENACCESSINFORMATION = 22
Global Const $TOKENVIRTUALIZATIONALLOWED = 23
Global Const $TOKENVIRTUALIZATIONENABLED = 24
Global Const $TOKENINTEGRITYLEVEL = 25
Global Const $TOKENUIACCESS = 26
Global Const $TOKENMANDATORYPOLICY = 27
Global Const $TOKENLOGONSID = 28
Global Const $TOKEN_ASSIGN_PRIMARY = 0x00000001
Global Const $TOKEN_DUPLICATE = 0x00000002
Global Const $TOKEN_IMPERSONATE = 0x00000004
Global Const $TOKEN_QUERY = 0x00000008
Global Const $TOKEN_QUERY_SOURCE = 0x00000010
Global Const $TOKEN_ADJUST_PRIVILEGES = 0x00000020
Global Const $TOKEN_ADJUST_GROUPS = 0x00000040
Global Const $TOKEN_ADJUST_DEFAULT = 0x00000080
Global Const $TOKEN_ADJUST_SESSIONID = 0x00000100
Global Const $tagMEMMAP = "handle hProc;ulong_ptr Size;ptr Mem"
Func _SendMessage($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lresult")
Local $aResult = DllCall("user32.dll", $sReturnType, "SendMessageW", "hwnd", $hWnd, "uint", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
If @error Then Return SetError(@error, @extended, "")
If $iReturn >= 0 And $iReturn <= 4 Then Return $aResult[$iReturn]
Return $aResult
EndFunc
Global $__gaInProcess_WinAPI[64][2] = [[0, 0]]
Global $__gaWinList_WinAPI[64][2] = [[0, 0]]
Global Const $__WINAPICONSTANT_WM_SETFONT = 0x0030
Global Const $__WINAPICONSTANT_FW_NORMAL = 400
Global Const $__WINAPICONSTANT_DEFAULT_CHARSET = 1
Global Const $__WINAPICONSTANT_OUT_DEFAULT_PRECIS = 0
Global Const $__WINAPICONSTANT_CLIP_DEFAULT_PRECIS = 0
Global Const $__WINAPICONSTANT_DEFAULT_QUALITY = 0
Global Const $__WINAPICONSTANT_FORMAT_MESSAGE_ALLOCATE_BUFFER = 0x100
Global Const $__WINAPICONSTANT_FORMAT_MESSAGE_FROM_SYSTEM = 0x1000
Global Const $__WINAPICONSTANT_LOGPIXELSX = 88
Global Const $__WINAPICONSTANT_LOGPIXELSY = 90
Global Const $HGDI_ERROR = Ptr(-1)
Global Const $INVALID_HANDLE_VALUE = Ptr(-1)
Global Const $CLR_INVALID = -1
Global Const $__WINAPICONSTANT_FLASHW_CAPTION = 0x00000001
Global Const $__WINAPICONSTANT_FLASHW_TRAY = 0x00000002
Global Const $__WINAPICONSTANT_FLASHW_TIMER = 0x00000004
Global Const $__WINAPICONSTANT_FLASHW_TIMERNOFG = 0x0000000C
Global Const $__WINAPICONSTANT_GW_HWNDNEXT = 2
Global Const $__WINAPICONSTANT_GW_CHILD = 5
Global Const $__WINAPICONSTANT_DI_MASK = 0x0001
Global Const $__WINAPICONSTANT_DI_IMAGE = 0x0002
Global Const $__WINAPICONSTANT_DI_NORMAL = 0x0003
Global Const $__WINAPICONSTANT_DI_COMPAT = 0x0004
Global Const $__WINAPICONSTANT_DI_DEFAULTSIZE = 0x0008
Global Const $__WINAPICONSTANT_DI_NOMIRROR = 0x0010
Global Const $__WINAPICONSTANT_DISPLAY_DEVICE_ATTACHED_TO_DESKTOP = 0x00000001
Global Const $__WINAPICONSTANT_DISPLAY_DEVICE_PRIMARY_DEVICE = 0x00000004
Global Const $__WINAPICONSTANT_DISPLAY_DEVICE_MIRRORING_DRIVER = 0x00000008
Global Const $__WINAPICONSTANT_DISPLAY_DEVICE_VGA_COMPATIBLE = 0x00000010
Global Const $__WINAPICONSTANT_DISPLAY_DEVICE_REMOVABLE = 0x00000020
Global Const $__WINAPICONSTANT_DISPLAY_DEVICE_MODESPRUNED = 0x08000000
Global Const $NULL_BRUSH = 5
Global Const $NULL_PEN = 8
Global Const $BLACK_BRUSH = 4
Global Const $DKGRAY_BRUSH = 3
Global Const $DC_BRUSH = 18
Global Const $GRAY_BRUSH = 2
Global Const $HOLLOW_BRUSH = $NULL_BRUSH
Global Const $LTGRAY_BRUSH = 1
Global Const $WHITE_BRUSH = 0
Global Const $BLACK_PEN = 7
Global Const $DC_PEN = 19
Global Const $WHITE_PEN = 6
Global Const $ANSI_FIXED_FONT = 11
Global Const $ANSI_VAR_FONT = 12
Global Const $DEVICE_DEFAULT_FONT = 14
Global Const $DEFAULT_GUI_FONT = 17
Global Const $OEM_FIXED_FONT = 10
Global Const $SYSTEM_FONT = 13
Global Const $SYSTEM_FIXED_FONT = 16
Global Const $DEFAULT_PALETTE = 15
Global Const $MB_PRECOMPOSED = 0x01
Global Const $MB_COMPOSITE = 0x02
Global Const $MB_USEGLYPHCHARS = 0x04
Global Const $ULW_ALPHA = 0x02
Global Const $ULW_COLORKEY = 0x01
Global Const $ULW_OPAQUE = 0x04
Global Const $WH_CALLWNDPROC = 4
Global Const $WH_CALLWNDPROCRET = 12
Global Const $WH_CBT = 5
Global Const $WH_DEBUG = 9
Global Const $WH_FOREGROUNDIDLE = 11
Global Const $WH_GETMESSAGE = 3
Global Const $WH_JOURNALPLAYBACK = 1
Global Const $WH_JOURNALRECORD = 0
Global Const $WH_KEYBOARD = 2
Global Const $WH_KEYBOARD_LL = 13
Global Const $WH_MOUSE = 7
Global Const $WH_MOUSE_LL = 14
Global Const $WH_MSGFILTER = -1
Global Const $WH_SHELL = 10
Global Const $WH_SYSMSGFILTER = 6
Global Const $WPF_ASYNCWINDOWPLACEMENT = 0x04
Global Const $WPF_RESTORETOMAXIMIZED = 0x02
Global Const $WPF_SETMINPOSITION = 0x01
Global Const $KF_EXTENDED = 0x0100
Global Const $KF_ALTDOWN = 0x2000
Global Const $KF_UP = 0x8000
Global Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 8)
Global Const $LLKHF_INJECTED = 0x10
Global Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 8)
Global Const $LLKHF_UP = BitShift($KF_UP, 8)
Global Const $OFN_ALLOWMULTISELECT = 0x00000200
Global Const $OFN_CREATEPROMPT = 0x00002000
Global Const $OFN_DONTADDTORECENT = 0x02000000
Global Const $OFN_ENABLEHOOK = 0x00000020
Global Const $OFN_ENABLEINCLUDENOTIFY = 0x00400000
Global Const $OFN_ENABLESIZING = 0x00800000
Global Const $OFN_ENABLETEMPLATE = 0x00000040
Global Const $OFN_ENABLETEMPLATEHANDLE = 0x00000080
Global Const $OFN_EXPLORER = 0x00080000
Global Const $OFN_EXTENSIONDIFFERENT = 0x00000400
Global Const $OFN_FILEMUSTEXIST = 0x00001000
Global Const $OFN_FORCESHOWHIDDEN = 0x10000000
Global Const $OFN_HIDEREADONLY = 0x00000004
Global Const $OFN_LONGNAMES = 0x00200000
Global Const $OFN_NOCHANGEDIR = 0x00000008
Global Const $OFN_NODEREFERENCELINKS = 0x00100000
Global Const $OFN_NOLONGNAMES = 0x00040000
Global Const $OFN_NONETWORKBUTTON = 0x00020000
Global Const $OFN_NOREADONLYRETURN = 0x00008000
Global Const $OFN_NOTESTFILECREATE = 0x00010000
Global Const $OFN_NOVALIDATE = 0x00000100
Global Const $OFN_OVERWRITEPROMPT = 0x00000002
Global Const $OFN_PATHMUSTEXIST = 0x00000800
Global Const $OFN_READONLY = 0x00000001
Global Const $OFN_SHAREAWARE = 0x00004000
Global Const $OFN_SHOWHELP = 0x00000010
Global Const $OFN_EX_NOPLACESBAR = 0x00000001
Global Const $tagCURSORINFO = "dword Size;dword Flags;handle hCursor;" & $tagPOINT
Global Const $tagDISPLAY_DEVICE = "dword Size;wchar Name[32];wchar String[128];dword Flags;wchar ID[128];wchar Key[128]"
Global Const $tagFLASHWINFO = "uint Size;hwnd hWnd;dword Flags;uint Count;dword TimeOut"
Global Const $tagICONINFO = "bool Icon;dword XHotSpot;dword YHotSpot;handle hMask;handle hColor"
Global Const $tagMEMORYSTATUSEX = "dword Length;dword MemoryLoad;" & _
"uint64 TotalPhys;uint64 AvailPhys;uint64 TotalPageFile;uint64 AvailPageFile;" & _
"uint64 TotalVirtual;uint64 AvailVirtual;uint64 AvailExtendedVirtual"
Func _WinAPI_GetClassName($hWnd)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Local $aResult = DllCall("user32.dll", "int", "GetClassNameW", "hwnd", $hWnd, "wstr", "", "int", 4096)
If @error Then Return SetError(@error, @extended, False)
Return SetExtended($aResult[0], $aResult[2])
EndFunc
Func _WinAPI_IsClassName($hWnd, $sClassName)
Local $sSeparator = Opt("GUIDataSeparatorChar")
Local $aClassName = StringSplit($sClassName, $sSeparator)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Local $sClassCheck = _WinAPI_GetClassName($hWnd)
For $x = 1 To UBound($aClassName) - 1
If StringUpper(StringMid($sClassCheck, 1, StringLen($aClassName[$x]))) = StringUpper($aClassName[$x]) Then Return True
Next
Return False
EndFunc
Global $__ghWinInet_FTP = -1
Global $__ghCallback_FTP, $__gbCallback_Set = False
Global Const $INTERNET_OPEN_TYPE_DIRECT = 1
Global Const $INTERNET_OPEN_TYPE_PRECONFIG = 0
Global Const $INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY = 4
Global Const $INTERNET_OPEN_TYPE_PROXY = 3
Global Const $FTP_TRANSFER_TYPE_UNKNOWN = 0
Global Const $FTP_TRANSFER_TYPE_ASCII = 1
Global Const $FTP_TRANSFER_TYPE_BINARY = 2
Global Const $INTERNET_FLAG_PASSIVE = 0x08000000
Global Const $INTERNET_FLAG_TRANSFER_ASCII = $FTP_TRANSFER_TYPE_ASCII
Global Const $INTERNET_FLAG_TRANSFER_BINARY = $FTP_TRANSFER_TYPE_BINARY
Global Const $INTERNET_DEFAULT_FTP_PORT = 21
Global Const $INTERNET_SERVICE_FTP = 1
Global Const $INTERNET_FLAG_HYPERLINK = 0x00000400
Global Const $INTERNET_FLAG_NEED_FILE = 0x00000010
Global Const $INTERNET_FLAG_NO_CACHE_WRITE = 0x04000000
Global Const $INTERNET_FLAG_RELOAD = 0x80000000
Global Const $INTERNET_FLAG_RESYNCHRONIZE = 0x00000800
Global Const $INTERNET_FLAG_ASYNC = 0x10000000
Global Const $INTERNET_FLAG_FROM_CACHE = 0x01000000
Global Const $INTERNET_FLAG_OFFLINE = $INTERNET_FLAG_FROM_CACHE
Global Const $INTERNET_STATUS_CLOSING_CONNECTION = 50
Global Const $INTERNET_STATUS_CONNECTION_CLOSED = 51
Global Const $INTERNET_STATUS_CONNECTING_TO_SERVER = 20
Global Const $INTERNET_STATUS_CONNECTED_TO_SERVER = 21
Global Const $INTERNET_STATUS_CTL_RESPONSE_RECEIVED = 42
Global Const $INTERNET_STATUS_INTERMEDIATE_RESPONSE = 120
Global Const $INTERNET_STATUS_PREFETCH = 43
Global Const $INTERNET_STATUS_REDIRECT = 110
Global Const $INTERNET_STATUS_REQUEST_COMPLETE = 100
Global Const $INTERNET_STATUS_HANDLE_CREATED = 60
Global Const $INTERNET_STATUS_HANDLE_CLOSING = 70
Global Const $INTERNET_STATUS_SENDING_REQUEST = 30
Global Const $INTERNET_STATUS_REQUEST_SENT = 31
Global Const $INTERNET_STATUS_RECEIVING_RESPONSE = 40
Global Const $INTERNET_STATUS_RESPONSE_RECEIVED = 41
Global Const $INTERNET_STATUS_STATE_CHANGE = 200
Global Const $INTERNET_STATUS_RESOLVING_NAME = 10
Global Const $INTERNET_STATUS_NAME_RESOLVED = 11
Func _FTP_Close($l_InternetSession)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Local $ai_InternetCloseHandle = DllCall($__ghWinInet_FTP, 'bool', 'InternetCloseHandle', 'handle', $l_InternetSession)
If @error Or $ai_InternetCloseHandle[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError(), 0)
If $__gbCallback_Set = True Then DllCallbackFree($__ghCallback_FTP)
Return $ai_InternetCloseHandle[0]
EndFunc
Func _FTP_Connect($l_InternetSession, $s_ServerName, $s_Username, $s_Password, $i_Passive = 0, $i_ServerPort = 0, $l_Service = $INTERNET_SERVICE_FTP, $l_Flags = 0, $l_Context = 0)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
If $i_Passive == 1 Then $l_Flags = BitOR($l_Flags, $INTERNET_FLAG_PASSIVE)
Local $ai_InternetConnect = DllCall($__ghWinInet_FTP, 'hwnd', 'InternetConnectW', 'handle', $l_InternetSession, 'wstr', $s_ServerName, 'ushort', $i_ServerPort, 'wstr', $s_Username, 'wstr', $s_Password, 'dword', $l_Service, 'dword', $l_Flags, 'dword_ptr', $l_Context)
If @error Or $ai_InternetConnect[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError() ,0)
Return $ai_InternetConnect[0]
EndFunc
Func _FTP_FileGet($l_FTPSession, $s_RemoteFile, $s_LocalFile, $fFailIfExists = False, $dwFlagsAndAttributes = 0, $l_Flags = $FTP_TRANSFER_TYPE_UNKNOWN, $l_Context = 0)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Local $ai_FTPGetFile = DllCall($__ghWinInet_FTP, 'bool', 'FtpGetFileW', 'handle', $l_FTPSession, 'wstr', $s_RemoteFile, 'wstr', $s_LocalFile, 'bool', $fFailIfExists, 'dword', $dwFlagsAndAttributes, 'dword', $l_Flags, 'dword_ptr', $l_Context)
If @error Or $ai_FTPGetFile[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError(), 0)
Return $ai_FTPGetFile[0]
EndFunc
Func _FTP_FilePut($l_FTPSession, $s_LocalFile, $s_RemoteFile, $l_Flags = 0, $l_Context = 0)
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Local $ai_FTPPutFile = DllCall($__ghWinInet_FTP, 'bool', 'FtpPutFileW', 'handle', $l_FTPSession, 'wstr', $s_LocalFile, 'wstr', $s_RemoteFile, 'dword', $l_Flags, 'dword_ptr', $l_Context)
If @error Or $ai_FTPPutFile[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError() ,0)
Return $ai_FTPPutFile[0]
EndFunc
Func _FTP_Open($s_Agent, $l_AccessType = $INTERNET_OPEN_TYPE_DIRECT, $s_ProxyName = '', $s_ProxyBypass = '', $l_Flags = 0)
If $__ghWinInet_FTP = -1 Then __FTP_Init()
Local $ai_InternetOpen = DllCall($__ghWinInet_FTP, 'handle', 'InternetOpenW', 'wstr', $s_Agent, 'dword', $l_AccessType, _
'wstr', $s_ProxyName, 'wstr', $s_ProxyBypass, 'dword', $l_Flags)
If @error Or $ai_InternetOpen[0] = 0 Then Return SetError(-1, _WinAPI_GetLastError(), 0)
Return $ai_InternetOpen[0]
EndFunc
Func _FTP_ProgressUpload($l_FTPSession, $s_LocalFile, $s_RemoteFile, $FunctionToCall = "")
If $__ghWinInet_FTP = -1 Then Return SetError(-2, 0, 0)
Local $ai_InternetCloseHandle, $glen, $last, $x, $parts, $buffer, $ai_ftpwrite, $result, $out, $i, $ret
Local $ai_ftpopenfile = DllCall($__ghWinInet_FTP, 'handle', 'FtpOpenFileW', 'handle', $l_FTPSession, 'wstr', $s_RemoteFile, 'dword', $GENERIC_WRITE, 'dword', $FTP_TRANSFER_TYPE_BINARY, 'dword_ptr', 0)
If @error Or $ai_ftpopenfile[0] = 0 Then Return SetError(-3, _WinAPI_GetLastError(), 0)
If $FunctionToCall = "" Then ProgressOn("FTP Upload", "Uploading " & $s_LocalFile)
Local $fhandle = FileOpen($s_LocalFile, 16)
$glen = FileGetSize($s_LocalFile)
$last = Mod($glen, 100)
$x =($glen - $last) / 100
If $x = 0 Then
$x = $last
$parts = 1
ElseIf $last > 0 Then
$parts = 101
Else
$parts = 100
EndIf
If $x < $last Then
$buffer = DllStructCreate("byte[" & $last & "]")
Else
$buffer = DllStructCreate("byte[" & $x & "]")
EndIf
For $i = 1 To $parts
Select
Case $i = 101 And $last > 0
$x = $last
EndSelect
DllStructSetData($buffer, 1, FileRead($fhandle, $x))
$ai_ftpwrite = DllCall($__ghWinInet_FTP, 'bool', 'InternetWriteFile', 'handle', $ai_ftpopenfile[0], 'ptr', DllStructGetPtr($buffer), 'dword', $x, 'dword*', $out)
If @error Or $ai_ftpwrite[0] = 0 Then
Local $lasterror = _WinAPI_GetLastError()
$ai_InternetCloseHandle = DllCall($__ghWinInet_FTP, 'bool', 'InternetCloseHandle', 'handle', $ai_ftpopenfile[0])
FileClose($fhandle)
Return SetError(-4, $lasterror, 0)
EndIf
If $FunctionToCall == "" Then
ProgressSet($i)
Else
Select
Case $parts = 1
$result = 100
Case $i = 101
$result = 100
Case Else
$result = $i
EndSelect
$ret = Call($FunctionToCall, $result)
If $ret <= 0 Then
$ai_InternetCloseHandle = DllCall($__ghWinInet_FTP, 'bool', 'InternetCloseHandle', 'handle', $ai_ftpopenfile[0])
DllCall($__ghWinInet_FTP, 'bool', 'FtpDeleteFileW', 'handle', $l_FTPSession, 'wstr', $s_RemoteFile)
FileClose($fhandle)
Return SetError(-6, 0, $ret)
EndIf
EndiF
Sleep(10)
Next
FileClose($fhandle)
If $FunctionToCall = "" Then ProgressOff()
$ai_InternetCloseHandle = DllCall($__ghWinInet_FTP, 'bool', 'InternetCloseHandle', 'handle', $ai_ftpopenfile[0])
If @error Or $ai_InternetCloseHandle[0] = 0 Then Return SetError(-5, 0, 0)
Return 1
EndFunc
Func __FTP_Init()
$__ghWinInet_FTP = DllOpen('wininet.dll')
EndFunc
Global Const $TVS_HASBUTTONS = 0x00000001
Global Const $TVS_HASLINES = 0x00000002
Global Const $TVS_LINESATROOT = 0x00000004
Global Const $TVS_EDITLABELS = 0x00000008
Global Const $TVS_DISABLEDRAGDROP = 0x00000010
Global Const $TVS_SHOWSELALWAYS = 0x00000020
Global Const $TVS_RTLREADING = 0x00000040
Global Const $TVS_NOTOOLTIPS = 0x00000080
Global Const $TVS_CHECKBOXES = 0x00000100
Global Const $TVS_TRACKSELECT = 0x00000200
Global Const $TVS_SINGLEEXPAND = 0x00000400
Global Const $TVS_INFOTIP = 0x00000800
Global Const $TVS_FULLROWSELECT = 0x00001000
Global Const $TVS_NOSCROLL = 0x00002000
Global Const $TVS_NONEVENHEIGHT = 0x00004000
Global Const $TVS_NOHSCROLL = 0x00008000
Global Const $TVS_DEFAULT = 0x00000037
Global Const $GUI_SS_DEFAULT_TREEVIEW = BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS)
Global Const $TVE_COLLAPSE = 0x0001
Global Const $TVE_EXPAND = 0x0002
Global Const $TVE_TOGGLE = 0x0003
Global Const $TVE_EXPANDPARTIAL = 0x4000
Global Const $TVE_COLLAPSERESET = 0x8000
Global Const $TVGN_ROOT = 0x00000000
Global Const $TVGN_NEXT = 0x00000001
Global Const $TVGN_PREVIOUS = 0x00000002
Global Const $TVGN_PARENT = 0x00000003
Global Const $TVGN_CHILD = 0x00000004
Global Const $TVGN_FIRSTVISIBLE = 0x00000005
Global Const $TVGN_NEXTVISIBLE = 0x00000006
Global Const $TVGN_PREVIOUSVISIBLE = 0x00000007
Global Const $TVGN_DROPHILITE = 0x00000008
Global Const $TVGN_CARET = 0x00000009
Global Const $TVGN_LASTVISIBLE = 0x0000000A
Global Const $TVHT_NOWHERE = 0x00000001
Global Const $TVHT_ONITEMICON = 0x00000002
Global Const $TVHT_ONITEMLABEL = 0x00000004
Global Const $TVHT_ONITEMINDENT = 0x00000008
Global Const $TVHT_ONITEMBUTTON = 0x00000010
Global Const $TVHT_ONITEMRIGHT = 0x00000020
Global Const $TVHT_ONITEMSTATEICON = 0x00000040
Global Const $TVHT_ONITEM = 0x00000046
Global Const $TVHT_ABOVE = 0x00000100
Global Const $TVHT_BELOW = 0x00000200
Global Const $TVHT_TORIGHT = 0x00000400
Global Const $TVHT_TOLEFT = 0x00000800
Global Const $TVI_ROOT = 0xFFFF0000
Global Const $TVI_FIRST = 0xFFFF0001
Global Const $TVI_LAST = 0xFFFF0002
Global Const $TVI_SORT = 0xFFFF0003
Global Const $TVIF_TEXT = 0x00000001
Global Const $TVIF_IMAGE = 0x00000002
Global Const $TVIF_PARAM = 0x00000004
Global Const $TVIF_STATE = 0x00000008
Global Const $TVIF_HANDLE = 0x00000010
Global Const $TVIF_SELECTEDIMAGE = 0x00000020
Global Const $TVIF_CHILDREN = 0x00000040
Global Const $TVIF_INTEGRAL = 0x00000080
Global Const $TVIF_DI_SETITEM = 0x00001000
Global Const $TVSIL_NORMAL = 0
Global Const $TVSIL_STATE = 2
Global Const $TVC_BYKEYBOARD = 0x2
Global Const $TVC_BYMOUSE = 0x1
Global Const $TVC_UNKNOWN = 0x0
Global Const $TVIS_FOCUSED = 0x00000001
Global Const $TVIS_SELECTED = 0x00000002
Global Const $TVIS_CUT = 0x00000004
Global Const $TVIS_DROPHILITED = 0x00000008
Global Const $TVIS_BOLD = 0x00000010
Global Const $TVIS_EXPANDED = 0x00000020
Global Const $TVIS_EXPANDEDONCE = 0x00000040
Global Const $TVIS_EXPANDPARTIAL = 0x00000080
Global Const $TVIS_OVERLAYMASK = 0x00000F00
Global Const $TVIS_STATEIMAGEMASK = 0x0000F000
Global Const $TVIS_USERMASK = 0x0000F000
Global Const $TVIS_UNCHECKED = 4096
Global Const $TVIS_CHECKED = 8192
Global Const $TVNA_ADD = 1
Global Const $TVNA_ADDFIRST = 2
Global Const $TVNA_ADDCHILD = 3
Global Const $TVNA_ADDCHILDFIRST = 4
Global Const $TVNA_INSERT = 5
Global Const $TVTA_ADDFIRST = 1
Global Const $TVTA_ADD = 2
Global Const $TVTA_INSERT = 3
Global Const $TV_FIRST = 0x1100
Global Const $TVM_INSERTITEMA = $TV_FIRST + 0
Global Const $TVM_DELETEITEM = $TV_FIRST + 1
Global Const $TVM_EXPAND = $TV_FIRST + 2
Global Const $TVM_GETITEMRECT = $TV_FIRST + 4
Global Const $TVM_GETCOUNT = $TV_FIRST + 5
Global Const $TVM_GETINDENT = $TV_FIRST + 6
Global Const $TVM_SETINDENT = $TV_FIRST + 7
Global Const $TVM_GETIMAGELIST = $TV_FIRST + 8
Global Const $TVM_SETIMAGELIST = $TV_FIRST + 9
Global Const $TVM_GETNEXTITEM = $TV_FIRST + 10
Global Const $TVM_SELECTITEM = $TV_FIRST + 11
Global Const $TVM_GETITEMA = $TV_FIRST + 12
Global Const $TVM_SETITEMA = $TV_FIRST + 13
Global Const $TVM_EDITLABELA = $TV_FIRST + 14
Global Const $TVM_GETEDITCONTROL = $TV_FIRST + 15
Global Const $TVM_GETVISIBLECOUNT = $TV_FIRST + 16
Global Const $TVM_HITTEST = $TV_FIRST + 17
Global Const $TVM_CREATEDRAGIMAGE = $TV_FIRST + 18
Global Const $TVM_SORTCHILDREN = $TV_FIRST + 19
Global Const $TVM_ENSUREVISIBLE = $TV_FIRST + 20
Global Const $TVM_SORTCHILDRENCB = $TV_FIRST + 21
Global Const $TVM_ENDEDITLABELNOW = $TV_FIRST + 22
Global Const $TVM_GETISEARCHSTRINGA = $TV_FIRST + 23
Global Const $TVM_SETTOOLTIPS = $TV_FIRST + 24
Global Const $TVM_GETTOOLTIPS = $TV_FIRST + 25
Global Const $TVM_SETINSERTMARK = $TV_FIRST + 26
Global Const $TVM_SETITEMHEIGHT = $TV_FIRST + 27
Global Const $TVM_GETITEMHEIGHT = $TV_FIRST + 28
Global Const $TVM_SETBKCOLOR = $TV_FIRST + 29
Global Const $TVM_SETTEXTCOLOR = $TV_FIRST + 30
Global Const $TVM_GETBKCOLOR = $TV_FIRST + 31
Global Const $TVM_GETTEXTCOLOR = $TV_FIRST + 32
Global Const $TVM_SETSCROLLTIME = $TV_FIRST + 33
Global Const $TVM_GETSCROLLTIME = $TV_FIRST + 34
Global Const $TVM_SETINSERTMARKCOLOR = $TV_FIRST + 37
Global Const $TVM_GETINSERTMARKCOLOR = $TV_FIRST + 38
Global Const $TVM_GETITEMSTATE = $TV_FIRST + 39
Global Const $TVM_SETLINECOLOR = $TV_FIRST + 40
Global Const $TVM_GETLINECOLOR = $TV_FIRST + 41
Global Const $TVM_MAPACCIDTOHTREEITEM = $TV_FIRST + 42
Global Const $TVM_MAPHTREEITEMTOACCID = $TV_FIRST + 43
Global Const $TVM_INSERTITEMW = $TV_FIRST + 50
Global Const $TVM_GETITEMW = $TV_FIRST + 62
Global Const $TVM_SETITEMW = $TV_FIRST + 63
Global Const $TVM_GETISEARCHSTRINGW = $TV_FIRST + 64
Global Const $TVM_EDITLABELW = $TV_FIRST + 65
Global Const $TVM_GETUNICODEFORMAT = 0x2000 + 6
Global Const $TVM_SETUNICODEFORMAT = 0x2000 + 5
Global Const $TVN_FIRST = -400
Global Const $TVN_SELCHANGINGA = $TVN_FIRST - 1
Global Const $TVN_SELCHANGEDA = $TVN_FIRST - 2
Global Const $TVN_GETDISPINFOA = $TVN_FIRST - 3
Global Const $TVN_SETDISPINFOA = $TVN_FIRST - 4
Global Const $TVN_ITEMEXPANDINGA = $TVN_FIRST - 5
Global Const $TVN_ITEMEXPANDEDA = $TVN_FIRST - 6
Global Const $TVN_BEGINDRAGA = $TVN_FIRST - 7
Global Const $TVN_BEGINRDRAGA = $TVN_FIRST - 8
Global Const $TVN_DELETEITEMA = $TVN_FIRST - 9
Global Const $TVN_BEGINLABELEDITA = $TVN_FIRST - 10
Global Const $TVN_ENDLABELEDITA = $TVN_FIRST - 11
Global Const $TVN_KEYDOWN = $TVN_FIRST - 12
Global Const $TVN_GETINFOTIPA = $TVN_FIRST - 13
Global Const $TVN_GETINFOTIPW = $TVN_FIRST - 14
Global Const $TVN_SINGLEEXPAND = $TVN_FIRST - 15
Global Const $TVN_SELCHANGINGW = $TVN_FIRST - 50
Global Const $TVN_SELCHANGEDW = $TVN_FIRST - 51
Global Const $TVN_GETDISPINFOW = $TVN_FIRST - 52
Global Const $TVN_SETDISPINFOW = $TVN_FIRST - 53
Global Const $TVN_ITEMEXPANDINGW = $TVN_FIRST - 54
Global Const $TVN_ITEMEXPANDEDW = $TVN_FIRST - 55
Global Const $TVN_BEGINDRAGW = $TVN_FIRST - 56
Global Const $TVN_BEGINRDRAGW = $TVN_FIRST - 57
Global Const $TVN_DELETEITEMW = $TVN_FIRST - 58
Global Const $TVN_BEGINLABELEDITW = $TVN_FIRST - 59
Global Const $TVN_ENDLABELEDITW = $TVN_FIRST - 60
Global Const $E_INVALIDARG = 0x80070057
Global Const $ILC_MASK = 0x00000001
Global Const $ILC_COLOR = 0x00000000
Global Const $ILC_COLORDDB = 0x000000FE
Global Const $ILC_COLOR4 = 0x00000004
Global Const $ILC_COLOR8 = 0x00000008
Global Const $ILC_COLOR16 = 0x00000010
Global Const $ILC_COLOR24 = 0x00000018
Global Const $ILC_COLOR32 = 0x00000020
Global Const $ILC_PALETTE = 0x00000800
Global Const $ILC_MIRROR = 0x00002000
Global Const $ILC_PERITEMMIRROR = 0x00008000
Global Const $ILCF_MOVE = 0x0
Global Const $ILCF_SWAP = 0x1
Global Const $ILD_NORMAL = 0x00000000
Global Const $ILD_TRANSPARENT = 0x00000001
Global Const $ILD_BLEND25 = 0x00000002
Global Const $ILD_BLEND50 = 0x00000004
Global Const $ILD_MASK = 0x00000010
Global Const $ILD_IMAGE = 0x00000020
Global Const $ILD_ROP = 0x00000040
Global Const $ILD_OVERLAYMASK = 0x00000F00
Global Const $ILS_NORMAL = 0x00000000
Global Const $ILS_GLOW = 0x00000001
Global Const $ILS_SHADOW = 0x00000002
Global Const $ILS_SATURATE = 0x00000004
Global Const $ILS_ALPHA = 0x00000008
Global Const $COLOR_AQUA = 0x00FFFF
Global Const $COLOR_BLACK = 0x000000
Global Const $COLOR_BLUE = 0x0000FF
Global Const $COLOR_CREAM = 0xFFFBF0
Global Const $COLOR_FUCHSIA = 0xFF00FF
Global Const $COLOR_GRAY = 0x808080
Global Const $COLOR_GREEN = 0x008000
Global Const $COLOR_LIME = 0x00FF00
Global Const $COLOR_MAROON = 0x8B1C62
Global Const $COLOR_MEDBLUE = 0x0002C4
Global Const $COLOR_MEDGRAY = 0xA0A0A4
Global Const $COLOR_MONEYGREEN = 0xC0DCC0
Global Const $COLOR_NAVY = 0x000080
Global Const $COLOR_OLIVE = 0x808000
Global Const $COLOR_PURPLE = 0x800080
Global Const $COLOR_RED = 0xFF0000
Global Const $COLOR_SILVER = 0xC0C0C0
Global Const $COLOR_SKYBLUE = 0xA6CAF0
Global Const $COLOR_TEAL = 0x008080
Global Const $COLOR_WHITE = 0xFFFFFF
Global Const $COLOR_YELLOW = 0xFFFF00
Global Const $CLR_NONE = 0xFFFFFFFF
Global Const $CLR_DEFAULT = 0xFF000000
Global Const $CLR_AQUA = 0xFFFF00
Global Const $CLR_BLACK = 0x000000
Global Const $CLR_BLUE = 0xFF0000
Global Const $CLR_CREAM = 0xF0FBFF
Global Const $CLR_FUCHSIA = 0xFF00FF
Global Const $CLR_GRAY = 0x808080
Global Const $CLR_GREEN = 0x008000
Global Const $CLR_LIME = 0x00FF00
Global Const $CLR_MAROON = 0x621C8B
Global Const $CLR_MEDBLUE = 0xC40200
Global Const $CLR_MEDGRAY = 0xA4A0A0
Global Const $CLR_MONEYGREEN = 0xC0DCC0
Global Const $CLR_NAVY = 0x800000
Global Const $CLR_OLIVE = 0x008080
Global Const $CLR_PURPLE = 0x800080
Global Const $CLR_RED = 0x0000FF
Global Const $CLR_SILVER = 0xC0C0C0
Global Const $CLR_SKYBLUE = 0xF0CAA6
Global Const $CLR_TEAL = 0x808000
Global Const $CLR_WHITE = 0xFFFFFF
Global Const $CLR_YELLOW = 0x00FFFF
Global Const $CC_ANYCOLOR = 0x0100
Global Const $CC_FULLOPEN = 0x0002
Global Const $CC_RGBINIT = 0x0001
Global Const $__IMAGELISTCONSTANT_IMAGE_BITMAP = 0
Global Const $__IMAGELISTCONSTANT_LR_LOADFROMFILE = 0x0010
Global Const $_UDF_GlobalIDs_OFFSET = 2
Global Const $_UDF_GlobalID_MAX_WIN = 16
Global Const $_UDF_STARTID = 10000
Global Const $_UDF_GlobalID_MAX_IDS = 55535
Global Const $__UDFGUICONSTANT_WS_VISIBLE = 0x10000000
Global Const $__UDFGUICONSTANT_WS_CHILD = 0x40000000
Global $_UDF_GlobalIDs_Used[$_UDF_GlobalID_MAX_WIN][$_UDF_GlobalID_MAX_IDS + $_UDF_GlobalIDs_OFFSET + 1]
Func __UDF_DebugPrint($sText, $iLine = @ScriptLineNumber, $err=@error, $ext=@extended)
ConsoleWrite( _
"!===========================================================" & @CRLF & _
"+======================================================" & @CRLF & _
"-->Line(" & StringFormat("%04d", $iLine) & "):" & @TAB & $sText & @CRLF & _
"+======================================================" & @CRLF)
Return SetError($err, $ext, 1)
EndFunc
Func __UDF_ValidateClassName($hWnd, $sClassNames)
__UDF_DebugPrint("This is for debugging only, set the debug variable to false before submitting")
If _WinAPI_IsClassName($hWnd, $sClassNames) Then Return True
Local $sSeparator = Opt("GUIDataSeparatorChar")
$sClassNames = StringReplace($sClassNames, $sSeparator, ",")
__UDF_DebugPrint("Invalid Class Type(s):" & @LF & @TAB & "Expecting Type(s): " & $sClassNames & @LF & @TAB & "Received Type : " & _WinAPI_GetClassName($hWnd))
Exit
EndFunc
Global $__ghTVLastWnd
Global $Debug_TV = False
Global Const $__TREEVIEWCONSTANT_ClassName = "SysTreeView32"
Global Const $__TREEVIEWCONSTANT_WM_SETREDRAW = 0x000B
Global Const $__TREEVIEWCONSTANT_DEFAULT_GUI_FONT = 17
Global Const $tagTVINSERTSTRUCT = "handle Parent;handle InsertAfter;" & $tagTVITEM
Func _StringEncrypt($i_Encrypt, $s_EncryptText, $s_EncryptPassword, $i_EncryptLevel = 1)
If $i_Encrypt <> 0 And $i_Encrypt <> 1 Then
SetError(1, 0, '')
ElseIf $s_EncryptText = '' Or $s_EncryptPassword = '' Then
SetError(1, 0, '')
Else
If Number($i_EncryptLevel) <= 0 Or Int($i_EncryptLevel) <> $i_EncryptLevel Then $i_EncryptLevel = 1
Local $v_EncryptModified
Local $i_EncryptCountH
Local $i_EncryptCountG
Local $v_EncryptSwap
Local $av_EncryptBox[256][2]
Local $i_EncryptCountA
Local $i_EncryptCountB
Local $i_EncryptCountC
Local $i_EncryptCountD
Local $i_EncryptCountE
Local $v_EncryptCipher
Local $v_EncryptCipherBy
If $i_Encrypt = 1 Then
For $i_EncryptCountF = 0 To $i_EncryptLevel Step 1
$i_EncryptCountG = ''
$i_EncryptCountH = ''
$v_EncryptModified = ''
For $i_EncryptCountG = 1 To StringLen($s_EncryptText)
If $i_EncryptCountH = StringLen($s_EncryptPassword) Then
$i_EncryptCountH = 1
Else
$i_EncryptCountH += 1
EndIf
$v_EncryptModified = $v_EncryptModified & Chr(BitXOR(Asc(StringMid($s_EncryptText, $i_EncryptCountG, 1)), Asc(StringMid($s_EncryptPassword, $i_EncryptCountH, 1)), 255))
Next
$s_EncryptText = $v_EncryptModified
$i_EncryptCountA = ''
$i_EncryptCountB = 0
$i_EncryptCountC = ''
$i_EncryptCountD = ''
$i_EncryptCountE = ''
$v_EncryptCipherBy = ''
$v_EncryptCipher = ''
$v_EncryptSwap = ''
$av_EncryptBox = ''
Local $av_EncryptBox[256][2]
For $i_EncryptCountA = 0 To 255
$av_EncryptBox[$i_EncryptCountA][1] = Asc(StringMid($s_EncryptPassword, Mod($i_EncryptCountA, StringLen($s_EncryptPassword)) + 1, 1))
$av_EncryptBox[$i_EncryptCountA][0] = $i_EncryptCountA
Next
For $i_EncryptCountA = 0 To 255
$i_EncryptCountB = Mod(($i_EncryptCountB + $av_EncryptBox[$i_EncryptCountA][0] + $av_EncryptBox[$i_EncryptCountA][1]), 256)
$v_EncryptSwap = $av_EncryptBox[$i_EncryptCountA][0]
$av_EncryptBox[$i_EncryptCountA][0] = $av_EncryptBox[$i_EncryptCountB][0]
$av_EncryptBox[$i_EncryptCountB][0] = $v_EncryptSwap
Next
For $i_EncryptCountA = 1 To StringLen($s_EncryptText)
$i_EncryptCountC = Mod(($i_EncryptCountC + 1), 256)
$i_EncryptCountD = Mod(($i_EncryptCountD + $av_EncryptBox[$i_EncryptCountC][0]), 256)
$i_EncryptCountE = $av_EncryptBox[Mod(($av_EncryptBox[$i_EncryptCountC][0] + $av_EncryptBox[$i_EncryptCountD][0]), 256)][0]
$v_EncryptCipherBy = BitXOR(Asc(StringMid($s_EncryptText, $i_EncryptCountA, 1)), $i_EncryptCountE)
$v_EncryptCipher &= Hex($v_EncryptCipherBy, 2)
Next
$s_EncryptText = $v_EncryptCipher
Next
Else
For $i_EncryptCountF = 0 To $i_EncryptLevel Step 1
$i_EncryptCountB = 0
$i_EncryptCountC = ''
$i_EncryptCountD = ''
$i_EncryptCountE = ''
$v_EncryptCipherBy = ''
$v_EncryptCipher = ''
$v_EncryptSwap = ''
$av_EncryptBox = ''
Local $av_EncryptBox[256][2]
For $i_EncryptCountA = 0 To 255
$av_EncryptBox[$i_EncryptCountA][1] = Asc(StringMid($s_EncryptPassword, Mod($i_EncryptCountA, StringLen($s_EncryptPassword)) + 1, 1))
$av_EncryptBox[$i_EncryptCountA][0] = $i_EncryptCountA
Next
For $i_EncryptCountA = 0 To 255
$i_EncryptCountB = Mod(($i_EncryptCountB + $av_EncryptBox[$i_EncryptCountA][0] + $av_EncryptBox[$i_EncryptCountA][1]), 256)
$v_EncryptSwap = $av_EncryptBox[$i_EncryptCountA][0]
$av_EncryptBox[$i_EncryptCountA][0] = $av_EncryptBox[$i_EncryptCountB][0]
$av_EncryptBox[$i_EncryptCountB][0] = $v_EncryptSwap
Next
For $i_EncryptCountA = 1 To StringLen($s_EncryptText) Step 2
$i_EncryptCountC = Mod(($i_EncryptCountC + 1), 256)
$i_EncryptCountD = Mod(($i_EncryptCountD + $av_EncryptBox[$i_EncryptCountC][0]), 256)
$i_EncryptCountE = $av_EncryptBox[Mod(($av_EncryptBox[$i_EncryptCountC][0] + $av_EncryptBox[$i_EncryptCountD][0]), 256)][0]
$v_EncryptCipherBy = BitXOR(Dec(StringMid($s_EncryptText, $i_EncryptCountA, 2)), $i_EncryptCountE)
$v_EncryptCipher = $v_EncryptCipher & Chr($v_EncryptCipherBy)
Next
$s_EncryptText = $v_EncryptCipher
$i_EncryptCountG = ''
$i_EncryptCountH = ''
$v_EncryptModified = ''
For $i_EncryptCountG = 1 To StringLen($s_EncryptText)
If $i_EncryptCountH = StringLen($s_EncryptPassword) Then
$i_EncryptCountH = 1
Else
$i_EncryptCountH += 1
EndIf
$v_EncryptModified &= Chr(BitXOR(Asc(StringMid($s_EncryptText, $i_EncryptCountG, 1)), Asc(StringMid($s_EncryptPassword, $i_EncryptCountH, 1)), 255))
Next
$s_EncryptText = $v_EncryptModified
Next
EndIf
Return $s_EncryptText
EndIf
EndFunc
Global Const $SBARS_SIZEGRIP = 0x100
Global Const $SBT_TOOLTIPS = 0x800
Global Const $SBARS_TOOLTIPS = 0x800
Global Const $SBT_SUNKEN = 0x0
Global Const $SBT_NOBORDERS = 0x100
Global Const $SBT_POPOUT = 0x200
Global Const $SBT_RTLREADING = 0x400
Global Const $SBT_NOTABPARSING = 0x800
Global Const $SBT_OWNERDRAW = 0x1000
Global Const $__STATUSBARCONSTANT_WM_USER = 0X400
Global Const $SB_GETBORDERS =($__STATUSBARCONSTANT_WM_USER + 7)
Global Const $SB_GETICON =($__STATUSBARCONSTANT_WM_USER + 20)
Global Const $SB_GETPARTS =($__STATUSBARCONSTANT_WM_USER + 6)
Global Const $SB_GETRECT =($__STATUSBARCONSTANT_WM_USER + 10)
Global Const $SB_GETTEXTA =($__STATUSBARCONSTANT_WM_USER + 2)
Global Const $SB_GETTEXTW =($__STATUSBARCONSTANT_WM_USER + 13)
Global Const $SB_GETTEXT = $SB_GETTEXTA
Global Const $SB_GETTEXTLENGTHA =($__STATUSBARCONSTANT_WM_USER + 3)
Global Const $SB_GETTEXTLENGTHW =($__STATUSBARCONSTANT_WM_USER + 12)
Global Const $SB_GETTEXTLENGTH = $SB_GETTEXTLENGTHA
Global Const $SB_GETTIPTEXTA =($__STATUSBARCONSTANT_WM_USER + 18)
Global Const $SB_GETTIPTEXTW =($__STATUSBARCONSTANT_WM_USER + 19)
Global Const $SB_GETUNICODEFORMAT = 0x2000 + 6
Global Const $SB_ISSIMPLE =($__STATUSBARCONSTANT_WM_USER + 14)
Global Const $SB_SETBKCOLOR = 0x2000 + 1
Global Const $SB_SETICON =($__STATUSBARCONSTANT_WM_USER + 15)
Global Const $SB_SETMINHEIGHT =($__STATUSBARCONSTANT_WM_USER + 8)
Global Const $SB_SETPARTS =($__STATUSBARCONSTANT_WM_USER + 4)
Global Const $SB_SETTEXTA =($__STATUSBARCONSTANT_WM_USER + 1)
Global Const $SB_SETTEXTW =($__STATUSBARCONSTANT_WM_USER + 11)
Global Const $SB_SETTEXT = $SB_SETTEXTA
Global Const $SB_SETTIPTEXTA =($__STATUSBARCONSTANT_WM_USER + 16)
Global Const $SB_SETTIPTEXTW =($__STATUSBARCONSTANT_WM_USER + 17)
Global Const $SB_SETUNICODEFORMAT = 0x2000 + 5
Global Const $SB_SIMPLE =($__STATUSBARCONSTANT_WM_USER + 9)
Global Const $SB_SIMPLEID = 0xff
Global Const $SBN_FIRST = -880
Global Const $SBN_SIMPLEMODECHANGE = $SBN_FIRST - 0
Global $__ghSBLastWnd
Global $Debug_SB = False
Global Const $__STATUSBARCONSTANT_ClassName = "msctls_statusbar32"
Global Const $__STATUSBARCONSTANT_WM_SIZE = 0x05
Global Const $__STATUSBARCONSTANT_CLR_DEFAULT = 0xFF000000
Global Const $tagBORDERS = "int BX;int BY;int RX"
Global $_ghEditLastWnd
Global $Debug_Ed = False
Global Const $__EDITCONSTANT_ClassName = "Edit"
Global Const $__EDITCONSTANT_GUI_CHECKED = 1
Global Const $__EDITCONSTANT_GUI_HIDE = 32
Global Const $__EDITCONSTANT_GUI_EVENT_CLOSE = -3
Global Const $__EDITCONSTANT_GUI_ENABLE = 64
Global Const $__EDITCONSTANT_GUI_DISABLE = 128
Global Const $__EDITCONSTANT_SS_CENTER = 1
Global Const $__EDITCONSTANT_WM_SETREDRAW = 0x000B
Global Const $__EDITCONSTANT_WS_CAPTION = 0x00C00000
Global Const $__EDITCONSTANT_WS_POPUP = 0x80000000
Global Const $__EDITCONSTANT_WS_TABSTOP = 0x00010000
Global Const $__EDITCONSTANT_WS_SYSMENU = 0x00080000
Global Const $__EDITCONSTANT_WS_MINIMIZEBOX = 0x00020000
Global Const $__EDITCONSTANT_DEFAULT_GUI_FONT = 17
Global Const $__EDITCONSTANT_WM_SETFONT = 0x0030
Global Const $__EDITCONSTANT_WM_GETTEXTLENGTH = 0x000E
Global Const $__EDITCONSTANT_WM_GETTEXT = 0x000D
Global Const $__EDITCONSTANT_WM_SETTEXT = 0x000C
Global Const $__EDITCONSTANT_SB_LINEUP = 0
Global Const $__EDITCONSTANT_SB_LINEDOWN = 1
Global Const $__EDITCONSTANT_SB_PAGEDOWN = 3
Global Const $__EDITCONSTANT_SB_PAGEUP = 2
Global Const $__EDITCONSTANT_SB_SCROLLCARET = 4
Global Const $tagEDITBALLOONTIP = "dword Size;ptr Title;ptr Text;int Icon"
Func _GUICtrlEdit_SetPasswordChar($hWnd, $cDisplayChar = "0")
If $Debug_Ed Then __UDF_ValidateClassName($hWnd, $__EDITCONSTANT_ClassName)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
$cDisplayChar = StringLeft($cDisplayChar, 1)
If Asc($cDisplayChar) = 48 Then
_SendMessage($hWnd, $EM_SETPASSWORDCHAR)
Else
_SendMessage($hWnd, $EM_SETPASSWORDCHAR, Asc($cDisplayChar))
EndIf
EndFunc
AutoItSetOption("GUICloseOnESC", 1)
AutoItSetOption("GUIOnEventMode", 1)
AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("TrayOnEventMode", 1)
FileChangeDir(@ScriptDir)
If @Compiled = 0 Then FileChangeDir("..")
If 1 = 0 Then Callback(0)
Global $HKCU = "HKCU" & _Iif(@OSArch <> "x86", "64", "")
Global $User = RegRead($HKCU & "\Software\XPtsp\Updater", "Username")
Global $Pass = RegRead($HKCU & "\Software\XPtsp\Updater", "Password")
If $Pass <> "" And $User <> "" Then $Pass = _StringEncrypt(0, $Pass, $User, 2)
Global $tmp = @WorkingDir & "\temp"
DirCreate($tmp)
Global $TITLE = "XPtsp Theme Uploader"
Global $CABLITE = DllOpen("Programs\CABLITE.DLL")
If $CABLITE = -1 Then MsgBox(0, "", "Problem opening CABLITE.DLL")
Global $THEME = RegRead($HKCU & "\SOFTWARE\XPtsp\Settings", "Theme")
If @error Then $THEME = "Green"
Global $GUI, $Pat[60], $res, $FTP, $MAX = 0, $NUM = 0, $T1, $T2
While 1
If InetGet("http://www.xptsp.com/XPtsp/Version.php", $tmp & "\Version.ini", 1 + 4) > 0 Then ExitLoop
If MsgBox(0x2015, $TITLE, "Unable to download ""Version.ini"" file from the server!" & @CRLF & @CRLF & "Uploader requires access to the Internet in " & _
"order to function." & @CRLF & "Please connect to the Internet so that Uploader can connect.", 0, $GUI) = 2 Then Exit
WEnd
GUISetState(@SW_DISABLE)
$GUI = GUICreate($TITLE, 500, 360)
GUICtrlCreateGroup("", 0, 314, 500, 1)
GUISetFont(9, 400)
GUISetOnEvent($GUI_EVENT_CLOSE, "CancelAnyPage")
GUICtrlCreatePic(@WorkingDir & "\Pics\Logo.jpg", 0, 0, 96, 314)
GUISetFont(9, 400)
GUICtrlCreateTab(106, 10, 380, 295)
$Pat[0] = GUICtrlCreateTabItem("Settings")
GUICtrlCreateGroup("FTP Login Credentials:", 120, 40, 350, 80)
GUICtrlSetFont(-1, -1, 800)
GUICtrlCreateLabel("Username: ", 120, 65, 100, 20, $SS_RIGHT)
$Pat[5] = GUICtrlCreateEdit($User, 220, 60, 240, 20, 0)
GUICtrlCreateLabel("Password: ", 120, 95, 100, 20, $SS_RIGHT)
$Pat[6] = GUICtrlCreateEdit($Pass, 220, 90, 240, 20, $ES_PASSWORD)
_GUICtrlEdit_SetPasswordChar(-1, "*")
GUICtrlCreateGroup("Folder Settings:", 120, 130, 350, 160)
GUICtrlSetFont(-1, -1, 800)
GUICtrlCreateLabel("Updating Theme:", 130, 150, 110, 20)
$Pat[4] = GUICtrlCreateCombo("", 240, 145, 220, 20, $CBS_DROPDOWNLIST)
Dim $INI = IniReadSection($tmp & "\Version.ini", "Themes_v3")
If @error = 0 Then
For $i = 1 To $INI[0][0]
GUICtrlSetData($Pat[4], $INI[$i][0])
Next
EndIf
GUICtrlSetData($Pat[4], IniRead($res & "\Version.ini", "Theme", "Name", $INI[1][0]))
GUICtrlCreateLabel("XPtsp Resource Folder to process:", 130, 180, 330, 20)
$Pat[1] = GUICtrlCreateEdit($res, 130, 200, 330, 20, 0)
$Pat[2] = GUICtrlCreateCheckbox("Store Compressed Update Files here:", 130, 230, 330, 20)
$Pat[3] = GUICtrlCreateEdit("", 130, 250, 330, 20, 0)
GUICtrlSetState(-1, $GUI_DISABLE)
$Pat[10] = GUICtrlCreateTabItem("Progress")
$Pat[11] = GUICtrlCreateTreeView(120, 40, 350, 220, BitOR($TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS), $WS_EX_STATICEDGE)
$Pat[12] = GUICtrlCreateProgress(120, 270, 350, 20, $PBS_SMOOTH)
GUICtrlCreateTabItem("")
$Pat[30] = GUICtrlCreateButton("Start", 320, 325, 80, 25)
GUICtrlSetOnEvent(-1, "Process")
GUICtrlSetState(-1, $GUI_DEFBUTTON)
$Pat[31] = GUICtrlCreateButton("Close", 410, 325, 80, 25)
GUICtrlSetOnEvent(-1, "CancelAnyPage")
GUISetState()
While 1
Sleep(100)
WEnd
Func Process()
Local $Search, $File, $S, $T, $U = False, $A, $Con, $Path, $F, $T2, $Pack
Local $THEME = GUICtrlRead($Pat[4]), $User = GUICtrlRead($Pat[5])
$res = GUICtrlRead($Pat[1])
$FTP = _FTP_Open("XPtsp")
$A = GUICreate($TITLE, 200, 40, -1, -1, $WS_POPUPWINDOW, -1, $GUI)
GUICtrlCreateLabel("Contacting Server....", 10, 10, 180, 20, $SS_CENTER)
GUICtrlSetFont(-1, 12, 800)
GUISetState()
$Con = _FTP_Connect($FTP, "ftp.xptsp.com", $User, GUICtrlRead($Pat[6]))
GUIDelete($A)
GUISwitch($GUI)
If($Con = 0) Then
_FTP_Close($FTP)
GUICtrlSetState($Pat[5], $GUI_FOCUS)
Return MsgBox(0, $TITLE, "Invalid Username or Password!", 0, $GUI)
EndIf
RegWrite($HKCU & "\Software\XPtsp\Updater", "Username", "REG_SZ", $User)
RegWrite($HKCU & "\Software\XPtsp\Updater", "Password", "REG_SZ", _StringEncrypt(1, GUICtrlRead($Pat[6]), $User, 2))
GUICtrlSetState($Pat[10], $GUI_SHOW)
Notify("Theme Processed: " & $THEME)
Notify("================================================")
Notify("Getting Version.txt from Server")
FileDelete($tmp & "\Version.txt")
$Path = ""
If _FTP_FileGet($Con, "Updates/Version.txt", $tmp & "\Version.txt") = 0 Then
$Path = $THEME & "/"
If _FTP_FileGet($Con, $Path & "Updates/Version.txt", $tmp & "\Version.txt") = 0 Then
$Path = "public_html/xptsp.com/XPtsp/" & $Path
If _FTP_FileGet($Con, $Path & "Updates/Version.txt", $tmp & "\Version.txt") = 0 Then
_FTP_Close($FTP)
Return MsgBox(0, $TITLE, "Unable to get the Updates file information!", 0, $GUI)
EndIf
EndIf
EndIf
$S = IniRead($tmp & "\Version.txt", "Theme", "Name", "")
If $S <> IniRead($res & "\Version.ini", "Theme", "Name", "") Or $S = "" Then
_FTP_Close($FTP)
Return MsgBox(0, $TITLE, "Incorrect theme folder for selected theme!")
EndIf
Notify("")
$CABLITE = DllOpen("D:\XPtsp\Programs\CABLITE.DLL")
If $CABLITE = -1 Then Exit MsgBox(0, "", "Problem opening CABLITE.DLL")
FileChangeDir(GUICtrlRead($Pat[1]))
$Search = FileFindFirstFile("*.res")
If $Search = -1 Then Exit MsgBox(0, "Error", "No files/directories matched the search pattern")
While 1
$File = FileFindNextFile($Search)
If @error Then ExitLoop
$MAX += 1
WEnd
FileClose($Search)
$Search = FileFindFirstFile("*.res")
While 1
$File = FileFindNextFile($Search)
If @error Then ExitLoop
$NUM += 1
GUICtrlSetData($Pat[12], $NUM / $MAX * 100)
$Pack = CheckFile($File) Or CheckFile($File, "Home") Or CheckFile($File, "MCE")
$Pack = $Pack Or CheckFile($File, "X64") Or CheckFile($File, "W2K") Or CheckFile($File, "W2K3")
If $Pack = True Then
Notify("Uploading " & $File)
$A = StringReplace($File, ".res", ".7z")
$F = @WorkingDir & "\" & StringReplace($File, ".res", "")
RunWait(@ProgramFilesDir & "\7-zip\7z a -r -ms=on -mmt -mx9 """ & @WorkingDir & "\" & $A & """ """ & $F & ".res"" """ & $F & ".rc""", @WorkingDir, @SW_HIDE)
_FTP_FilePut($Con, @WorkingDir & "\" & $A, $Path & "Updates/" & $A)
FileDelete(@WorkingDir & "\" & $A)
$U = True
EndIf
Sleep(100)
WEnd
FileClose($Search)
If $U = False Then
_FTP_Close($FTP)
Return GUICtrlSetState($Pat[0], $GUI_SHOW)
EndIf
Notify("Uploading Version.txt")
_FTP_FilePut($Con, $tmp & "\Version.txt", $Path & "Updates/Version.txt", $FTP_TRANSFER_TYPE_ASCII)
Notify("")
Notify("Building Theme Package")
ProgressOff()
FileDelete(@WorkingDir & ".xptsp")
RunWait(@ProgramFilesDir & "\7-zip\7zG a -r -ms=on -mmt -mx9 """ & @WorkingDir & ".xptsp"" """ & @WorkingDir & "\*""", @WorkingDir)
Notify("Uploading Theme Package")
$S = StringMid(@WorkingDir, StringInStr(@WorkingDir, "\", 0, -1) + 1) & ".xptsp"
_FTP_ProgressUpload($Con, @WorkingDir & ".xptsp", $Path & $S, "Callback")
Notify("")
MsgBox(0, $TITLE, "Operation has been completed!", 0, $GUI)
GUICtrlSetState($Pat[10], $GUI_SHOW)
EndFunc
Func Callback($Percent)
GUICtrlSetData($Pat[12], $Percent)
Return 1
EndFunc
Func CheckFile($File, $Section = "Pro")
Local $F = @WorkingDir & "\" & _Iif($Section <> "Pro", $Section & "\", "") & $File
If FileExists($F) = 0 Then Return False
Local $T = FileGetTime($F, 0, 1), $S
Local $T2 = IniRead($tmp & "\Version.txt", $Section, StringReplace($File, ".res", ""), ",")
If StringRight($T2, 2) = ",1" Then $T2 = StringTrimRight($T2, 2)
$T2 = StringMid($T2, StringInStr($T2, ",", 0, -1) + 1)
If $T > $T2 Then
$S = MD5Hash($F) & "|" & FileGetSize($F) & "|" & $T
IniWrite("Version.ini", $Section, StringReplace($File, ".res", ""), $S)
IniWrite($tmp & "\Version.txt", $Section, StringReplace($File, ".res", ""), StringReplace($S, "|", ",") & ",1")
Return True
EndIf
Return False
EndFunc
Func Notify($Str)
Local $i = GUICtrlCreateTreeViewItem($Str, $Pat[11])
GUICtrlSetState($i, $GUI_FOCUS)
EndFunc
Func CancelAnyPage()
Exit
EndFunc
Func MD5Hash($SFile)
Local $sBuffer = DllStructCreate("char[33]")
DllCall($CABLITE, 'dword', 'MD5FileHex', 'str', $SFile, 'ptr', DllStructGetPtr($sBuffer))
Local $sHash = DllStructGetData($sBuffer, 1)
$sBuffer = 0
Return($sHash)
EndFunc
