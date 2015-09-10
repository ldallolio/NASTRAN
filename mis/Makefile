
# GNU Fortran

FC = gfortran
FFLAGS += -g -w -fno-range-check -fno-automatic -fcray-pointer

# Archive

AR = ar
MOD = cr

# Objects

SRCF = $(wildcard *.f)
OBJS = $(patsubst %.f,%.o,$(SRCF))

# Default target

default:	libnastran.a

all:	TAGS libnastran.a

# Specific targets

libnastran.a:	$(OBJS)
	$(AR) $(MOD) $@ $(OBJS)

TAGS:	$(SRCF)
	etags $(SRCF)

# Template rules

%.o:	%.f
	$(FC) $(FFLAGS) -c -o $@ $<

# Phony rules

.PHONY:	clean distclean

distclean:	clean
	-rm libnastran.a

clean:
	-rm *.o
