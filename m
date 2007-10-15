From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 21:36:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710152136130.25221@racer.site>
References: <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> 
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> 
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> 
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> 
 <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net>
  <Pine.LNX.4.64.0710150217120.25221@racer.site> <20071015175606.GE2966@steel.home>
  <4713B367.52CEC7E2@dessent.net> <Pine.LNX.4.64.0710151938300.25221@racer.site>
 <4713BA89.633B86F2@dessent.net> <Pine.LNX.4.64.0710152026260.25221@racer.site>
 <alpine.LFD.0.999.0710151321560.6887@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Eli Zaretskii <eliz@gnu.org>, ae@op5.se, tsuna@lrde.epita.fr
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 23:30:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhWgd-0003eP-DG
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 22:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759184AbXJOUhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 16:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757941AbXJOUhE
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 16:37:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:55185 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757340AbXJOUhD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 16:37:03 -0400
Received: (qmail invoked by alias); 15 Oct 2007 20:37:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 15 Oct 2007 22:37:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+S9Ap/8NuSPEiORWO/NlQ/psFdrdSApe6NcjF5Ja
	BAYMLQZ8APDJe2
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.999.0710151321560.6887@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61041>

Hi,

On Mon, 15 Oct 2007, Linus Torvalds wrote:

> On Mon, 15 Oct 2007, Johannes Schindelin wrote:
> > 
> > Bash we can fix in the long run (this goes under the keyword 
> > "builtinification" on the git list)
> 
> I thought busybox was being used for the core commands? Is ash not 
> complete/usable enough (with all the fixes git has had for broken 
> shells) to be used?

No, not yet.  The problem is not so much ash, as Nguyen, who said that 
gitbox is not there yet.

Ciao,
Dscho
