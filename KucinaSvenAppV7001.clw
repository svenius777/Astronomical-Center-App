

   MEMBER('KucinaSvenAppV7.clw')                           ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABEIP.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('BRWEXT.INC'),ONCE

                     MAP
                       INCLUDE('KUCINASVENAPPV7001.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('KUCINASVENAPPV7002.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Frame
!!! </summary>
Main PROCEDURE 

SplashProcedureThread LONG
DisplayDayString STRING('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ')
DisplayDayText   STRING(9),DIM(7),OVER(DisplayDayString)
AppFrame             APPLICATION('Sven Kucina Aplikacija'),AT(,,482,221),RESIZE,HVSCROLL,ICON('app.ico'),CURSOR('Sentinel normal.cur'), |
  MAX,STATUS(-1,80,120,45),SYSTEM,WALLPAPER('gettyimages-stars.bmp'),IMM
                       MENUBAR,USE(?MENUBAR1)
                         MENU('Datoteka'),USE(?FileMenu)
                           ITEM('Postavke ispisa...'),USE(?PrintSetup),MSG('Setup Printer'),STD(STD:PrintSetup)
                           ITEM,USE(?SEPARATOR1),SEPARATOR
                           ITEM('Izlaz'),USE(?Exit),MSG('Exit this application'),STD(STD:Close)
                         END
                         MENU('Uredi'),USE(?EditMenu)
                           ITEM('Izrezi'),USE(?Cut),MSG('Remove item to Windows Clipboard'),STD(STD:Cut)
                           ITEM('Kopiraj'),USE(?Copy),MSG('Copy item to Windows Clipboard'),STD(STD:Copy)
                           ITEM('Zaljepi'),USE(?Paste),MSG('Paste contents of Windows Clipboard'),STD(STD:Paste)
                         END
                         MENU('Popis'),USE(?MENU3)
                           ITEM('Mjesta'),USE(?PopisMjesta)
                           ITEM('Polaznika'),USE(?PopisPolaznika)
                           ITEM('Pohvalnica'),USE(?PopisPohvalnica)
                           ITEM('ProgramaAstronomije'),USE(?PopisProgramaAstronomije)
                         END
                         MENU('Prozor'),USE(?MENU1),MSG('Create and Arrange windows'),STD(STD:WindowList)
                           ITEM('Plocice'),USE(?Tile),MSG('Make all open windows visible'),STD(STD:TileWindow)
                           ITEM('Kaskadno'),USE(?Cascade),MSG('Stack all open windows'),STD(STD:CascadeWindow)
                           ITEM('Uredi ikone'),USE(?Arrange),MSG('Align all window icons'),STD(STD:ArrangeIcons)
                         END
                         MENU('Pomoc'),USE(?MENU2),MSG('Windows Help')
                           ITEM('Sadrzaj'),USE(?Helpindex),MSG('View the contents of the help file'),STD(STD:HelpIndex)
                           ITEM('Potrazi pomoc na...'),USE(?HelpSearch),MSG('Search for help on a subject'),STD(STD:HelpSearch)
                           ITEM('Kako koristiti pomoc'),USE(?HelpOnHelp),MSG('How to use Windows Help'),STD(STD:HelpOnHelp)
                         END
                         MENU('Ispis'),USE(?MENU4)
                           ITEM('svih MJESTA'),USE(?IspisSvihMjesta)
                           ITEM('svih POHVALNICA po POLAZNICIMA'),USE(?IspisPohvalnicaPoPolaznicima)
                         END
                       END
                       TOOLBAR,AT(0,0,482,32),USE(?TOOLBAR1),COLOR(0082004Bh)
                         BUTTON('Mjesto'),AT(16,10),USE(?GumbMjesto),FONT('Baskerville Old Face',12,0082004Bh,FONT:bold), |
  COLOR(0000D7FFh)
                         BUTTON('Polaznik'),AT(108,10),USE(?GumbPolaznik),FONT('Baskerville Old Face',12,0082004Bh, |
  FONT:bold),COLOR(0000D7FFh)
                         BUTTON('Program Astronomije'),AT(205,10),USE(?GumbProgramAstronomije),FONT('Baskerville Old Face', |
  12,0082004Bh,FONT:bold),COLOR(0000D7FFh)
                         BUTTON('Pohvalnica'),AT(348,10),USE(?GumbPohvalnica),FONT('Baskerville Old Face',12,0082004Bh, |
  FONT:bold),COLOR(0000D7FFh)
                       END
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
Menu::MENUBAR1 ROUTINE                                     ! Code for menu items on ?MENUBAR1
Menu::FileMenu ROUTINE                                     ! Code for menu items on ?FileMenu
Menu::EditMenu ROUTINE                                     ! Code for menu items on ?EditMenu
Menu::MENU3 ROUTINE                                        ! Code for menu items on ?MENU3
  CASE ACCEPTED()
  OF ?PopisMjesta
    START(PopisMjesta, 50000)
  OF ?PopisPolaznika
    START(PopisPolaznika, 50000)
  OF ?PopisPohvalnica
    START(PopisPohvalnica, 50000)
  OF ?PopisProgramaAstronomije
    START(PopisProgramaAstronomije, 50000)
  END
Menu::MENU1 ROUTINE                                        ! Code for menu items on ?MENU1
Menu::MENU2 ROUTINE                                        ! Code for menu items on ?MENU2
Menu::MENU4 ROUTINE                                        ! Code for menu items on ?MENU4
  CASE ACCEPTED()
  OF ?IspisSvihMjesta
    START(IspisSvihMjesta, 50000)
  OF ?IspisPohvalnicaPoPolaznicima
    START(IspisPohvalnicaPoPolaznicima, 50000)
  END

ThisWindow.Ask PROCEDURE

  CODE
  IF NOT INRANGE(AppFrame{PROP:Timer},1,100)
    AppFrame{PROP:Timer} = 100
  END
    AppFrame{Prop:StatusText,3} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D6)
    AppFrame{PROP:StatusText,4} = FORMAT(CLOCK(),@T1)
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Main')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = 1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.Open(AppFrame)                                      ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('Main',AppFrame)                            ! Restore window settings from non-volatile store
  SELF.SetAlerts()
      AppFrame{PROP:TabBarVisible}  = False
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('Main',AppFrame)                         ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
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
    CASE ACCEPTED()
    ELSE
      DO Menu::MENUBAR1                                    ! Process menu items on ?MENUBAR1 menu
      DO Menu::FileMenu                                    ! Process menu items on ?FileMenu menu
      DO Menu::EditMenu                                    ! Process menu items on ?EditMenu menu
      DO Menu::MENU3                                       ! Process menu items on ?MENU3 menu
      DO Menu::MENU1                                       ! Process menu items on ?MENU1 menu
      DO Menu::MENU2                                       ! Process menu items on ?MENU2 menu
      DO Menu::MENU4                                       ! Process menu items on ?MENU4 menu
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?GumbMjesto
      START(PopisMjesta, 50000)
    OF ?GumbPolaznik
      START(PopisPolaznika, 50000)
    OF ?GumbProgramAstronomije
      START(PopisProgramaAstronomije, 50000)
    OF ?GumbPohvalnica
      START(PopisPohvalnica, 50000)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:OpenWindow
      SplashProcedureThread = START(SkocniProzor)          ! Run the splash window procedure
    OF EVENT:Timer
      AppFrame{Prop:StatusText,3} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D6)
      AppFrame{PROP:StatusText,4} = FORMAT(CLOCK(),@T1)
    ELSE
      IF SplashProcedureThread
        IF EVENT() = Event:Accepted
          POST(Event:CloseWindow,,SplashProcedureThread)   ! Close the splash window
          SplashPRocedureThread = 0
        END
     END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Splash
!!! </summary>
SkocniProzor PROCEDURE 

window               WINDOW,AT(,,204,112),FONT('Microsoft Sans Serif',8,,FONT:regular),NOFRAME,CENTER,CURSOR('Sentinel normal.cur'), |
  GRAY,MDI
                       PANEL,AT(0,-42,204,154),USE(?PANEL1),BEVEL(6),FILL(008B0000h)
                       PANEL,AT(2,2,200,108),USE(?PANEL2),BEVEL(-2,1),FILL(00701919h)
                       IMAGE('giphy.gif'),AT(68,47,70,43),USE(?Image1)
                       STRING('Bok! Ovo je moja aplikacija za astronomski centar.'),AT(13,20,175,10),USE(?String2:2), |
  FONT(,8,0000C0C0h),CENTER,COLOR(00701919h)
                       STRING('Napravio: Sven Kucina'),AT(13,33,175,10),USE(?String1:2),FONT(,,0000C0C0h),CENTER, |
  COLOR(00701919h)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

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
  GlobalErrors.SetProcedureName('SkocniProzor')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PANEL1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.Open(window)                                        ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('SkocniProzor',window)                      ! Restore window settings from non-volatile store
  TARGET{Prop:Timer} = 1000                                ! Close window on timer event, so configure timer
  TARGET{Prop:Alrt,255} = MouseLeft                        ! Alert mouse clicks that will close window
  TARGET{Prop:Alrt,254} = MouseLeft2
  TARGET{Prop:Alrt,253} = MouseRight
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('SkocniProzor',window)                   ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:AlertKey
      CASE KEYCODE()
      OF MouseLeft
      OROF MouseLeft2
      OROF MouseRight
        POST(Event:CloseWindow)                            ! Splash window will close on mouse click
      END
    OF EVENT:LoseFocus
        POST(Event:CloseWindow)                            ! Splash window will close when focus is lost
    OF Event:Timer
      POST(Event:CloseWindow)                              ! Splash window will close on event timer
    OF Event:AlertKey
      CASE KEYCODE()                                       ! Splash window will close on mouse click
      OF MouseLeft
      OROF MouseLeft2
      OROF MouseRight
        POST(Event:CloseWindow)
      END
    ELSE
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisMjesta PROCEDURE 

BRW1::View:Browse    VIEW(MJESTO)
                       PROJECT(MJS:Postanski_broj)
                       PROJECT(MJS:Naziv_mjesta)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
MJS:Postanski_broj     LIKE(MJS:Postanski_broj)       !List box control field - type derived from field
MJS:Naziv_mjesta       LIKE(MJS:Naziv_mjesta)         !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis mjesta'),AT(0,0,281,128),FONT('Lucida Sans',11,0082004Bh,,CHARSET:DEFAULT),RESIZE, |
  CURSOR('Sentinel normal.cur'),GRAY,MDI,SYSTEM,WALLPAPER('gettyimages-stars.bmp')
                       LIST,AT(6,6,267,100),USE(?List),HVSCROLL,FORMAT('90C|M~Postanski broj~@P#####P@150C|M~N' & |
  'aziv mjesta~@s30@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(7,110,40,12),USE(?Insert)
                       BUTTON('&Izmjena'),AT(52,110,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(97,110,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(147,110,40,12),USE(?Select)
                       BUTTON('Izlaz'),AT(202,110,40,12),USE(?Close)
                     END

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
SetAlerts              PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::EIPManager     BrowseEIPManager                      ! Browse EIP Manager for Browse using ?List
EditInPlace::MJS:Postanski_broj EditEntryClass             ! Edit-in-place class for field MJS:Postanski_broj
EditInPlace::MJS:Naziv_mjesta EditEntryClass               ! Edit-in-place class for field MJS:Naziv_mjesta
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
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

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisMjesta')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:MJESTO.SetOpenRelated()
  Relate:MJESTO.Open                                       ! File MJESTO used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:MJESTO,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,MJS:PK_Mjesto_PostanskiBroj)          ! Add the sort order for MJS:PK_Mjesto_PostanskiBroj for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,MJS:Postanski_broj,1,BRW1)     ! Initialize the browse locator using  using key: MJS:PK_Mjesto_PostanskiBroj , MJS:Postanski_broj
  BRW1.AddField(MJS:Postanski_broj,BRW1.Q.MJS:Postanski_broj) ! Field MJS:Postanski_broj is a hot field or requires assignment from browse
  BRW1.AddField(MJS:Naziv_mjesta,BRW1.Q.MJS:Naziv_mjesta)  ! Field MJS:Naziv_mjesta is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('PopisMjesta',BrowseWindow)                 ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse,?List,'','',BRW1::View:Browse)
  BRW1::SortHeader.UseSortColors = False
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:MJESTO.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('PopisMjesta',BrowseWindow)              ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeMjesta
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.SetAlerts PROCEDURE

  CODE
  PARENT.SetAlerts
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.SetAlerts()


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  !Take Sort Headers Events
  IF BRW1::SortHeader.TakeEvents()
     RETURN Level:Notify
  END
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(EditInPlace::MJS:Postanski_broj,1)
  SELF.AddEditControl(EditInPlace::MJS:Naziv_mjesta,2)
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW1.SetSort PROCEDURE(BYTE NewOrder,BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.SetSort(NewOrder,Force)
  IF BRW1::LastSortOrder<>NewOrder THEN
     BRW1::SortHeader.ClearSort()
  END
  BRW1::LastSortOrder=NewOrder
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

BRW1::SortHeader.QueueResorted       PROCEDURE(STRING pString)
  CODE
    IF pString = ''
       BRW1.RestoreSort()
       BRW1.ResetSort(True)
    ELSE
       BRW1.ReplaceSort(pString,BRW1::Sort0:Locator)
       BRW1.SetLocatorFromSort()
    END
!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisPolaznika PROCEDURE 

LOC:Pretraga         STRING(20)                            ! 
BRW1::View:Browse    VIEW(POLAZNIK)
                       PROJECT(PLZ:OIB_polaznika)
                       PROJECT(PLZ:Ime_prezime_polaznika)
                       PROJECT(PLZ:Ima_predznanje)
                       PROJECT(PLZ:Postanski_broj)
                       PROJECT(PLZ:Adresa)
                       PROJECT(PLZ:Telefon)
                       PROJECT(PLZ:Email)
                       JOIN(MJS:PK_Mjesto_PostanskiBroj,PLZ:Postanski_broj)
                         PROJECT(MJS:Naziv_mjesta)
                         PROJECT(MJS:Postanski_broj)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
PLZ:OIB_polaznika      LIKE(PLZ:OIB_polaznika)        !List box control field - type derived from field
PLZ:Ime_prezime_polaznika LIKE(PLZ:Ime_prezime_polaznika) !List box control field - type derived from field
PLZ:Ima_predznanje     LIKE(PLZ:Ima_predznanje)       !List box control field - type derived from field
PLZ:Postanski_broj     LIKE(PLZ:Postanski_broj)       !List box control field - type derived from field
MJS:Naziv_mjesta       LIKE(MJS:Naziv_mjesta)         !List box control field - type derived from field
PLZ:Adresa             LIKE(PLZ:Adresa)               !List box control field - type derived from field
PLZ:Telefon            LIKE(PLZ:Telefon)              !List box control field - type derived from field
PLZ:Email              LIKE(PLZ:Email)                !List box control field - type derived from field
MJS:Postanski_broj     LIKE(MJS:Postanski_broj)       !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW6::View:Browse    VIEW(UPLATNICA)
                       PROJECT(PLT:OIB_polaznika)
                       PROJECT(PLT:Broj_uplatnice)
                       PROJECT(PLT:Placanje_za_mjesec)
                       PROJECT(PLT:Ima_karticu)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?List:2
PLT:OIB_polaznika      LIKE(PLT:OIB_polaznika)        !List box control field - type derived from field
PLT:Broj_uplatnice     LIKE(PLT:Broj_uplatnice)       !List box control field - type derived from field
PLT:Placanje_za_mjesec LIKE(PLT:Placanje_za_mjesec)   !List box control field - type derived from field
PLT:Ima_karticu        LIKE(PLT:Ima_karticu)          !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW8::View:Browse    VIEW(POHADJA)
                       PROJECT(PHD:OIB_polaznika)
                       PROJECT(PHD:Datum_pocetka)
                       PROJECT(PHD:Datum_zavrsetka)
                       PROJECT(PHD:Broj_programa)
                       JOIN(PRN:PK_ProgAstro_BrojProgAstro,PHD:Broj_programa)
                         PROJECT(PRN:Naziv_programa_astronomije)
                         PROJECT(PRN:Broj_programa)
                       END
                     END
Queue:Browse:2       QUEUE                            !Queue declaration for browse/combo box using ?List:3
PHD:OIB_polaznika      LIKE(PHD:OIB_polaznika)        !List box control field - type derived from field
PHD:Datum_pocetka      LIKE(PHD:Datum_pocetka)        !List box control field - type derived from field
PHD:Datum_zavrsetka    LIKE(PHD:Datum_zavrsetka)      !List box control field - type derived from field
PRN:Naziv_programa_astronomije LIKE(PRN:Naziv_programa_astronomije) !List box control field - type derived from field
PHD:Broj_programa      LIKE(PHD:Broj_programa)        !Primary key field - type derived from field
PRN:Broj_programa      LIKE(PRN:Broj_programa)        !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis polaznika'),AT(0,0,570,352),FONT('Lucida Sans',11,0082004Bh,,CHARSET:DEFAULT), |
  RESIZE,CURSOR('Sentinel normal.cur'),GRAY,MDI,SYSTEM,WALLPAPER('gettyimages-stars.bmp')
                       PROMPT('Pretraga:'),AT(388,13),USE(?LOC:Pretraga:Prompt)
                       ENTRY(@s20),AT(420,14,60,10),USE(LOC:Pretraga)
                       BUTTON('Trazenje'),AT(484,13,32,10),USE(?BUTTON1)
                       LIST,AT(39,28,482,102),USE(?List),HVSCROLL,FORMAT('[113C|M~OIB polaznika~@P#{11}P@160C|' & |
  'M~Ime prezime polaznika~@s40@53C|M~Ima predznanje~@s5@60C|M~Postanski broj~@P#####P@' & |
  '120C|M~Naziv mjesta~@s30@]|~OPCE INFORMACIJE~[120C|M~Adresa~@s30@56C|M~Telefon~@s14@' & |
  '160C|M~Email~@s40@]|~KONTAKT~'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(39,133,40,12),USE(?Insert)
                       BUTTON('&Izmjena'),AT(85,133,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(129,133,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(179,133,40,12),USE(?Select)
                       BUTTON('Izlaz'),AT(446,133,40,12),USE(?Close)
                       STRING('Popis uplatnica odabranog polaznika:'),AT(28,170),USE(?STRING1),FONT(,,,FONT:bold)
                       LIST,AT(28,184,316,67),USE(?List:2),HVSCROLL,FORMAT('62C|M~OIB polaznika~@P#{11}P@87C|M' & |
  '~Broj uplatnice~@s20@71C|M~Placanje za mjesec~@s11@19C|M~Ima karticu~@s5@'),FROM(Queue:Browse:1), |
  IMM
                       BUTTON('Unos'),AT(360,184,42,12),USE(?Insert:2)
                       BUTTON('Izmjena'),AT(360,208,42,12),USE(?Change:2)
                       BUTTON('Brisanje'),AT(360,234,42,12),USE(?Delete:2)
                       STRING('Podaci o pohadjanjima astronomskih programa odabranog polaznika:'),AT(28,263),USE(?STRING2), |
  FONT(,,,FONT:bold)
                       LIST,AT(28,277,316,62),USE(?List:3),HVSCROLL,FORMAT('61C|M~OIB polaznika~@P#{11}P@63C|M' & |
  '~Datum pocetka~@d17@61C|M~Datum zavrsetka~@d17@160C|M~Naziv programa astronomije~@s40@'), |
  FROM(Queue:Browse:2),IMM
                       BUTTON('Unos'),AT(360,277,42,12),USE(?Insert:3)
                       BUTTON('Izmjena'),AT(360,303,42,12),USE(?Change:3)
                       BUTTON('Brisanje'),AT(360,327,42,12),USE(?Delete:3)
                       SHEET,AT(28,14,506,140),USE(?SHEET1)
                         TAB('Po OIBu polaznika'),USE(?TAB1),FONT(,,0000D7FFh)
                         END
                         TAB('Po imenu polaznika'),USE(?TAB2),FONT(,,0000D7FFh)
                         END
                         TAB('Po postanskom broju'),USE(?TAB3),FONT(,,0000D7FFh)
                         END
                       END
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  EntryLocatorClass                     ! Default Locator
BRW1::Sort1:Locator  EntryLocatorClass                     ! Conditional Locator - CHOICE(?SHEET1)=2
BRW1::Sort2:Locator  EntryLocatorClass                     ! Conditional Locator - CHOICE(?SHEET1)=3
BRW6                 CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW6::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW8                 CLASS(BrowseClass)                    ! Browse using ?List:3
Q                      &Queue:Browse:2                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW8::Sort0:Locator  StepLocatorClass                      ! Default Locator
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
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

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisPolaznika')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?LOC:Pretraga:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:POHADJA.SetOpenRelated()
  Relate:POHADJA.Open                                      ! File POHADJA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:POLAZNIK,SELF) ! Initialize the browse manager
  BRW6.Init(?List:2,Queue:Browse:1.ViewPosition,BRW6::View:Browse,Queue:Browse:1,Relate:UPLATNICA,SELF) ! Initialize the browse manager
  BRW8.Init(?List:3,Queue:Browse:2.ViewPosition,BRW8::View:Browse,Queue:Browse:2,Relate:POHADJA,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,PLZ:SK_Polaznik_ImePrezime)           ! Add the sort order for PLZ:SK_Polaznik_ImePrezime for sort order 1
  BRW1.AddLocator(BRW1::Sort1:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort1:Locator.Init(?LOC:Pretraga,PLZ:Ime_prezime_polaznika,1,BRW1) ! Initialize the browse locator using ?LOC:Pretraga using key: PLZ:SK_Polaznik_ImePrezime , PLZ:Ime_prezime_polaznika
  BRW1.AddSortOrder(,PLZ:SK_Polaznik_PostanskiBroj)        ! Add the sort order for PLZ:SK_Polaznik_PostanskiBroj for sort order 2
  BRW1.AddLocator(BRW1::Sort2:Locator)                     ! Browse has a locator for sort order 2
  BRW1::Sort2:Locator.Init(?LOC:Pretraga,PLZ:Postanski_broj,1,BRW1) ! Initialize the browse locator using ?LOC:Pretraga using key: PLZ:SK_Polaznik_PostanskiBroj , PLZ:Postanski_broj
  BRW1.AddSortOrder(,PLZ:PK_Polaznik_OIBpolaznika)         ! Add the sort order for PLZ:PK_Polaznik_OIBpolaznika for sort order 3
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 3
  BRW1::Sort0:Locator.Init(?LOC:Pretraga,PLZ:OIB_polaznika,1,BRW1) ! Initialize the browse locator using ?LOC:Pretraga using key: PLZ:PK_Polaznik_OIBpolaznika , PLZ:OIB_polaznika
  BRW1.AddField(PLZ:OIB_polaznika,BRW1.Q.PLZ:OIB_polaznika) ! Field PLZ:OIB_polaznika is a hot field or requires assignment from browse
  BRW1.AddField(PLZ:Ime_prezime_polaznika,BRW1.Q.PLZ:Ime_prezime_polaznika) ! Field PLZ:Ime_prezime_polaznika is a hot field or requires assignment from browse
  BRW1.AddField(PLZ:Ima_predznanje,BRW1.Q.PLZ:Ima_predznanje) ! Field PLZ:Ima_predznanje is a hot field or requires assignment from browse
  BRW1.AddField(PLZ:Postanski_broj,BRW1.Q.PLZ:Postanski_broj) ! Field PLZ:Postanski_broj is a hot field or requires assignment from browse
  BRW1.AddField(MJS:Naziv_mjesta,BRW1.Q.MJS:Naziv_mjesta)  ! Field MJS:Naziv_mjesta is a hot field or requires assignment from browse
  BRW1.AddField(PLZ:Adresa,BRW1.Q.PLZ:Adresa)              ! Field PLZ:Adresa is a hot field or requires assignment from browse
  BRW1.AddField(PLZ:Telefon,BRW1.Q.PLZ:Telefon)            ! Field PLZ:Telefon is a hot field or requires assignment from browse
  BRW1.AddField(PLZ:Email,BRW1.Q.PLZ:Email)                ! Field PLZ:Email is a hot field or requires assignment from browse
  BRW1.AddField(MJS:Postanski_broj,BRW1.Q.MJS:Postanski_broj) ! Field MJS:Postanski_broj is a hot field or requires assignment from browse
  BRW6.Q &= Queue:Browse:1
  BRW6.AddSortOrder(,PLT:PK_Uplatnica_OIB_BrojUplatnice)   ! Add the sort order for PLT:PK_Uplatnica_OIB_BrojUplatnice for sort order 1
  BRW6.AddRange(PLT:OIB_polaznika,Relate:UPLATNICA,Relate:POLAZNIK) ! Add file relationship range limit for sort order 1
  BRW6.AddLocator(BRW6::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW6::Sort0:Locator.Init(,PLT:Broj_uplatnice,1,BRW6)     ! Initialize the browse locator using  using key: PLT:PK_Uplatnica_OIB_BrojUplatnice , PLT:Broj_uplatnice
  BRW6.AddField(PLT:OIB_polaznika,BRW6.Q.PLT:OIB_polaznika) ! Field PLT:OIB_polaznika is a hot field or requires assignment from browse
  BRW6.AddField(PLT:Broj_uplatnice,BRW6.Q.PLT:Broj_uplatnice) ! Field PLT:Broj_uplatnice is a hot field or requires assignment from browse
  BRW6.AddField(PLT:Placanje_za_mjesec,BRW6.Q.PLT:Placanje_za_mjesec) ! Field PLT:Placanje_za_mjesec is a hot field or requires assignment from browse
  BRW6.AddField(PLT:Ima_karticu,BRW6.Q.PLT:Ima_karticu)    ! Field PLT:Ima_karticu is a hot field or requires assignment from browse
  BRW8.Q &= Queue:Browse:2
  BRW8.AddSortOrder(,PHD:PK_Pohadja_OIB_BrojProgAstro)     ! Add the sort order for PHD:PK_Pohadja_OIB_BrojProgAstro for sort order 1
  BRW8.AddRange(PHD:OIB_polaznika,Relate:POHADJA,Relate:POLAZNIK) ! Add file relationship range limit for sort order 1
  BRW8.AddLocator(BRW8::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW8::Sort0:Locator.Init(,PHD:Broj_programa,1,BRW8)      ! Initialize the browse locator using  using key: PHD:PK_Pohadja_OIB_BrojProgAstro , PHD:Broj_programa
  BRW8.AddField(PHD:OIB_polaznika,BRW8.Q.PHD:OIB_polaznika) ! Field PHD:OIB_polaznika is a hot field or requires assignment from browse
  BRW8.AddField(PHD:Datum_pocetka,BRW8.Q.PHD:Datum_pocetka) ! Field PHD:Datum_pocetka is a hot field or requires assignment from browse
  BRW8.AddField(PHD:Datum_zavrsetka,BRW8.Q.PHD:Datum_zavrsetka) ! Field PHD:Datum_zavrsetka is a hot field or requires assignment from browse
  BRW8.AddField(PRN:Naziv_programa_astronomije,BRW8.Q.PRN:Naziv_programa_astronomije) ! Field PRN:Naziv_programa_astronomije is a hot field or requires assignment from browse
  BRW8.AddField(PHD:Broj_programa,BRW8.Q.PHD:Broj_programa) ! Field PHD:Broj_programa is a hot field or requires assignment from browse
  BRW8.AddField(PRN:Broj_programa,BRW8.Q.PRN:Broj_programa) ! Field PRN:Broj_programa is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('PopisPolaznika',BrowseWindow)              ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjePolaznika
  BRW6.AskProcedure = 2                                    ! Will call: AzuriranjeUplatnice
  BRW8.AskProcedure = 3                                    ! Will call: AzuriranjePohadja
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW6.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW8.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
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
    INIMgr.Update('PopisPolaznika',BrowseWindow)           ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      AzuriranjePolaznika
      AzuriranjeUplatnice
      AzuriranjePohadja
    END
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
    CASE ACCEPTED()
    OF ?BUTTON1
      ThisWindow.reset(1)
    END
  ReturnValue = PARENT.TakeAccepted()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW1.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?SHEET1)=2
    RETURN SELF.SetSort(1,Force)
  ELSIF CHOICE(?SHEET1)=3
    RETURN SELF.SetSort(2,Force)
  ELSE
    RETURN SELF.SetSort(3,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


BRW6.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END


BRW8.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisPohvalnica PROCEDURE 

BRW1::View:Browse    VIEW(POHVALNICA)
                       PROJECT(PHV:Broj_pohvalnice)
                       PROJECT(PHV:Datum_primitka)
                       PROJECT(PHV:Ime_programa)
                       PROJECT(PHV:Ocjena)
                       PROJECT(PHV:OIB_polaznika)
                       JOIN(PLZ:PK_Polaznik_OIBpolaznika,PHV:OIB_polaznika)
                         PROJECT(PLZ:Ime_prezime_polaznika)
                         PROJECT(PLZ:Ima_predznanje)
                         PROJECT(PLZ:OIB_polaznika)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
PHV:Broj_pohvalnice    LIKE(PHV:Broj_pohvalnice)      !List box control field - type derived from field
PHV:Datum_primitka     LIKE(PHV:Datum_primitka)       !List box control field - type derived from field
PHV:Ime_programa       LIKE(PHV:Ime_programa)         !List box control field - type derived from field
PHV:Ocjena             LIKE(PHV:Ocjena)               !List box control field - type derived from field
PHV:OIB_polaznika      LIKE(PHV:OIB_polaznika)        !List box control field - type derived from field
PLZ:Ime_prezime_polaznika LIKE(PLZ:Ime_prezime_polaznika) !List box control field - type derived from field
PLZ:Ima_predznanje     LIKE(PLZ:Ima_predznanje)       !List box control field - type derived from field
PLZ:OIB_polaznika      LIKE(PLZ:OIB_polaznika)        !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis pohvalnica'),AT(0,0,547,189),FONT('Lucida Sans',11,0082004Bh,,CHARSET:DEFAULT), |
  RESIZE,CURSOR('Sentinel normal.cur'),GRAY,MDI,SYSTEM,WALLPAPER('gettyimages-stars.bmp')
                       LIST,AT(5,5,528,150),USE(?List),HVSCROLL,FORMAT('[50C|M~Broj pohvalnice~@s5@64C|M~Datum' & |
  ' primitka~@D6@160C|M~Ime programa~@s40@35C|M~Ocjena~@n3@]|~POHVALNICA~[57C|M~OIB pol' & |
  'aznika~@P#{11}P@160C|M~Ime i prezime polaznika~@s40@50C|M~Ima predznanje~@s5@]|~POLAZNIK~'), |
  FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(6,164,40,12),USE(?Insert)
                       BUTTON('&Izmjena'),AT(51,164,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(96,164,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(146,164,40,12),USE(?Select)
                       BUTTON('Izlaz'),AT(494,164,40,12),USE(?Close)
                     END

BRW1::LastSortOrder       BYTE
BRW1::SortHeader  CLASS(SortHeaderClassType) !Declare SortHeader Class
QueueResorted          PROCEDURE(STRING pString),VIRTUAL
                  END
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
SetAlerts              PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
SetSort                PROCEDURE(BYTE NewOrder,BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
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

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisPohvalnica')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:POHVALNICA.Open                                   ! File POHVALNICA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:POHVALNICA,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,PHV:PK_Pohvalnica_BrojPohvalnice)     ! Add the sort order for PHV:PK_Pohvalnica_BrojPohvalnice for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,PHV:Broj_pohvalnice,1,BRW1)    ! Initialize the browse locator using  using key: PHV:PK_Pohvalnica_BrojPohvalnice , PHV:Broj_pohvalnice
  BRW1.AddField(PHV:Broj_pohvalnice,BRW1.Q.PHV:Broj_pohvalnice) ! Field PHV:Broj_pohvalnice is a hot field or requires assignment from browse
  BRW1.AddField(PHV:Datum_primitka,BRW1.Q.PHV:Datum_primitka) ! Field PHV:Datum_primitka is a hot field or requires assignment from browse
  BRW1.AddField(PHV:Ime_programa,BRW1.Q.PHV:Ime_programa)  ! Field PHV:Ime_programa is a hot field or requires assignment from browse
  BRW1.AddField(PHV:Ocjena,BRW1.Q.PHV:Ocjena)              ! Field PHV:Ocjena is a hot field or requires assignment from browse
  BRW1.AddField(PHV:OIB_polaznika,BRW1.Q.PHV:OIB_polaznika) ! Field PHV:OIB_polaznika is a hot field or requires assignment from browse
  BRW1.AddField(PLZ:Ime_prezime_polaznika,BRW1.Q.PLZ:Ime_prezime_polaznika) ! Field PLZ:Ime_prezime_polaznika is a hot field or requires assignment from browse
  BRW1.AddField(PLZ:Ima_predznanje,BRW1.Q.PLZ:Ima_predznanje) ! Field PLZ:Ima_predznanje is a hot field or requires assignment from browse
  BRW1.AddField(PLZ:OIB_polaznika,BRW1.Q.PLZ:OIB_polaznika) ! Field PLZ:OIB_polaznika is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('PopisPohvalnica',BrowseWindow)             ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjePohvalnice
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.Init(Queue:Browse,?List,'','',BRW1::View:Browse)
  BRW1::SortHeader.UseSortColors = False
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:POHVALNICA.Close
  !Kill the Sort Header
  BRW1::SortHeader.Kill()
  END
  IF SELF.Opened
    INIMgr.Update('PopisPohvalnica',BrowseWindow)          ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjePohvalnice
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.SetAlerts PROCEDURE

  CODE
  PARENT.SetAlerts
  !Initialize the Sort Header using the Browse Queue and Browse Control
  BRW1::SortHeader.SetAlerts()


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  !Take Sort Headers Events
  IF BRW1::SortHeader.TakeEvents()
     RETURN Level:Notify
  END
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW1.SetSort PROCEDURE(BYTE NewOrder,BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.SetSort(NewOrder,Force)
  IF BRW1::LastSortOrder<>NewOrder THEN
     BRW1::SortHeader.ClearSort()
  END
  BRW1::LastSortOrder=NewOrder
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

BRW1::SortHeader.QueueResorted       PROCEDURE(STRING pString)
  CODE
    IF pString = ''
       BRW1.RestoreSort()
       BRW1.ResetSort(True)
    ELSE
       BRW1.ReplaceSort(pString,BRW1::Sort0:Locator)
       BRW1.SetLocatorFromSort()
    END
!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PopisProgramaAstronomije PROCEDURE 

BRW1::View:Browse    VIEW(PROGRAM_ASTRONOMIJE)
                       PROJECT(PRN:Broj_programa)
                       PROJECT(PRN:Naziv_programa_astronomije)
                       PROJECT(PRN:Opis_programa)
                       PROJECT(PRN:Dnevno_trajanje_programa)
                       PROJECT(PRN:Predavac)
                       PROJECT(PRN:Cijena_programa)
                       PROJECT(PRN:Cijena_Programa_s_PDV)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
PRN:Broj_programa      LIKE(PRN:Broj_programa)        !List box control field - type derived from field
PRN:Naziv_programa_astronomije LIKE(PRN:Naziv_programa_astronomije) !List box control field - type derived from field
PRN:Opis_programa      LIKE(PRN:Opis_programa)        !List box control field - type derived from field
PRN:Dnevno_trajanje_programa LIKE(PRN:Dnevno_trajanje_programa) !List box control field - type derived from field
PRN:Predavac           LIKE(PRN:Predavac)             !List box control field - type derived from field
PRN:Cijena_programa    LIKE(PRN:Cijena_programa)      !List box control field - type derived from field
PRN:Cijena_Programa_s_PDV LIKE(PRN:Cijena_Programa_s_PDV) !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Popis programa astronomije'),AT(0,0,481,156),FONT('Lucida Sans',11,0082004Bh,,CHARSET:DEFAULT), |
  RESIZE,CURSOR('Sentinel normal.cur'),GRAY,MDI,SYSTEM,WALLPAPER('gettyimages-stars.bmp')
                       LIST,AT(5,5,460,116),USE(?List),HVSCROLL,COLUMN,FORMAT('55C|M~Broj programa~@n3@160C|M~' & |
  'Naziv programa astronomije~@s40@536C|M~Opis programa~@s200@100C|M~Dnevno trajanje pr' & |
  'ograma~@t7@200C|M~Predavac~@s50@92C|M~Cijena programa~@n7.2@75C|M~Cijena Programa s ' & |
  'PDV~@n9.2@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(6,133,40,12),USE(?Insert)
                       BUTTON('&Izmjena'),AT(50,133,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(96,133,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(146,133,40,12),USE(?Select)
                       BUTTON('Ispis astronomskog programa'),AT(231,133),USE(?Print)
                       BUTTON('Izlaz'),AT(384,133,40,12),USE(?Close)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
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

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('PopisProgramaAstronomije')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:PROGRAM_ASTRONOMIJE.Open                          ! File PROGRAM_ASTRONOMIJE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:PROGRAM_ASTRONOMIJE,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,PRN:PK_ProgAstro_BrojProgAstro)       ! Add the sort order for PRN:PK_ProgAstro_BrojProgAstro for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,PRN:Broj_programa,1,BRW1)      ! Initialize the browse locator using  using key: PRN:PK_ProgAstro_BrojProgAstro , PRN:Broj_programa
  BRW1.AddField(PRN:Broj_programa,BRW1.Q.PRN:Broj_programa) ! Field PRN:Broj_programa is a hot field or requires assignment from browse
  BRW1.AddField(PRN:Naziv_programa_astronomije,BRW1.Q.PRN:Naziv_programa_astronomije) ! Field PRN:Naziv_programa_astronomije is a hot field or requires assignment from browse
  BRW1.AddField(PRN:Opis_programa,BRW1.Q.PRN:Opis_programa) ! Field PRN:Opis_programa is a hot field or requires assignment from browse
  BRW1.AddField(PRN:Dnevno_trajanje_programa,BRW1.Q.PRN:Dnevno_trajanje_programa) ! Field PRN:Dnevno_trajanje_programa is a hot field or requires assignment from browse
  BRW1.AddField(PRN:Predavac,BRW1.Q.PRN:Predavac)          ! Field PRN:Predavac is a hot field or requires assignment from browse
  BRW1.AddField(PRN:Cijena_programa,BRW1.Q.PRN:Cijena_programa) ! Field PRN:Cijena_programa is a hot field or requires assignment from browse
  BRW1.AddField(PRN:Cijena_Programa_s_PDV,BRW1.Q.PRN:Cijena_Programa_s_PDV) ! Field PRN:Cijena_Programa_s_PDV is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('PopisProgramaAstronomije',BrowseWindow)    ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjeProgramaAstronomije
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.PrintProcedure = 2
  BRW1.PrintControl = ?Print
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
    INIMgr.Update('PopisProgramaAstronomije',BrowseWindow) ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      AzuriranjeProgramaAstronomije
      IspisAstronomskogPrograma
    END
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeMjesta PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::MJS:Record  LIKE(MJS:RECORD),THREAD
FormWindow           WINDOW('Azuriranje podataka o mjestu...'),AT(,,280,105),FONT('Lucida Sans',11,0082004Bh,,CHARSET:DEFAULT), |
  RESIZE,CENTER,CURSOR('Sentinel normal.cur'),GRAY,MDI,SYSTEM,WALLPAPER('gettyimages-stars.bmp')
                       PROMPT('Postanski broj:'),AT(22,14),USE(?MJS:Postanski_broj:Prompt)
                       ENTRY(@P#####P),AT(88,14,60,10),USE(MJS:Postanski_broj),TIP('Postanski broj je broj izm' & |
  'edju 10000 i 53000.')
                       PROMPT('Naziv mjesta:'),AT(22,34),USE(?MJS:Naziv_mjesta:Prompt)
                       ENTRY(@s30),AT(88,34,120,10),USE(MJS:Naziv_mjesta),CAP,REQ
                       BUTTON('Spremi'),AT(18,80,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Odustani'),AT(78,80,40,12),USE(?Cancel)
                       STRING(@S40),AT(143,80),USE(ActionMessage)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

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
  GlobalErrors.SetProcedureName('AzuriranjeMjesta')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?MJS:Postanski_broj:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(MJS:Record,History::MJS:Record)
  SELF.AddHistoryField(?MJS:Postanski_broj,1)
  SELF.AddHistoryField(?MJS:Naziv_mjesta,2)
  SELF.AddUpdateFile(Access:MJESTO)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:MJESTO.SetOpenRelated()
  Relate:MJESTO.Open                                       ! File MJESTO used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:MJESTO
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
  INIMgr.Fetch('AzuriranjeMjesta',FormWindow)              ! Restore window settings from non-volatile store
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
    Relate:MJESTO.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeMjesta',FormWindow)           ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


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
    OF ?MJS:Postanski_broj
      IF Access:MJESTO.TryValidateField(1)                 ! Attempt to validate MJS:Postanski_broj in MJESTO
        SELECT(?MJS:Postanski_broj)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?MJS:Postanski_broj
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?MJS:Postanski_broj{PROP:FontColor} = FieldColorQueue.OldColor
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
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeProgramaAstronomije PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::PRN:Record  LIKE(PRN:RECORD),THREAD
FormWindow           WINDOW('Azuriranje podataka o programu astronomije...'),AT(,,560,214),FONT('Lucida Sans',11, |
  0082004Bh,,CHARSET:DEFAULT),RESIZE,CENTER,CURSOR('Sentinel normal.cur'),GRAY,MDI,SYSTEM, |
  WALLPAPER('gettyimages-stars.bmp')
                       PROMPT('Broj programa:'),AT(24,12,52),USE(?PRN:Broj_programa:Prompt)
                       SPIN(@n3),AT(83,10,27,12),USE(PRN:Broj_programa,,?PRN:Broj_programa:2),MSG('Broj koji jedinstveno identificira neki program astronomije')
                       OPTION('Naziv programa astronomije:'),AT(23,32,126,94),USE(PRN:Naziv_programa_astronomije), |
  BOXED,TIP('Koji program polaznik pohadja')
                         RADIO('OSNOVNOSKOLSKI PROGRAM'),AT(29,44),USE(?PRN:Naziv_programa_astronomije:Radio1),TIP('Koji progr' & |
  'am polaznik pohadja'),VALUE('OSNOVNOSKOLSKI PROGRAM')
                         RADIO('DIGITALNI PLANETARIJ'),AT(29,57),USE(?PRN:Naziv_programa_astronomije:Radio2),TIP('Koji progr' & |
  'am polaznik pohadja'),VALUE('DIGITALNI PLANETARIJ')
                         RADIO('ZVJEZDARNICA I TELESKOP'),AT(29,70),USE(?PRN:Naziv_programa_astronomije:Radio3),TIP('Koji progr' & |
  'am polaznik pohadja'),VALUE('ZVJEZDARNICA I TELESKOP')
                         RADIO('TECAJ OSNOVA ASTRONOMIJE'),AT(29,83),USE(?PRN:Naziv_programa_astronomije:Radio4),TIP('Koji progr' & |
  'am polaznik pohadja'),VALUE('TECAJ OSNOVA ASTRONOMIJE')
                         RADIO('OBICNO PREDAVANJE'),AT(29,96),USE(?PRN:Naziv_programa_astronomije:Radio5),TIP('Koji progr' & |
  'am polaznik pohadja'),VALUE('OBICNO PREDAVANJE')
                         RADIO('HANGOUT'),AT(29,109),USE(?PRN:Naziv_programa_astronomije:Radio6),TIP('Koji progr' & |
  'am polaznik pohadja'),VALUE('HANGOUT')
                       END
                       PROMPT('Opis programa:'),AT(172,12),USE(?PRN:Opis_programa:Prompt)
                       TEXT,AT(234,13,118,84),USE(PRN:Opis_programa),HVSCROLL,MSG('Opis programa astronomije'),TIP('Opis progr' & |
  'ama astronomije')
                       PROMPT('Dnevno trajanje programa:'),AT(172,116),USE(?PRN:Dnevno_trajanje_programa:Prompt)
                       ENTRY(@t7),AT(264,116,26,10),USE(PRN:Dnevno_trajanje_programa),MSG('Dnevno trajanje pro' & |
  'grama astronomije'),REQ,TIP('Dnevno trajanje programa astronomije')
                       STRING('h'),AT(294,116,6),USE(?STRING2)
                       PROMPT('Predavac:'),AT(172,142),USE(?PRN:Predavac:Prompt)
                       ENTRY(@s50),AT(264,142,98,10),USE(PRN:Predavac),CAP,MSG('Ime i prezime predavaca koji p' & |
  'redaje program astronomije'),REQ,TIP('Ime i prezime predavaca koji predaje program a' & |
  'stronomije')
                       PROMPT('Cijena programa:'),AT(398,12),USE(?PRN:Cijena_programa:Prompt)
                       SPIN(@n7.2),AT(464,13,43),USE(PRN:Cijena_programa,,?PRN:Cijena_programa:2),MSG('Cijena programa astronomije')
                       STRING('kn'),AT(510,16),USE(?STRING1)
                       PROMPT('Cijena Programa s PDV-om:'),AT(365,42),USE(?PRN:Cijena_Programa_s_PDV:Prompt)
                       ENTRY(@n9.2),AT(464,42,42,10),USE(PRN:Cijena_Programa_s_PDV),LEFT,REQ
                       STRING('kn'),AT(510,42,8,10),USE(?STRING1:2)
                       BUTTON('Spremi'),AT(16,192,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Odustani'),AT(60,192,40,12),USE(?Cancel)
                       STRING(@S40),AT(106,192),USE(ActionMessage)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
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
  GlobalErrors.SetProcedureName('AzuriranjeProgramaAstronomije')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PRN:Broj_programa:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(PRN:Record,History::PRN:Record)
  SELF.AddHistoryField(?PRN:Broj_programa:2,1)
  SELF.AddHistoryField(?PRN:Naziv_programa_astronomije,2)
  SELF.AddHistoryField(?PRN:Opis_programa,3)
  SELF.AddHistoryField(?PRN:Dnevno_trajanje_programa,4)
  SELF.AddHistoryField(?PRN:Predavac,5)
  SELF.AddHistoryField(?PRN:Cijena_programa:2,6)
  SELF.AddHistoryField(?PRN:Cijena_Programa_s_PDV,7)
  SELF.AddUpdateFile(Access:PROGRAM_ASTRONOMIJE)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:PROGRAM_ASTRONOMIJE.Open                          ! File PROGRAM_ASTRONOMIJE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:PROGRAM_ASTRONOMIJE
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
  INIMgr.Fetch('AzuriranjeProgramaAstronomije',FormWindow) ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeProgramaAstronomije',FormWindow) ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


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
    CASE FIELD()
    OF ?PRN:Cijena_Programa_s_PDV
      PRN:Cijena_Programa_s_PDV=PRN:Cijena_programa+(0.25*PRN:Cijena_programa)
    END
  ReturnValue = PARENT.TakeSelected()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjePolaznika PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
BRW8::View:Browse    VIEW(UPLATNICA)
                       PROJECT(PLT:OIB_polaznika)
                       PROJECT(PLT:Broj_uplatnice)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
PLT:OIB_polaznika      LIKE(PLT:OIB_polaznika)        !List box control field - type derived from field
PLT:Broj_uplatnice     LIKE(PLT:Broj_uplatnice)       !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::PLZ:Record  LIKE(PLZ:RECORD),THREAD
FormWindow           WINDOW('Azuriranje polaznika...'),AT(,,532,199),FONT('Lucida Sans',11,0082004Bh),RESIZE,CENTER, |
  CURSOR('Sentinel normal.cur'),GRAY,MDI,SYSTEM,WALLPAPER('gettyimages-stars.bmp')
                       PROMPT('OIB polaznika:'),AT(16,14),USE(?PLZ:OIB_polaznika:Prompt)
                       ENTRY(@P###########P),AT(76,14,60,10),USE(PLZ:OIB_polaznika),REQ
                       PROMPT('Ime i prezime:'),AT(16,33),USE(?PLZ:Ime_prezime_polaznika:Prompt)
                       ENTRY(@s40),AT(76,32,122,10),USE(PLZ:Ime_prezime_polaznika),CAP,REQ
                       PROMPT('Adresa:'),AT(16,50),USE(?PLZ:Adresa:Prompt)
                       ENTRY(@s30),AT(76,50,122,10),USE(PLZ:Adresa),CAP,MSG('Adresa na koju ce polaznik primat' & |
  'i novosti i razne kupone za teme vezane uz astronomiju'),REQ,TIP('Adresa na koju ce ' & |
  'polaznik primati novosti i razne kupone za teme vezane uz astronomiju')
                       PROMPT('Telefon:'),AT(15,68),USE(?PLZ:Telefon:Prompt)
                       ENTRY(@s14),AT(76,69,60,10),USE(PLZ:Telefon),MSG('Telefon za kontakt'),REQ,TIP('Telefon za kontakt')
                       PROMPT('Email:'),AT(16,87),USE(?PLZ:Email:Prompt)
                       ENTRY(@s40),AT(76,88,158,10),USE(PLZ:Email),MSG('Email za kontakt'),TIP('Email za kontakt')
                       PROMPT('Postanski broj:'),AT(15,106),USE(?PLZ:Postanski_broj:Prompt)
                       ENTRY(@P#####P),AT(76,107,42,10),USE(PLZ:Postanski_broj),TIP('Postanski broj je broj iz' & |
  'medju 10000 i 53000.')
                       BUTTON('...'),AT(122,106,12,11),USE(?CallLookup)
                       CHECK(' Ima predznanje'),AT(15,125),USE(PLZ:Ima_predznanje),MSG('Ima li polaznik predzn' & |
  'anja odnosno da li je vec pohadjao neki program astronomije?'),TIP('Ima li polaznik ' & |
  'predznanja odnosno da li je vec pohadjao neki program astronomije?'),VALUE('Ima','Nema')
                       LIST,AT(328,13,177,98),USE(?List),FORMAT('63C|M~OIB polaznika~@P#{11}P@80C|M~Broj uplat' & |
  'nice~@s20@'),FROM(Queue:Browse),IMM
                       PROMPT('Ukupno uplatnica:'),AT(328,125),USE(?PLZ:Ukupno_polaznika:Prompt)
                       ENTRY(@n5),AT(394,126,26,10),USE(PLZ:Ukupno_polaznika),RIGHT,REQ
                       BUTTON('Spremi'),AT(15,176,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Odustani'),AT(64,176,40,12),USE(?Cancel)
                       STRING(@S40),AT(136,176),USE(ActionMessage)
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

BRW8                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
ResetFromView          PROCEDURE(),DERIVED
                     END

BRW8::Sort0:Locator  StepLocatorClass                      ! Default Locator
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
  GlobalErrors.SetProcedureName('AzuriranjePolaznika')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PLZ:OIB_polaznika:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(PLZ:Record,History::PLZ:Record)
  SELF.AddHistoryField(?PLZ:OIB_polaznika,1)
  SELF.AddHistoryField(?PLZ:Ime_prezime_polaznika,2)
  SELF.AddHistoryField(?PLZ:Adresa,3)
  SELF.AddHistoryField(?PLZ:Telefon,4)
  SELF.AddHistoryField(?PLZ:Email,5)
  SELF.AddHistoryField(?PLZ:Postanski_broj,8)
  SELF.AddHistoryField(?PLZ:Ima_predznanje,6)
  SELF.AddHistoryField(?PLZ:Ukupno_polaznika,7)
  SELF.AddUpdateFile(Access:POLAZNIK)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:POLAZNIK.SetOpenRelated()
  Relate:POLAZNIK.Open                                     ! File POLAZNIK used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:POLAZNIK
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
  BRW8.Init(?List,Queue:Browse.ViewPosition,BRW8::View:Browse,Queue:Browse,Relate:UPLATNICA,SELF) ! Initialize the browse manager
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW8.Q &= Queue:Browse
  BRW8.AddSortOrder(,PLT:PK_Uplatnica_OIB_BrojUplatnice)   ! Add the sort order for PLT:PK_Uplatnica_OIB_BrojUplatnice for sort order 1
  BRW8.AddLocator(BRW8::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW8::Sort0:Locator.Init(,PLT:OIB_polaznika,1,BRW8)      ! Initialize the browse locator using  using key: PLT:PK_Uplatnica_OIB_BrojUplatnice , PLT:OIB_polaznika
  BRW8.AddField(PLT:OIB_polaznika,BRW8.Q.PLT:OIB_polaznika) ! Field PLT:OIB_polaznika is a hot field or requires assignment from browse
  BRW8.AddField(PLT:Broj_uplatnice,BRW8.Q.PLT:Broj_uplatnice) ! Field PLT:Broj_uplatnice is a hot field or requires assignment from browse
  INIMgr.Fetch('AzuriranjePolaznika',FormWindow)           ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.AddItem(ToolbarForm)
  BRW8.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:POLAZNIK.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjePolaznika',FormWindow)        ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  MJS:Postanski_broj = PLZ:Postanski_broj                  ! Assign linking field value
  Access:MJESTO.Fetch(MJS:PK_Mjesto_PostanskiBroj)
  MJS:Postanski_broj = PLZ:Postanski_broj                  ! Assign linking field value
  Access:MJESTO.Fetch(MJS:PK_Mjesto_PostanskiBroj)
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
    PopisMjesta
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
    OF ?PLZ:Postanski_broj
      IF Access:POLAZNIK.TryValidateField(8)               ! Attempt to validate PLZ:Postanski_broj in POLAZNIK
        SELECT(?PLZ:Postanski_broj)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?PLZ:Postanski_broj
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?PLZ:Postanski_broj{PROP:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    OF ?CallLookup
      ThisWindow.Update()
      MJS:Postanski_broj = PLZ:Postanski_broj
      IF SELF.Run(1,SelectRecord) = RequestCompleted       ! Call lookup procedure and verify RequestCompleted
        PLZ:Postanski_broj = MJS:Postanski_broj
      END
      ThisWindow.Reset(1)
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
    OF ?PLZ:Postanski_broj
      MJS:Postanski_broj = PLZ:Postanski_broj
      IF Access:MJESTO.TryFetch(MJS:PK_Mjesto_PostanskiBroj)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          PLZ:Postanski_broj = MJS:Postanski_broj
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


BRW8.ResetFromView PROCEDURE

PLZ:Ukupno_polaznika:Cnt LONG                              ! Count variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:UPLATNICA.SetQuickScan(1)
  SELF.Reset
  IF SELF.UseMRP
     IF SELF.View{PROP:IPRequestCount} = 0
          SELF.View{PROP:IPRequestCount} = 60
     END
  END
  LOOP
    IF SELF.UseMRP
       IF SELF.View{PROP:IPRequestCount} = 0
            SELF.View{PROP:IPRequestCount} = 60
       END
    END
    CASE SELF.Next()
    OF Level:Notify
      BREAK
    OF Level:Fatal
      SETCURSOR()
      RETURN
    END
    SELF.SetQueueRecord
    PLZ:Ukupno_polaznika:Cnt += 1
  END
  SELF.View{PROP:IPRequestCount} = 0
  PLZ:Ukupno_polaznika = PLZ:Ukupno_polaznika:Cnt
  PARENT.ResetFromView
  Relate:UPLATNICA.SetQuickScan(0)
  SETCURSOR()

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeUplatnice PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::PLT:Record  LIKE(PLT:RECORD),THREAD
FormWindow           WINDOW('Azuriranje podataka o uplatnicama'),AT(,,289,159),FONT('Lucida Sans',11,0082004Bh, |
  ,CHARSET:DEFAULT),RESIZE,CENTER,CURSOR('Sentinel normal.cur'),GRAY,MDI,SYSTEM,WALLPAPER('gettyimage' & |
  's-stars.bmp')
                       PROMPT('Broj uplatnice:'),AT(22,13),USE(?PLT:Broj_uplatnice:Prompt)
                       ENTRY(@s20),AT(96,14,59,10),USE(PLT:Broj_uplatnice),RIGHT(1),REQ
                       PROMPT('Placanje za mjesec:'),AT(22,42),USE(?PLT:Placanje_za_mjesec:Prompt:2)
                       LIST,AT(96,42,76,12),USE(PLT:Placanje_za_mjesec),DROP(12),FROM('Sijecanj|#Sijecanj|Velj' & |
  'aca|#Veljaca|Ozujak|#Ozujak|Travanj|#Travanj|Svibanj|#Svibanj|Lipanj|#Lipanj|Srpanj|' & |
  '#Srpanj|Kolovoz|#Kolovoz|Rujan|#Rujan|Listopad|#Listopad|Studeni|#Studeni|Prosinac|#Prosinac'), |
  MSG('Za koji mjesec korisnik placa program'),TIP('Za koji mjesec korisnik placa program')
                       CHECK(' Ima karticu'),AT(22,72),USE(PLT:Ima_karticu,,?PLT:Ima_karticu:2),TIP('Ima li pol' & |
  'aznik karticu?'),VALUE('Da','Ne')
                       BUTTON('Spremi'),AT(5,140,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Odustani'),AT(50,140,40,12),USE(?Cancel)
                       STRING(@S40),AT(95,140),USE(ActionMessage)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

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
  GlobalErrors.SetProcedureName('AzuriranjeUplatnice')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PLT:Broj_uplatnice:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(PLT:Record,History::PLT:Record)
  SELF.AddHistoryField(?PLT:Broj_uplatnice,2)
  SELF.AddHistoryField(?PLT:Placanje_za_mjesec,3)
  SELF.AddHistoryField(?PLT:Ima_karticu:2,4)
  SELF.AddUpdateFile(Access:UPLATNICA)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:UPLATNICA.Open                                    ! File UPLATNICA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:UPLATNICA
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
  INIMgr.Fetch('AzuriranjeUplatnice',FormWindow)           ! Restore window settings from non-volatile store
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
    Relate:UPLATNICA.Close
  END
  IF SELF.Opened
    INIMgr.Update('AzuriranjeUplatnice',FormWindow)        ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


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

