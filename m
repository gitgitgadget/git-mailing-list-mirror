From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/4] git-gui i18n: Add more words to glossary.
Date: Sun, 7 Oct 2007 19:12:31 -0400
Message-ID: <20071007231231.GD2137@spearce.org>
References: <200710052239.02492.stimming@tuhh.de> <20071007180559.GA2137@spearce.org> <200710072242.26288.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:13:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefJD-0002q0-4I
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142AbXJGXMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 19:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757936AbXJGXMh
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:12:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58375 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757930AbXJGXMg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:12:36 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IefIN-0005qZ-F4; Sun, 07 Oct 2007 19:12:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A0A7820FBAE; Sun,  7 Oct 2007 19:12:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200710072242.26288.stimming@tuhh.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60237>

Christian Stimming <stimming@tuhh.de> wrote:
> Am Sonntag, 7. Oktober 2007 20:05 schrieb Shawn O. Pearce:
> > Christian Stimming <stimming@tuhh.de> wrote:
> > > Signed-off-by: Christian Stimming <stimming@tuhh.de>
> > >
> > > ---
> > >  po/glossary/git-gui-glossary.pot |   12 ++++++++++--
> > >  po/glossary/git-gui-glossary.txt |    2 ++
> > >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > What version is this series applied to?  It rejects against my
> > currently published master on repo.or.cz.
> 
> It rejects? The patch were intended against master on git-gui.git on 
> repo.or.cz; the base for the patches was 
> 1952aa1d5735ccbedd832620e43db3e03fc77088

Right, that's what I tried to apply them to.
 
> I might have messed up some line wrappings... if that is the case, I can of 
> course resend and try harder to send them correctly.

If you are sending a series like that and its all po translation
stuff that is unlikely to need commenting on feel free to just dump
it all out as a single mbox (`git format-patch --stdout`) and attach
it to the email.  Less chance of the MUA mangling the message.

I'd rather not to this for code however, as myself or others may
want to reply with comments.  Having it inline makes this task
much easier.

-- 
Shawn.
