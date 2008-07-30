From: Jeff King <peff@peff.net>
Subject: Re: Bizarre missing changes (git bug?)
Date: Wed, 30 Jul 2008 00:26:09 -0400
Message-ID: <20080730042609.GB3350@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain> <20080729053108.GH26997@sigill.intra.peff.net> <Pine.LNX.4.64.0807291339580.6791@localhost.localdomain> <20080729125247.GC12069@sigill.intra.peff.net> <alpine.LFD.1.10.0807291006070.3334@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 06:27:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO3HO-0005uk-Db
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 06:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbYG3E0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 00:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbYG3E0O
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 00:26:14 -0400
Received: from peff.net ([208.65.91.99]:3719 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962AbYG3E0N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 00:26:13 -0400
Received: (qmail 4799 invoked by uid 111); 30 Jul 2008 04:26:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Jul 2008 00:26:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jul 2008 00:26:09 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807291006070.3334@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90733>

On Tue, Jul 29, 2008 at 10:25:35AM -0700, Linus Torvalds wrote:

> On Tue, 29 Jul 2008, Jeff King wrote:
> > 
> > I glanced briefly over "gitk kernel/printk.c" and it looks pretty sane.
> 
> Jeff, it _is_ sane. When Roman says it's "incorrect", he is just wrong.

I agree with you, btw. It is definitely correct and useful; however, I
am curious if there is some "in between" level of simplification that
might produce an alternate graph that has interesting features. And that
is why I am trying to get Roman to lay out exactly what it is he wants.

-Peff
