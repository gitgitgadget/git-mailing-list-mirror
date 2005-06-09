From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [ANNOUNCE] Cogito-0.11.2
Date: Thu, 9 Jun 2005 10:35:32 +0200
Message-ID: <20050609083532.GE29665@pasky.ji.cz>
References: <20050608230725.GR982@pasky.ji.cz> <42A780A7.3060608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 12:28:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgIRu-0007Zn-Sy
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 10:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVFIIfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 04:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVFIIfi
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 04:35:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36332 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262328AbVFIIfd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 04:35:33 -0400
Received: (qmail 7796 invoked by uid 2001); 9 Jun 2005 08:35:32 -0000
To: Dan Holmsand <holmsand@gmail.com>
Content-Disposition: inline
In-Reply-To: <42A780A7.3060608@gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jun 09, 2005 at 01:35:03AM CEST, I got a letter
where Dan Holmsand <holmsand@gmail.com> told me that...
> Petr Baudis wrote:
> >  Here's git-rev-list --pretty HEAD ^cogito-0.11.1 | git-shortlog
> >(BTW, Dan, what about another cg-log option for git-shortlog output? ;-):
> 
> Well, since I try to use the same output format as git-rev-list --pretty 
> does (most of the time, it *is* just that...), I can actually already do
> 
>    cg-log -r:cogito-0.11.1 | git-shortlog
> 
> and get the same thing.

I'll see how I like it, but currently I find myself use all of the
commit header items a lot, so I'm not too keen to losing some of them,
perhaps except the tree line. Ok, and it might be enough to have the
parent lines only for the merge commits. Nothing against things like
s/^author/Author:/.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
