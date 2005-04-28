From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] GIT: Create tar archives of tree on the fly, take two
Date: Thu, 28 Apr 2005 11:21:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281121070.18901@ppc970.osdl.org>
References: <20050428174038.GA24352@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Joshua T. Corbin" <jcorbin@node1.wunjo.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Apr 28 20:15:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRDWv-0004Z9-0f
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 20:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVD1STt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 14:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVD1STs
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 14:19:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:18627 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262209AbVD1STh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 14:19:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SIJUs4026931
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 11:19:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SIJTPt032274;
	Thu, 28 Apr 2005 11:19:30 -0700
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20050428174038.GA24352@lsrfire.ath.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Rene Scharfe wrote:
> 
> I think it fits nicely into the core toolset of git.  What do you think?

Yes. Mind sending in a sign-off too, and I'll apply it.

		Linus
