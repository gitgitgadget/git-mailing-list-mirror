From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/4] git-gui i18n: Add more words to glossary.
Date: Sun, 7 Oct 2007 19:39:37 -0400
Message-ID: <20071007233937.GG2137@spearce.org>
References: <200710052239.02492.stimming@tuhh.de> <20071007180559.GA2137@spearce.org> <200710072242.26288.stimming@tuhh.de> <20071007231231.GD2137@spearce.org> <Pine.LNX.4.64.0710080029430.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:39:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iefiz-0006W0-QO
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756607AbXJGXjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 19:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756381AbXJGXjm
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:39:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59109 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756086AbXJGXjl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:39:41 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iefia-0006Ze-MT; Sun, 07 Oct 2007 19:39:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2498920FBAE; Sun,  7 Oct 2007 19:39:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710080029430.4174@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60263>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 7 Oct 2007, Shawn O. Pearce wrote:
> 
> > If you are sending a series like that and its all po translation stuff 
> > that is unlikely to need commenting on feel free to just dump it all out 
> > as a single mbox (`git format-patch --stdout`) and attach it to the 
> > email.  Less chance of the MUA mangling the message.
> 
> In this case, I suggest just pushing it to git-gui-i18n.git, maybe as a 
> temporary branch "for-shawn", and send a pull request.  That's the best 
> way to ensure that nothing gets mangled.

Yea, that's an even better option.  :-)
 
-- 
Shawn.
