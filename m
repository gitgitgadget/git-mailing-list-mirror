From: Nicolas Pitre <nico@cam.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 12:04:29 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710161201510.19446@xanadu.home>
References: <47125F74.9050600@op5.se>
 <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se>
 <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
 <471448D0.6080200@op5.se> <E1Ihfrl-0007w1-3I@fencepost.gnu.org>
 <20071016155608.GA10603@old.davidb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Eli Zaretskii <eliz@gnu.org>, Andreas Ericsson <ae@op5.se>,
	barkalow@iabervon.org, raa.lkml@gmail.com,
	Johannes.Schindelin@gmx.de, tsuna@lrde.epita.fr,
	git@vger.kernel.org, make-w32@gnu.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:05:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihouj-0003Jw-4q
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 18:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbXJPQEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 12:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbXJPQEu
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 12:04:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44564 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbXJPQEt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 12:04:49 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ00011RHZ83VE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Oct 2007 12:04:21 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071016155608.GA10603@old.davidb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61202>

On Tue, 16 Oct 2007, David Brown wrote:

> On Tue, Oct 16, 2007 at 02:25:21AM -0400, Eli Zaretskii wrote:
> 
> > On the other hand, what packages have 100K files?  If there's only one
> > -- the Linux kernel -- then I think this kind of performance is for
> > all practical purposes unimportant on Windows, because while it is
> > reasonable to assume that someone would like to use git on Windows,
> > assuming that someone will develop the Linux kernel on Windows is --
> > how should I put it -- _really_ far-fetched ;-)
> 
> Oh, I wish others could think this clearly.  Quoting a serious line off of
> a task list at an unnamed company:
> 
>   - Make Linux kernel compile under windows.
> 
> I don't think it will move past just being a wish list item, but there seem
> to be people that think it should be done.

Linux is compilable on Windows, and has been for a long time already.
With Cygwin it is pretty trivial to do.  I prefer native Linux though.


Nicolas
