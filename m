X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 22 Nov 2006 23:21:30 +0000
Message-ID: <E1Gn1PG-0002oW-00@skye.ra.phy.cam.ac.uk>
References: <20061116160700.GA3383@thunk.org>
NNTP-Posting-Date: Wed, 22 Nov 2006 23:21:50 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Your message of "Thu, 16 Nov 2006 11:07:00 EST."
             <20061116160700.GA3383@thunk.org> 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32110>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gn1PO-0003Yu-3f for gcvg-git@gmane.org; Thu, 23 Nov
 2006 00:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757162AbWKVXVf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 18:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757164AbWKVXVe
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 18:21:34 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:25770 "EHLO
 mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP id S1757162AbWKVXVe
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 18:21:34 -0500
Received: from skye.ra.phy.cam.ac.uk ([131.111.48.158] ident=mail) by
 mraos.ra.phy.cam.ac.uk with esmtp (Exim 4.43) id 1Gn1PG-0004wO-Vu; Wed, 22
 Nov 2006 23:21:31 +0000
Received: from sanjoy by skye.ra.phy.cam.ac.uk with local (Exim 3.36 #1) id
 1Gn1PG-0002oW-00; Wed, 22 Nov 2006 23:21:30 +0000
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org

The car analogy is excellently clear.

> they need more than the "stupid simple" git usage, but if they don't
> need the extreme power of git, Hg is simpler for people to learn how
> to use.

As a 80%-hg/20%-git user, I'm curious what features of git you had in
mind, so I know where to look as I wander up the git learning curve.

My experience with the git user interface, for what it's worth, is
that I never quite get the conceptual model crystal clear enough in my
head. So it won't stay for long enough for me to progress up the
learning curve and retain the gains.  I move up a bit, but the gain
soon evaporates and I backslide, and then just hack my way through it.

I found hg's conceptual model very easy to learn, almost as if I don't
have to remember anything.  Maybe that simplicity comes at a price,
whence my question at the start about the extreme-power features of
git.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
