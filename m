From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: space compression (again)
Date: Fri, 15 Apr 2005 12:11:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504151210590.7211@ppc970.osdl.org>
References: <Pine.LNX.4.61.0504151232160.27637@cag.csail.mit.edu>
 <Pine.LNX.4.58.0504151117360.7211@ppc970.osdl.org>
 <Pine.LNX.4.61.0504151437100.27637@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 21:07:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMW92-0001th-16
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 21:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVDOTJx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 15:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVDOTJx
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 15:09:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:1772 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261793AbVDOTJw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 15:09:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3FJ9ks4014085
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 12:09:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3FJ9jtX009334;
	Fri, 15 Apr 2005 12:09:45 -0700
To: "C. Scott Ananian" <cscott@cscott.net>
In-Reply-To: <Pine.LNX.4.61.0504151437100.27637@cag.csail.mit.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, C. Scott Ananian wrote:
> 
> So I guess I'll have to implement this and find out, won't I? =)

The best way to shup somebody up is always to just do it, and say "hey, I 
told you so". It's hard to argue with numbers.

			Linus
