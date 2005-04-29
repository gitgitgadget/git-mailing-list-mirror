From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: More problems...
Date: Fri, 29 Apr 2005 10:51:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504291049290.18901@ppc970.osdl.org>
References: <20050429170127.A30010@flint.arm.linux.org.uk>
 <20050429171205.B30010@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 19:44:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRZWw-0004bO-Kr
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 19:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbVD2RtU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 13:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVD2RtT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 13:49:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:55249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262857AbVD2RtR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 13:49:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3THn9s4022513
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 10:49:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3THn8xA026563;
	Fri, 29 Apr 2005 10:49:08 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050429171205.B30010@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Apr 2005, Russell King wrote:
> 
> Not particularly nice, but very necessary, and apparantly the only
> way to get this to work.  Grumble.  Why am I seemingly the only one
> running into all these blocking problems.

Well, I suspect not a lot of people are actually using cogito for kernel 
stuff.

I still use my old "git-pull-script" to update stuff. I know how it works, 
and it does at least these things right (as long as "merge-base" works 
right, of course - which so far it has for me since the re-write).

		Linus
