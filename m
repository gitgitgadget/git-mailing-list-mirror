From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Git wiki
Date: Wed, 3 May 2006 08:30:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605030817580.4086@g5.osdl.org>
References: <20060502232553.GL27689@pasky.or.cz> <7virooj92i.fsf@assigned-by-dhcp.cox.net>
 <4d8e3fd30605030139k33c5a404k54861fdd02c87134@mail.gmail.com>
 <20060503090007.GM27689@pasky.or.cz> <4d8e3fd30605030213r625ce87fw5cbee554f1c20fbd@mail.gmail.com>
 <Pine.LNX.4.64.0605030934220.28543@localhost.localdomain>
 <20060503142957.GA9056@spearce.org> <4458C5D7.8010501@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, Nicolas Pitre <nico@cam.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 17:31:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbJJe-0006g3-3m
	for gcvg-git@gmane.org; Wed, 03 May 2006 17:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbWECPa6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 11:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbWECPa6
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 11:30:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12749 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965117AbWECPa6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 11:30:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k43FURtH003719
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 May 2006 08:30:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k43FUQEk003991;
	Wed, 3 May 2006 08:30:27 -0700
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4458C5D7.8010501@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19490>



On Wed, 3 May 2006, Andreas Ericsson wrote:
> 
> Considering Sun's CEO's common comments on Solaris' superiority over Linux I
> think it's safe to assume that the same CEO wouldn't exactly jump of joy if
> his employees started depending on a tool fathered by Linus.

I doubt it went that high up, but with any kind of politics it's obviously 
possible that somebody consciously or unconsciously felt it might become a 
political problem, and it might have made a difference.

However, I think the _real_ issue is that Mercurial has a much nicer 
introductory phase. The standard mercurial web-page is so much more 
professional and nice to look at than any git page I have ever seen, and 
let's face it: first looks _do_ count.

Also, the fact that Solaris had the unfortunate bug with signals probably 
didn't much help to endear git to them, since it made it look like git had 
problems. Never mind that we solved it - I think it took us a while to 
even realize that Solaris had a problem, because we weren't intimately 
involved.

Which brings me to the final point, which is that I think the hg team was 
very active and supporting, perhaps Matt himself. That's _important_ - the 
OpenSolaris people probably felt very comfortable with strong support from 
the developers. It can often be _the_ best (and biggest) reason to choose 
any product - regardless of anything else.

Even if I think the git mailing list itself is very responsive, I think 
the hg people were just more directly and actively involved. For git, they 
had to come to us.

I also suspect that some people find python scripts somewhat less 
intimidating than C. I'll also happily admit that my coding standards tend 
to lean towards the "sparse" when it comes to comments, and I much prefer 
the "small and well-named functions" approach, and git seems to have stuck 
to that with Junio. Which just turns some people off.

So I don't think you need politics to explain it. I think hg is doing 
quite well. It took some different design decisions, and while I 
personally think the git ones are better, I'm somewhat biased ;)

			Linus
