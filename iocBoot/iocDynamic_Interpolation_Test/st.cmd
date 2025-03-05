#!../../bin/linux-x86_64/Dynamic_Interpolation_Test
#
# $File: //ASP/opa/acc/eqc/ctl/interpolation/trunk/iocBoot/iocDynamic_Interpolation_Test/st.cmd $
# $Revision: #1 $
# $DateTime: 2025/02/25 13:38:50 $
# Last checked in by: $Author: starritt $
#

## You may have to change Dynamic_Interpolation_Test to something else
## everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/Dynamic_Interpolation_Test.dbd"
Dynamic_Interpolation_Test_registerRecordDeviceDriver pdbbase

## Load record instances
#dbLoadRecords("db/xxx.db")

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncxxx,"user=starritt"

# end
