From: Theodore Tso <tytso@mit.edu>
Subject: Re: Darcs
Date: Sun, 24 Jun 2007 17:52:23 -0400
Message-ID: <20070624215216.GA3910@thunk.org>
References: <cecbdd220706232232w77a609faxf0e6b2dc37f0d1f4@mail.gmail.com> <alpine.LFD.0.98.0706241030540.3593@woody.linux-foundation.org> <46a038f90706241345m4b5ecb80p9f4ec840993023e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bu Bacoo <bubacoo@gmail.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 23:52:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2a0i-0007cf-Sc
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 23:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbXFXVwm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 17:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbXFXVwm
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 17:52:42 -0400
Received: from thunk.org ([69.25.196.29]:56887 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352AbXFXVwm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 17:52:42 -0400
Received: from root (helo=tinytim.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I2a8H-0006yZ-Oi; Sun, 24 Jun 2007 18:00:34 -0400
Received: from tytso by tinytim.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I2a0N-0007Ft-1l; Sun, 24 Jun 2007 17:52:23 -0400
Content-Disposition: inline
In-Reply-To: <46a038f90706241345m4b5ecb80p9f4ec840993023e0@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50825>

On Mon, Jun 25, 2007 at 08:45:57AM +1200, Martin Langhoff wrote:
> OTOH, and from the POV of someone closely following the SCM tools in
> the last few years (and using almost all of them), darcs was the first
> usable DSCM in the camp. I am not sure how much of its commandline
> user interface was borrowed from BK or elsewhere, but darcs was
> _easy_, where Arch was extremely hard to use.

> The darcs commandset (init, push, pull) is what git, hg and bzr have
> today in common. 

> And the closer we get to Darcs UI the happier I feel ;-)

Darcs was first announced in April 2003 [1].

Linus first started using BK to manage the Linux source tree in 2002;
I first started using Bitkeeper to manage e2fsprogs back in 2001; and
BK was first available in late 1998.

So to give credit where credit is due, the whole "$foo init", "$foo
commit", "$foo push", "$foo pull" DSCM UI was first pioneered by Larry
McVoy and BitKeeper, not Darcs.

						- Ted

[1]  http://www.haskell.org/pipermail/haskell-cafe/2003-April/004139.html
