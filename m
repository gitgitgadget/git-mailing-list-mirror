From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Thu, 28 Jul 2005 19:59:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507281956510.3307@g5.osdl.org>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
 <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
 <20050722192424.GB8556@mars.ravnborg.org> <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
 <1122068634.7042.35.camel@localhost.localdomain> <7vu0imh23q.fsf@assigned-by-dhcp.cox.net>
 <1122108098.6863.38.camel@localhost.localdomain> <20050723093035.GB11814@pasky.ji.cz>
 <1122114452.6863.72.camel@localhost.localdomain> <20050728194748.GD24948@pasky.ji.cz>
 <7vack6qrhd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org, Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Fri Jul 29 05:01:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyL6h-0002Nq-JO
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 05:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVG2DAB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 23:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVG2DAB
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 23:00:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17796 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261567AbVG2DAA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 23:00:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6T2xgjA026527
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Jul 2005 19:59:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6T2xfm4004881;
	Thu, 28 Jul 2005 19:59:41 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vack6qrhd.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Jul 2005, Junio C Hamano wrote:
> 
> I do not want to get involved in policy decisions, but for the
> record I always hated your commit log for that "identifies the
> committer physically" approach.

Well, I have to say that I find it quite useful myself. I try to commit
x86 patches to the kernel on an x86 machine (I had better had tested them
there), so they usually say "torvalds@evo.osdl.org" or "torvalds@yonah..",
while my normal patches tend to say "torvalds@g5.." since that's my main
machine.

So I tend to not override it, even though none of those are really valid
email addresses.

		Linus
