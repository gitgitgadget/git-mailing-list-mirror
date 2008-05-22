From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Two minor tweaks on git-gui where textboxes weren't vertically centered with their labels and buttons
Date: Thu, 22 May 2008 08:11:07 -0400
Message-ID: <20080522121107.GK29038@spearce.org>
References: <412a1d9a0805172218v7c0a920es8a48129014051a35@mail.gmail.com> <20080519040746.GA29038@spearce.org> <412a1d9a0805182234i18e2da4ckf428b2c134e174d1@mail.gmail.com> <alpine.DEB.1.00.0805191127200.30431@racer> <7vej7w6syo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Twiinz <twiinz@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 14:12:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz9eU-0006C2-TE
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 14:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760743AbYEVMLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 08:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760676AbYEVMLS
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 08:11:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47555 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760236AbYEVMLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 08:11:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jz9dR-0002Ts-3F; Thu, 22 May 2008 08:11:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D2B1A20FBAE; Thu, 22 May 2008 08:11:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vej7w6syo.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82616>

Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The Signed-off-by is not so much for _you_ as for the people who _use_ 
> > what you contributed, so that they can always say "but Twiinz signed off 
> > on it, he said that he will not sue my $ss off later, like this Darl 
> > b$stard".
> >
> > So yes, I do worry.
> 
> It is not about him suing us, but more about "He certified that he did not
> steal it from anywhere else", iow, other people suing us for what he did.
> 
> And we should worry.

In this case it is a very trivial patch.  Anyone who tries to do
the same thing is likely to come up with the same result, or one
that is close enough that it looks identical anyway.

Still, it isn't in my main tree, because it is lacking a proper
Signed-off-by tag by the original author.

-- 
Shawn.
