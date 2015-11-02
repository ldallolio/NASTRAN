#!/bin/bash
cwd=$(pwd)
echo The current work Directory is - $cwd
progname="$1"
SOLVER="UMFP";export SOLVER
#sof="windmill"
ft05="$progname.inp"
ft06="$progname.out"
nptp="$progname.nptp"
echo Input file is: $ft05
sof1="none"
sof2="none"
nasthome=$(dirname $(dirname $(readlink -f $0)))
rfdir="$nasthome/rf"
tmp="/tmp"
prefix="LUFACTOR"
#MUMPS_OOC_TMPDIR=$tmp;export MUMPS_OOC_TMPDIR 
#MUMPS_OOC_PREFIX=$prefix;export MUMPS_OOC_PREFIX
projectdir="$cwd"
nasexec="$nasthome/mds/nastran"
#rm -r $tmp
mkdir -p $tmp
nasscr=$tmp
dbmem="14000000"
ocmem="14000000"
echo ==== NASTRAN is beginning execution of $progname ====
NPTPNM=$nptp;export NPTPNM 
PLTNM="$progname.plt";export PLTNM
DICTNM="none";export DICTNM
PUNCHNM="$progname.pnh" ;export PUNCHNM
OUT11="$progname.out11" ;export OUT11
IN12="$progname.in12" ;export IN12
FTN11="none";export FTN11
FTN12="none";export FTN12
DIRCTY=$nasscr ;export DIRCTY
lognm="$progname.log" 
LOGNM=$lognm;export LOGNM
OPTPNM="none";export OPTPNM
RFDIR=$rfdir ;export RFDIR  
FTN13="none";export FTN13
SOF1=$sof1;export SOF1
SOF2=$sof2  ;export SOF2
FTN14="none";export FTN14
FTN17="none";export FTN17
FTN18="none";export FTN18
FTN19="none";export FTN19
FTN20="none";export FTN20
FTN15="none";export FTN15
FTN16="none";export FTB16
FTN21="none";export FTN21
FTN22="none";export FTN22
FTN23="none";export FTN23
DBMEM=$dbmem;export DBMEM
OCMEM=$ocmem ;export OCMEM
FT05=$ft05;export FT05
FT06=$ft06;export FT06
CWD=$cwd;export CWD
PROJ=$projectdir;export PROJ
printenv
rm $nptp
#$nasexec

gdb $nasexec
#./../test/a.out
#ls -la $tmp
#rm -r $tmp
echo ===== NASTRAN has completed problem $progname =====

