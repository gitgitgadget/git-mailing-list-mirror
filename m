From: Andi Kleen <andi@firstfloor.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 18:36:38 +0200
Message-ID: <20080823163638.GW23334@one.firstfloor.org>
References: <20080822174655.GP23334@one.firstfloor.org> <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org> <20080822182718.GQ23334@one.firstfloor.org> <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org> <20080823071014.GT23334@one.firstfloor.org> <48AFD764.7010605@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 18:35:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWw5Q-000597-1a
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 18:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbYHWQeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 12:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbYHWQeb
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 12:34:31 -0400
Received: from one.firstfloor.org ([213.235.205.2]:53572 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbYHWQea (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 12:34:30 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 1235518900B9; Sat, 23 Aug 2008 18:36:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48AFD764.7010605@gnu.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93464>

On Sat, Aug 23, 2008 at 11:24:52AM +0200, Paolo Bonzini wrote:
> Andi Kleen wrote:
> >> Exactly. Don't rebase. And don't base your development on somebody who 
> >> does.
> > 
> > That's pretty much impossible in the current state of Linux development
> > as far as I know.
> > 
> >> Remember how I told you that you should never rebase?
> > 
> > I suspect your recommendation does not match real world git use.
> 
> I think if you have to rebase often, you're actually better off using

[ ] You read my original email.

The issue is not that I'm rebasing [1], but that other people I'm updating
trees from are rebasing all the time. And Linus and the others can
say "don't rebase" all the time -- that doesn't change the fact thato
others are rebasing anyways. And git's support for dealing with that seems
to be quite poor.

-Andi

[1] Ok I do it occasionally, but that's not the problem here, and
I don't have a real user base for my trees and the branches I'm 
doing that on.
