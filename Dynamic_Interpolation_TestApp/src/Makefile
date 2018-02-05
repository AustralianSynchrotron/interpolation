# $File: //ASP/Dev/SBS/4_Controls/4_4_Equipment_Control/Common/sw/Interpolation/Dynamic_Interpolation_TestApp/src/Makefile $
# $Revision: #1 $
# $DateTime: 2018/02/05 20:50:27 $
# Last checked in by: $Author: starritt $
#

TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = Dynamic_Interpolation_Test
# Dynamic_Interpolation_Test.dbd will be created and installed
DBD += Dynamic_Interpolation_Test.dbd

# Dynamic_Interpolation_Test.dbd will be made up from these files:
Dynamic_Interpolation_Test_DBD += base.dbd

# Include dbd files from all support applications:
#
Dynamic_Interpolation_Test_DBD += dynamic_interpolation_subroutines.dbd

# Add all the support libraries needed by this IOC
#
Dynamic_Interpolation_Test_LIBS += dynamic_interpolation

# Dynamic_Interpolation_Test_registerRecordDeviceDriver.cpp derives from Dynamic_Interpolation_Test.dbd
Dynamic_Interpolation_Test_SRCS += Dynamic_Interpolation_Test_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
Dynamic_Interpolation_Test_SRCS_DEFAULT += Dynamic_Interpolation_TestMain.cpp
Dynamic_Interpolation_Test_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#Dynamic_Interpolation_Test_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
Dynamic_Interpolation_Test_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

# end
