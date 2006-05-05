From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 5 May 2006 18:36:29 +0200
Message-ID: <20060505163629.GZ27689@pasky.or.cz>
References: <20060505005659.9092.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 18:35:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc3H0-0007aq-Js
	for gcvg-git@gmane.org; Fri, 05 May 2006 18:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWEEQfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 12:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWEEQfT
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 12:35:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50857 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750818AbWEEQfS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 12:35:18 -0400
Received: (qmail 29864 invoked by uid 2001); 5 May 2006 18:36:29 +0200
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20060505005659.9092.qmail@science.horizon.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19616>

Dear diary, on Fri, May 05, 2006 at 02:56:59AM CEST, I got a letter
where linux@horizon.com said that...
> Actually, AFAICT from looking at the mailing list history, it's not dirty
> politics: the tie-breaker was the support and enthusiasm of the mercurial
> developers.  It passed with only minor comment on the git mailing list,
> but it was a Big Thing to the hg folks.
> 
> There are ups and downs.  OpenSolaris is definitely the big fish in
> the mercurial pond (that wasn't *meant* to sound like a recipe for
> heavy metal toxicity), and will get lots of attention, but git has more
> real-world experience.  The big fish in the git pond is Linus and Linux.
> 
> In any case, mercurial and git are really very similar, far closer
> to each other than any third system, so it's not like the decision is
> a descent into heresy.  Hopefully some useful cross-pollination
> can occur, and converting history from one to the other would be
> simple if anyone ever wanted to.

It's a philosophical question here, but I'd say that Git is much closer
to Monotone than to any other version control system - I think it can be
described as Monotone model with more elegant implementation (for some,
at least ;), no certificates and restriction of one head per branch.
And another important difference is that Monotone has persistent file
identifiers, but I think that's about the only thing that would make
Monotone more "file orientated".

I'm not much of a Mercurial pro but it appears to me that the
architectural differences there are larger, especially wrt. the revlogs
and wholly quite a more file-oriented model.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
