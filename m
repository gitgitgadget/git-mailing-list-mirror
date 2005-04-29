From: Tom Lord <lord@emf.net>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 12:22:19 -0700 (PDT)
Message-ID: <200504291922.MAA27053@emf.net>
References: <2944.10.10.10.24.1114802002.squirrel@linux1>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 21:20:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRb2U-0008FL-HP
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 21:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbVD2TZD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 15:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVD2TWq
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 15:22:46 -0400
Received: from emf.emf.net ([205.149.0.19]:49417 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S262901AbVD2TWY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 15:22:24 -0400
Received: (from lord@localhost) by emf.net (K/K) id MAA27053; Fri, 29 Apr 2005 12:22:19 -0700 (PDT)
To: seanlkml@sympatico.ca
In-reply-to: <2944.10.10.10.24.1114802002.squirrel@linux1> (seanlkml@sympatico.ca)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



  > Ahh, you don't believe in the development model that has produced Linux! 
  > Personally I do believe in it, so much so that I question the value of
  > signatures at the changeset level.  To me it doesn't matter where the code
  > came from just so long as it works.

To me, it doesn't matter where the code came from.  It's necessary
but not sufficient that it seems to work.  It's necessary that it's
well understood and has undergone only well understood changes.

On that last necessity, a *lot* of open source projects are quite
pathetic.  `git'-style use of signatures raises the bar, slightly, for
where exploits can happen.  They also lower the bar for repudiation of
bogus changes.

   > Signatures are just a way to
   > increase the comfort level that the code has passed through a number of
   > people who have shown themselves to be relatively good auditors.  That's
   > why I trust the code from my distribution of choice.  Everything is out in
   > the open anyway so it's much harder for a con man to do his thing.

Only if the audience is proactively skeptical.

-t

