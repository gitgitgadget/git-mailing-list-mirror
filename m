From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Thu, 9 Aug 2007 10:14:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708091013430.21857@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com> 
 <Pine.LNX.4.64.0708031334530.14781@racer.site> 
 <E3C81783E0454702B1F38D0B68CE1AC0@ntdev.corp.microsoft.com> 
 <Pine.LNX.4.64.0708032231320.14781@racer.site> 
 <e7bda7770708031716i61f80d89o8970b3236a961613@mail.gmail.com> 
 <Pine.LNX.4.64.0708040123560.14781@racer.site> 
 <e7bda7770708051641h15bd38abo659e74322e6232c0@mail.gmail.com> 
 <Pine.LNX.4.64.0708060054020.14781@racer.site>  <46B6B60C.4080805@trolltech.com>
 <81b0412b0708090147y11783e3i4f0a6251dbe2c736@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Torgil Svensson <torgil.svensson@gmail.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 11:15:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ47L-0002GX-TZ
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 11:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933716AbXHIJPk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 05:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933599AbXHIJPk
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 05:15:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:57422 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759332AbXHIJPj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 05:15:39 -0400
Received: (qmail invoked by alias); 09 Aug 2007 09:15:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp011) with SMTP; 09 Aug 2007 11:15:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xUXRT4b9x7W0a2TQWFIYZwQVSKn1tyLSQ/V9qL3
	tZHpZ5iwXl+t+V
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0708090147y11783e3i4f0a6251dbe2c736@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55435>

Hi,

On Thu, 9 Aug 2007, Alex Riesen wrote:

> On 8/6/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> > Johannes Schindelin said the following on 06.08.2007 02:11:
> > On Windows we have a replacement terminal, which has all the features
> > you want, and also supports tabs like Konsole. I've used it for
> > several years, and it works great. Have a look and see if you like it,
> > then we can add it to the repo:
> >      http://sourceforge.net/projects/console/
> >
> > Original name, ey? :-)
> 
> A fine example of windows hackery (they had to inject some code into
> the process running a standard windows console to redirect the IO,
> because windows has no tty of any form).
> It is wonder it works, but it really does (surprisingly often).
> Very impressive.

I have some issues with it, though.

- I really hate to leave anything older than W2K behind.  You might not 
  care, but I do.

- I tested it, and it gave a constant flicker, at least in the status bar.  
  Does not seem to be that fleshed out.

So I'd really like to see rxvt.exe fixed.

Ciao,
Dscho
