From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 02:04:48 -0400
Message-ID: <E1IhJ4K-00086x-5U@fencepost.gnu.org>
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
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: ae@op5.se, raa.lkml@gmail.com, git@vger.kernel.org, make-w32@gnu.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org Mon Oct 15 08:05:02 2007
Return-path: <make-w32-bounces+gnu-make-w32=m.gmane.org@gnu.org>
Envelope-to: gnu-make-w32@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhJ4X-0005LH-El
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 08:05:02 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1IhJ4Q-0001l6-SO
	for gnu-make-w32@m.gmane.org; Mon, 15 Oct 2007 02:04:54 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1IhJ4M-0001kk-D5
	for make-w32@gnu.org; Mon, 15 Oct 2007 02:04:50 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1IhJ4K-0001kP-U2
	for make-w32@gnu.org; Mon, 15 Oct 2007 02:04:49 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1IhJ4K-0001kL-L1
	for make-w32@gnu.org; Mon, 15 Oct 2007 02:04:48 -0400
Received: from fencepost.gnu.org ([140.186.70.10])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <eliz@gnu.org>) id 1IhJ4K-00026s-9k
	for make-w32@gnu.org; Mon, 15 Oct 2007 02:04:48 -0400
Received: from eliz by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <eliz@gnu.org>)
	id 1IhJ4K-00086x-5U; Mon, 15 Oct 2007 02:04:48 -0400
In-reply-to: <Pine.LNX.4.64.0710150223230.25221@racer.site> (message from
	Johannes Schindelin on Mon, 15 Oct 2007 02:24:53 +0100 (BST))
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60949>

> Date: Mon, 15 Oct 2007 02:24:53 +0100 (BST)
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> cc: Eli Zaretskii <eliz@gnu.org>, Alex Riesen <raa.lkml@gmail.com>, ae@op5.se, 
>     tsuna@lrde.epita.fr, make-w32@gnu.org
> 
> To clarify: git works on Windows.  Most of the time, that is.  But all 
> those changes that were necessary to go there have not yet found their way 
> into the official git.git repository.

I, for one, appreciate all the hard work invested in that.

While we are at that: can you (or someone else) point me to
instructions on how to build the MinGW port of GIT?  I found a tarball
of the MinGW-ported GIT (v1.5.3, I think), but what I don't seem to be
able to find is some kind of HOWTO: what tools I need to have
installed, how to configure them (if there are any special issues
there), what command(s) to type, etc.  Is there anything like that out
there, or can someone post such instructions?

TIA
