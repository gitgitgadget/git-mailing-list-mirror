From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fwd: Re: git checkout -f branch doesn't remove extra files
Date: Fri, 12 Aug 2005 22:33:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508122230200.19049@g5.osdl.org>
References: <20050813041737.GB25236@redhat.com> <Pine.LNX.4.58.0508122151120.19049@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 13 07:34:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3oeC-0002UK-EC
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 07:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVHMFda (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 01:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVHMFd3
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 01:33:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751311AbVHMFd3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 01:33:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7D5XNjA008699
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 Aug 2005 22:33:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7D5XMKS030860;
	Fri, 12 Aug 2005 22:33:23 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0508122151120.19049@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 12 Aug 2005, Linus Torvalds wrote:
> 
> Git actually has a _lot_ of nifty tools. I didn't realize that people 
> didn't know about such basic stuff as "git-tar-tree" and "git-ls-files". 

Btw, I just checked that git-tar-tree is documented and has a man-page. It 
does. However, that man-page attributes authorship to me, which is wrong. 
git-tar-tree was written by Rene Scharfe <rene.scharfe@lsrfire.ath.cx>.

Don't know how many other man-pages say I wrote something just because 
people copied another man-page around. Worth fixing, though.

		Linus
