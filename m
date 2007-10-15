From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 07:09:15 -0400
Message-ID: <E1IhNox-0004n2-N5@fencepost.gnu.org>
References: <1192293466.17584.95.camel@homebase.localnet>
	<uy7e6keyv.fsf@gnu.org>
	<1192381040.4908.57.camel@homebase.localnet>
	<1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
	<47125F74.9050600@op5.se>
	<Pine.LNX.4.64.0710141934310.25221@racer.site> 
	<47126957.1020204@op5.se>
	<Pine.LNX.4.64.0710142112540.25221@racer.site> 
	<20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
	<Pine.LNX.4.64.0710150039120.25221@racer.site>
	<4712B616.165BBF8D@dessent.net>
	<Pine.LNX.4.64.0710150217120.25221@racer.site>
	<Pine.LNX.4.64.0710150223230.25221@racer.site>
	<E1IhJ4K-00086x-5U@fencepost.gnu.org>
	<AD60F584-7AAD-4083-9BA6-21F0D00D6D1D@zib.de>
	<E1IhLBW-0006uw-19@fencepost.gnu.org>
	<Pine.LNX.4.64.0710150946500.25221@racer.site>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: prohaska@zib.de, make-w32@gnu.org, raa.lkml@gmail.com, ae@op5.se,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org Mon Oct 15 13:09:46 2007
Return-path: <make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org>
Envelope-to: gnu-make-w32@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhNpD-0001GA-VP
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 13:09:32 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1IhNp7-0005xn-2T
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 07:09:25 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1IhNp0-0005wJ-Vf
	for make-w32@gnu.org; Mon, 15 Oct 2007 07:09:19 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1IhNoz-0005vD-F5
	for make-w32@gnu.org; Mon, 15 Oct 2007 07:09:18 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1IhNoz-0005v9-3b
	for make-w32@gnu.org; Mon, 15 Oct 2007 07:09:17 -0400
Received: from fencepost.gnu.org ([140.186.70.10])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <eliz@gnu.org>) id 1IhNoy-0007L8-N0
	for make-w32@gnu.org; Mon, 15 Oct 2007 07:09:16 -0400
Received: from eliz by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <eliz@gnu.org>)
	id 1IhNox-0004n2-N5; Mon, 15 Oct 2007 07:09:15 -0400
In-reply-to: <Pine.LNX.4.64.0710150946500.25221@racer.site> (message from
	Johannes Schindelin on Mon, 15 Oct 2007 09:47:25 +0100 (BST))
X-detected-kernel: by monty-python.gnu.org: Linux 2.6, seldom 2.4 (older, 4)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60984>

> Date: Mon, 15 Oct 2007 09:47:25 +0100 (BST)
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org, 
>     raa.lkml@gmail.com, ae@op5.se, tsuna@lrde.epita.fr, make-w32@gnu.org
> 
> If you could make Git compile with Visual C++, that would be fabulous.

I prefer GCC (the MinGW port), but without the MSYS ports of
additional tools.  I use the GnuWin32 ports augmented by some of my
own (where GnuWin32 ports are buggy or terribly slow).
