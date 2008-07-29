From: Jeff King <peff@peff.net>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 01:31:08 -0400
Message-ID: <20080729053108.GH26997@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org> <200807260512.40088.zippel@linux-m68k.org> <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:32:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNhoi-0006it-3D
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbYG2FbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbYG2FbL
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:31:11 -0400
Received: from peff.net ([208.65.91.99]:4799 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbYG2FbK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:31:10 -0400
Received: (qmail 6099 invoked by uid 111); 29 Jul 2008 05:31:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Jul 2008 01:31:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2008 01:31:08 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90577>

On Tue, Jul 29, 2008 at 04:59:01AM +0200, Roman Zippel wrote:

> Right now you're giving me the choice between a crappy incomplete history 
> or a crappy history full of useless information. That's it? As long as 
> your challenge involves being compared to crappy history, I'm not 
> interested. If the solution should involve a switch "--correct-history" 
> or I have to wait for the result, I don't care, because it's the correct 
> history I want. As long as you're trying to sell me crappy history I'm not 
> buying it.
> 
> Can we please get past this and look at what is required to produce the 
> correct history?

You seem to be indicating here (and elsewhere in the thread) that there
exists some history graph for which neither "git log" nor "git log
--full-history" produces the output you want, but that there is some
better output (even if it might take more time to compute).

Perhaps I am just slow, but I haven't been able to figure out what that
history is, or what the "correct" output should be. Can you try to state
more clearly what it is you are looking for?

-Peff
