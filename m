From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid warning when From: is encoded
Date: Sat, 26 Jul 2008 04:53:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807260449490.26810@eeepc-johanness>
References: <1216991208-18782-1-git-send-email-4ux6as402@sneakemail.com>  <20080725131625.GA11221@toroid.org> <bd6139dc0807250901n7408a8e6w5dead238e897fc03@mail.gmail.com> <488A01B8.2010405@freescale.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Abhijit Menon-Sen <ams@toroid.org>,
	=?ISO-8859-15?Q?Peter_Valdemar_M=F8rch?= <4ux6as402@sneakemail.com>,
	git@vger.kernel.org
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 04:53:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMZuU-0003q1-37
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 04:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbYGZCwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 22:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbYGZCw3
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 22:52:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:44768 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751545AbYGZCw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 22:52:29 -0400
Received: (qmail invoked by alias); 26 Jul 2008 02:52:27 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp040) with SMTP; 26 Jul 2008 04:52:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GiQ9xhowGNYmtPFJyiryuY+fXNc8iUg8Wjl0XPp
	Pdwg3ofWdqOXL1
X-X-Sender: user@eeepc-johanness
In-Reply-To: <488A01B8.2010405@freescale.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90158>

Hi,

On Fri, 25 Jul 2008, Jon Loeliger wrote:

> Sverre Rabbelier wrote:
> 
> > Acked-by is reserved for people who are "owners" of the area the patch
> > touches.
> 
> I love pronouncements like this.  While that may be exactly true
> for the Git project, it is not, in general, always true.

It may not be true in general, but from what I heard of the Kernel 
community, even there it is considered rude if you just step in and say 
ACK, when you clearly have no idea what you are talking about (which is 
normally determined by your being involved in that area).

So you can love (or not) pronouncements like that, but the fact still 
stands true: how can your ACK be of any value (or for that matter, how can 
your ACK be taken seriously) when you haven't proven -- in code! -- that 
you understand the code?

Hthab,
Dscho
