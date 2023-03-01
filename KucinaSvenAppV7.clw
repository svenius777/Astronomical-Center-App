   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE

   MAP
     MODULE('KUCINASVENAPPV7_BC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('KUCINASVENAPPV7001.CLW')
Main                   PROCEDURE   !
     END
   END

SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

!region File Declaration
POLAZNIK             FILE,DRIVER('TOPSPEED'),PRE(PLZ),CREATE,BINDABLE,THREAD ! Tablica koja sadrzi podatke o polaznicima nekog programa astronomije
SK_Polaznik_ImePrezime   KEY(PLZ:Ime_prezime_polaznika),DUP,NOCASE !                     
SK_Polaznik_PostanskiBroj KEY(PLZ:Postanski_broj),DUP,NOCASE !                     
PK_Polaznik_OIBpolaznika KEY(PLZ:OIB_polaznika),NOCASE,PRIMARY !                     
VK_PolaznikMjesto_PostanskiBroj KEY(PLZ:Postanski_broj),DUP,NOCASE !                     
Record                   RECORD,PRE()
OIB_polaznika               STRING(11)                     !                     
Ime_prezime_polaznika       CSTRING(41)                    !                     
Adresa                      CSTRING(31)                    ! Adresa na koju ce polaznik primati novosti i razne kupone za teme vezane uz astronomiju
Telefon                     CSTRING(15)                    ! Telefon za kontakt  
Email                       CSTRING(41)                    ! Email za kontakt    
Ima_predznanje              CSTRING(6)                     ! Ima li polaznik predznanja odnosno da li je vec pohadjao neki program astronomije?
Ukupno_polaznika            SHORT                          !                     
Postanski_broj              CSTRING(20)                    !                     
                         END
                     END                       

POHADJA              FILE,DRIVER('TOPSPEED'),PRE(PHD),CREATE,BINDABLE,THREAD ! Tablica s podacima o pohadjanju polaznika razlicitih programa astronomije
PK_Pohadja_OIB_BrojProgAstro KEY(PHD:OIB_polaznika,PHD:Broj_programa),NOCASE,PRIMARY !                     
RK_Pohadja_SifraProgAstro_OIB KEY(PHD:Broj_programa,PHD:OIB_polaznika),NOCASE !                     
Record                   RECORD,PRE()
OIB_polaznika               STRING(11)                     !                     
Broj_programa               SHORT                          ! Broj koji jedinstveno identificira neki program astronomije
Datum_pocetka               DATE                           ! Datum pocetka programa
Datum_zavrsetka             DATE                           ! Datum zavrsetka programa astronomije
                         END
                     END                       

UPLATNICA            FILE,DRIVER('TOPSPEED'),PRE(PLT),CREATE,BINDABLE,THREAD ! Tablica s podacima o uplatnicama polaznika
PK_Uplatnica_OIB_BrojUplatnice KEY(PLT:OIB_polaznika,PLT:Broj_uplatnice),NOCASE,PRIMARY !                     
Record                   RECORD,PRE()
OIB_polaznika               STRING(11)                     !                     
Broj_uplatnice              STRING(20)                     !                     
Placanje_za_mjesec          STRING(11)                     ! Za koji mjesec korisnik placa program
Ima_karticu                 CSTRING(6)                     !                     
                         END
                     END                       

PROGRAM_ASTRONOMIJE  FILE,DRIVER('TOPSPEED'),PRE(PRN),CREATE,BINDABLE,THREAD ! Tablica s podacima o programima astronomije
PK_ProgAstro_BrojProgAstro KEY(PRN:Broj_programa),NOCASE,PRIMARY !                     
Record                   RECORD,PRE()
Broj_programa               SHORT                          ! Broj koji jedinstveno identificira neki program astronomije
Naziv_programa_astronomije  CSTRING(41)                    !                     
Opis_programa               CSTRING(201)                   ! Opis programa astronomije
Dnevno_trajanje_programa    TIME                           ! Dnevno trajanje programa astronomije
Predavac                    CSTRING(51)                    ! Ime i prezime predavaca koji predaje program astronomije
Cijena_programa             DECIMAL(5,2)                   ! Cijena programa astronomije
Cijena_Programa_s_PDV       DECIMAL(6,2)                   !                     
                         END
                     END                       

MJESTO               FILE,DRIVER('TOPSPEED'),PRE(MJS),CREATE,BINDABLE,THREAD ! Tablica s podacima o mjestima
PK_Mjesto_PostanskiBroj  KEY(MJS:Postanski_broj),NOCASE,PRIMARY !                     
Record                   RECORD,PRE()
Postanski_broj              CSTRING(20)                    !                     
Naziv_mjesta                CSTRING(31)                    !                     
                         END
                     END                       

POHVALNICA           FILE,DRIVER('TOPSPEED'),PRE(PHV),CREATE,BINDABLE,THREAD ! Tablica s podacima o primljenim pohvalnicama nakon zavrsetka tecaja
PK_Pohvalnica_BrojPohvalnice KEY(PHV:Broj_pohvalnice),NOCASE,PRIMARY !                     
VK_PohvalnicaPolaznik_OIBpolaznika KEY(PHV:OIB_polaznika),DUP,NOCASE !                     
Record                   RECORD,PRE()
Broj_pohvalnice             CSTRING(6)                     ! Broj koji identificira pohvalnicu polaznika
Datum_primitka              DATE                           ! Datum primitka pohvalnice
Ime_programa                CSTRING(41)                    ! Naziv programa iz kojega je polaznik dobio pohvalnicu (samo dva)
Ocjena                      STRING(1)                      ! Ocjena koju je polaznik dobio iz odredjenog programa astronomije
OIB_polaznika               STRING(11)                     !                     
                         END
                     END                       

!endregion

Access:POLAZNIK      &FileManager,THREAD                   ! FileManager for POLAZNIK
Relate:POLAZNIK      &RelationManager,THREAD               ! RelationManager for POLAZNIK
Access:POHADJA       &FileManager,THREAD                   ! FileManager for POHADJA
Relate:POHADJA       &RelationManager,THREAD               ! RelationManager for POHADJA
Access:UPLATNICA     &FileManager,THREAD                   ! FileManager for UPLATNICA
Relate:UPLATNICA     &RelationManager,THREAD               ! RelationManager for UPLATNICA
Access:PROGRAM_ASTRONOMIJE &FileManager,THREAD             ! FileManager for PROGRAM_ASTRONOMIJE
Relate:PROGRAM_ASTRONOMIJE &RelationManager,THREAD         ! RelationManager for PROGRAM_ASTRONOMIJE
Access:MJESTO        &FileManager,THREAD                   ! FileManager for MJESTO
Relate:MJESTO        &RelationManager,THREAD               ! RelationManager for MJESTO
Access:POHVALNICA    &FileManager,THREAD                   ! FileManager for POHVALNICA
Relate:POHVALNICA    &RelationManager,THREAD               ! RelationManager for POHVALNICA

FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
GlobalErrorStatus    ErrorStatusClass,THREAD
GlobalErrors         ErrorClass                            ! Global error manager
INIMgr               INIClass                              ! Global non-volatile storage manager
GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END


  CODE
  GlobalErrors.Init(GlobalErrorStatus)
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
  INIMgr.Init('.\KucinaSvenAppV7.INI', NVD_INI)            ! Configure INIManager to use INI file
  DctInit
  Main
  INIMgr.Update
  INIMgr.Kill                                              ! Destroy INI manager
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher


Dictionary.Construct PROCEDURE

  CODE
  IF THREAD()<>1
     DctInit()
  END


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()

