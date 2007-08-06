From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: way to automatically add untracked files?
Date: Mon, 6 Aug 2007 13:17:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708061317101.14781@racer.site>
References: <873ayymzc1.fsf@catnip.gol.com> <buo1wehxssa.fsf@dhapc248.dev.necel.com>
 <Pine.LNX.4.64.0708060419230.14781@racer.site> <200708060946.12793.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Miles Bader <miles.bader@necel.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Aug 06 14:18:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II1Xc-0008S3-CR
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 14:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbXHFMSQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 08:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbXHFMSQ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 08:18:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:37988 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751517AbXHFMSP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 08:18:15 -0400
Received: (qmail invoked by alias); 06 Aug 2007 12:18:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 06 Aug 2007 14:18:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/IdFunfO/peEimlOS5RYTTqnL2zDS2nLUNnxoIp
	bCannRMGcxL39w
X-X-Sender: gene099@racer.site
In-Reply-To: <200708060946.12793.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55142>

Hi,

On Mon, 6 Aug 2007, Johan Herland wrote:

> On Monday 06 August 2007, Johannes Schindelin wrote:
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > >> But I'm wondering whether we'd want to include it in git by default 
> > > >> (instead of having to tell confused users to add the alias).
> > > >
> > > > I recommend against that, too.  All too often, I have some temporary files 
> > > > in the working tree, and I'll be dimmed if I'm the only one.  So 
> > > > "addremove" adds too much possibility for pilot errors.
> > > 
> > > "Recommend against it"?  Why?
> > 
> > Didn't I say that? It just _asks_ for pilot errors.
> 
> Ok, in that spirit I also suggest removing _all_ git plumbing-level commands
> from the default installation.

Oh, come on.  You were talking about a porcelain command.

Ciao,
Dscho
