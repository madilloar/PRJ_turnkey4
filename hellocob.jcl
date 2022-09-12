//COBOL    JOB ,'MADILLOAR',CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1)
//*********************************************************************
//*        DEFINE COMPILE AND LINK AND EXECUTE PROCEDURE
//*********************************************************************
//CLEXEC   PROC
//*--------------------------------------------------------------------
//*        COMPILE
//*--------------------------------------------------------------------
//COMPILE  EXEC PGM=IKFCBL00,REGION=4096K,
//         PARM='NOSEQ,DMAP,PMAP'
//SYSPRINT DD SYSOUT=*
//SYSPUNCH DD SYSOUT=*
//SYSLIB   DD UNIT=SYSDA,SPACE=(TRK,(1,,1))
//SYSUT1   DD UNIT=SYSDA,SPACE=(460,(700,100))
//SYSUT2   DD UNIT=SYSDA,SPACE=(460,(700,100))
//SYSUT3   DD UNIT=SYSDA,SPACE=(460,(700,100))
//SYSUT4   DD UNIT=SYSDA,SPACE=(460,(700,100))
//SYSLIN   DD DISP=(MOD,PASS),UNIT=SYSDA,SPACE=(80,(500,100))
//*--------------------------------------------------------------------
//*        LINK
//*--------------------------------------------------------------------
//LINK     EXEC PGM=IEWL,REGION=2048K,
//         PARM='LIST,LET,MAP,XREF'
//SYSPRINT DD SYSOUT=*
//SYSLIN   DD DISP=(OLD,DELETE),DSNAME=*.COMPILE.SYSLIN
//         DD DDNAME=SYSIN
//SYSLMOD  DD DISP=(,PASS),DSNAME=&GODATA(RUN),
//            UNIT=SYSDA,SPACE=(1024,(50,20,1))
//SYSLIB   DD DISP=SHR,DSNAME=SYS1.COBLIB
//SYSUT1   DD UNIT=(SYSDA,SEP=(SYSLIN,SYSLMOD)),SPACE=(1024,(50,20))
//*--------------------------------------------------------------------
//*        EXECUTE
//*--------------------------------------------------------------------
//EXECUTE  EXEC PGM=*.LINK.SYSLMOD,COND=((5,LT,COMPILE),(5,LT,LINK))
//SYSPRINT DD SYSOUT=*
//         PEND
//*********************************************************************
//*        LIKE HERE DOCUMENT
//*********************************************************************
//HEREDOC  EXEC CLEXEC
//COMPILE.SYSIN DD *
000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID.  'HELLO-WORLD'.
000300 ENVIRONMENT DIVISION.
000400 CONFIGURATION SECTION.
000500 DATA DIVISION.
000600 WORKING-STORAGE SECTION.
000700 77  HELLO-MSG     PIC X(12) VALUE 'Hello World!'.
000800*--1----+----2----+----3----+----4----+----5----+----6----+----7--
000900 PROCEDURE DIVISION.
001000     DISPLAY HELLO-MSG UPON CONSOLE.
001100     GOBACK.
//
//
