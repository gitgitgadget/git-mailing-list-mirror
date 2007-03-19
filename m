From: Raimund Bauer <ray007@gmx.net>
Subject: RE: [wishlist] graphical diff
Date: Mon, 19 Mar 2007 21:29:06 +0100
Message-ID: <1174336146.5639.26.camel@localhost>
References: <001001c769fe$af8f4400$0b0aa8c0@abf.local>
	 <Pine.LNX.4.63.0703191359380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <1174322644.5639.17.camel@localhost>
	 <Pine.LNX.4.63.0703191748580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: 'Robin Rosenberg' <robin.rosenberg.lists@dewire.com>,
	'git' <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 19 21:29:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTOTj-0006to-7t
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 21:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbXCSU3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 16:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbXCSU3M
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 16:29:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:40872 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753189AbXCSU3K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 16:29:10 -0400
Received: (qmail invoked by alias); 19 Mar 2007 20:29:08 -0000
Received: from p5498AE42.dip0.t-ipconnect.de (EHLO [192.168.178.22]) [84.152.174.66]
  by mail.gmx.net (mp010) with SMTP; 19 Mar 2007 21:29:08 +0100
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX1+uCOReg1qu0HGYspdL4bQ4vJVdjoreUyuCkDXoCf
	ZQLkMKLhmyAxy2
In-Reply-To: <Pine.LNX.4.63.0703191748580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.8.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42668>

On Mon, 2007-03-19 at 17:49 +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 19 Mar 2007, Raimund Bauer wrote:
> 
> > $ git show v1.4.0:git.c > git.c.v1.4.0
> > $ git show v1.4.4:git.c > git.c.v1.4.4
> > $ tkdiff git.c.v1.4.0 git.c.v1.4.4
> > $ rm git.c.v1.4.0 git.c.v1.4.4
> 
> This almost looks like a script! Why don't you make it one?

Because I had hoped that someone more familiar with git and scripting
than me can come up with something, that
1.) also works in the multi-file case
2.) can take all the usual object and revision specifiers that git diff
takes.

And then there's gitk integration ...

But I'll take a look at it ;-)

> Ciao,
> Dscho

-- 
best regards

  Ray
