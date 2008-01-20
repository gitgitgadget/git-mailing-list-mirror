From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: gitk layout bug
Date: Sun, 20 Jan 2008 01:50:47 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801200149450.5731@racer.site>
References: <alpine.LFD.1.00.0801191740020.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 02:51:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGPLZ-0006qi-1b
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 02:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbYATBvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 20:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbYATBvM
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 20:51:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:39304 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753334AbYATBvL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 20:51:11 -0500
Received: (qmail invoked by alias); 20 Jan 2008 01:51:09 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp009) with SMTP; 20 Jan 2008 02:51:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180vSNgEDo0Ab37y+LaXfOnuovvPmBCUflhb2jqhA
	XRmLe7lh80MeSg
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0801191740020.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71151>

Hi,

On Sat, 19 Jan 2008, Linus Torvalds wrote:

> In the current git repository, try this:
> 
> 	gitk origin/master..origin/pu
> 
> and it starts out looking ok.
> 
> But then scroll down a bit (say, press "PageDown" ten to twenty times), 
> and scroll up again, and now that thing is totally unusable.
> 
> Is it just me?

Just tried; I'm getting a lot of horizontal pink lines which seem to 
extend infinitely to the right, where at first they were vertical lines...

So it is not just you, I guess.

Ciao,
Dscho
