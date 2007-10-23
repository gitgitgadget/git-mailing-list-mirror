From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Mon, 22 Oct 2007 23:34:54 -0400
Message-ID: <20071023033454.GW14735@spearce.org>
References: <20071022063222.GS14735@spearce.org> <7vy7du8vv7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 05:35:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkAXv-00065n-NQ
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 05:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbXJWDfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 23:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbXJWDfA
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 23:35:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37852 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbXJWDe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 23:34:59 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IkAXV-00071P-29; Mon, 22 Oct 2007 23:34:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4B15420FBAE; Mon, 22 Oct 2007 23:34:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vy7du8vv7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62074>

Junio C Hamano <gitster@pobox.com> wrote:
> Thanks for keeping the git list running smoothly while I was away.

Funny thing.  There's this tool called "git" that makes it really
easy to fork a project, apply patches straight from email, and
republish it for others to read and work on top of.  You should
check it out sometime.  :-)
 
> I've pulled the four integration branches from you, and split
> out the topic branches out of next and pu so that I can take a
> look at them individually.  I haven't looked at the actual
> changes yet (but I do not have to, as long as I can trust
> capable others), and only skimmed the list messages (about 2200
> of them since I left).
> 
> git.git at k.org and alt-git.git at repo.or.cz should be in sync
> with you now.  I'll take a look at the recent changes after
> grabbing some sleep ;-)

We're glad to have you back.  Or should I say _I'm_ glad to have
you back.  Never underestimate a man until you've at least walked
a week in his shoes.  :-)

Most of the patches that happened while you were away were merged
or parked into my git/spearce.git work (in large part thanks
to Lars Hjemli's work during the first week you were offline).
So hopefully you can just pickup from "recent history" (e.g. today
forward) and if we missed anything really interesting authors can
repost once you've had a chance to get caught up.

-- 
Shawn.
