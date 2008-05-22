From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Two minor tweaks on git-gui where textboxes weren't vertically centered with their labels and buttons
Date: Thu, 22 May 2008 08:55:59 -0400
Message-ID: <20080522125559.GO29038@spearce.org>
References: <412a1d9a0805172218v7c0a920es8a48129014051a35@mail.gmail.com> <20080519040746.GA29038@spearce.org> <412a1d9a0805182234i18e2da4ckf428b2c134e174d1@mail.gmail.com> <alpine.DEB.1.00.0805191127200.30431@racer> <7vej7w6syo.fsf@gitster.siamese.dyndns.org> <20080522121107.GK29038@spearce.org> <412a1d9a0805220545veb9af51y833aed2234d258b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Twiinz <twiinz@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 14:57:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzALu-00084T-Lj
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 14:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759072AbYEVM4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 08:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759227AbYEVM4I
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 08:56:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57872 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759072AbYEVM4G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 08:56:06 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JzAKq-00063s-AC; Thu, 22 May 2008 08:55:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 88E3720FBAE; Thu, 22 May 2008 08:55:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <412a1d9a0805220545veb9af51y833aed2234d258b@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82625>

Twiinz <twiinz@gmail.com> wrote:
> On Thu, May 22, 2008 at 7:11 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > In this case it is a very trivial patch.  Anyone who tries to do
> > the same thing is likely to come up with the same result, or one
> > that is close enough that it looks identical anyway.
> >
> > Still, it isn't in my main tree, because it is lacking a proper
> > Signed-off-by tag by the original author.
> 
> Sorry for the late response,
> 
> It's a very trivial patch, indeed.
> 
> I'm still a bit confused with those Signed-off-by things. Anyway I
> sign hereby that:
> - I coded those few lines myself
> - I didn't steal them from anyone
> - I'm not going to sue anybody over its utilization

See "Sign your work" of git.git/Documentation/SubmittingPatches:

  http://repo.or.cz/w/git.git?a=blob;f=Documentation/SubmittingPatches;h=0e155c936c25255706bc6d47651c2b336c628417;hb=377d9c409ffe0f0d994b929aeb94716139207b9d

I think most reasonable people would say your statement has roughly
the same intent and effect as the Developer's Certificate of
Origin 1.1.
 
> If there's more that need to be done to get this patch approved please
> point me to some online materials that detail the process.
> 
> I hope that helps,

I'm going to edit your commit and add the signed off by line for you:

	Signed-off-by: Twiinz <twiinz@gmail.com>

Thanks.

-- 
Shawn.
