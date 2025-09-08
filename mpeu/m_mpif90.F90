!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!-----------------------------------------------------------------------
! CVS $Id$
! CVS $Name$
!-----------------------------------------------------------------------
!BOP
!
! !MODULE: m_mpif90 - additional MPI F90 functions
!
! !DESCRIPTION:
!
!   This used to provide an F90 module interface to MPI before
!   MPI libraries had their own module.  Only a few custom functions are left now
!
! !INTERFACE:

    module m_mpif90
      use mpi

      implicit none
      private

      public :: MP_type

      public :: MP_perr

      public :: MP_log2

! !REVISION HISTORY:
!       09Dec97 - Jing Guo <guo@thunder> - initial prototyping/coding.
!               . started with everything public, without any interface
!                 declaration.
!               . Then limited to only variables current expected to
!                 be used.
!       16Mar25 - R. Jacob (jacob@anl.gov) - remove most of this since MPI
!                reliably has an F90 module now.
!
!EOP
!_______________________________________________________________________


        !----------------------------------------

interface MP_type; module procedure     &
  typeI_,       & ! MPI_INTEGER
  typeL_,       & ! MPI_LOGICAL
  typeC_,       & ! MPI_CHARACTER
  typeSP_,      & ! MPI_REAL
  typeDP_,      & ! MPI_DOUBLE_PRECISION
  typeI1_,      & ! MPI_INTEGER
  typeL1_,      & ! MPI_LOGICAL
  typeC1_,      & ! MPI_CHARACTER
  typeSP1_,     & ! MPI_REAL
  typeDP1_,     & ! MPI_DOUBLE_PRECISION
  typeI2_,      & ! MPI_INTEGER
  typeL2_,      & ! MPI_LOGICAL
  typeC2_,      & ! MPI_CHARACTER
  typeSP2_,     & ! MPI_REAL
  typeDP2_        ! MPI_DOUBLE_PRECISION
end interface

interface MP_perr; module procedure perr_; end interface

  character(len=*),parameter :: myname='m_mpif90'
contains

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: typeI_ - return MPI datatype of INTEGER
!
! !DESCRIPTION:
!
! !INTERFACE:

    function typeI_(ival)
      implicit none
      integer,intent(in) :: ival
      integer :: typeI_

! !REVISION HISTORY:
!       28Sep99 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::typeI_'

  typeI_=MPI_INTEGER

end function typeI_
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: typeL_ - return MPI datatype of LOGICAL
!
! !DESCRIPTION:
!
! !INTERFACE:

    function typeL_(lval)
      implicit none
      logical,intent(in) :: lval
      integer :: typeL_

! !REVISION HISTORY:
!       28Sep99 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::typeL_'

  typeL_=MPI_LOGICAL

end function typeL_
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: typeC_ - return MPI datatype of CHARACTER
!
! !DESCRIPTION:
!
! !INTERFACE:

    function typeC_(cval)
      implicit none
      character(len=*),intent(in) :: cval
      integer :: typeC_

! !REVISION HISTORY:
!       28Sep99 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::typeC_'

  typeC_=MPI_CHARACTER

end function typeC_
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: typeSP_ - return MPI datatype of single precision REAL
!
! !DESCRIPTION:
!
! !INTERFACE:

    function typeSP_(rval)
      use m_realkinds,only : SP
      implicit none
      real(SP),intent(in) :: rval
      integer :: typeSP_

! !REVISION HISTORY:
!       28Sep99 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::typeSP_'

  typeSP_=MPI_REAL

end function typeSP_

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: typeDP_ - return MPI datatype of double precision REAL
!
! !DESCRIPTION:
!
! !INTERFACE:

    function typeDP_(rval)
      use m_realkinds,only : DP
      implicit none
      real(DP),intent(in) :: rval
      integer :: typeDP_

! !REVISION HISTORY:
!       28Sep99 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::typeDP_'

  typeDP_=MPI_DOUBLE_PRECISION

end function typeDP_

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: typeI1_ - return MPI datatype of INTEGER
!
! !DESCRIPTION:
!
! !INTERFACE:

    function typeI1_(ival)
      implicit none
      integer,dimension(:),intent(in) :: ival
      integer :: typeI1_

! !REVISION HISTORY:
!       28Sep99 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::typeI1_'

  typeI1_=MPI_INTEGER

end function typeI1_
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: typeL1_ - return MPI datatype of LOGICAL
!
! !DESCRIPTION:
!
! !INTERFACE:

    function typeL1_(lval)
      implicit none
      logical,dimension(:),intent(in) :: lval
      integer :: typeL1_

! !REVISION HISTORY:
!       28Sep99 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::typeL1_'

  typeL1_=MPI_LOGICAL

end function typeL1_
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: typeC1_ - return MPI datatype of CHARACTER
!
! !DESCRIPTION:
!
! !INTERFACE:

    function typeC1_(cval)
      implicit none
      character(len=*),dimension(:),intent(in) :: cval
      integer :: typeC1_

! !REVISION HISTORY:
!       28Sep99 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::typeC1_'

  typeC1_=MPI_CHARACTER

end function typeC1_
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: typeSP1_ - return MPI datatype of single precision REAL
!
! !DESCRIPTION:
!
! !INTERFACE:

    function typeSP1_(rval)
      use m_realkinds,only : SP
      implicit none
      real(SP),dimension(:),intent(in) :: rval
      integer :: typeSP1_

! !REVISION HISTORY:
!       28Sep99 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::typeSP1_'

  typeSP1_=MPI_REAL

end function typeSP1_

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: typeDP1_ - return MPI datatype of double precision REAL
!
! !DESCRIPTION:
!
! !INTERFACE:

    function typeDP1_(rval)
      use m_realkinds,only : DP
      implicit none
      real(DP),dimension(:),intent(in) :: rval
      integer :: typeDP1_

! !REVISION HISTORY:
!       28Sep99 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::typeDP1_'

  typeDP1_=MPI_DOUBLE_PRECISION

end function typeDP1_

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: typeI2_ - return MPI datatype of INTEGER
!
! !DESCRIPTION:
!
! !INTERFACE:

    function typeI2_(ival)
      implicit none
      integer,dimension(:,:),intent(in) :: ival
      integer :: typeI2_

! !REVISION HISTORY:
!       28Sep99 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::typeI2_'

  typeI2_=MPI_INTEGER

end function typeI2_
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: typeL2_ - return MPI datatype of LOGICAL
!
! !DESCRIPTION:
!
! !INTERFACE:

    function typeL2_(lval)
      implicit none
      logical,dimension(:,:),intent(in) :: lval
      integer :: typeL2_

! !REVISION HISTORY:
!       28Sep99 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::typeL2_'

  typeL2_=MPI_LOGICAL

end function typeL2_
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: typeC2_ - return MPI datatype of CHARACTER
!
! !DESCRIPTION:
!
! !INTERFACE:

    function typeC2_(cval)
      implicit none
      character(len=*),dimension(:,:),intent(in) :: cval
      integer :: typeC2_

! !REVISION HISTORY:
!       28Sep99 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::typeC2_'

  typeC2_=MPI_CHARACTER

end function typeC2_
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: typeSP2_ - return MPI datatype of single precision REAL
!
! !DESCRIPTION:
!
! !INTERFACE:

    function typeSP2_(rval)
      use m_realkinds,only : SP
      implicit none
      real(SP),dimension(:,:),intent(in) :: rval
      integer :: typeSP2_

! !REVISION HISTORY:
!       28Sep99 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::typeSP2_'

  typeSP2_=MPI_REAL

end function typeSP2_

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: typeDP2_ - return MPI datatype of double precision REAL
!
! !DESCRIPTION:
!
! !INTERFACE:

    function typeDP2_(rval)
      use m_realkinds,only : DP
      implicit none
      real(DP),dimension(:,:),intent(in) :: rval
      integer :: typeDP2_

! !REVISION HISTORY:
!       28Sep99 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::typeDP2_'

  typeDP2_=MPI_DOUBLE_PRECISION

end function typeDP2_

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: perr_ - MPI error information hanlder
!
! !DESCRIPTION:
!
! !INTERFACE:

    subroutine perr_(proc,MP_proc,ierror)
      use m_stdio, only : stderr
      implicit none
      character(len=*),intent(in) :: proc
      character(len=*),intent(in) :: MP_proc
      integer,intent(in) :: ierror

! !REVISION HISTORY:
!       21Apr98 - Jing Guo <guo@thunder> - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::perr_'

  character(len=MPI_MAX_ERROR_STRING) :: estr
  integer :: ln,ier

  call MPI_error_string(ierror,estr,ln,ier)
  if(ier /= 0 .or. ln<=0) then
    write(stderr,'(4a,i4)') proc,': ',  &
        MP_proc,' error, ierror =',ierror
  else
    write(stderr,'(6a)') proc,': ',     &
        MP_proc,' error, "',estr(1:ln),'"'
  endif

end subroutine perr_

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: MP_log2 - The smallest integer its power of 2 is >= nPE
!
! !DESCRIPTION:
!
! !INTERFACE:

    function MP_log2(nPE)
      implicit none
      integer,intent(in) :: nPE
      integer :: MP_log2

! !REVISION HISTORY:
!       01Feb00 - Jing Guo <guo@dao.gsfc.nasa.gov>
!               - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::MP_log2'

  integer :: n2

  MP_log2=0
  n2=1
  do while(n2<nPE)
    MP_log2 = MP_log2+1
    n2 = n2+n2
  end do

end function MP_log2

end module m_mpif90
!.
