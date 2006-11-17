X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 23:50:37 +0100
Message-ID: <20061117225037.GI7201@pasky.or.cz>
References: <20061116221701.4499.qmail@science.horizon.com> <20061117153246.GA20065@thunk.org> <BAYC1-PASMTP07C8A8D8E5E78173953CA9AEE80@CEZ.ICE> <fcaeb9bf0611170819j57cda9e1ia4ecd4cd13956447@mail.gmail.com> <20061117113404.810fd4ea.seanlkml@sympatico.ca> <20061117165333.GR4842@pasky.or.cz> <20061117120154.3eaf5611.seanlkml@sympatico.ca> <20061117213125.GG7201@pasky.or.cz> <6efbd9b70611171436t1e0cadf2j7e9387ca77f85538@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 22:50:57 +0000 (UTC)
Cc: Sean <seanlkml@sympatico.ca>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <6efbd9b70611171436t1e0cadf2j7e9387ca77f85538@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31737>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlCXj-0000OF-Bi for gcvg-git@gmane.org; Fri, 17 Nov
 2006 23:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755990AbWKQWuk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 17:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756008AbWKQWuk
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 17:50:40 -0500
Received: from w241.dkm.cz ([62.24.88.241]:18911 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1755990AbWKQWuj (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 17:50:39 -0500
Received: (qmail 16462 invoked by uid 2001); 17 Nov 2006 23:50:37 +0100
To: Chris Riddoch <riddochc@gmail.com>
Sender: git-owner@vger.kernel.org

On Fri, Nov 17, 2006 at 11:36:25PM CET, Chris Riddoch wrote:
> On 11/17/06, Petr Baudis <pasky@suse.cz> wrote:
> >If someone writes a crash course in pure Git covering the same grounds
> >as the current ones (possibly by just extending/retouching the tutorial)
> >(it does not necessarily need to be a "refugee" crash course, it can
> >build up from scratch), I can add it on the web. If it becomes as easy
> >to use and with as mild learning curve as Cogito, it means Cogito got
> >mostly obsolete and I'll happily remove the Cogito crash courses from
> >the web.
> 
> As a relatively new user myself, I ran into the same confusion when I
> came to the website for the first time.  One of the most prominent
> things on the front page is the "Git Crash Courses."  Clicking on that
> gives me the crash courses, all of which are about Cogito, not for
> Git.  So why doesn't the front page say "Cogito Crash Courses"
> instead?
> 
> And I don't think it matters much whether Cogito makes things easier
> or not -- the Git website really should make Git's documentation more
> prominent than Cogito's.  I'd expect the opposite of Cogito's website.

I think the difference here is the Git _tool_ vs. the Git version
control system. Cogito is an element of the second: To use Git, you can
either use the Git tool or the Cogito tool or the StGIT tool or even
just the qgit tool (which also lets you inspect the working copy and
commit). I believe the tool best suited for general usage by newbies _at
this point_ is Cogito, so that's what I use for introduction to Git. I'm
not saying this is ideal situation and I and others are/will be working
to fix it.

I'm all for making it more obvious what's going on at the website, I
think the current wording is better. Also, if people believe that a
crash course for core Git would help things, I'm all for it as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
