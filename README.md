# Dynamic Interpolation module

## Introduction

This module provides multi-dimensional interpolation capability.
The interpolation library is used inconjuction with the aSubRecord.

Note: This documentation assumes the reader is familiar with the aSub record.
Within this documentation, INPx referes to INPA, INPB, INPC, ... INPU.
And similar applies for OUTx, VALx etc.

## Description

The interpolation library enables an aSub record to perform 1-D, 2-D upto 8-D
interpolations.
Each dimension of interpolation requires a scalar PV to drive the interpolation.
For eample, a 2-D interpolation (the rest of the documentation uses this 2-D
example) would be driven by two scalar PV values (say X1 and X2).

Also associated with each dimensiion is a co-ordinate set, which is a set of
interpolation break-point values or x values.
The values in each co-ordinate set must be either monatonically increasing
or monatonically decreasing.
The co-ordinate values would typically be defined in a waveform record, but
any multi-value record type or PV in general will work.
And with later version of EPICS a const json sting can also be used. e.g.:

    field (INPF, {const:[1, 5, 1.1, 1.2, 1.3, 1.4, 1.5]})

The interpolation library can perform one or more interpolations in parallel,
all driven by the same set of input values (X1, X2 as in the 2-D example above).
Associated with each output is a scalar PV to which the interpolated value
is written (although it could just be left in the corresponding VALx field).
Also associated with each output (Y1, Y2, ...) is an interpolation table
or array of y values.
The output interpolation table values would also typically be defined in
a waveform record.
The output interpolation table values must coorespond to the combination on input x values.

For example if X1 in co-ordinate set is [0, 1] and the X2 set is [2, 5, 7]
then the Y1 interpolation table must contain 6 values corresponding to
the Y1 value for each combination of input X values, i.e.:

    [ Y1 (X1=0, X2=2), Y1(X1=0, X2=5), Y1(X1=0, X2=7)
      Y1 (X1=1, X2=2), Y1(X1=1, X2=5), Y1(X1=1, X2=7) ]  


Each dimension of input uses two of the INPx fields, and each interpolated
values requires one of the INPx fields, therefore there is a trade-off between
the number of items that can be interpolated and the number of dimensions.
The detials are described below.


## aSub record field usage

### Static fields


| field | type   | description         |
|-------|--------|---------------------|
| INAM  | STRING | Set to Dynamic_Interpolation_Init   |
| SNAM  | STRING | Set to Dynamic_Interpolation_Process  |
| INPA  | LONG   | Number of dimensions (1 .. 8).<br>0 sort of works but is a degenerate case.  |
| INPB  | LONG   | First/Last interpolation item (D = 4, E = 5, ... J = 10,  ... U = 21).<br>Encoded as 100*First + Last |
| INPC  |        | Not used/spare  |
| OUTA  | LONG   | Indicates if any coordinate out side of region of interest. |

If an input value is outside of the range of values defined in the corresponding
input coordinate set, the output value is constrained to the boundary values
as opposed to attempting any sort of extrapolation.

### Input Coordinte Sets and X values

Which of these input fields are interpreted as an input coordinte set and
input X values depend on the value assigned to INPA, the number of dimensions.

| field | type   | description         |
|-------|--------|---------------------|
| INPD  | DOUBLE | Input coordinte set for 1st dimension  |
| INPE  | DOUBLE | Input value X1      |
| INPF  | DOUBLE | Input coordinte set for 2nd dimension (if applicable) |
| INPG  | DOUBLE | Input value X2 (if applicable)    |
| ...   | ...    | ...   |
| INPR  | DOUBLE | Input coordinte set for 8th dimension (if applicable) |
| INPS  | DOUBLE | Input value X8 (if applicable)    |


### Output Interplation Tables and Y values

Which of these fields are interpreted as an output interploation tables and
output Y values depends on the value assigned to INPB.

| field | type   | description         |
|-------|--------|---------------------|
| INPD  | DOUBLE | Y1 Interplation array (if applicable) |
| VALD  | DOUBLE | Y1 value (if applicable)  |
| OUTD  | DOUBLE | Y1 destination (if applicable)  |
| INPE  | DOUBLE | Y2 Interplation array (if applicable) |
| VALE  | DOUBLE | Y2 value (if applicable)  |
| OUTE  | DOUBLE | Y2 destination (if applicable)  |
| ...   | ...    | ...   |
| INPU  | DOUBLE | Y18 Interplation array (if applicable) |
| VALU  | DOUBLE | Y18 value (if applicable)  |
| OUTU  | DOUBLE | Y18 destination (if applicable)  |

Note, the interpolated output value is only calculated if
both INPx/OUTx are DOUBLE.

The number of available interpolation table/interpolated output value
pairs also depends on the number of dimensions (n):

    INPD/OUTD:  n <= 0
    INPE/OUTE:  n <= 0
    INPF/OUTF:  n <= 1
    INPG/OUTG:  n <= 1
    INPH/OUTH:  n <= 2
    INPI/OUTI:  n <= 2
    INPJ/OUTJ:  n <= 3
    INPK/OUTK:  n <= 3
    INPL/OUTL:  n <= 4
    INPM/OUTM:  n <= 4
    INPN/OUTN:  n <= 5
    INPO/OUTO:  n <= 5
    INPP/OUTP:  n <= 6
    INPQ/OUTQ:  n <= 6
    INPR/OUTR:  n <= 7
    INPS/OUTS:  n <= 7
    INPT/OUTT:  n <= 8
    INPU/OUTU:  n <= 8


## Multi dimensional array formats.

This format described here applies to both input coordinate sets and to output
interpolation tables.

The expected waveform format is  { n, size [n], data [m] }
where
    n is the number of dimensions;
    size [n] is a list of the sizes of each of the n dimensions;
    data [m] is array content, row major; and
    m = size [1] * size [2] * ... size [n]

### Examples:

  1-D 5-tuple array requires 7 waveform elements.

  |   0    |   1    |    2   |    3   |    4   |   5    |    6   |
  |--------|--------|--------|--------|--------|--------|--------|
  |  1.0   |  5.0   |  a[1]  |  a[2]  |  a[3]  |  a[4]  |  a[5]  |


  2-D [3x2] array requires 9 waveform elements.

  |   0    |   1    |    2   |    3   |    4   |   5    |    6   |    7   |    8   |
  |--------|--------|--------|--------|--------|--------|--------|--------|--------|
  |  2.0   |  3.0   |  2.0   | a[1,1] | a[1,2] | a[2,1] | a[2,2] | a[3,1] | a[3,2] |


Degenerate (0-D) scaler.

  |   0    |   1    |
  |--------|--------|
  |  0.0   |   a    |

The number of dimensions and dimension size meta data in the first 1 + n
elements are held double variables, but must contain whole number (integer)
values.


## Building the interpolation module into an IOC

This is pretty much how you would include any module into an IOC.
Either copy the Dynamic_InterpolationSup directory to the top directory of
your IOC, or add a line to the IOC's configure/RELEASE file (directly or
via an include):

    INTERPOLATION=/the/location/of/this/module/at/your/facility

and in the IOC's main application src Makefile, add the following:

    YourIOCName_DBD  += dynamic_interpolation_subroutines.dbd
    YourIOCName_LIBS += dynamic_interpolation

Why is it called dynamic_interpolation?
There was a previous incarnation of this module called interpolation,
which was more static in that the interpolation values were read from a
file.

## Real World Example

This extracted from a templates which is part of the local correction system
used to calculate the upstream and downstream corrector magnet currents,
driven by the gap or field strength of an insertion device.
The aSub record has been configured to calculate the required currents
for 4 magnets.

The template can perform upto a 2-D interpolation when needed;
as one of our insertion devices has some hysterisis, for this device one
input is configured to be the ramp direction, i.e. 0 for field ramping up
and 1 for field ramping down.
The ramp value never takes on an intemediate value, say 1.5, so no
interpolation happens per se.
Well actually it does, but the input co-ordinate set values are [0 , 1] and
the input value is either 0 or 1, so it is effectively a selection mechanism
between one of two 1-D interpolations.


    record (aSub, "$(NAME):LOCAL_CORR_CALC") {
        field (DESC, "Interpolation calculation")
        field (SCAN, "Passive")

        field (INAM, "Dynamic_Interpolation_Init")
        field (SNAM, "Dynamic_Interpolation_Process")

        # Number of dimensions
        #
        field (INPA, "$(DIMS)")
        field (FTA,  "LONG")

        # First/Last Interpolated Input/Output
        # D = 4, E = 5, ... J = 10,  ... U = 21
        # Encoded as 100*First + Last
        #
        field (INPB, "1013")             #  J .. M
        field (FTB,  "LONG")

        # Out of range input indicator
        # No separate record - just in VALA (for now).
        #
        field (FTVA, "LONG")

        # 1st input coordinates set (max 40) and coordinate.
        #
        field (INPD, "$(NAME):INP1_COORDINATE_SET")
        field (NOD,  "42")
        field (FTD,  "DOUBLE")

        # Associated input coordinate 1
        #
        field (INPE, "$(INP1)")
        field (FTE,  "DOUBLE")

        # 2nd input coordinates set (max 40) and coordinate.
        #
        field (INPF, "$(NAME):INP2_COORDINATE_SET")
        field (NOF,  "42")
        field (FTF,  "DOUBLE")

        # Associated input coordinate 2
        #
        field (INPG, "$(INP2)")
        field (FTG,  "DOUBLE")

        # Interpolation Tables and Interpolated Outputs
        # PP mode forces the record to process as it is on same IOC.
        # This mitigates need for an FLNK to each output.
        #
        field (INPJ, "$(NAME):CPS01_INTERPOLATION_TABLE")
        field (OUTJ, "$(IDEV)CPS01:CURRENT_SP PP")
        field (NOJ,  "$(SIZE)")
        field (FTJ,  "DOUBLE")
        field (FTVJ, "DOUBLE")

        field (INPK, "$(NAME):CPS02_INTERPOLATION_TABLE")
        field (OUTK, "$(IDEV)CPS02:CURRENT_SP PP")
        field (NOK,  "$(SIZE)")
        field (FTK,  "DOUBLE")
        field (FTVK, "DOUBLE")

        field (INPL, "$(NAME):CPS03_INTERPOLATION_TABLE")
        field (OUTL, "$(IDEV)CPS03:CURRENT_SP PP")
        field (NOL,  "$(SIZE)")
        field (FTL,  "DOUBLE")
        field (FTVL, "DOUBLE")

        field (INPM, "$(NAME):CPS04_INTERPOLATION_TABLE")
        field (OUTM, "$(IDEV)CPS04:CURRENT_SP PP")
        field (NOM,  "$(SIZE)")
        field (FTM,  "DOUBLE")
        field (FTVM, "DOUBLE")
    }


The input coordinate sets and interpolation table waveforms are autosaved.

<font size="-1">Last updated: Tue Jan 21 17:22:38 2025</font>
<br>
