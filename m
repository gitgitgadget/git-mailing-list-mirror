From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: way to automatically add untracked files?
Date: Mon, 6 Aug 2007 04:21:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708060419230.14781@racer.site>
References: <873ayymzc1.fsf@catnip.gol.com> <200708051411.25238.johan@herland.net>
 <20070805161117.GE28263@thunk.org> <200708052116.04140.johan@herland.net>
 <Pine.LNX.4.64.0708060112330.14781@racer.site> <buo1wehxssa.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miles Bader <miles.bader@necel.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 05:22:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHtAa-00057m-Vz
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 05:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbXHFDWJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 23:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbXHFDWI
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 23:22:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:49403 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752801AbXHFDWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 23:22:07 -0400
Received: (qmail invoked by alias); 06 Aug 2007 03:22:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 06 Aug 2007 05:22:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ZLYZrIP+ZbWpHM1M1y7MUA51Q/ziLaCrmiM9nBm
	A4WNjALpfSVdHU
X-X-Sender: gene099@racer.site
In-Reply-To: <buo1wehxssa.fsf@dhapc248.dev.necel.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55102>

Hi,

[please, netiquette says that you should Cc _at least_ the one you're 
responding to]

On Mon, 6 Aug 2007, Miles Bader wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> But I'm wondering whether we'd want to include it in git by default 
> >> (instead of having to tell confused users to add the alias).
> >
> > I recommend against that, too.  All too often, I have some temporary files 
> > in the working tree, and I'll be dimmed if I'm the only one.  So 
> > "addremove" adds too much possibility for pilot errors.
> 
> "Recommend against it"?  Why?

Didn't I say that? It just _asks_ for pilot errors.

> It's a separate command, so if it doesn't fit your working style, don't
> use it.

Hah!  If that were true, we'd have a lot less mails like "I tried this and 
it did not work", only to find out that the person assumed that 
documentation is for wimps, and tried a command that "sounded" like it 
would do the right thing.

Ciao,
Dscho
