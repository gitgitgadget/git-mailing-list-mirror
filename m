From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/3] init-db.c: normalize env var handling.
Date: Tue, 19 Apr 2005 21:59:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504192159000.6467@ppc970.osdl.org>
References: <mailbox-1242-1113971319-971926@spoon>
 <Pine.LNX.4.58.0504192142040.6467@ppc970.osdl.org> <4265E0BB.4040700@superlucidity.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 06:53:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO7DT-00010n-Ed
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 06:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVDTE5s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 00:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVDTE5s
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 00:57:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:7350 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261398AbVDTE5r (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 00:57:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3K4vjs4020668
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 21:57:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3K4viOi019298;
	Tue, 19 Apr 2005 21:57:44 -0700
To: Zach Welch <zw@superlucidity.net>
In-Reply-To: <4265E0BB.4040700@superlucidity.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Zach Welch wrote:
> 
> I feel even more abashed for my earlier scripting faux pas. Would you
> like me to resend them to you off-list?

No, I edited them and applied them (the first series, I'll have to think 
about the second one).

It's only when there are tens of patches that it gets really old really 
quickly to edit things by hand. Three I can handle ;)

		Linus
