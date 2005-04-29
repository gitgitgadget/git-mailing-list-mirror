From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 15:13:22 -0400 (EDT)
Message-ID: <2944.10.10.10.24.1114802002.squirrel@linux1>
References: <2712.10.10.10.24.1114799620.squirrel@linux1>
    (seanlkml@sympatico.ca) <200504291854.LAA26550@emf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org, mpm@selenic.com, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 21:18:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRazA-0007sI-Uq
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 21:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbVD2TVe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 15:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVD2TV3
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 15:21:29 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:63199 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262895AbVD2TN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 15:13:27 -0400
Received: from linux1 ([67.71.124.169]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050429191324.DJBW1623.simmts8-srv.bellnexxia.net@linux1>;
          Fri, 29 Apr 2005 15:13:24 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j3TJDKJv001434;
	Fri, 29 Apr 2005 15:13:22 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Fri, 29 Apr 2005 15:13:22 -0400 (EDT)
In-Reply-To: <200504291854.LAA26550@emf.net>
To: "Tom Lord" <lord@emf.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, April 29, 2005 2:54 pm, Tom Lord said:

> The process should not rely on the security of every developer's
> machine.  The process should not rely on simply trusting quality
> contributors by reputation (e.g., most cons begin by establishing
> trust and continue by relying inappropriately on
> trust-without-verification).  This relates to why Linus'
> self-advertised process should be raising yellow and red cards all
> over the place: either he is wasting a huge amount of his own time and
> should be largely replaced by an automated patch queue manager, or he
> is being trusted to do more than is humanly possible.
>

Ahh, you don't believe in the development model that has produced Linux! 
Personally I do believe in it, so much so that I question the value of
signatures at the changeset level.  To me it doesn't matter where the code
came from just so long as it works.   Signatures are just a way to
increase the comfort level that the code has passed through a number of
people who have shown themselves to be relatively good auditors.  That's
why I trust the code from my distribution of choice.  Everything is out in
the open anyway so it's much harder for a con man to do his thing.

Sean



