From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 21:28:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705252127440.4648@racer.site>
References: <8c5c35580705250752k2021f02dv804d87da5c0d5da7@mail.gmail.com>
 <11801165433267-git-send-email-hjemli@gmail.com> <Pine.LNX.4.64.0705251924280.4648@racer.site>
 <alpine.LFD.0.98.0705251256250.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 25 22:28:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrgOf-0000AI-Rj
	for gcvg-git@gmane.org; Fri, 25 May 2007 22:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763927AbXEYU2W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 16:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755162AbXEYU2V
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 16:28:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:60092 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764776AbXEYU2V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 16:28:21 -0400
Received: (qmail invoked by alias); 25 May 2007 20:28:19 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 25 May 2007 22:28:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ey08VXvqel2odHWKses11waWlw+6r9fOdmmEu/Y
	sfI7A7JkpljL+H
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.98.0705251256250.26602@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48407>

Hi,

On Fri, 25 May 2007, Linus Torvalds wrote:

> On Fri, 25 May 2007, Johannes Schindelin wrote:
> >
> > I did not realize this earlier, but we seem to have more and more programs 
> > where actions are specified without "--", i.e. "git-svn fetch", or 
> > "git-bundle create".
> 
> Hey, don't forget "git bisect", the granddaddy of them all.

Oh, sorry! How could I? Respect the elders. ;-)

Ciao,
Dscho
