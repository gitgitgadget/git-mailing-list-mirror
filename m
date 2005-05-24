From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 10:28:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505241024450.2307@ppc970.osdl.org>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>
  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org> 
 <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>  <1116615600.12975.33.camel@dhcp-188>
  <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>
  <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>  <428E4D8C.3020606@zytor.com>
 <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
 <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
 <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240849050.2307@ppc970.osdl.org> <42935F96.8030205@cobite.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 19:32:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DadDp-0002n2-1Z
	for gcvg-git@gmane.org; Tue, 24 May 2005 19:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVEXRab (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 13:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVEXRab
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 13:30:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:21472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261381AbVEXR0t (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 13:26:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4OHQejA007506
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 10:26:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4OHQdFn007298;
	Tue, 24 May 2005 10:26:39 -0700
To: David Mansfield <david@cobite.com>
In-Reply-To: <42935F96.8030205@cobite.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, David Mansfield wrote:
> 
> Yes.  While not falling asleep last night I realized that the 
> quick-and-dirty approach was bogus.  I need to track what the ancestor 
> is as I'm building up the data structure, not while outputting it. 

Yes.

> It's completely done now except for that it segfaults instantly.

Very good. Are you going to also make a new release at some point, so that 
we don't have strange random patches floating around?

> BTW where did you get the cvsroot for syslinux?  Could I get a copy 
> somewhere?

Peter sent it in private email, I don't know how public that is (it
probably is perfectly public and he just didn't want to spam the mailing
list or run afoul of size limits, but I just don't know for sure, so..),
but I bet he'll happily send it to you too.

		Linus
