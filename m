From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 3 Jun 2005 09:30:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506030929150.1876@ppc970.osdl.org>
References: <20050603152212.GA4598@jmcmullan.timesys>
 <Pine.LNX.4.58.0506030856490.1876@ppc970.osdl.org> <1117814982.32257.64.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 18:26:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeEze-0006xP-MN
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 18:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVFCQ2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 12:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVFCQ2z
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 12:28:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:9941 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261376AbVFCQ2q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 12:28:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j53GShjA005472
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Jun 2005 09:28:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j53GSg5O031797;
	Fri, 3 Jun 2005 09:28:42 -0700
To: "McMullan, Jason" <jason.mcmullan@timesys.com>
In-Reply-To: <1117814982.32257.64.camel@jmcmullan.timesys>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 3 Jun 2005, McMullan, Jason wrote:
> 
> > Anyway, technically this looks ok, but I'd hate to apply it until there is 
> > something that actually uses it and an example of that usage.
> 
> Well, I use it to keep my home and work repos in sync, but yeah,
> users == 1 doesn't make a good case for inclusion.

Well, it's fine, but you should at least tell _how_ you use it. What are
the scripts you use to synchronize etc etc..

So when I said "some_thing_ that actually uses it", I didn't mean more
_people_ than you personally, but the scaffolding around it, really.

			Linus
