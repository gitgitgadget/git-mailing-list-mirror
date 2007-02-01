From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git docs on kernel.org too new?
Date: Thu, 1 Feb 2007 14:17:47 -0500
Message-ID: <20070201191747.GB18608@spearce.org>
References: <Pine.LNX.4.62.0702011051300.31498@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Feb 01 20:18:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HChRp-0007QA-Fu
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 20:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422952AbXBATRx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 14:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422954AbXBATRx
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 14:17:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39431 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422952AbXBATRw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 14:17:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HChRG-0008Ba-Mi; Thu, 01 Feb 2007 14:17:42 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5ECB120FBAE; Thu,  1 Feb 2007 14:17:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0702011051300.31498@torch.nrlssc.navy.mil>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38389>

Brandon Casey <casey@nrlssc.navy.mil> wrote:
> The git documentation here:
> 
>   http://www.kernel.org/pub/software/scm/git/docs/
> 
> does not seem to describe the current stable release of
> git: git-1.4.4.4 (there is a release candidate of 1.5.0 on kernel.org)

Yes.  The docs on kernel.org roughly track the `master` branch
of git.git, which is stablizing the 1.5.0 release.  Git 1.5.0-rc3
was posted last night, and with the exception of a couple of minor
cleanups for the detached HEAD warning messages, will be the 1.5.0
final release.

Despite being a release candidate I think we would all encourage
you to try working with 1.5.0-rc3 or later.  It is extremely stable,
the documentation has been significantly improved and updated since
1.4.4.4, and the learning curve should be easier for new users.

-- 
Shawn.
