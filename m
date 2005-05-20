From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Fri, 20 May 2005 11:16:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org> <1116611932.12975.22.camel@dhcp-188>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 20:15:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZBzg-0000s8-Uy
	for gcvg-git@gmane.org; Fri, 20 May 2005 20:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVETSOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 14:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVETSOE
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 14:14:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:54764 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261438AbVETSN6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 14:13:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4KIDtjA009639
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 11:13:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4KIDs46024972;
	Fri, 20 May 2005 11:13:54 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <1116611932.12975.22.camel@dhcp-188>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 20 May 2005, Kay Sievers wrote:
> 
> Something like that: :)
>   http://www.kernel.org/git/?p=cogito/cogito.git;a=summary

Looking good.

I still think "minutes" is an awfully long word to waste vertical space
with, especially since it's also the only one that will have up to three
digits associated with it. It seems kind of silly to give more (or even
equal) space to the simplified time field than to the person who did
something.

(To see minutes, you need to use "git/git.git" instead of cogito.

So I still think you should change "minutes" to "min", which is the common 
abbreviation.

(That "ago" is also very repetitive, but removing it would seem to make it 
unreadable, so I guess it's needed).

				Linus
