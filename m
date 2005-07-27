From: Linus Torvalds <torvalds@osdl.org>
Subject: Meet the new maintainer..
Date: Tue, 26 Jul 2005 20:24:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507262004320.3227@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jul 27 05:24:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxcWr-0005la-QN
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 05:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVG0DYO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jul 2005 23:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVG0DYO
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 23:24:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38553 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261997AbVG0DYN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2005 23:24:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6R3O8jA013358
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Jul 2005 20:24:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6R3O7nG031491;
	Tue, 26 Jul 2005 20:24:07 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I'm sure some of you eagle-eyes have already noticed this, but for the
last 24 hours the "owner" field on the main git project at www.kernel.org
hasn't been pointing to yours truly any more. It says "Junio C Hamano"  
instead.

The description may still say "Linus' core git plumbing", but I think
that's just because Junio is being shy about things, and not very 
assertive, but the fact is, in the great tag-game of project 
maintainership, Junio is the new "it".

I always said I didn't really want to maintain it in the long run, and 
maybe some of you thought I was just saying that, especially as the weeks 
dragged out to over three months, but hey, that's just because this thing 
ended up being a bit bigger and more professional than I originally even 
envisioned. 

Junio was the obvious choice, and since he accepted the maintainership 
position, it means that I don't have to track the git details as closely, 
and can go back to reading the linux kernel mailing list more actively. 

I'll just continue to send patches to Junio instead of applying them to my
tree and pushing them out that way (or maybe I'll try to push any changes
through my slaved git trees instead). In other words, I'm not "dropping" 
git, I just prefer working on it as a contributor rather than trying to 
keep track of everything that happens.

So I don't think much will change, except I suspect Junio will drop fewer
patches on the floor and ask for fewer re-sends or need less prodding ;)

		Linus
