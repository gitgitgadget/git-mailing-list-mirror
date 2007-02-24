From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] object name: introduce ':::<oneline prefix>' notation
Date: Sat, 24 Feb 2007 03:10:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702240310220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702231930290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702232347310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm741hfx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702240229540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk5y81g4t.fsf@assigned-by-dhcp.cox.net> <alpine.LRH.0.82.0702232055060.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Feb 24 03:10:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKmN2-0000oM-TA
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 03:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933338AbXBXCKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 21:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933334AbXBXCKm
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 21:10:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:45006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933338AbXBXCKl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 21:10:41 -0500
Received: (qmail invoked by alias); 24 Feb 2007 02:10:40 -0000
X-Provags-ID: V01U2FsdGVkX1+8Ar0k/868uroHp3ZY5BNP+SYfc7xDVb3gMn3jrx
	lNBQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <alpine.LRH.0.82.0702232055060.29426@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40492>

Hi,

On Fri, 23 Feb 2007, Nicolas Pitre wrote:

> On Fri, 23 Feb 2007, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > >> By the way, where do you start digging from?  From all refs?
> > >
> > > Yes, all refs. In order of the date.
> > 
> > Then, another possibly useful extension is "start from this ref"
> > (you can give multiple and if no such refs are given keep the
> > current "from all refs" behaviour).
> 
> Can we generalize the syntax a bit more instead?
> 
> What about HEAD:/blah ?

I'd expect this to do the same as HEAD:blah

Ciao,
Dscho
