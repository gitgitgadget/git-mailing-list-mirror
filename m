From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Fri, 20 May 2005 11:28:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org> <1116611932.12975.22.camel@dhcp-188>
 <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 20:26:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZCBy-0002Tv-M3
	for gcvg-git@gmane.org; Fri, 20 May 2005 20:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVETS0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 14:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVETS0m
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 14:26:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:11905 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261540AbVETS0f (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 14:26:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4KIQWjA010575
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 11:26:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4KIQVPt025550;
	Fri, 20 May 2005 11:26:31 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 20 May 2005, Linus Torvalds wrote:
>
> Looking good.

Oh, dang, while I'm at it, why not ask for the "commmitdiff" thing to have 
the commit message in it too, ie basically look like a prettified version 
of "git-diff-tree -v -M <cmitname>"

You already do the first line of it, so there's not much missing. Right
now there is no place where everything important from one commit is
"brought together" (ie no single place where you can see both what the
diff is all about, and what it actually does).

		Linus
