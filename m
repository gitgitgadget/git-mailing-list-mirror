From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: Merge with git-pasky II.
Date: Wed, 13 Apr 2005 20:51:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
References: <20050414002902.GU25711@pasky.ji.cz> <20050413212546.GA17236@64m.dyndns.org>
 <20050414004504.GW25711@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christopher Li <git@chrisli.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 05:47:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLvJX-0006is-Rd
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 05:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVDNDuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 23:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVDNDuF
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 23:50:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:10127 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261268AbVDNDuA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 23:50:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3E3nrs4025743
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 13 Apr 2005 20:49:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3E3nqYx006057;
	Wed, 13 Apr 2005 20:49:52 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050414004504.GW25711@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Apr 2005, Petr Baudis wrote:
>
> http://www.theregister.co.uk/2005/04/11/torvalds_attack/ ... I'm nothing
> like a regular reader of (R), but I thought the guys have at least a bit
> of sense. Duh. :/ Or is April 11 now yet another joke day after April 1?

I actually _am_ a fairly regular reader, and hey, being opinionated and a 
bit over the top is what makes the site worthwhile. It's obviously what 
motivates the people. 

And then, occasionally, when they bite you, hey, that's the price of
having a high profile. I worry more about sometimes not listening to
critics than I do about the critics themselves.

Thick skin is the name of the game. I'd not get any work done otherwise.

On that note - I've been avoiding doing the merge-tree thing, in the hope 
that somebody else does what I've described. I really do suck at scripting 
things, yet this is clearly something where using C to do a lot of the 
stuff is pointless.

Almost all the parts do seem to be there, ie Daniel did the "common 
parent" part, and the rest really does seem to be more about scripting 
than writing more C plumbing stuff..

		Linus
