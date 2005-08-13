From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git/cogito workshop/bof at linuxconf au?
Date: Sat, 13 Aug 2005 16:33:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508131625010.3553@g5.osdl.org>
References: <46a038f90508130034858ad34@mail.gmail.com> 
 <Pine.LNX.4.58.0508131111270.19049@g5.osdl.org> <46a038f905081316056e83ebec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 14 01:34:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E45Vo-0007SL-Ei
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 01:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVHMXd5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 19:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbVHMXd5
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 19:33:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25237 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932406AbVHMXd5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 19:33:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7DNXsjA007662
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 13 Aug 2005 16:33:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7DNXrIv000605;
	Sat, 13 Aug 2005 16:33:54 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f905081316056e83ebec@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 14 Aug 2005, Martin Langhoff wrote:
> 
> And how are things lining up for the upcoming one (January 2006, Dunedin, NZ)?  

Dunno yet. I have a policy of trying to travel with the whole family,
which means I'll have to decide whether I'm willing to put that much money
into it, or whether some poor unsuspecting company can help sponsor me ;)
We'll see.

> There's a lot of interest, but the barriers of entry are somewhat
> high, with the codebase moving fast, and some of the concepts
> requiring re-learning of what to expect from an SCM. Perhaps no so
> much among kernel hackers, but the general populace is largely still
> laden with cvs/svn and their mindset.

Yeah. We do not have a nice paper explaining the concepts and usage. The 
tutorial isn't really in-depth enough (it doesn't even mention a lot of 
the helper scripts or even some of the core stuff). The old README started 
out explaining some of the concepts, but it's _way_ of out date in all 
usage respects.

Pasky has the Overview thing, which gets pointed to by kernel.org, and 
which could be expanded upon a lot. 

I'll happily help anybody who wants to try to write some nice
documentation (answer questions etc), but I'm just not very good at doing
it myself.

		Linus
