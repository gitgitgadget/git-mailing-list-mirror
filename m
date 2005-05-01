From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Quick command reference
Date: Sun, 1 May 2005 09:29:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505010927040.2296@ppc970.osdl.org>
References: <17012.53862.704670.858276@cargo.ozlabs.ibm.com>   
 <4274EB3D.2060602@dgreaves.com> <4274F373.6030001@khandalf.com>
 <4274FB3F.8090206@dgreaves.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: omb@bluewin.ch, Paul Mackerras <paulus@samba.org>,
	git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 01 18:22:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSHCP-00086B-5U
	for gcvg-git@gmane.org; Sun, 01 May 2005 18:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVEAQ1k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 12:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVEAQ1k
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 12:27:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:64136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261670AbVEAQ1j (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 12:27:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j41GRPs4011162
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 May 2005 09:27:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j41GRNlG021086;
	Sun, 1 May 2005 09:27:24 -0700
To: David Greaves <david@dgreaves.com>
In-Reply-To: <4274FB3F.8090206@dgreaves.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 1 May 2005, David Greaves wrote:
> 
> I've spent many many hours doing this and I'm happy to spend many more -
> but I'm at that frustrated point where it makes no sense until I know
> it's of use.

I just tend to be concentrating on the technology itself, so docs 
invariably fall a bit behind for me, until I get to the point where I 
start looking at what (for me) ends up being the secondary things.

Anyway, what I'd really appreciate is a whole "Documentation" 
subdirectory, and preferably in some standard format. Maybe real 
old-fashioned man-pages, but hey, especially with something like this, 
just html would be good too.

(And no, by "standard format" I do _not_ mean xml or stuff like that. I 
mean something that is actually easy to read ;)

		Linus
