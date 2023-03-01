  MEMBER('KucinaSvenAppV7.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('KucinaSvenAppV7_BC0.CLW')
KucinaSvenAppV7_BC0:DctInit             PROCEDURE()
KucinaSvenAppV7_BC0:DctKill             PROCEDURE()
KucinaSvenAppV7_BC0:FilesInit           PROCEDURE()
    END
  END

DctInit PROCEDURE()
  CODE
  KucinaSvenAppV7_BC0:DctInit
  KucinaSvenAppV7_BC0:FilesInit


DctKill PROCEDURE()
  CODE
  KucinaSvenAppV7_BC0:DctKill

