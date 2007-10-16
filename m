From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 11:43:03 -0400
Message-ID: <E1IhoZT-0005cj-6w@fencepost.gnu.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
 <Pine.LNX.4.64.0710160032020.7638@iabervon.org> <E1IhgT2-0000bg-O6@fencepost.gnu.org>
 <Pine.LNX.4.64.0710161335260.25221@racer.site> <E1IhmHM-0002hB-HR@fencepost.gnu.org>
 <Pine.LNX.4.64.0710161422110.25221@racer.site> <E1Ihnvq-0002Xr-F9@fencepost.gnu.org> <Pine.LNX.4.64.0710161617490.25221@racer.site>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: barkalow@iabervon.org, raa.lkml@gmail.com, ae@op5.se,
	tsuna@lrde.epita.fr, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 17:43:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhoZi-0006is-FJ
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 17:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933107AbXJPPnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 11:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932987AbXJPPnH
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 11:43:07 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:33972 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933033AbXJPPnF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 11:43:05 -0400
Received: from eliz by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <eliz@gnu.org>)
	id 1IhoZT-0005cj-6w; Tue, 16 Oct 2007 11:43:03 -0400
In-reply-to: <Pine.LNX.4.64.0710161617490.25221@racer.site> (message from
	Johannes Schindelin on Tue, 16 Oct 2007 16:18:10 +0100 (BST))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61196>

> Date: Tue, 16 Oct 2007 16:18:10 +0100 (BST)
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> cc: barkalow@iabervon.org, raa.lkml@gmail.com, ae@op5.se, tsuna@lrde.epita.fr, 
>     git@vger.kernel.org
> 
> > That's a ``feature'': Explorer is the parent of all the desktop
> > display.  Kinda like the login shell on Unix: if you kill it, there
> > goes your whole session.  Except that on Windows, the OS pays
> > attention and restarts Explorer right away to get you back in
> > business.  (In first versions of Windows, there was no restarting of
> > Explorer, so if you killed it, you needed to reboot :-()
> 
> I kinda knew that.  But what's now with your recommendation to never run 
> Explorer?

I meant not to open "My Computer" and use the GUI for browsing the
directories.  If you meant that the touching of files is done even if
you don't open the GUI, then just ignore my advice: Explorer cannot be
killed.  I'm surprised that it touches files and directories,
though...
