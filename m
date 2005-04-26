From: Tom Lord <lord@emf.net>
Subject: Re: Merge with git-pasky II.
Date: Tue, 26 Apr 2005 13:39:54 -0700 (PDT)
Message-ID: <200504262039.NAA21459@emf.net>
References: <Pine.LNX.4.44.0504261301520.4678-100000@wax.eds.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 22:39:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQWow-0003hU-36
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 22:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVDZUmk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 16:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVDZUkY
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 16:40:24 -0400
Received: from emf.emf.net ([205.149.0.19]:64778 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S261660AbVDZUjz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 16:39:55 -0400
Received: (from lord@localhost) by emf.net (K/K) id NAA21459; Tue, 26 Apr 2005 13:39:54 -0700 (PDT)
To: bram@bitconjurer.org
In-reply-to: <Pine.LNX.4.44.0504261301520.4678-100000@wax.eds.org> (message from Bram Cohen on Tue, 26 Apr 2005 13:31:31 -0700 (PDT))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


  > What I'd really like to hear is some explanation of why git is
  > reimplementing all of this stuff from scratch.

Whatever Linus' reasons, it's not a bad exercise and it does help
robustify the kernel project to roll its own.  Not that he seems to be
doing *this* part especially well or anything, but that doesn't matter
from the perspective of the good reasons to do it.

It doesn't matter much -- get stuff into git and people can layer on
that pretty gently.  The low layers of git are a common idea but
context and Linus' nifty code make this instance of the idea a bit
of a gem.



  > please remember that I've spent years
  > thinking about merge algorithms

I'm surprised we haven't met sooner.  If we did and I forgot, sorry.

-t
