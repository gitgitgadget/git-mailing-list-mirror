From: "Dave Korn" <dave.korn@artimi.com>
Subject: RE: Switching from CVS to GIT
Date: Sun, 14 Oct 2007 23:59:35 +0100
Message-ID: <023101c80eb5$e3b6b310$2e08a8c0@CAM.ARTIMI.COM>
References: <1192293466.17584.95.camel@homebase.localnet><uy7e6keyv.fsf@gnu.org><1192381040.4908.57.camel@homebase.localnet><1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr><47125F74.9050600@op5.se><Pine.LNX.4.64.0710141934310.25221@racer.site><47126957.1020204@op5.se><Pine.LNX.4.64.0710142112540.25221@racer.site>
	<20071014221446.GC2776@steel.home>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: 'Andreas Ericsson' <ae@op5.se>, 'Make Windows' <make-w32@gnu.org>,
	'git list' <git@vger.kernel.org>
To: "'Alex Riesen'" <raa.lkml@gmail.com>,
	"'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
X-From: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org Mon Oct 15 00:59:54 2007
Return-path: <make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org>
Envelope-to: gnu-make-w32@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhCR5-0002iI-3x
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 00:59:51 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1IhCQy-0002x6-Et
	for gnu-make-w32@m.gmane.org; Sun, 14 Oct 2007 18:59:44 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1IhCQt-0002wP-Sa
	for make-w32@gnu.org; Sun, 14 Oct 2007 18:59:39 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1IhCQs-0002w9-4G
	for make-w32@gnu.org; Sun, 14 Oct 2007 18:59:39 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1IhCQr-0002w6-VA
	for make-w32@gnu.org; Sun, 14 Oct 2007 18:59:37 -0400
Received: from mail.artimi.com ([194.72.81.2])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dave.korn@artimi.com>) id 1IhCQr-0007i7-Hr
	for make-w32@gnu.org; Sun, 14 Oct 2007 18:59:37 -0400
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft
	SMTPSVC(6.0.3790.3959); Sun, 14 Oct 2007 23:59:35 +0100
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20071014221446.GC2776@steel.home>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
Thread-Index: AcgOs4fHch/7bR+URh6XAXw0UYKR0AAAadQg
X-OriginalArrivalTime: 14 Oct 2007 22:59:35.0261 (UTC)
	FILETIME=[E3BAF8D0:01C80EB5]
X-detected-kernel: by monty-python.gnu.org: Windows 2000 SP4, XP SP1+
X-BeenThere: make-w32@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Discussion of Windows-specific issues with GNU make <make-w32.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/make-w32>
List-Post: <mailto:make-w32@gnu.org>
List-Help: <mailto:make-w32-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/make-w32>,
	<mailto:make-w32-request@gnu.org?subject=subscribe>
Sender: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Errors-To: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60926>

On 14 October 2007 23:15, Alex Riesen wrote:

> Interprocess communication:
> 
> - no reliable text environment (I'm programming in the damn thing for
>   10 years and I still don't know how to pass an environment variable
>   _for_sure_)
> 
> - it has only one argument (limited in size) passed to started
>   programs, which means that there is no possible way to safely pass
>   file and text arguments on command line (more than one, that is)

  Whuh?

http://msdn2.microsoft.com/en-us/library/y5zz48s1(VS.80).aspx


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
