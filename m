From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/3] Documentation: Add definition of "evil merge" to GIT Glossary
Date: Fri, 25 May 2007 21:05:19 -0400
Message-ID: <20070526010519.GV28023@spearce.org>
References: <11801326601014-git-send-email-jnareb@gmail.com> <1180132662719-git-send-email-jnareb@gmail.com> <Pine.LNX.4.64.0705260151320.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 26 03:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrkip-00048A-M5
	for gcvg-git@gmane.org; Sat, 26 May 2007 03:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbXEZBFY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 21:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbXEZBFY
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 21:05:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35461 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbXEZBFY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 21:05:24 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HrkiU-00010q-V0; Fri, 25 May 2007 21:05:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 82BA720FBAE; Fri, 25 May 2007 21:05:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705260151320.4648@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48439>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> On Sat, 26 May 2007, Jakub Narebski wrote:
> 
> > +[[def_evil_merge]]evil merge::
> > +	An evil merge is a <<def_merge,merge>> that introduces changes that
> > +	do not appear in any <<def_parent,parent>>.
> 
> Funny. For me, an evil merge is an octopus.

Funny, for me an evil merge is 30 commits in a straight row, all
branch merges, when an octopus would be easier to read in gitk,
and easier to execute... ;-)

Actually, my definition of evil merge matches Jakub's definition.

-- 
Shawn.
