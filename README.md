# interpolation
EPICS Multi-dimensional Interpolation

##Description
Interpolation calculation sub-routine, for use with the aSubRecord.
Enables the record to perform 1-D, 2-D .. 8-D table interpolation.

INPA: long - number of dimensions (0 .. 8). 0 works but is a degenerate case.
INPB: long - first/last interpolation item (D = 4, E = 5, ... J = 10,  ... U = 21)
              Encoded as 100*First + Last
INPC: long - spare.

OUTA: long - indicates if any coordinate out side of region of interest.

The interpretation of other inputs depends on the number of dimensions.
Less dimensions means that more interpolation tables inputs and interpolated
value outputs can be processed by a record instance.

INPx/INPy: dimension co-ordinate set (array) and associated co-ordinate.
The number of co-ordinate sets and coordinate pairs is defined by the
number of dimensions (n). Both field types must be DOUBLE.

    INPD/INPE:  n >= 1
    INPF/INPG:  n >= 2
    INPH/INPI:  n >= 3
    INPJ/INPK:  n >= 4
    INPL/INPM:  n >= 5
    INPN/INPO:  n >= 6
    INPP/INPQ:  n >= 7
    INPR/INPS:  n >= 8

INPz/OUTz: interpolation table, interpolated output value. Only calculated if both INPz/OUTz are DOUBLE.

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


## Multi dimensional array format within a waveform record.

The expected waveform format is  { n, size [n], data [m] }
where
    n is the number of dimensions;
    size [n] is a list of the sizes of each of the n dimensions;
    data [m] is array content, row major; and
    m = size [1] * size [2] * ... size [n]

## Examples:

  1-D 5-tuple array requires 7 waveform elements.

  +--------+--------+--------+--------+--------+--------+--------+
  |  1.0   |  5.0   |  a[1]  |  a[2]  |  a[3]  |  a[4]  |  a[5]  |
  +--------+--------+--------+--------+--------+--------+--------+


  2-D [3x2] array requires 9 waveform elements.

  +--------+--------+--------+--------+--------+--------+--------+--------+--------+
  |  2.0   |  3.0   |  2.0   | a[1,1] | a[1,2] | a[2,1] | a[2,2] | a[3,1] | a[3,2] |
  +--------+--------+--------+--------+--------+--------+--------+--------+--------+


Degenerate (0-D) scaler.

  +--------+--------+
  |  0.0   |    a   |
  +--------+--------+

The number of dimensions and dimension size meta data in the first 1 + n
waveform elements are still held double variables, but must contain whole
number Integer) values.

