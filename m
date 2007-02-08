From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Correct some language in fast-import documentation.
Date: Thu, 8 Feb 2007 17:11:41 -0500
Message-ID: <20070208221141.GC1091@spearce.org>
References: <20070208075851.GB3950@spearce.org> <20070208082850.GA4334@informatik.uni-freiburg.de> <7vveidyqw5.fsf@assigned-by-dhcp.cox.net> <20070208183243.GA30673@spearce.org> <Pine.LNX.4.63.0702081937260.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070208203145.GA26420@informatik.uni-freiburg.de> <Pine.LNX.4.63.0702082152590.22628@wbgn013.biozentrum.uni-wuerzburg.de> <eqg6rb$mb1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 23:11:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFHUa-0003xR-3Y
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 23:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945927AbXBHWLp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 17:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945930AbXBHWLp
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 17:11:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36558 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945927AbXBHWLo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 17:11:44 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HFHUM-00063T-Fm; Thu, 08 Feb 2007 17:11:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9EF8220FBAE; Thu,  8 Feb 2007 17:11:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <eqg6rb$mb1$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39104>

Jakub Narebski <jnareb@gmail.com> wrote:
> By the way, how this .mailmap thingy work? Is it corrected
> using email to find proper entry?

Its used by git-shortlog to put all commits by the same person
under a single heading.  It uses email address as key.

-- 
Shawn.
