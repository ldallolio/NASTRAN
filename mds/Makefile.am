# what flags you want to pass to the Fortran compiler & linker
FFLAGS = -g -w -fno-range-check -fno-automatic -fcray-pointer

# this lists the binaries to produce, the (non-PHONY, binary) targets in
# the previous manual Makefile
bin_PROGRAMS = nastran
nastran_SOURCES = nastrn.f dummy.f mapfns.f zzcore.f xsem00.f init.f geturn.f klock.f waltim.f cputim.f tdate.f conmsg.f read.f close.f khrbcd.f khrfn1.f khrfn4.f gino.f ginoio.f bufchk.f bckrec.f fwdrec.f rectyp.f qopen.f qread.f rewind.f sgino.f write.f bldpk.f bpack.f bunpak.f bunpk.f intpk.f pack.f unpack.f logfil.f skpfil.f  sofio.f sofiof.f corwds.f rdblk.f wrtblk.f eof.f mpyq.f endget.f endgtb.f endput.f getstr.f putstr.f getstb.f filpos.f savpos.f emgsoc.f defcor.f gnfiat.f umffd.f  k2b.f exfort.f rfopen.f forwrt.f fornum.f

nastran_LDADD = ../mis/libnastran.a
