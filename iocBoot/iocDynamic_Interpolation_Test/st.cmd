#!../../bin/linux-x86_64/Dynamic_Interpolation_Test
#
# $File: //ASP/Dev/SBS/4_Controls/4_4_Equipment_Control/Common/sw/Interpolation/iocBoot/iocDynamic_Interpolation_Test/st.cmd $
# $Revision: #1 $
# $DateTime: 2018/02/05 20:50:27 $
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
