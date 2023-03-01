

   MEMBER('KucinaSvenAppV7.clw')                           ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('KUCINASVENAPPV7002.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('KUCINASVENAPPV7001.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjePohadja PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::PHD:Record  LIKE(PHD:RECORD),THREAD
FormWindow           WINDOW('Azuriranje pohadjanja polaznika u programima astronomije...'),AT(,,287,137),FONT('Lucida Sans', |
  11,0082004Bh,,CHARSET:ANSI),RESIZE,CENTER,CURSOR('Sentinel normal.cur'),GRAY,MDI,SYSTEM, |
  WALLPAPER('gettyimages-stars.bmp')
                       BUTTON('Spremi'),AT(22,112,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Odustani'),AT(82,112,40,12),USE(?Cancel)
                       STRING(@S40),AT(139,114),USE(ActionMessage)
                       PROMPT('Broj programa:'),AT(22,12),USE(?PHD:Broj_programa:Prompt)
                       ENTRY(@n3),AT(82,13,22,10),USE(PHD:Broj_programa),RIGHT,MSG('Broj koji jedinstveno iden' & |
  'tificira neki program astronomije'),TIP('Broj koji jedinstveno identificira neki pro' & |
  'gram astronomije')
                       PROMPT('Datum pocetka:'),AT(22,36),USE(?PHD:Datum_pocetka:Prompt)
                       ENTRY(@d17),AT(82,36,45,10),USE(PHD:Datum_pocetka),MSG('Datum pocetka programa'),REQ,TIP('Datum poce' & |
  'tka programa')
                       BUTTON('...'),AT(130,36,12,12),USE(?Calendar)
                       PROMPT('Datum zavrsetka:'),AT(22,60),USE(?PHD:Datum_zavrsetka:Prompt)
                       ENTRY(@d17),AT(82,60,45,10),USE(PHD:Datum_zavrsetka),MSG('Datum zavrsetka programa astronomije'), |
  REQ,TIP('Datum zavrsetka programa astronomije')
                       BUTTON('...'),AT(130,60,12,12),USE(?Calendar:2)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

Calendar6            CalendarClass
Calendar7            CalendarClass
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'Pregled zapisa'
  OF InsertRecord
    ActionMessage = 'Unos zapisa'
  OF ChangeRecord
    ActionMessage = 'Izmjena zapisa'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjePohadja')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(PHD:Record,History::PHD:Record)
  SELF.AddHistoryField(?PHD:Broj_programa,2)
  SELF.AddHistoryField(?PHD:Datum_pocetka,3)
  SELF.AddHistoryField(?PHD:Datum_zavrsetka,4)
  SELF.AddUpdateFile(Access:POHADJA)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:POHADJA.Open                                      ! File POHADJA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:POHADJA
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('AzuriranjePohadja',FormWindow)             ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:POHADJA.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjePohadja',FormWindow)          ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  PRN:Broj_programa = PHD:Broj_programa                    ! Assign linking field value
  Access:PROGRAM_ASTRONOMIJE.Fetch(PRN:PK_ProgAstro_BrojProgAstro)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    PopisProgramaAstronomije
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    OF ?PHD:Broj_programa
      IF Access:POHADJA.TryValidateField(2)                ! Attempt to validate PHD:Broj_programa in POHADJA
        SELECT(?PHD:Broj_programa)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?PHD:Broj_programa
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?PHD:Broj_programa{PROP:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    OF ?Calendar
      ThisWindow.Update()
      Calendar6.Ask('Select a Date',PHD:Datum_pocetka)
      IF Calendar6.Response = RequestCompleted THEN
      PHD:Datum_pocetka=Calendar6.SelectedDate
      DISPLAY(?PHD:Datum_pocetka)
      END
      ThisWindow.Reset(True)
    OF ?Calendar:2
      ThisWindow.Update()
      Calendar7.Ask('Select a Date',PHD:Datum_zavrsetka)
      IF Calendar7.Response = RequestCompleted THEN
      PHD:Datum_zavrsetka=Calendar7.SelectedDate
      DISPLAY(?PHD:Datum_zavrsetka)
      END
      ThisWindow.Reset(True)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?PHD:Broj_programa
      PRN:Broj_programa = PHD:Broj_programa
      IF Access:PROGRAM_ASTRONOMIJE.TryFetch(PRN:PK_ProgAstro_BrojProgAstro)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          PHD:Broj_programa = PRN:Broj_programa
        END
      END
      ThisWindow.Reset()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjePohvalnice PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
FDB11::View:FileDrop VIEW(POLAZNIK)
                       PROJECT(PLZ:OIB_polaznika)
                       PROJECT(PLZ:Telefon)
                     END
Queue:FileDrop:1     QUEUE                            !Queue declaration for browse/combo box using ?PLZ:OIB_polaznika:2
PLZ:OIB_polaznika      LIKE(PLZ:OIB_polaznika)        !List box control field - type derived from field
PLZ:Telefon            LIKE(PLZ:Telefon)              !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::PHV:Record  LIKE(PHV:RECORD),THREAD
FormWindow           WINDOW('Azuriranje podataka o pohvalnicama...'),AT(,,577,159),FONT('Lucida Sans',11,0082004Bh, |
  ,CHARSET:DEFAULT),RESIZE,CENTER,CURSOR('Sentinel normal.cur'),GRAY,MDI,SYSTEM,WALLPAPER('gettyimage' & |
  's-stars.bmp')
                       PROMPT('Broj pohvalnice:'),AT(18,8),USE(?PHV:Broj_pohvalnice:Prompt)
                       ENTRY(@s5),AT(87,9,60,10),USE(PHV:Broj_pohvalnice),MSG('Broj koji identificira pohvalni' & |
  'cu polaznika'),REQ,TIP('Broj koji identificira pohvalnicu polaznika')
                       PROMPT('Datum primitka:'),AT(18,28),USE(?PHV:Datum_primitka:Prompt)
                       ENTRY(@D6),AT(87,28,60,10),USE(PHV:Datum_primitka),MSG('Datum primitka pohvalnice'),REQ,TIP('Datum prim' & |
  'itka pohvalnice')
                       BUTTON('...'),AT(150,26,12,12),USE(?Calendar)
                       OPTION('Ime programa:'),AT(18,56,124,52),USE(PHV:Ime_programa),BOXED,MSG('Naziv program' & |
  'a iz kojega je polaznik dobio pohvalnicu (samo dva)'),TIP('Naziv programa iz kojega ' & |
  'je polaznik dobio pohvalnicu (samo dva)')
                         RADIO('OSNOVNOSKOLSKI PROGRAM'),AT(22,76),USE(?PHV:Ime_programa:Radio1),VALUE('OSNOVNOSKO' & |
  'LSKI PROGRAM')
                         RADIO('TECAJ OSNOVA ASTRONOMIJE'),AT(22,88),USE(?PHV:Ime_programa:Radio2),VALUE('TECAJ OSNO' & |
  'VA ASTRONOMIJE')
                       END
                       PROMPT('Ocjena:'),AT(198,8),USE(?PHV:Ocjena:Prompt)
                       ENTRY(@n3),AT(252,8,60,10),USE(PHV:Ocjena),RIGHT,MSG('Ocjena koju je polaznik dobio iz ' & |
  'odredjenog programa astronomije'),TIP('Ocjena koju je polaznik dobio iz odredjenog p' & |
  'rograma astronomije (mora biti u rangu 1-5)')
                       PROMPT('OIB polaznika:'),AT(198,48),USE(?PHV:OIB_polaznika:Prompt)
                       LIST,AT(252,42,151,15),USE(PLZ:OIB_polaznika,,?PLZ:OIB_polaznika:2),DROP(5),FORMAT('65C|M~OIB~' & |
  '@P#{11}P@43C|M~Telefon~@s14@'),FROM(Queue:FileDrop:1)
                       STRING(@s40),AT(411,48,99),USE(PLZ:Ime_prezime_polaznika)
                       BUTTON('Spremi'),AT(5,140,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Odustani'),AT(50,140,40,12),USE(?Cancel)
                       STRING(@S40),AT(95,140),USE(ActionMessage)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

FDB11                CLASS(FileDropClass)                  ! File drop manager
Q                      &Queue:FileDrop:1              !Reference to display queue
                     END

Calendar6            CalendarClass
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'Pregled zapisa'
  OF InsertRecord
    ActionMessage = 'Unos zapisa'
  OF ChangeRecord
    ActionMessage = 'Izmjena zapisa'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjePohvalnice')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PHV:Broj_pohvalnice:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(PHV:Record,History::PHV:Record)
  SELF.AddHistoryField(?PHV:Broj_pohvalnice,1)
  SELF.AddHistoryField(?PHV:Datum_primitka,2)
  SELF.AddHistoryField(?PHV:Ime_programa,3)
  SELF.AddHistoryField(?PHV:Ocjena,4)
  SELF.AddUpdateFile(Access:POHVALNICA)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:POHVALNICA.SetOpenRelated()
  Relate:POHVALNICA.Open                                   ! File POHVALNICA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:POHVALNICA
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('AzuriranjePohvalnice',FormWindow)          ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.AddItem(ToolbarForm)
  FDB11.Init(?PLZ:OIB_polaznika:2,Queue:FileDrop:1.ViewPosition,FDB11::View:FileDrop,Queue:FileDrop:1,Relate:POLAZNIK,ThisWindow)
  FDB11.Q &= Queue:FileDrop:1
  FDB11.AddSortOrder(PLZ:PK_Polaznik_OIBpolaznika)
  FDB11.AddField(PLZ:OIB_polaznika,FDB11.Q.PLZ:OIB_polaznika) !List box control field - type derived from field
  FDB11.AddField(PLZ:Telefon,FDB11.Q.PLZ:Telefon) !List box control field - type derived from field
  FDB11.AddUpdateField(PLZ:OIB_polaznika,PHV:OIB_polaznika)
  ThisWindow.AddItem(FDB11.WindowComponent)
  FDB11.DefaultFill = 0
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:POHVALNICA.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjePohvalnice',FormWindow)       ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  PLZ:OIB_polaznika = PHV:OIB_polaznika                    ! Assign linking field value
  Access:POLAZNIK.Fetch(PLZ:PK_Polaznik_OIBpolaznika)
  PLZ:OIB_polaznika = PHV:OIB_polaznika                    ! Assign linking field value
  Access:POLAZNIK.Fetch(PLZ:PK_Polaznik_OIBpolaznika)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?Calendar
      ThisWindow.Update()
      Calendar6.Ask('Select a Date',PHV:Datum_primitka)
      IF Calendar6.Response = RequestCompleted THEN
      PHV:Datum_primitka=Calendar6.SelectedDate
      DISPLAY(?PHV:Datum_primitka)
      END
      ThisWindow.Reset(True)
    OF ?PHV:Ocjena
      IF Access:POHVALNICA.TryValidateField(4)             ! Attempt to validate PHV:Ocjena in POHVALNICA
        SELECT(?PHV:Ocjena)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?PHV:Ocjena
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?PHV:Ocjena{PROP:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Report
!!! </summary>
IspisSvihMjesta PROCEDURE 

Progress:Thermometer BYTE                                  ! 
Process:View         VIEW(MJESTO)
                       PROJECT(MJS:Naziv_mjesta)
                       PROJECT(MJS:Postanski_broj)
                     END
ReportPageNumber     LONG,AUTO
ProgressWindow       WINDOW('U tijeku...'),AT(,,142,59),DOUBLE,CENTER,GRAY,TIMER(1)
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Odustani'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

Report               REPORT,AT(1000,2000,6250,7688),PRE(RPT),PAPER(PAPER:A4),FONT('Arial',10,,FONT:regular,CHARSET:ANSI), |
  THOUS
                       HEADER,AT(1000,1000,6250,1000),USE(?Header),FONT(,,0020A5DAh),COLOR(00701919h)
                         STRING('Popis svih mjesta'),AT(604,146,2250,542),USE(?STRING1),FONT('Baskerville Old Face', |
  22)
                         STRING('Datum:'),AT(4010,375,615),USE(?ReportDatePrompt),TRN
                         STRING('<<-- Date Stamp -->'),AT(4833,375,1229),USE(?ReportDateStamp),TRN
                         STRING('Vrijeme:'),AT(4010,635,615),USE(?ReportTimePrompt),TRN
                         STRING('<<-- Time Stamp -->'),AT(4833,635,1240),USE(?ReportTimeStamp),TRN
                       END
Detail                 DETAIL,AT(0,0,6250,1854),USE(?Detail)
                         STRING(@P#####P),AT(1844,875,646),USE(MJS:Postanski_broj)
                         STRING(@s30),AT(1844,1292),USE(MJS:Naziv_mjesta)
                         STRING('Postanski broj:'),AT(604,875,1000),USE(?STRING2)
                         STRING('Naziv mjesta:'),AT(604,1292,885),USE(?STRING3)
                         IMAGE('spaceLine.jpg'),AT(31,31,6167,531),USE(?IMAGE1)
                       END
                       FOOTER,AT(1000,9688,6250,1000),USE(?Footer)
                         STRING(@N3),AT(2792,427),USE(ReportPageNumber)
                       END
                       FORM,AT(1000,1000,6250,9688),USE(?Form)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ProgressMgr          StepStringClass                       ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('IspisSvihMjesta')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:MJESTO.SetOpenRelated()
  Relate:MJESTO.Open                                       ! File MJESTO used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('IspisSvihMjesta',ProgressWindow)           ! Restore window settings from non-volatile store
  ProgressMgr.Init(ScrollSort:AllowAlpha+ScrollSort:AllowNumeric,ScrollBy:RunTime)
  ThisReport.Init(Process:View, Relate:MJESTO, ?Progress:PctText, Progress:Thermometer, ProgressMgr, MJS:Postanski_broj)
  ThisReport.CaseSensitiveValue = FALSE
  ThisReport.AddSortOrder(MJS:PK_Mjesto_PostanskiBroj)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:MJESTO.SetQuickScan(1,Propagate:OneMany)
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:MJESTO.Close
  END
  IF SELF.Opened
    INIMgr.Update('IspisSvihMjesta',ProgressWindow)        ! Save window data to non-volatile store
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportDateStamp{PROP:Text} = FORMAT(TODAY(),@D17)
  END
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportTimeStamp{PROP:Text} = FORMAT(CLOCK(),@T7)
  END
  IF ReturnValue = Level:Benign
    Report$?ReportPageNumber{PROP:PageNo} = True
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Report
!!! </summary>
IspisAstronomskogPrograma PROCEDURE 

Progress:Thermometer BYTE                                  ! 
Process:View         VIEW(PROGRAM_ASTRONOMIJE)
                       PROJECT(PRN:Broj_programa)
                       PROJECT(PRN:Cijena_Programa_s_PDV)
                       PROJECT(PRN:Dnevno_trajanje_programa)
                       PROJECT(PRN:Naziv_programa_astronomije)
                       PROJECT(PRN:Opis_programa)
                       PROJECT(PRN:Predavac)
                     END
ProgressWindow       WINDOW('U tijeku...'),AT(,,142,59),DOUBLE,CENTER,GRAY,TIMER(1)
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Odustani'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

Report               REPORT,AT(1000,2000,7688,4250),PRE(RPT),PAPER(PAPER:A4),LANDSCAPE,FONT('Arial',10,,FONT:regular, |
  CHARSET:ANSI),THOUS
                       HEADER,AT(1000,1000,7688,1000),USE(?Header),FONT(,,0020A5DAh),COLOR(00701919h)
                         STRING('O programu astronomije'),AT(2198,198,3115,458),USE(?STRING1),FONT('Baskerville Old Face', |
  22)
                       END
Detail                 DETAIL,AT(0,0,7677,4573),USE(?Detail)
                         STRING(@n3),AT(2198,125),USE(PRN:Broj_programa),LEFT
                         STRING(@s40),AT(2198,594),USE(PRN:Naziv_programa_astronomije)
                         STRING('Broj programa:'),AT(729,125),USE(?STRING2)
                         STRING('Naziv programa:'),AT(729,594),USE(?STRING3)
                         STRING('Opis programa'),AT(729,1146),USE(?STRING4)
                         STRING(@t7),AT(2198,2552),USE(PRN:Dnevno_trajanje_programa)
                         STRING(@s50),AT(2198,2979),USE(PRN:Predavac)
                         STRING(@n9.2),AT(2167,3458),USE(PRN:Cijena_Programa_s_PDV),RIGHT
                         STRING('Dnevno trajanje:'),AT(740,2552),USE(?STRING5)
                         STRING('Predavac:'),AT(729,2979),USE(?STRING6)
                         STRING('Cijena s PDV-om:'),AT(729,3458),USE(?STRING7)
                         TEXT,AT(2167,1146,4781),USE(PRN:Opis_programa,,?PRN:Opis_programa:2)
                         STRING('kn'),AT(2990,3458),USE(?STRING8)
                         STRING('h'),AT(2729,2552),USE(?STRING9)
                       END
                       FOOTER,AT(1000,6250,7688,1000),USE(?Footer)
                         IMAGE('spaceLine.jpg'),AT(1552,31,4500,917),USE(?IMAGE1)
                       END
                       FORM,AT(1000,1000,7688,6250),USE(?Form)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ProgressMgr          StepLongClass                         ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('IspisAstronomskogPrograma')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:PROGRAM_ASTRONOMIJE.Open                          ! File PROGRAM_ASTRONOMIJE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('IspisAstronomskogPrograma',ProgressWindow) ! Restore window settings from non-volatile store
  ProgressMgr.Init(ScrollSort:AllowNumeric,)
  ThisReport.Init(Process:View, Relate:PROGRAM_ASTRONOMIJE, ?Progress:PctText, Progress:Thermometer, ProgressMgr, PRN:Broj_programa)
  ThisReport.AddSortOrder(PRN:PK_ProgAstro_BrojProgAstro)
  ThisReport.AddRange(PRN:Broj_programa)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:PROGRAM_ASTRONOMIJE.SetQuickScan(1,Propagate:OneMany)
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:PROGRAM_ASTRONOMIJE.Close
  END
  IF SELF.Opened
    INIMgr.Update('IspisAstronomskogPrograma',ProgressWindow) ! Save window data to non-volatile store
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Report
!!! </summary>
IspisPohvalnicaPoPolaznicima PROCEDURE 

Progress:Thermometer BYTE                                  ! 
Process:View         VIEW(POHVALNICA)
                       PROJECT(PHV:Broj_pohvalnice)
                       PROJECT(PHV:Datum_primitka)
                       PROJECT(PHV:Ime_programa)
                       PROJECT(PHV:Ocjena)
                       PROJECT(PHV:OIB_polaznika)
                       JOIN(PLZ:PK_Polaznik_OIBpolaznika,PHV:OIB_polaznika)
                         PROJECT(PLZ:Adresa)
                         PROJECT(PLZ:Email)
                         PROJECT(PLZ:Ima_predznanje)
                         PROJECT(PLZ:Ime_prezime_polaznika)
                         PROJECT(PLZ:OIB_polaznika)
                         PROJECT(PLZ:Postanski_broj)
                         PROJECT(PLZ:Telefon)
                         JOIN(PLT:PK_Uplatnica_OIB_BrojUplatnice,PLZ:OIB_polaznika)
                           PROJECT(PLT:Broj_uplatnice)
                           PROJECT(PLT:Placanje_za_mjesec)
                         END
                       END
                     END
ProgressWindow       WINDOW('U tijeku...'),AT(,,142,59),DOUBLE,CENTER,GRAY,TIMER(1)
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Odustani'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

Report               REPORT,AT(1000,2000,6250,7688),PRE(RPT),PAPER(PAPER:A4),FONT('Arial',10,,FONT:regular,CHARSET:ANSI), |
  THOUS
                       HEADER,AT(0,1000,8271,1000),USE(?Header),FONT(,,0020A5DAh),COLOR(00701919h)
                         STRING('Popis pohvalnica po polaznicima'),AT(687,167),USE(?STRING1),FONT('Baskerville Old Face', |
  22)
                         STRING('Datum:'),AT(5521,594,667),USE(?ReportDatePrompt),TRN
                         STRING('<<-- Date Stamp -->'),AT(6250,594),USE(?ReportDateStamp),TRN
                       END
break1                 BREAK(PHV:Broj_pohvalnice),USE(?BREAK1)
break2                   BREAK(PLZ:OIB_polaznika),USE(?BREAK2)
                           HEADER,AT(-1000,0,8271,2979),USE(?GROUPHEADER1)
                             STRING(@s5),AT(5062,687),USE(PHV:Broj_pohvalnice)
                             STRING(@P###########P),AT(646,948),USE(PLZ:OIB_polaznika)
                             STRING(@s40),AT(646,1208),USE(PLZ:Ime_prezime_polaznika)
                             STRING(@s30),AT(646,1469),USE(PLZ:Adresa)
                             STRING(@s14),AT(646,1729),USE(PLZ:Telefon)
                             STRING(@s40),AT(646,1990),USE(PLZ:Email)
                             CHECK(' Ima predznanje'),AT(646,2250),USE(PLZ:Ima_predznanje),VALUE('Ima','Nema')
                             STRING(@P#####P),AT(646,2510),USE(PLZ:Postanski_broj)
                             STRING(@D6),AT(5062,948),USE(PHV:Datum_primitka)
                             STRING(@s40),AT(5073,1208,2906),USE(PHV:Ime_programa)
                             STRING(@n3),AT(5062,1469),USE(PHV:Ocjena),LEFT
                             STRING('Polaznik:'),AT(646,687,667),USE(?STRING2),FONT(,,,FONT:bold)
                             STRING('Broj pohvalnice:'),AT(3865,687),USE(?STRING3)
                             STRING('Ime programa:'),AT(3865,1208),USE(?STRING4)
                             STRING('Datum primitka:'),AT(3865,948),USE(?STRING5)
                             STRING('Ocjena:'),AT(3865,1469),USE(?STRING6)
                             IMAGE('spaceLine.jpg'),AT(-10,31,8271,458),USE(?IMAGE1)
                           END
Detail                     DETAIL,AT(-1000,0,8365,1000),USE(?Detail)
                             STRING(@s20),AT(2354,187),USE(PLT:Broj_uplatnice,,?PLT:Broj_uplatnice:3),LEFT(1)
                             STRING(@s11),AT(2354,448),USE(PLT:Placanje_za_mjesec)
                             STRING('Broj uplatnice:'),AT(687,187,969),USE(?STRING7)
                             STRING('Placanje za mjesec:'),AT(677,448,1354,250),USE(?STRING8)
                           END
                           FOOTER,AT(0,0),USE(?GROUPFOOTER1)
                           END
                         END
                         FOOTER,AT(0,0),USE(?GROUPFOOTER2)
                         END
                       END
                       FOOTER,AT(1000,9688,6250,1000),USE(?Footer)
                       END
                       FORM,AT(1000,1000,6250,9688),USE(?Form)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ProgressMgr          StepStringClass                       ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('IspisPohvalnicaPoPolaznicima')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:POHVALNICA.Open                                   ! File POHVALNICA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('IspisPohvalnicaPoPolaznicima',ProgressWindow) ! Restore window settings from non-volatile store
  ProgressMgr.Init(ScrollSort:AllowAlpha+ScrollSort:AllowNumeric,ScrollBy:RunTime)
  ThisReport.Init(Process:View, Relate:POHVALNICA, ?Progress:PctText, Progress:Thermometer, ProgressMgr, PHV:Broj_pohvalnice)
  ThisReport.CaseSensitiveValue = FALSE
  ThisReport.AddSortOrder(PHV:PK_Pohvalnica_BrojPohvalnice)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:POHVALNICA.SetQuickScan(1,Propagate:OneMany)
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:POHVALNICA.Close
  END
  IF SELF.Opened
    INIMgr.Update('IspisPohvalnicaPoPolaznicima',ProgressWindow) ! Save window data to non-volatile store
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportDateStamp{PROP:Text} = FORMAT(TODAY(),@D17)
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

