  MEMBER('KucinaSvenAppV7.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
KucinaSvenAppV7_BC0:DctInit    PROCEDURE()
KucinaSvenAppV7_BC0:DctKill    PROCEDURE()
KucinaSvenAppV7_BC0:FilesInit  PROCEDURE()
  END

Hide:Access:POLAZNIK CLASS(FileManager),TYPE               ! FileManager for POLAZNIK
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:POLAZNIK CLASS(RelationManager),TYPE           ! RelationManager for POLAZNIK
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:POHADJA  CLASS(FileManager),TYPE               ! FileManager for POHADJA
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:POHADJA  CLASS(RelationManager),TYPE           ! RelationManager for POHADJA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:UPLATNICA CLASS(FileManager),TYPE              ! FileManager for UPLATNICA
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:UPLATNICA CLASS(RelationManager),TYPE          ! RelationManager for UPLATNICA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:PROGRAM_ASTRONOMIJE CLASS(FileManager),TYPE    ! FileManager for PROGRAM_ASTRONOMIJE
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:PROGRAM_ASTRONOMIJE CLASS(RelationManager),TYPE ! RelationManager for PROGRAM_ASTRONOMIJE
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:MJESTO   CLASS(FileManager),TYPE               ! FileManager for MJESTO
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:MJESTO   CLASS(RelationManager),TYPE           ! RelationManager for MJESTO
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:POHVALNICA CLASS(FileManager),TYPE             ! FileManager for POHVALNICA
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:POHVALNICA CLASS(RelationManager),TYPE         ! RelationManager for POHVALNICA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END


_Hide:Access:POLAZNIK &Hide:Access:POLAZNIK,AUTO,THREAD
_Hide:Relate:POLAZNIK &Hide:Relate:POLAZNIK,AUTO,THREAD
_Hide:Access:POHADJA &Hide:Access:POHADJA,AUTO,THREAD
_Hide:Relate:POHADJA &Hide:Relate:POHADJA,AUTO,THREAD
_Hide:Access:UPLATNICA &Hide:Access:UPLATNICA,AUTO,THREAD
_Hide:Relate:UPLATNICA &Hide:Relate:UPLATNICA,AUTO,THREAD
_Hide:Access:PROGRAM_ASTRONOMIJE &Hide:Access:PROGRAM_ASTRONOMIJE,AUTO,THREAD
_Hide:Relate:PROGRAM_ASTRONOMIJE &Hide:Relate:PROGRAM_ASTRONOMIJE,AUTO,THREAD
_Hide:Access:MJESTO  &Hide:Access:MJESTO,AUTO,THREAD
_Hide:Relate:MJESTO  &Hide:Relate:MJESTO,AUTO,THREAD
_Hide:Access:POHVALNICA &Hide:Access:POHVALNICA,AUTO,THREAD
_Hide:Relate:POHVALNICA &Hide:Relate:POHVALNICA,AUTO,THREAD


KucinaSvenAppV7_BC0:DctInit PROCEDURE()
  CODE
  _Hide:Access:POLAZNIK &= NEW(Hide:Access:POLAZNIK)
  _Hide:Relate:POLAZNIK &= NEW(Hide:Relate:POLAZNIK)
  _Hide:Access:POHADJA &= NEW(Hide:Access:POHADJA)
  _Hide:Relate:POHADJA &= NEW(Hide:Relate:POHADJA)
  _Hide:Access:UPLATNICA &= NEW(Hide:Access:UPLATNICA)
  _Hide:Relate:UPLATNICA &= NEW(Hide:Relate:UPLATNICA)
  _Hide:Access:PROGRAM_ASTRONOMIJE &= NEW(Hide:Access:PROGRAM_ASTRONOMIJE)
  _Hide:Relate:PROGRAM_ASTRONOMIJE &= NEW(Hide:Relate:PROGRAM_ASTRONOMIJE)
  _Hide:Access:MJESTO &= NEW(Hide:Access:MJESTO)
  _Hide:Relate:MJESTO &= NEW(Hide:Relate:MJESTO)
  _Hide:Access:POHVALNICA &= NEW(Hide:Access:POHVALNICA)
  _Hide:Relate:POHVALNICA &= NEW(Hide:Relate:POHVALNICA)
  Relate:POLAZNIK &= _Hide:Relate:POLAZNIK
  Relate:POHADJA &= _Hide:Relate:POHADJA
  Relate:UPLATNICA &= _Hide:Relate:UPLATNICA
  Relate:PROGRAM_ASTRONOMIJE &= _Hide:Relate:PROGRAM_ASTRONOMIJE
  Relate:MJESTO &= _Hide:Relate:MJESTO
  Relate:POHVALNICA &= _Hide:Relate:POHVALNICA


KucinaSvenAppV7_BC0:FilesInit PROCEDURE()
  CODE
  _Hide:Relate:POLAZNIK.Init
  _Hide:Relate:POHADJA.Init
  _Hide:Relate:UPLATNICA.Init
  _Hide:Relate:PROGRAM_ASTRONOMIJE.Init
  _Hide:Relate:MJESTO.Init
  _Hide:Relate:POHVALNICA.Init


KucinaSvenAppV7_BC0:DctKill PROCEDURE()
  CODE
  _Hide:Relate:POLAZNIK.Kill
  DISPOSE(_Hide:Relate:POLAZNIK)
  _Hide:Relate:POHADJA.Kill
  DISPOSE(_Hide:Relate:POHADJA)
  _Hide:Relate:UPLATNICA.Kill
  DISPOSE(_Hide:Relate:UPLATNICA)
  _Hide:Relate:PROGRAM_ASTRONOMIJE.Kill
  DISPOSE(_Hide:Relate:PROGRAM_ASTRONOMIJE)
  _Hide:Relate:MJESTO.Kill
  DISPOSE(_Hide:Relate:MJESTO)
  _Hide:Relate:POHVALNICA.Kill
  DISPOSE(_Hide:Relate:POHVALNICA)


Hide:Relate:POLAZNIK.Init PROCEDURE()
  CODE
  _Hide:Access:POLAZNIK.Init
  SELF.Init(Access:POLAZNIK,1)


Hide:Access:POLAZNIK.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= PLZ:Record
  SELF.FileNameValue = 'POLAZNIK'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= POLAZNIK
  PARENT.Init
  Access:POLAZNIK &= SELF


Hide:Access:POLAZNIK.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:POLAZNIK &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:POLAZNIK.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(POLAZNIK,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(PLZ:SK_Polaznik_ImePrezime,'PLZ:SK_Polaznik_ImePrezime',0)
    SELF.AddKey(PLZ:SK_Polaznik_PostanskiBroj,'PLZ:SK_Polaznik_PostanskiBroj',0)
    SELF.AddKey(PLZ:PK_Polaznik_OIBpolaznika,'PLZ:PK_Polaznik_OIBpolaznika',0)
    SELF.AddKey(PLZ:VK_PolaznikMjesto_PostanskiBroj,'PLZ:VK_PolaznikMjesto_PostanskiBroj',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:POLAZNIK.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 8
    GlobalErrors.SetField('PLZ:Postanski_broj')
    IF NOT INRANGE(PLZ:Postanski_broj,10000,53000)
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldOutOfRange,'10000 .. 53000')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:POLAZNIK.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:MJESTO)

  SELF.AddRelation(Relate:UPLATNICA,RI:CASCADE,RI:CASCADE,PLT:PK_Uplatnica_OIB_BrojUplatnice)
  SELF.AddRelationLink(PLZ:OIB_polaznika,PLT:OIB_polaznika)

  SELF.AddRelation(Relate:POHADJA,RI:CASCADE,RI:CASCADE,PHD:PK_Pohadja_OIB_BrojProgAstro)
  SELF.AddRelationLink(PLZ:OIB_polaznika,PHD:OIB_polaznika)

  SELF.AddRelation(Relate:POHVALNICA,RI:CASCADE,RI:RESTRICT,PHV:VK_PohvalnicaPolaznik_OIBpolaznika)
  SELF.AddRelationLink(PLZ:OIB_polaznika,PHV:OIB_polaznika)


Hide:Relate:POLAZNIK.Kill PROCEDURE

  CODE
  _Hide:Access:POLAZNIK.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:POLAZNIK &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:POLAZNIK)                           ! destroy the file manager


Hide:Relate:POHADJA.Init PROCEDURE()
  CODE
  _Hide:Access:POHADJA.Init
  SELF.Init(Access:POHADJA,1)


Hide:Access:POHADJA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= PHD:Record
  SELF.FileNameValue = 'POHADJA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= POHADJA
  PARENT.Init
  Access:POHADJA &= SELF


Hide:Access:POHADJA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:POHADJA &= NULL                                   ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:POHADJA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(POHADJA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(PHD:PK_Pohadja_OIB_BrojProgAstro,'PHD:PK_Pohadja_OIB_BrojProgAstro',0)
    SELF.AddKey(PHD:RK_Pohadja_SifraProgAstro_OIB,'PHD:RK_Pohadja_SifraProgAstro_OIB',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:POHADJA.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:POLAZNIK1     USHORT,AUTO
Save:PROGRAM_ASTRONOMIJE2 USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 1
    GlobalErrors.SetField('PHD:OIB_polaznika')
    Save:POLAZNIK1 = Access:POLAZNIK.SaveFile()
    PLZ:OIB_polaznika = PHD:OIB_polaznika
    ReturnValue = Access:POLAZNIK.TryFetch(PLZ:PK_Polaznik_OIBpolaznika)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'POLAZNIK')
      END
    END
    Access:POLAZNIK.RestoreFile(Save:POLAZNIK1)
  OF 2
    GlobalErrors.SetField('Broj koji jedinstveno identificira neki program astronomije')
    Save:PROGRAM_ASTRONOMIJE2 = Access:PROGRAM_ASTRONOMIJE.SaveFile()
    PRN:Broj_programa = PHD:Broj_programa
    ReturnValue = Access:PROGRAM_ASTRONOMIJE.TryFetch(PRN:PK_ProgAstro_BrojProgAstro)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'PROGRAM_ASTRONOMIJE')
      END
    END
    Access:PROGRAM_ASTRONOMIJE.RestoreFile(Save:PROGRAM_ASTRONOMIJE2)
  END
  RETURN ReturnValue


Hide:Relate:POHADJA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:POLAZNIK)

  SELF.AddRelation(Relate:PROGRAM_ASTRONOMIJE)


Hide:Relate:POHADJA.Kill PROCEDURE

  CODE
  _Hide:Access:POHADJA.Kill                                ! Kill the file manager
  PARENT.Kill
  Relate:POHADJA &= NULL                                   ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:POHADJA)                            ! destroy the file manager


Hide:Relate:UPLATNICA.Init PROCEDURE()
  CODE
  _Hide:Access:UPLATNICA.Init
  SELF.Init(Access:UPLATNICA,1)


Hide:Access:UPLATNICA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= PLT:Record
  SELF.FileNameValue = 'UPLATNICA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= UPLATNICA
  PARENT.Init
  Access:UPLATNICA &= SELF


Hide:Access:UPLATNICA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:UPLATNICA &= NULL                                 ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:UPLATNICA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(UPLATNICA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(PLT:PK_Uplatnica_OIB_BrojUplatnice,'PLT:PK_Uplatnica_OIB_BrojUplatnice',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:UPLATNICA.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:POLAZNIK1     USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 1
    GlobalErrors.SetField('PLT:OIB_polaznika')
    Save:POLAZNIK1 = Access:POLAZNIK.SaveFile()
    PLZ:OIB_polaznika = PLT:OIB_polaznika
    ReturnValue = Access:POLAZNIK.TryFetch(PLZ:PK_Polaznik_OIBpolaznika)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'POLAZNIK')
      END
    END
    Access:POLAZNIK.RestoreFile(Save:POLAZNIK1)
  OF 3
    GlobalErrors.SetField('Za koji mjesec korisnik placa program')
    IF INSTRING(']' & CLIP(PLT:Placanje_za_mjesec) & '[', ']Sijecanj[]Veljaca[]Ozujak[]Travanj[]Svibanj[]Lipanj[]Srpanj[]Kolovoz[]Rujan[]Listopad[]Studeni[]Prosinac[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''Sijecanj'',''Veljaca'',''Ozujak'',''Travanj'',''Svibanj'',''Lipanj'',''Srpanj'',''Kolovoz'',''Rujan'',''Listopad'',''Studeni'',''Prosinac''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:UPLATNICA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:POLAZNIK)


Hide:Relate:UPLATNICA.Kill PROCEDURE

  CODE
  _Hide:Access:UPLATNICA.Kill                              ! Kill the file manager
  PARENT.Kill
  Relate:UPLATNICA &= NULL                                 ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:UPLATNICA)                          ! destroy the file manager


Hide:Relate:PROGRAM_ASTRONOMIJE.Init PROCEDURE()
  CODE
  _Hide:Access:PROGRAM_ASTRONOMIJE.Init
  SELF.Init(Access:PROGRAM_ASTRONOMIJE,1)


Hide:Access:PROGRAM_ASTRONOMIJE.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= PRN:Record
  SELF.FileNameValue = 'PROGRAM_ASTRONOMIJE'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= PROGRAM_ASTRONOMIJE
  PARENT.Init
  Access:PROGRAM_ASTRONOMIJE &= SELF


Hide:Access:PROGRAM_ASTRONOMIJE.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:PROGRAM_ASTRONOMIJE &= NULL                       ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:PROGRAM_ASTRONOMIJE.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(PROGRAM_ASTRONOMIJE,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(PRN:PK_ProgAstro_BrojProgAstro,'PRN:PK_ProgAstro_BrojProgAstro',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:PROGRAM_ASTRONOMIJE.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 2
    GlobalErrors.SetField('PRN:Naziv_programa_astronomije')
    IF INSTRING(']' & PRN:Naziv_programa_astronomije & '[', ']OSNOVNOSKOLSKI PROGRAM[]DIGITALNI PLANETARIJ[]ZVJEZDARNICA I TELESKOP[]TECAJ OSNOVA ASTRONOMIJE[]OBICNO PREDAVANJE[]HANGOUT[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''OSNOVNOSKOLSKI PROGRAM'',''DIGITALNI PLANETARIJ'',''ZVJEZDARNICA I TELESKOP'',''TECAJ OSNOVA ASTRONOMIJE'',''OBICNO PREDAVANJE'',''HANGOUT''')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:PROGRAM_ASTRONOMIJE.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:POHADJA,RI:CASCADE,RI:CASCADE,PHD:PK_Pohadja_OIB_BrojProgAstro)
  SELF.AddRelationLink(PRN:Broj_programa,PHD:Broj_programa)


Hide:Relate:PROGRAM_ASTRONOMIJE.Kill PROCEDURE

  CODE
  _Hide:Access:PROGRAM_ASTRONOMIJE.Kill                    ! Kill the file manager
  PARENT.Kill
  Relate:PROGRAM_ASTRONOMIJE &= NULL                       ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:PROGRAM_ASTRONOMIJE)                ! destroy the file manager


Hide:Relate:MJESTO.Init PROCEDURE()
  CODE
  _Hide:Access:MJESTO.Init
  SELF.Init(Access:MJESTO,1)


Hide:Access:MJESTO.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= MJS:Record
  SELF.FileNameValue = 'MJESTO'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= MJESTO
  PARENT.Init
  Access:MJESTO &= SELF


Hide:Access:MJESTO.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:MJESTO &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:MJESTO.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(MJESTO,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(MJS:PK_Mjesto_PostanskiBroj,'MJS:PK_Mjesto_PostanskiBroj',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:MJESTO.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 1
    GlobalErrors.SetField('MJS:Postanski_broj')
    IF NOT INRANGE(MJS:Postanski_broj,10000,53000)
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldOutOfRange,'10000 .. 53000')
      END
    END
  END
  RETURN ReturnValue


Hide:Relate:MJESTO.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:POLAZNIK,RI:CASCADE,RI:RESTRICT,PLZ:VK_PolaznikMjesto_PostanskiBroj)
  SELF.AddRelationLink(MJS:Postanski_broj,PLZ:Postanski_broj)


Hide:Relate:MJESTO.Kill PROCEDURE

  CODE
  _Hide:Access:MJESTO.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:MJESTO &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:MJESTO)                             ! destroy the file manager


Hide:Relate:POHVALNICA.Init PROCEDURE()
  CODE
  _Hide:Access:POHVALNICA.Init
  SELF.Init(Access:POHVALNICA,1)


Hide:Access:POHVALNICA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= PHV:Record
  SELF.FileNameValue = 'POHVALNICA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= POHVALNICA
  PARENT.Init
  Access:POHVALNICA &= SELF


Hide:Access:POHVALNICA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:POHVALNICA &= NULL                                ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:POHVALNICA.PrimeFields PROCEDURE

  CODE
  PHV:Datum_primitka = TODAY()                             ! Assign initial field value
  PARENT.PrimeFields


Hide:Access:POHVALNICA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(POHVALNICA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(PHV:PK_Pohvalnica_BrojPohvalnice,'PHV:PK_Pohvalnica_BrojPohvalnice',0)
    SELF.AddKey(PHV:VK_PohvalnicaPolaznik_OIBpolaznika,'PHV:VK_PohvalnicaPolaznik_OIBpolaznika',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:POHVALNICA.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:POLAZNIK5     USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 3
    GlobalErrors.SetField('Naziv programa iz kojega je polaznik dobio pohvalnicu (samo dva)')
    IF INSTRING(']' & PHV:Ime_programa & '[', ']OSNOVNOSKOLSKI PROGRAM[]TECAJ OSNOVA ASTRONOMIJE[', 1, 1) = 0
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInList,'''OSNOVNOSKOLSKI PROGRAM'',''TECAJ OSNOVA ASTRONOMIJE''')
      END
    END
  OF 4
    GlobalErrors.SetField('Ocjena koju je polaznik dobio iz odredjenog programa astronomije')
    IF NOT INRANGE(PHV:Ocjena,1,5)
      ReturnValue = Level:Notify
    END
    IF ReturnValue <> Level:Benign
      IF HandleErrors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldOutOfRange,'1 .. 5')
      END
    END
  OF 5
    GlobalErrors.SetField('PHV:OIB_polaznika')
    Save:POLAZNIK5 = Access:POLAZNIK.SaveFile()
    PLZ:OIB_polaznika = PHV:OIB_polaznika
    ReturnValue = Access:POLAZNIK.TryFetch(PLZ:PK_Polaznik_OIBpolaznika)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'POLAZNIK')
      END
    END
    Access:POLAZNIK.RestoreFile(Save:POLAZNIK5)
  END
  RETURN ReturnValue


Hide:Relate:POHVALNICA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:POLAZNIK)


Hide:Relate:POHVALNICA.Kill PROCEDURE

  CODE
  _Hide:Access:POHVALNICA.Kill                             ! Kill the file manager
  PARENT.Kill
  Relate:POHVALNICA &= NULL                                ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:POHVALNICA)                         ! destroy the file manager

