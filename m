From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit annotations (was:: Octopus merge: unique (?) to git, but
 is it useful?)
Date: Tue, 3 Jun 2008 21:33:18 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806032131300.13507@racer.site.net>
References: <200806030314.03252.jnareb@gmail.com> <200806030932.03051.jnareb@gmail.com> <alpine.LFD.1.10.0806031244290.3473@woody.linux-foundation.org> <200806032227.02951.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 22:35:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3dEG-0003lA-Te
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 22:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbYFCUeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 16:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbYFCUeo
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 16:34:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:43092 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751762AbYFCUen (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 16:34:43 -0400
Received: (qmail invoked by alias); 03 Jun 2008 20:34:35 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 03 Jun 2008 22:34:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+tMqcBtsit1k7/q5bDffViQ3lU7rxp8p09gjrHHI
	yp5b3BagOCp2U6
X-X-Sender: gene099@racer.site.net
In-Reply-To: <200806032227.02951.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83705>

Hi,

On Tue, 3 Jun 2008, Jakub Narebski wrote:

> Linus Torvalds wrote:
> 
> > One of the things I could imagine using git for is to have "annotation 
> > branches" for things like code review etc. They'd be a real branch in 
> > their own right and with their own history, but at the same time they 
> > could well want to point back to the "code branch" that they annotate 
> > by considering that another parent in a "non-data merge" (and yes, 
> > you'd obviously have to use a special merge strategy for things like 
> > that, but you'd likely integrate it in some "annotation tool chain" 
> > rather than anything else).
> 
> By the way, what is status of git-notes / commit annotations?  Did it got
> abandoned, on hiatus, or what?

You probably meant to Cc: me, and Linus, right?

I all but abandoned it.  It works, but I do not need it, and kind of 
waited for the guy who wanted them to chime in, so that I did not waste my 
time in vain.

IIRC it was Johan Herland, but I could be wrong.

Ciao,
Dscho
