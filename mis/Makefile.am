# what flags you want to pass to the Fortran compiler & linker
FFLAGS = -g -w -fno-range-check -fno-automatic -fcray-pointer

# this lists the binaries to produce, the (non-PHONY, binary) targets in
# the previous manual Makefile
noinst_LIBRARIES = libnastran.a
libnastran_a_SOURCES = a42a8.f a82int.f adr.f adri.f adrprt.f af.f ai.f ais.f akapm.f \
akappa.f akp2.f alamda.f alg01.f alg02.f alg03.f alg04.f alg05.f \
alg06.f alg07.f alg08.f alg09.f alg10.f alg11.f alg12.f alg13.f alg14.f \
alg15.f alg16.f alg17.f alg18.f alg19.f alg1.f alg25.f alg26.f alg29.f \
alg2.f alg30.f alg3.f alg4.f alg5.f alg6.f alg7.f alg8.f alg9.f \
algan.f algap.f algar.f alg.f algpb.f algpo.f algpr.f allmat.f amatrx.f \
amgb1a.f amgb1b.f amgb1c.f amgb1d.f amgb1.f amgb1s.f amgb2a.f amgb2.f \
amgbfs.f amg.f amgrod.f amgsba.f amgt1a.f amgt1b.f amgt1c.f amgt1d.f \
amgt1.f amgt1s.f amgt1t.f amgt2a.f amgt2.f ampa.f ampb1.f ampb2.f \
ampb.f ampc1.f ampc2.f ampc.f ampd.f ampe.f amp.f ampf.f angtrs.f \
anisop.f apd12.f apd1.f apd2.f apd3.f apd4.f apd5.f apdb1.f apdb2a.f \
apdb2.f apdb.f apdcs.f apd.f apdf.f apdoe.f apdr.f area.f arrm.f \
ascm01.f ascm02.f ascm03.f ascm04.f ascm05.f ascm06.f ascm07.f ascm08.f \
ascm09.f ascm10.f ascm11.f ascm12.f ascm13.f asdmap.f aspro.f asycon.f \
ateig.f autock.f autosv.f axis10.f axis.f axloop.f bandit.f bard.f \
bar.f bars.f basglb.f bdat01.f bdat02.f bdat03.f bdat04.f bdat05.f \
bdat06.f betrns.f bfsmat.f bgrid.f bint.f biotsv.f bishel.f bislc2.f \
bisloc.f bitpat.f bmg.f bmgtns.f border.f bound.f bread.f bseqgp.f \
btstrp.f bug.f calcv.f case.f casege.f cdcmpd.f cdcmps.f cdcomp.f \
cdetm2.f cdetm.f cdifbs.f cdivid.f cdtfbs.f cead1a.f cead.f centre.f \
cf1fbs.f cf1ort.f cf2fbs.f cf2ort.f cfactr.f cfbsor.f cfe1ao.f cfe1my.f \
cfe2ao.f cfe2my.f cfeer1.f cfeer2.f cfeer3.f cfeer4.f cfeer.f cfer3d.f \
cfer3s.f cfnor1.f cfnor2.f chkopn.f cidck.f cifsdd.f cinfbs.f cinvp1.f \
cinvp2.f cinvp3.f cinvpr.f clstab.f clvec.f cmauto.f cmcase.f cmckcd.f \
cmckdf.f cmcomb.f cmcont.f cmdisc.f cmhgen.f cmiwrt.f cmmcon.f cmrd2a.f \
cmrd2b.f cmrd2c.f cmrd2d.f cmrd2e.f cmrd2.f cmrd2f.f cmrd2g.f cmrels.f \
cmsfil.f cmsofo.f cmtimu.f cmtoc.f cmtrce.f cnorm1.f cnorm.f cnstdd.f \
cnstrc.f com12.f comb1.f comb2.f combin.f combo.f comect.f comugv.f \
cone.f conm1d.f conm1s.f conm2d.f conm2s.f contor.f copy.f cpyfil.f \
cpystr.f crdrd2.f crdrd.f create.f criggp.f crspld.f crspls.f crsub.f \
csqrtx.f csub.f csumm.f cthmck.f ctrnsp.f curcas.f curv1.f curv2.f \
curv3.f curv.f curvit.f curvps.f cxloop.f cxtrny.f cyct1.f cyct2a.f \
cyct2b.f cyct2.f dadd5.f dadd.f dadotb.f dapoly.f daxb.f dbar.f dbase.f \
dcone.f dcross.f ddamat.f ddampg.f ddcmps.f ddcomp.f ddr1a.f ddr1b.f \
ddr1.f ddr2.f ddr.f ddrmm1.f ddrmm2.f ddrmma.f ddrmm.f ddrmmp.f \
ddrmms.f ddumx.f decode.f decomp.f degree.f delete.f delkls.f delset.f \
deltkl.f desvel.f detck.f detckx.f detdet.f detfbs.f detm1.f detm3.f \
detm4.f detm5.f detm.f dfbs.f dgree.f diag36.f diagon.f diam.f dihex.f \
dipole.f dis2d8.f displa.f dist.f dk100.f dk211.f dk89.f dki.f dkint.f \
dkl.f dkls.f dlamby.f dlamg.f dlbpt2.f dlkapm.f dloop.f dlpt2.f \
dmatrs.f dmatrx.f dmfgr.f dmpfil.f dmpyad.f dmpy.f dnorm.f dpd1.f \
dpd2.f dpd3.f dpd4.f dpd5.f dpdaa.f dpdcbd.f dpd.f dplot.f dpltst.f \
dppsb.f dpps.f dpse2.f dpse3.f dpse4.f dpzy.f dqdmem.f dquad.f draw.f \
drkapm.f drod.f drwchr.f ds1a.f ds1b.f ds1etd.f ds1.f dschk.f dshear.f \
dsmg1.f dsmg2.f dstroy.f dtranp.f dtrbsc.f dtria.f dtrmem.f dtshld.f \
dtshls.f dumerg.f dumod1.f dumod2.f dumod3.f dumod4.f dumod5.f dumper.f \
dumx.f dupart.f dvectr.f dvmag.f dypz.f dzpy.f dzy.f dzymat.f eadd.f \
eandm.f ectloc.f edit.f edtl.f egnvct.f eject.f ektrmd.f ektrms.f \
elelbl.f elim.f em1d.f em2d.f em3d.f ema1d.f ema1.f ema1s.f emadtq.f \
ema.f emastq.f emfld.f emg1b.f emgcng.f emgcor.f emg.f emgfin.f \
emgold.f emgout.f emgpro.f emgtab.f empcor.f emsg.f encode.f eqmcka.f \
eqmck.f eqmckm.f eqmcks.f eqout1.f eqscod.f eqsout.f errmkn.f errtrc.f \
estmag.f etrbkd.f etrbks.f etrbmd.f etrbms.f exi2.f exio1.f exio2.f \
exiobd.f exio.f exlvl.f exo2.f extern.f f6211.f f89.f fa1.f fa1ke.f \
fa1k.f fa1pka.f fa1pke.f fa1pki.f fa1pkv.f fa2.f factor.f factru.f \
failrs.f failur.f fbs1.f fbs21.f fbs2.f fbs3.f fbs4.f fbs.f fbsi.f \
fbsii.f fbsiii.f fbsint.f fbsinv.f fbsiv.f fcurl.f fdit.f fdsub.f \
fdvect.f feer1.f feer2.f feer3.f feer4.f feerdd.f feer.f ff100.f \
ffhelp.f ffread.f filcor.f filswi.f findc.f finder.f find.f flbbd.f \
flbelm.f flbema.f flbemg.f flbmg.f flbprt.f flbset.f flface.f flfree.f \
flld.f flunam.f fmdi.f fname.f fndgrd.f fndiam.f fndlvl.f fndnxl.f \
fndpar.f fndplt.f fndpnt.f fndset.f fnxt.f fnxtvc.f fnxtvd.f fnxtv.f \
fnxtvq.f forfil.f form12.f form1.f form22.f form2.f format.f formg2.f \
formgg.f fpont.f fqrw.f fqrwv.f frbk2.f frbk.f frd2a.f frd2b.f frd2c.f \
frd2d.f frd2e.f frd2f.f frd2i.f fread.f frlga.f frlgb.f frlg.f frmax.f \
frmlta.f frmltd.f frmlt.f frmltx.f frr1a1.f frrd1c.f frrd1d.f frrd1f.f \
frrd2.f frrd.f frsw2.f frsw.f ftube.f fvrs1a.f fvrs1b.f fvrs1c.f \
fvrs1d.f fvrs1e.f fvrs2a.f fvrst1.f fvrst2.f fwmw.f fzy2.f gauss.f \
geloop.f gencos.f gend.f gendsb.f genpar.f genvec.f getblk.f getdef.f \
gfbs.f gfscom.f gfsdir.f gfshc.f gfsh.f gfsma.f gfsmo2.f gfsmod.f \
gfsmrg.f gfsmt.f gfsptn.f gfsspc.f gfstrn.f gfswch.f gibstk.f gi.f \
giggks.f gigtka.f gigtkg.f ginofl.f gipsst.f givens.f gkad1a.f gkad1c.f \
gkad.f gkam1a.f gkam1b.f gkam.f gmmatc.f gmmatd.f gmmats.f gmmerg.f \
gmprtn.f gnfist.f go.f gopen.f gp1.f gp2.f gp3a.f gp3bd.f gp3b.f \
gp3c.f gp3d.f gp3.f gp4.f gp4prt.f gp4sp.f gpcyc.f gpfdr.f gpstg.f \
gpstgn.f gptabd.f gptlbl.f gptsym.f gpwg1a.f gpwg1b.f gpwg1c.f gpwg.f \
grav.f gravl1.f gravl2.f gravl3.f grbvec.f gridip.f gtmat1.f gust1.f \
gust2.f gust3.f gust.f hbdyd.f hbdy.f hbdys.f hccom.f hdchk.f hdcoef.f \
hdlin.f hdplot.f hdplt.f hdsket.f hdsolv.f hdstat.f hdstus.f hdsurf.f \
hdvs1.f hdvsr.f head.f hess1.f hess2.f hmat.f hring.f hsbg.f iapd.f \
idf1.f idf2.f idist.f idplot.f ifb2ar.f ifp1b.f ifp1c.f ifp1d.f ifp1e.f \
ifp1.f ifp1f.f ifp1g.f ifp1h.f ifp1pc.f ifp1s.f ifp1xy.f ifp3bd.f \
ifp3b.f ifp3.f ifp4b.f ifp4c.f ifp4e.f ifp4.f ifp4f.f ifp4g.f ifp5a.f \
ifp5.f ifpdco.f ifp.f ifpmdc.f ifppar.f ifppvc.f ifs1p.f ifs2p.f \
ifs3p.f ifs4p.f ifs5p.f ifte2.f ifte4.f ift.f iftg.f ifx1bd.f ifx2bd.f \
ifx3bd.f ifx4bd.f ifx5bd.f ifx6bd.f ifx7bd.f ihexd.f ihex.f ihexsd.f \
ihexs.f ihexss.f incore.f incro.f initl2.f initl.f inptt1.f inptt2.f \
inptt3.f inptt4.f inptt5.f input4.f input.f insert.f int2a8.f int2al.f \
intert.f intfbs.f intlst.f intprt.f intvec.f inverd.f invers.f invert.f \
invfbs.f invp1.f invp2.f invp3.f invpwr.f invtr.f is2d8d.f is2d8s.f \
isft.f itcode.f itembd.f itmprt.f ittype.f iunion.f jacob2.f jacobs.f \
kbar.f kcone2.f kconed.f kcones.f kdumx.f kelas.f kelbow.f kflud2.f \
kflud3.f kflud4.f khrfn2.f khrfn3.f khrfn5.f kompnt.f korsz.f kpanel.f \
kpltst.f kqdmem.f kqdplt.f krod.f krshft.f kslot.f ksolid.f ktetra.f \
ktrapr.f ktrbsc.f ktriqd.f ktrirg.f ktrm6d.f ktrm6s.f ktrmem.f ktrpld.f \
ktrpls.f ktrplt.f ktshld.f ktshls.f ktube.f lamx.f line10.f line.f \
linein.f linel.f linkup.f loadsu.f locpt.f lodapp.f loglog.f lprops.f \
lsplin.f machck.f magbdy.f magpha.f makmcb.f mapset.f maskn.f masstq.f \
matck.f matdum.f matgen.f matgpr.f matprn.f matprt.f matvc2.f matvec.f \
matwrt.f maxdgr.f mbamg.f mbbslj.f mbcap.f mbctr.f mbdpdh.f mbgae.f \
mbgate.f mbgaw.f mbgeod.f mbmode.f mbplot.f mbprit.f mbreg.f mce1a.f \
mce1b.f mce1c.f mce1d.f mce1.f mce2.f mcone.f mdumx.f melbow.f merge1.f \
merged.f merge.f mesage.f mflud2.f mflud3.f mflud4.f mfree.f mindeg.f \
mintrp.f modac1.f modac2.f modacc.f moda.f modb.f modc.f mplprt.f \
mpy3a.f mpy3b.f mpy3c.f mpy3dr.f mpy3.f mpy3ic.f mpy3nu.f mpy3oc.f \
mpy3p.f mpy4t.f mpya3d.f mpyad.f mpydri.f mpyl.f mqdplt.f mred1a.f \
mred1b.f mred1c.f mred1d.f mred1e.f mred1.f mred2a.f mred2b.f mred2c.f \
mred2d.f mred2e.f mred2.f mred2f.f mred2g.f mred2h.f mred2i.f mred2j.f \
mred2l.f mred2m.f mred2n.f mred2o.f mred2p.f mrge.f mring.f msgwrt.f \
mslot.f msolid.f mtimsu.f mtmsu1.f mtrapr.f mtrbsc.f mtriqd.f mtrirg.f \
mtrplt.f mtrxi.f mtrxin.f mtrxo.f mxcid.f mxcids.f na12a8.f na12if.f \
nascar.f norm11.f norm1.f normal.f nrlsum.f nsinfo.f number.f numtyp.f \
odum.f odumx.f of1pbd.f of2pbd.f of3pbd.f of3sbd.f of4pbd.f of5pbd.f \
of6pbd.f of7pbd.f of7sbd.f of8pbd.f of9pbd.f ofcomp.f ofp1a.f ofp1bd.f \
ofp1b.f ofp1c.f ofp1.f ofp5bd.f ofpcc1.f ofpcc2.f ofpcf1.f ofpcf2.f \
ofpcs1.f ofpcs2.f ofp.f ofpgpw.f ofpmis.f ofppnt.f ofppun.f ofprf1.f \
ofprf2.f ofprs1.f ofprs2.f ofpsn1.f ofpss1.f ofrf2s.f ofrs2s.f ofsnbd.f \
ofsplt.f ofssbd.f oldel1.f oldel2.f oldel3.f olplot.f onetwo.f onlins.f \
open.f opt2a.f opt2b.f opt2c.f opt2d.f optp1a.f optp1b.f optp1c.f \
optp1d.f optpr1.f optpr2.f optpx1.f optpx.f order.f ortck.f ortho.f \
oscxrf.f outmsc.f outpak.f outpt1.f outpt2.f outpt3.f outpt4.f outpt5.f \
outpt.f page2.f page.f pakcol.f param.f paraml.f partn1.f partn2.f \
partn3.f partn.f pcoord.f permut.f perpec.f pexit.f phdmia.f pidck.f \
piklvl.f pkbar.f pkqad1.f pkqad2.f pkqdm1.f pkqdm.f pkqdms.f pkqdpl.f \
pkrod.f pktq1.f pktq2.f pktrbs.f pktri1.f pktri2.f pktrm1.f pktrm.f \
pktrms.f pktrpl.f pktrq2.f pktrqd.f pla1.f pla2.f pla31.f pla32.f \
pla3.f pla41.f pla42.f pla4bd.f pla4b.f pla4.f plamat.f plbar1.f \
pload1.f pload3.f pload4.f pload.f ploadx.f ploapf.f plod4d.f plod4s.f \
plotbd.f plot.f pltmrg.f pltopr.f pltset.f plttra.f pnm.f polypt.f \
prefix.f preloc.f premat.f presax.f pretab.f pretrd.f pretrs.f print.f \
proces.f procom.f prolat.f prompt.f prtint.f prtmsg.f prtprm.f psbar.f \
psqad1.f psqad2.f psqdm1.f psqdm.f psqpl1.f psrod.f psta.f pstamg.f \
pstpl1.f pstq1.f pstq2.f pstrb1.f pstri1.f pstri2.f pstrm1.f pstrm.f \
pstrq2.f pthbdy.f ptintr.f pull.f push.f q2bcd.f q2bcs.f q2trmd.f \
q2trms.f q4bmgd.f q4bmgs.f q4gmgs.f q4nrms.f q4shps.f qdmem.f qdmm1d.f \
qdmm1.f qdmm1s.f qdmm1x.f qdmm2d.f qdmm2.f qdmm2s.f qdplt.f qhbdy.f \
qloadl.f qparam.f qparmd.f qparmr.f qriter.f quad4d.f quad4s.f qvol.f \
rand1.f rand2.f rand3.f rand5.f rand6.f rand7.f rand8.f random.f \
rbmg1.f rbmg2.f rbmg3.f rbmg4.f rcard2.f rcard.f rcova.f rcovb.f \
rcovc.f rcovds.f rcove.f rcovem.f rcovim.f rcovls.f rcovms.f rcovo.f \
rcovqv.f rcovr3.f rcovr.f rcovsl.f rcovss.f rcovui.f rcovuo.f rcovva.f \
rdmodx.f re2al.f read1.f read2.f read3.f read4.f read6.f read7.f \
readbd.f reduce.f redu.f reig.f relabl.f remflx.f rename.f retblk.f \
rfopen.f rforce.f rmg.f rodd.f rod.f rods.f rombdk.f romber.f rombsk.f \
rotate.f rotat.f rowdyz.f rsetup.f rsort.f ruler.f rzintd.f rzints.f \
sadd.f sadotb.f sanorm.f saxb.f saxif1.f saxif2.f sbar1.f sbar2.f \
sbspl2.f scalar.f scaled.f scalex.f scan.f scat.f sce1.f scheme.f \
scone1.f scone2.f scone3.f scrlm.f sd2rhd.f sdcin.f sdcins.f sdcmm.f \
sdcmps.f sdcmq.f sdcom1.f sdcom2.f sdcom3.f sdcom4.f sdcomp.f sdcout.f \
sdhtf1.f sdhtf2.f sdhtff.f sdr1a.f sdr1b.f sdr1.f sdr2aa.f sdr2a.f \
sdr2bd.f sdr2b.f sdr2c.f sdr2d.f sdr2e.f sdr2.f sdr3a.f sdr3.f sdrchk.f \
sdretd.f sdrht.f sdumx1.f sdumx2.f seemat.f selas1.f selas2.f selbo1.f \
selbo2.f selcam.f semdbd.f semint.f seteq.f setfnd.f setig.f setinp.f \
setlvl.f setval.f sfarea.f sfetch.f sgena.f sgenb.f sgen.f sgenm.f \
shape.f shcsgd.f shctsd.f shctss.f sheard.f shears.f shfors.f shgmgd.f \
shgmgs.f shlsts.f shpsts.f shsetd.f shsets.f shstns.f shstss.f shstts.f \
shxtrs.f sihex1.f sihex2.f sinc0s.f sjump.f skpfrm.f skprec.f sma1a.f \
sma1bd.f sma1b.f sma1.f sma2a.f sma2bd.f sma2b.f sma2.f sma3a.f sma3b.f \
sma3c.f sma3.f smleig.f smmats.f smp1.f smp2.f smpyad.f smsg.f snpdf.f \
sofcls.f sofi.f sofint.f sofo.f sofopn.f sofsiz.f softoc.f softrl.f \
sofut.f solid.f solve1.f solve.f solver.f sortdg.f sort.f sorti.f \
spanl1.f spanl2.f splt10.f sptchk.f sqdm11.f sqdm12.f sqdm21.f sqdm22.f \
sqdme1.f sqdpl1.f sqrtm.f squd41.f squd42.f srod1.f srod2.f ss2d81.f \
ss2d82.f ssg1a.f ssg1.f ssg2a.f ssg2b.f ssg2c.f ssg2.f ssg3a.f ssg3.f \
ssg4.f ssgetd.f ssght1.f ssght2.f ssght.f ssghtp.f ssgkhi.f ssgslt.f \
sslot1.f sslot2.f ssold1.f ssold2.f ssplin.f sswtch.f stack.f step2.f \
step.f stord1.f stord2.f stpaic.f stpax1.f stpax2.f stpax3.f stpbg.f \
stpbs0.f stpbs1.f stpda.f stpk.f stplot.f stpphi.f stppt2.f stqme2.f \
strap1.f strap2.f strax1.f strax2.f strax3.f strbs1.f stri31.f stri32.f \
strir1.f strir2.f strm61.f strm62.f strme1.f strp11.f strp12.f strpl1.f \
strpts.f strqd1.f strqd2.f strscn.f strsl1.f strsl2.f strslv.f stube1.f \
sub1.f suba.f subbb.f subb.f subcc.f subc.f sub.f subi.f subpb.f \
subp.f subph1.f summ.f sumphi.f suplt.f suread.f suwrt.f switch.f \
sxloop.f symbol.f t3bgbs.f t3bmgd.f t3bmgs.f t3gemd.f t3gems.f t3pl4d.f \
t3pl4s.f t3setd.f t3sets.f ta1abd.f ta1a.f ta1b.f ta1ca.f ta1c.f \
ta1cpd.f ta1cps.f ta1etd.f ta1.f ta1h.f tabfbd.f tabfmt.f table5.f \
tablev.f tabpch.f tabprt.f tabpt.f tapbit.f temp.f termsd.f termss.f \
tetra.f tiger.f timal3.f timeeq.f timts1.f timts2.f timtst.f tipe.f \
tis2d8.f tker.f tktztk.f tldrs.f tlodm6.f tlodsl.f tlodt1.f tlodt2.f \
tlodt3.f tlqd4d.f tlqd4s.f tltr3d.f tltr3s.f tmtogo.f tmtsio.f tmtslp.f \
tmtsot.f tordrd.f tordrs.f totape.f tpztem.f tquads.f traile.f trail.f \
tranem.f tranp1.f transp.f trapad.f trapax.f trbscd.f trbsc.f trbscs.f \
trd1a2.f trd1a.f trd1c2.f trd1c.f trd1d2.f trd1d.f trd1e.f trd.f tree.f \
trht1a.f trht1b.f trht1c.f trht.f tria3d.f tria3s.f triaad.f triaax.f \
tridi.f trif.f trimem.f triqd.f trlga.f trlgb.f trlgc.f trlgd.f trlg.f \
trmemd.f trmems.f trnsp.f trnsps.f trplmd.f trplms.f trplt.f trttem.f \
tshear.f tspl1d.f tspl1s.f tspl2d.f tspl2s.f tspl3d.f tspl3s.f ttlpge.f \
ttordr.f ttrapr.f ttrirg.f tubed.f tubes.f tvor.f twistd.f twists.f \
type10.f typflt.f typint.f umfzdd.f unpscr.f upart.f upcase.f usrmsg.f \
valvec.f varian.f vdra.f vdrbd.f vdrb.f vdr.f vec.f vecprt.f viscd.f \
viscs.f wavey.f wilvec.f wplt10.f wrtmsg.f wrtprt.f wrttrl.f xcei.f \
xchk.f xclean.f xcsa.f xdcode.f xdph.f xfadj1.f xfldef.f xflord.f \
xflszd.f xgpibs.f xgpidd.f xgpidg.f xgpi.f xgpimw.f xipfl.f xlnkdd.f \
xlnkhd.f xmpldd.f xosgen.f xparam.f xpolck.f xpunp.f xpurge.f xrcard.f \
xread.f xrecps.f xrgdcf.f xrgdev.f xrgdfm.f xrgdtb.f xrgdtp.f xrgnum.f \
xrgsst.f xrgsub.f xsave.f xscndm.f xsem01.f xsem02.f xsem03.f xsem04.f \
xsem05.f xsem06.f xsem07.f xsem08.f xsem09.f xsem10.f xsem11.f xsem12.f \
xsem13.f xsem14.f xsem15.f xsemx.f xsfabd.f xsfadd.f xsfa.f xsort2.f \
xsort.f xsosgn.f xtrnsy.f xtrny1.f xychar.f xydump.f xyfind.f xygraf.f \
xylog.f xyout.f xyplot.f xyprpl.f xyprpt.f xytics.f xytran.f yrcard.f \
zeroc.f zj.f

