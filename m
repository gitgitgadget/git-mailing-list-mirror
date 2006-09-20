From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Public Gitweb Hosting Service
Date: Wed, 20 Sep 2006 08:05:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609200753370.4388@g5.osdl.org>
References: <20060920004828.GI8259@pasky.or.cz> <Pine.LNX.4.64.0609192033050.4388@g5.osdl.org>
 <20060920105133.GL8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 17:07:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ3e3-00008Z-Fb
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 17:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWITPFs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 11:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWITPFs
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 11:05:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751594AbWITPFr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 11:05:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8KF5dnW017341
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Sep 2006 08:05:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8KF53sl000302;
	Wed, 20 Sep 2006 08:05:22 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060920105133.GL8259@pasky.or.cz>
X-Spam-Status: No, hits=-0.928 required=5 tests=AWL,HTML_MESSAGE,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.150 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27349>



On Wed, 20 Sep 2006, Petr Baudis wrote:

> Dear diary, on Wed, Sep 20, 2006 at 05:35:02AM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> said that...
> > 
> > When I click "summary" for the glibc-cvs.git tree, I get just a
> > 
> > 	<div class="title">&nbsp;</div>
> > 	-------------------^
> > 
> > thing back.
> > 
> > Broken gitweb?
> 
> That's the start of the summary table. Did you wait long enough here? It
> takes a while before the refs are processed and your browser might not
> show you the data received meanwhile.

It's _definitely_ broken for me. But it looks like that may be a firefox 
on ppc issue (even if other sites work fine), because I don't have the 
same problem on my Mac Mini. Strange.

Maybe it's a "yum install" that upgraded firefox while it was running or 
something.

		Linus
