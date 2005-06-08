From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-diff-cache: handle pathspec beginning with a dash
Date: Wed, 8 Jun 2005 13:00:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506081259580.2286@ppc970.osdl.org>
References: <20050606212700.GA3498@diku.dk> <20050608184709.GE982@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 21:58:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg6eR-0004KK-Jk
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 21:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVFHT7O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 15:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVFHT7O
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 15:59:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:29352 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261567AbVFHT65 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 15:58:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j58JwhjA015863
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Jun 2005 12:58:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j58Jwg3k008045;
	Wed, 8 Jun 2005 12:58:42 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050608184709.GE982@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 8 Jun 2005, Petr Baudis wrote:
>
> Dear diary, on Mon, Jun 06, 2005 at 11:27:00PM CEST, I got a letter
> where Jonas Fonseca <fonseca@diku.dk> told me that...
> > Parse everything after '--' as tree name or pathspec.
> > 
> > Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> 
> Thanks, applied to git-pb. Linus, any particular reason for holding this
> off?

It seems to have gone only to the mailing list. I only glance through the 
lists, and assume that if somebody wants me to apply a patch, they'll cc 
me personally too..

		Linus
