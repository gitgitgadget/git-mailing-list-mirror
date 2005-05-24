From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 16:05:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505241602330.2307@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
 <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
 <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
 <20050524161745.GA9537@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
 <20050524184612.GA23637@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505241212190.2307@ppc970.osdl.org> <20050525003917.40700d19.froese@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 01:04:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaiPr-0003sv-F1
	for gcvg-git@gmane.org; Wed, 25 May 2005 01:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVEXXEA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 19:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVEXXEA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 19:04:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:59800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262104AbVEXXDz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 19:03:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4ON3pjA031787
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 16:03:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4ON3otx023466;
	Tue, 24 May 2005 16:03:51 -0700
To: Edgar Toernig <froese@gmx.de>
In-Reply-To: <20050525003917.40700d19.froese@gmx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 25 May 2005, Edgar Toernig wrote:
> 
> Nothing is expanded when you quote the EOF-word:

Oh, wow.

It's even documented in the bash man-page, now that I understand what to 
look for.

Anyway, that doc also tells me that I'm quoting the right characters, so 
now it's not worth fixing any more.

		Linus
