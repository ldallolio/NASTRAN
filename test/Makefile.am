TESTS = bar.inp buckling_solid_shell_bar.bdf \
freq_solid_shell_bar.bdf mode_solid_shell_bar.bdf \
static_solid_shell_bar.bdf static_solid_shell_bar_pload1.bdf

XFAIL_TESTS =  buckling_solid_shell_bar.bdf \
freq_solid_shell_bar.bdf mode_solid_shell_bar.bdf \
static_solid_shell_bar.bdf static_solid_shell_bar_pload1.bdf

TEST_EXTENSIONS = .inp .bdf
INP_LOG_COMPILER = ./testrunner.sh
BDF_LOG_COMPILER = ./testrunner.sh

clean-local:
	-rm -f *.out *.in12 *.out11 *.nptp *.plt *.pnh *.log *.15 *.16 *.76
