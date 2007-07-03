From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Tue, 3 Jul 2007 13:09:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707031308170.4071@racer.site>
References: <46893F61.5060401@jaeger.mine.nu>
 <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
 <46895EA4.5040803@jaeger.mine.nu> <20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
 <vpq7ipittl2.fsf@bauges.imag.fr> <Pine.LNX.4.64.0707022205210.4071@racer.site>
 <vpqoditkc23.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Yann Dirson <ydirson@altern.org>,
	Christian Jaeger <christian@jaeger.mine.nu>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jul 03 14:10:10 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5hCr-0008HY-Dm
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 14:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757960AbXGCMKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 08:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757672AbXGCMKG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 08:10:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:49638 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755993AbXGCMKF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 08:10:05 -0400
Received: (qmail invoked by alias); 03 Jul 2007 12:10:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 03 Jul 2007 14:10:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xalwjdtXxIjmvWZG/OZ1+GhmlkZmnZfk9pMfw8/
	OWivD4NBMFGYCh
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqoditkc23.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51481>

Hi,

On Tue, 3 Jul 2007, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > What's so wrong with our man pages? You know, there have been man 
> > hours invested in them, and they are exclusively meant for consumption 
> > by people who do not know about the usage of the commands...
> 
> What's wrong is just that I shouldn't have to read a man page to avoid
> data-loss.

Okay, Mr Moy. How did you learn that "rm" leads to data-loss? Because it 
does. Hmm. How did you expect then, that git-rm does _not_ lead to data 
loss? If in doubt, you _have_ to read the manual. Especially if the tool 
is powerful.

Ciao,
Dscho
