From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git Survey summary
Date: Thu, 21 Sep 2006 12:48:18 -0400
Message-ID: <20060921164818.GF3934@spearce.org>
References: <fcaeb9bf0609120205m38a44571we21e05864c04a731@mail.gmail.com> <fcaeb9bf0609210712i125822c4gf8af3ecccdbd3d13@mail.gmail.com> <eeuapj$mgn$1@sea.gmane.org> <20060921155617.GB3934@spearce.org> <20060921163732.GX8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 18:54:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQRiv-0001BZ-L3
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 18:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWIUQs0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 12:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWIUQs0
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 12:48:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:4774 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751330AbWIUQsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 12:48:25 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQRig-0007bk-VP; Thu, 21 Sep 2006 12:48:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A6CCC20FB16; Thu, 21 Sep 2006 12:48:18 -0400 (EDT)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060921163732.GX8259@pasky.or.cz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27491>

Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Thu, Sep 21, 2006 at 05:56:17PM CEST, I got a letter
> where Shawn Pearce <spearce@spearce.org> said that...
> > I'm all for hyperlink integration of gitweb and bug tracking systems
> 
> Actually, Trac might be interesting if you want tight VCS web interface
> and bugtracking web interface integration, although Trac is not very
> powerful. I think the OLPC people did some work on integrating Trac and
> Git.
> 
> People will think I'm weird, but I have to admit that I rather do like
> Bugzilla.

Your not weird.  I also like Bugzilla for some projects; its rather
simple and somewhat easy to use...  I also know a lot of people
who hate it.

> I think we are doing fine as it is for now, though.

Oh I agree completely.  But that's the Git project.

However I think it would be nice if we had native hooks shipped
with core Git to connect to some popular bug tracking systems such
as Bugzilla and Trac.  Nothing incredibly fancy, but like how we
currently ship some default example hooks (and even install them into
every repo with `git init-db`!) we should at least ship some basic
examples and documentation for integrating to some popular systems.
Integrate with at least 2 and it should be easy for users to add
others...

Eh, its just more stuff for an ever growing wishlist.  :-)
I probably won't do it as its not high on my wish list for Git.
I don't currently use any bug tracking systems.

-- 
Shawn.
