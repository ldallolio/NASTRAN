
# GNU Fortran

F77 = gfortran
FFLAGS += -std=legacy
FOPTS = -g

# Archive

AR = ar
MOD = cr

# Objects

OBJS += a42a8.o a82int.o

# Default target

default:	libnastran.a

all:	libnastran.a

# Specific targets

libnastran.a:	$(OBJS)
	$(AR) $(MOD) $@ $(OBJS)

# Template rules

%.o:	%.f
	$(F77) $(FOPTS) $(FFLAGS) -c -o $@ $<

# Phony rules

.PHONY:	clean distclean

distclean:	clean
	-rm libnastran.a

clean:
	-rm *.o
