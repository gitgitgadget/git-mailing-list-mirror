From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-diff-cache: handle pathspec beginning with a dash
Date: Wed, 8 Jun 2005 13:13:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506081312410.2286@ppc970.osdl.org>
References: <20050606212700.GA3498@diku.dk> <20050608184709.GE982@pasky.ji.cz>
 <Pine.LNX.4.58.0506081259580.2286@ppc970.osdl.org> <20050608200612.GM982@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 22:09:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg6q8-0006oS-Ri
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 22:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVFHULx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 16:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVFHULx
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 16:11:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:3504 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261592AbVFHULv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 16:11:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j58KBljA017729
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Jun 2005 13:11:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j58KBk68013347;
	Wed, 8 Jun 2005 13:11:46 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050608200612.GM982@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 8 Jun 2005, Petr Baudis wrote:
> 
> I see. Jonas mentioned on IRC that he forgot to Cc' you. I'm usually
> going through everything on the mailing list, so if some patch stays out
> for few days I'll start nagging. ;-)

Even better, just forward it to me with the original author as "From:" at
the top of the email, and an added sign-off by you, and it will show which
path it took.

I took the two patches you pointed out from the mailing list, so they're 
in my archives now.

		Linus
