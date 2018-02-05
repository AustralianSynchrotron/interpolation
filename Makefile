# $File: //ASP/Dev/SBS/4_Controls/4_4_Equipment_Control/Common/sw/Interpolation/Makefile $
# $Revision: #2 $
# $DateTime: 2010/04/22 10:55:31 $
# Last checked in by: $Author: starritt $
#

#Makefile at top of application tree
TOP = .
include $(TOP)/configure/CONFIG
DIRS := $(DIRS) $(filter-out $(DIRS), configure)
DIRS := $(DIRS) $(filter-out $(DIRS), $(wildcard *RecordSup))
DIRS := $(DIRS) $(filter-out $(DIRS), $(wildcard *Sup))
DIRS := $(DIRS) $(filter-out $(DIRS), $(wildcard *App))
DIRS := $(DIRS) $(filter-out $(DIRS), $(wildcard iocBoot))
DIRS := $(DIRS) $(filter-out $(DIRS), $(wildcard iocboot))
include $(TOP)/configure/RULES_TOP

# end
