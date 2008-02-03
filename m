From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Sun, 3 Feb 2008 02:14:37 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802030210240.7372@racer.site>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <87k5lnwvzd.dancerj%dancer@netfort.gr.jp> <878x22j1km.dancerj%dancer@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junichi Uekawa <dancer@netfort.gr.jp>
X-From: git-owner@vger.kernel.org Sun Feb 03 03:15:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLUOa-0003Z8-NC
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 03:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929AbYBCCPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 21:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754576AbYBCCPP
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 21:15:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:34376 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754469AbYBCCPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 21:15:13 -0500
Received: (qmail invoked by alias); 03 Feb 2008 02:15:11 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp046) with SMTP; 03 Feb 2008 03:15:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19tMZMomuZtgTJBCA7isAORRJu/IO//irRBJhImz4
	4iYQ9BbvNqmT4+
X-X-Sender: gene099@racer.site
In-Reply-To: <878x22j1km.dancerj%dancer@netfort.gr.jp>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72316>

Hi,

On Sun, 3 Feb 2008, Junichi Uekawa wrote:

> I was wondering why I use the git-xxx format so much (in muscle, and
> in scripts). And realized I have the following reasons:
> 
> [1 and 2]
>
> 3. Linus said it's better (3 years ago), and I thought so too.

That woul be surprising.  Git was not invented until early April 2005.  At 
the moment I still wait (impatiently, because then my current contract 
ends) for April 2008.

The important thing to realise is that time is such a wonderful dimension 
to be exposed to: not only do you live (experience things that you did not 
know before), but also other people live and learn.

IOW even Linus realised that the git-xxx format is not _that_ good.  Which 
is why -- as you should have realised if you did not subscribe 5 minutes 
ago -- we do not recommend git-xxx at all, but insist on "git xxx".

Hth,
Dscho
