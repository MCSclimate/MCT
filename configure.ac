#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_INIT(MCT, 1.0)

# Process the following makefiles
AC_CONFIG_FILES(mpeu/Makefile.conf mct/Makefile.conf)

# Check for the C compiler
AC_PROG_CC([cc])

# Preset FCFLAGS and F90FLAGS
if test -n "$F90FLAGS"; then
   F90TEMPFLAGS="$F90FLAGS"
   F90FLAGS=""
if test -n "$FCFLAGS"; then
   F90FLAGS="$FCFLAGS"
fi
else
if test -n "$FCFLAGS"; then
   F90TEMPFLAGS=""
   F90FLAGS="$FCFLAGS"
fi
fi
OLDF90FLAGS="$F90FLAGS"

# Check for the Fortran compiler. 
AC_PROG_F90

# Check for MPI libraries. 
AC_LANG_PUSH(Fortran 90)

AC_ARG_VAR(MPILIBS,[MPI library command line invocation])
AC_ARG_VAR(MPIHEADER,[MPI header include path])
if test -n "$MPIHEADER"; then
   F90FLAGS="$MPIHEADER"
fi
ACX_MPI
F90FLAGS="$OLDF90FLAGS"

# Check how to get the compiler version.
# This test does not work for xlf compilers.
if test "$F90" != "xlf90"; then
   _AC_PROG_F90_VERSION
fi
f90_version="$ac_f90_version_output"

AC_LANG_POP(Fortran 90)

# Checks for compiler characteristics.

# Check for endianness
AC_C_BIGENDIAN

# Check if fortran compiler creates modules files
# in uppercase or lowercase
if test "$F90" = "frt"; then
   F90FLAGS="-Am"
fi
AC_F90_MOD_UPPERCASE
F90FLAGS="$OLDF90FLAGS"

# Check the fortran name mangling scheme
AC_F90_C_NAME_MANGLING
case $ac_cv_f90_mangling in
  "lower case, underscore") 
	 name_mangling="FORTRAN_UNDERSCORE_" ;;
  "lower case, no underscore")
	 name_mangling="FORTRAN_SAME" ;;
  "upper case, no underscore")  
	 name_mangling="FORTRAN_CAPS_" ;;
  *) name_mangling="UNKNOWN" ;;
esac

# Set FPP and FPPFLAGS
AC_ARG_VAR(FPP,C-preprocessor for Fortran source code)
AC_ARG_VAR(FPPFLAGS,C-preprocessing flags for Fortran source code)

if test -z "$FPP"; then
   AC_CHECK_PROGS(FPP,[cpp],$CPP)
fi
if test -z "$FPPFLAGS"; then
   FPPFLAGS="-P -C -N -traditional"
fi

# Check that the Fortran compiler can correctly process these directives
# If not, use the C preprocessor.

defineflag="-Daardvark"
if test "$F90" = "xlf90"; then
   defineflag="-WF,-Daardvark"
fi   
if test "$F90" = "frt"; then
   defineflag="-Wp,-Daardvark"
fi

AC_CHECK_FPP_COMPILER(
[
  implicit none
#if zebra || aardvark
  character(len=25) :: ch  ! '
#endif
  ch="Does this test &
!Comment-Line
          &work? "// &
          "YES!"
], [$defineflag])

if test -n "$FPP"; then

defineflag="-Daardvark"

AC_CHECK_FPP_EXTERNAL(
[
  implicit none
#if zebra || aardvark
  character(len=25) :: ch  ! '
#endif
  ch="Does this test &
!Comment-Line
          &work? "// &
          "YES!"
], [$defineflag])

else

AC_MSG_WARN(cpp is not defined in your path)

fi

if test "$ac_cv_f90_fpp_compiler" = "yes"; then
   AC_SUBST(FRULE,[.F.o])
   AC_SUBST(F90RULE,[.F90.o])
   AC_SUBST(FRULECPP,[.FRULECPP])
   AC_SUBST(F90RULECPP,[.F90RULECPP])
fi

if test "$ac_cv_f90_fpp_compiler" = "no"; then
if test "$ac_cv_f90_fpp_external" = "no"; then
   AC_MSG_WARN(Fortran Source Preprocessing has failed)
fi
if test "$ac_cv_f90_fpp_external" = "yes"; then
   AC_SUBST(FRULE,[.FRULE])
   AC_SUBST(F90RULE,[.F90RULE])
   AC_SUBST(FRULECPP,[.F.o])
   AC_SUBST(F90RULECPP,[.F90.o])
fi
fi

# Checks OS, compiler and machine type

test "$osname"=NONE && osname=`uname -s`
test "$machinename"=NONE && machinename=`uname -m`

echo "hostname=$ac_hostname"
echo "machinename=$machinename"
echo "osname=$osname"

# Set F90FLAGS and MACHDEFS

F90FLAGS="$F90TEMPFLAGS"
AC_ARG_VAR(MACHDEFS,MCT compiler and OS flags)

# Hardcode values for specific hostnames

if test "$ac_hostname" = "user02"; then
   if test -z "$MPILIBS"; then
   if test -z "$MPIHEADER"; then
      echo "MPI path for Titan is being manually set"
      MPILIBS="-L/usr/local/vmi/mpich/lib/intel -lmpich -lvmi -ldl -lpthread"
      MPIHEADER="-I/usr/local/vmi/mpich/include"
   fi
   fi
fi

# Check OS name

if echo $osname | grep -i aix >/dev/null 2>&1; then
   if test "$ac_cv_f90_fpp_compiler" = "yes"; then
      MACHDEFS="-WF,-DSYSAIX"
   else
      MACHDEFS="-DSYSAIX $MACHDEFS"
   fi
fi
if echo $osname | grep -i darwin >/dev/null 2>&1; then
   MACHDEFS="-DSYSDARWIN $MACHDEFS"
fi
if echo $osname | grep -i unix_system_v >/dev/null 2>&1; then
   if test "$ac_cv_f90_fpp_compiler" = "yes"; then
      MACHDEFS="-Wp,-DSYSUNIXSYSTEMV"
   else
      MACHDEFS="-DSYSUNIXSYSTEMV $MACHDEFS"
   fi
fi
if echo $osname | grep -i irix64 >/dev/null 2>&1; then
   MACHDEFS="-DSYSIRIX64 $MACHDEFS"
fi
if echo $osname | grep -i irix >/dev/null 2>&1; then
if echo $MACHDEFS | grep -i irix64 >/dev/null 2>&1; then
MACHDEFS="$MACHDEFS" # do nothing
else
MACHDEFS="-DSYSIRIX $MACHDEFS"
fi
fi
if echo $osname | grep -i linux >/dev/null 2>&1; then
   MACHDEFS="-DSYSLINUX $MACHDEFS"
fi
if echo $osname | grep -i osf1 >/dev/null 2>&1; then
   MACHDEFS="-DSYSOSF1 $MACHDEFS"
fi
if echo $osname | grep -i super >/dev/null 2>&1; then
   MACHDEFS="-DSYSSUPERUX $MACHDEFS"
fi
if echo $osname | grep -i sun >/dev/null 2>&1; then
   MACHDEFS="-DSYSSUNOS $MACHDEFS"
fi
if echo $osname | grep -i t3e >/dev/null 2>&1; then
   MACHDEFS="-DSYST3E $MACHDEFS"
fi
if echo $osname | grep -i unicos >/dev/null 2>&1; then
   MACHDEFS="-DSYSUNICOS $MACHDEFS"
fi

# Set FC to MPIF90. If MPILIBS is present, set FC to F90.
AC_ARG_VAR(FC,The Fortran compiler)
FC=$MPIF90
if test "$F90" != "$MPIF90";  then
   if test -n "$MPILIBS"; then
      FC=$F90
   fi
fi

# Set the following variables by checking the compiler name
AC_ARG_VAR(FCFLAGS,Fortran compiler flags for all source files)
AC_ARG_VAR(CCFLAGS,C source compilation flags)
AC_ARG_VAR(REAL8,[Fortran compiler flag for setting the default REAL size to REAL(KIND=8)])
AC_ARG_VAR(BIT64,Fortran compiler flag for generating 64-bit objects)
AC_ARG_VAR(ENDIAN,Fortran compiler flag for converting big-endian to little-endian)
AC_ARG_VAR(INCLUDEFLAG,Fortran compiler flag for specifying module search path)
AC_ARG_VAR(INCLUDEPATH,Additional library and module paths)

# Check compiler name
case $F90 in
xlf90) 
if test -z "$REAL8"; then
   REAL8="-qrealsize=8"
fi
if test "$MACHDEFS" = "-WF,-DSYSAIX"; then
   MACHDEFS="$MACHDEFS,-DCPRXLF"
else
   MACHDEFS="-DCPRXLF $MACHDEFS"
fi
if test -z "$FCFLAGS"; then
   FCFLAGS="-qarch=auto -O2"
fi
if test -z "$F90FLAGS"; then
  if test "$ac_cv_f90_fpp_compiler" = "yes"; then
     F90FLAGS="-qsuffix=f=F90:cpp=F90"
  fi
  if test "$ac_cv_f90_fpp_compiler" = "no"; then
     if test "$ac_cv_f90_fpp_external" = "yes"; then
	F90FLAGS="-qsuffix=f=f90"
     fi
  fi
fi;;	
pgf90) 
MACHDEFS="-DCPRPGI $MACHDEFS"
if test -z "$REAL8"; then
   REAL8="-r8"
fi
if test -z "$BIT64"; then
   BIT64="-pc 64"
fi
if test -z "$ENDIAN"; then
   ENDIAN="-byteswapio"
fi;;
ftn) 
MACHDEFS="-DCPRCRAY $MACHDEFS"
if test -z "$FCFLAGS"; then 
   FCFLAGS="-em"
fi
if test -z "$INCLUDEFLAG"; then
   INCLUDEFLAG="-p"
fi;;
frt)
if test "$MACHDEFS" = "-Wp,-DSYSUNIXSYSTEMV"; then
   MACHDEFS="$MACHDEFS,-DSYSFUJITSU"
else
   MACHDEFS="-DSYSFUJITSU $MACHDEFS"
fi
if test -z "$FCFLAGS"; then
   FCFLAGS="-Am -X9"
fi
if test -z "$BIT64"; then
   BIT64="-KA64"
fi
if test -z "$REAL8"; then
   REAL8="-Ad"
fi
echo "Suggested additional vectorization flags: -Wv,-s5,-t3,-noalias,-ilfunc,-md";;
epcf90) MACHDEFS="-DCPREPC $MACHDEFS";;
lf95) MACHDEFS="-DCPRLAHEY $MACHDEFS";;
ifc | efc)
MACHDEFS="-DCPRINTEL $MACHDEFS"
if test -z "$REAL8"; then
   REAL8="-r8"
fi
if test -z "$FCFLAGS"; then
   FCFLAGS="-w"
fi
echo "Intel Compilers must set the environment variable F_UFMTENDIAN=big to do endian conversion";;
g95) MACHDEFS="-DCPRGNU $MACHDEFS";;
esac

if echo $f90_version | grep -i nag >/dev/null 2>&1; then
   MACHDEFS="-DCPRNAG $MACHDEFS"
   if test -z "$FCFLAGS"; then
      FCFLAGS="-dusty -kind=byte"
   fi
fi
if echo $f90_version | grep -i absoft >/dev/null 2>&1; then
   MACHDEFS="-DCPRABSOFT $MACHDEFS"
   if test -z "$REAL8"; then
      REAL8="-N113"
   fi    
   if test -z "$INCLUDEFLAG"; then
      INCLUDEFLAG="-p"
   fi
fi
if echo $f90_version | grep -i workshop >/dev/null 2>&1; then
   MACHDEFS="-DCPRWORKSHOP $MACHDEFS"
   if test -z "$INCLUDEFLAG"; then
      INCLUDEFLAG="-M"
   fi
fi
if echo $f90_version | grep -i mipspro >/dev/null 2>&1; then
   MACHDEFS="-DCPRMIPSPRO $MACHDEFS"
   if test -z "$FCFLAGS"; then
      FCFLAGS="-O3"
   fi
   if test -z "$CCFLAGS"; then
      CCFLAGS="-64"
   fi
   if test -z "$REAL8"; then
      REAL8="-r8"
   fi
   if test -z "$BIT64"; then
      BIT64="-64"
   fi
fi
if echo $f90_version | grep -i compaq >/dev/null 2>&1; then
   MACHDEFS="-DCPRCOMPAQ $MACHDEFS"
   MPILIBS="$MPILIBS -lelan"
   if test -z "$FCFLAGS"; then
      FCFLAGS="-fast"
   fi
   if test -z "$REAL8"; then
      REAL8="-real_size 64"
   fi
   if test -z "$ENDIAN"; then
      ENDIAN="-convert big_endian"
   fi
fi
if echo $f90_version | grep -i sx >/dev/null 2>&1; then
   MACHDEFS="-DCPRSX $MACHDEFS"
   if test -z "$FCFLAGS"; then
      FCFLAGS="-EP -Chopt -Wf'-pvctl noassoc'"
   fi
fi

case $name_mangling in
  FORTRAN_CAPS_) CCFLAGS="-DFORTRAN_CAPS_ -O $CCFLAGS";;
  FORTRAN_SAME)  CCFLAGS="-DFORTRAN_SAME -O $CCFLAGS";;
  FORTRAN_UNDERSCORE_) CCFLAGS="-O $CCFLAGS";;
  *) AC_MSG_WARN([unusual Fortran 90 name-mangling scheme])
     CCFLAGS="-O $CCFLAGS";;
esac

if test -z "$INCLUDEFLAG"; then
   INCLUDEFLAG="-I"
fi

AC_OUTPUT

echo
echo "### Output Variables: Make Sure These Are Correct! ###"
echo "CC=$CC"
echo "CCFLAGS=$CCFLAGS"
echo "FPP=$FPP"
echo "FPPFLAGS=$FPPFLAGS"
echo "FC=$FC"
echo "F90=$F90"
echo "FCFLAGS=$FCFLAGS"
echo "F90FLAGS=$F90FLAGS"
echo "REAL8=$REAL8"
echo "BIT64=$BIT64"
echo "MPIF90=$MPIF90"
echo "MPILIBS=$MPILIBS"
echo "MPIHEADER=$MPIHEADER"
echo "MACHDEFS=$MACHDEFS"
echo "ENDIAN=$ENDIAN"
echo "INCLUDEFLAG=$INCLUDEFLAG"
echo "INCLUDEPATH=$INCLUDEPATH"
echo


# test -z is true for empty strings
# test -n is true for non-empty strings