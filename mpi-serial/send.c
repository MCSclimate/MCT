#include "mpiP.h"


/*
 * SENDING
 *
 */



static int mpi_match_recv(void *r, void *tag)
{
    return( ((Req *)r)->tag == MPI_ANY_TAG ||
	  ((Req *)r)->tag == *((int *)tag) );
}


/*
 *
 */



int FC_FUNC( mpi_isend , MPI_ISEND )(void *buf, int *count, int *datatype,
   int *dest, int *tag, int *comm, int *req, int *ierror)
{

  *ierror=MPI_Isend(buf,*count,*datatype,*dest,*tag,
		    *comm, (void *)req);

  return MPI_SUCCESS;
}



int MPI_Isend(const void *buf, int count, MPI_Datatype datatype,
	      int dest, int tag, MPI_Comm comm, MPI_Request *request)
{
  pListitem match;
  Comm *mycomm;
  Req *rreq, *sreq;

  mycomm=mpi_handle_to_ptr(comm);   /* (Comm *)comm; */

#ifdef INFO
  fflush(stdout);
  fprintf(stderr,"MPI_Isend: Comm=%d  tag=%d  count=%d type=%d\n",
	 mycomm->num,tag,count,datatype);
#endif

  if (dest!=0 && dest!=MPI_PROC_NULL)
    {
      fprintf(stderr,"MPI_Isend: send to %d\n",dest);
      abort();
    }

  mpi_alloc_handle(request,(void **) &sreq);


  if (dest==MPI_PROC_NULL)
    {
      sreq->complete=1;
      return(MPI_SUCCESS);
    }
  if (( match=AP_list_search_func(mycomm->recvlist,mpi_match_recv,&tag)))
    {
      rreq=(Req *)AP_listitem_data(match);
      AP_list_delete_item(mycomm->recvlist,match);

      copy_data2(buf, count, datatype, rreq->buf, rreq->count, rreq->type);
      rreq->complete=1;
      rreq->source=0;
      rreq->tag=tag;                    /* in case rreq->tag was MPI_ANY_TAG */

      sreq->complete=1;

#ifdef DEBUG
      printf("Completion(send) value=%d tag=%d\n",
	     *((int *)buf),rreq->tag);
#endif

      return(MPI_SUCCESS);
    }

  sreq->buf=(void*)buf; /* Explicit cast to suppress discarded-qualifiers warning */
  sreq->tag=tag;
  sreq->complete=0;
  sreq->listitem=AP_list_append(mycomm->sendlist,sreq);

#ifdef INFO
  print_list(mycomm->sendlist,"sendlist for comm ",mycomm->num);
#endif

  return(MPI_SUCCESS);
}


/*********/


int FC_FUNC(mpi_send, MPI_SEND) ( void *buf, int *count, int *datatype,
 		                int *dest, int *tag, int *comm, int *ierror)
{
  *ierror=MPI_Send(buf, *count, *datatype, *dest, *tag, *comm);
  return MPI_SUCCESS;
}



int MPI_Send(const void* buf, int count, MPI_Datatype datatype,
	     int dest, int tag, MPI_Comm comm)
{
  MPI_Request request;
  MPI_Status status;

#ifdef INFO
  fflush(stdout);
  fprintf(stderr,"MPI_Send: ");
#endif

  MPI_Isend(buf,count,datatype,dest,tag,comm,&request);
  MPI_Wait(&request,&status);


  return(MPI_SUCCESS);
}




/*********/


int FC_FUNC(mpi_ssend, MPI_SSEND) ( void *buf, int *count, int *datatype,
                                  int *dest, int *tag, int *comm, int *ierror)
{
  *ierror=MPI_Send(buf, *count, *datatype, *dest, *tag, *comm);
  return MPI_SUCCESS;
}



int MPI_Ssend(const void* buf, int count, MPI_Datatype datatype,
              int dest, int tag, MPI_Comm comm)
{
  return(MPI_Send(buf,count,datatype,dest,tag,comm));
}



/*********/


int FC_FUNC(mpi_rsend, MPI_RSEND) ( void *buf, int *count, int *datatype,
                                  int *dest, int *tag, int *comm, int *ierror)
{
  *ierror=MPI_Send(buf, *count, *datatype, *dest, *tag, *comm);
  return MPI_SUCCESS;
}



int MPI_Rsend(const void* buf, int count, MPI_Datatype datatype,
              int dest, int tag, MPI_Comm comm)
{
  return(MPI_Send(buf,count,datatype,dest,tag,comm));
}




/*********/



int FC_FUNC( mpi_irsend , MPI_IRSEND )(void *buf, int *count, int *datatype,
   int *dest, int *tag, int *comm, int *req, int *ierror)
{

  *ierror=MPI_Irsend(buf,*count,*datatype,*dest,*tag,
                    *comm, (void *)req);

  return MPI_SUCCESS;
}



int MPI_Irsend(const void *buf, int count, MPI_Datatype datatype,
               int dest, int tag, MPI_Comm comm, MPI_Request *request)
{
  Req *req;


  MPI_Isend(buf,count,datatype,dest,tag,comm,request);

  /* Ready mode implied a receive must already be posted,
   * so the Isend should have completed already.
   * Can't use MPI_Test here for the error check because
   * it would clear the request prematurely.
   */

  req=mpi_handle_to_ptr(*request);
  if ( !req->complete )
    {
      fprintf(stderr,"MPI_Irsend: no matching receive found\n");
      abort();
    }


  return(MPI_SUCCESS);
}




/*********/


int FC_FUNC(mpi_sendrecv, MPI_SENDRECV) (
     void *sendbuf, int *sendcount, int *sendtype, int *dest, int *sendtag,
     void *recvbuf, int *recvcount, int *recvtype, int *source, int *recvtag,
     int *comm, int *status,
     int *ierror)
{
  *ierror=MPI_Sendrecv(sendbuf, *sendcount, *sendtype, *dest, *sendtag,
                       recvbuf, *recvcount, *recvtype, *source, *recvtag,
                       *comm, mpi_c_status(status));
  return MPI_SUCCESS;
}



int MPI_Sendrecv(const void* sendbuf, int sendcount, MPI_Datatype sendtype,
                 int dest, int sendtag,
                 void *recvbuf, int recvcount, MPI_Datatype recvtype,
                 int source, int recvtag,
                 MPI_Comm comm, MPI_Status *status)
{
  MPI_Request request;


  MPI_Irecv(recvbuf, recvcount, recvtype, source, recvtag, comm, &request);

  MPI_Send(sendbuf, sendcount, sendtype, dest, sendtag, comm);

  MPI_Wait(&request,status);


  return(MPI_SUCCESS);
}



