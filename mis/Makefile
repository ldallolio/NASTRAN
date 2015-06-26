
# GNU Fortran

F77 = gfortran
FFLAGS += -std=legacy
FOPTS = -g

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
	$(F77) $(FOPTS) $(FFLAGS) -c -o $@ $<

# Phony rules

.PHONY:	clean distclean

distclean:	clean
	-rm libnastran.a

clean:
	-rm *.o
