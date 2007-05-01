From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: svn:externals using git submodules
Date: Tue, 1 May 2007 11:40:56 -0400
Message-ID: <20070501154056.GH5942@spearce.org>
References: <200705011121.17172.andyparkins@gmail.com> <20070501150724.GA20797@pe.Belkin> <20070501152228.GF5942@spearce.org> <20070501153626.GA21182@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Chris Shoemaker <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 17:41:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiuTR-0006sq-TJ
	for gcvg-git@gmane.org; Tue, 01 May 2007 17:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbXEAPlC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 11:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbXEAPlC
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 11:41:02 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46444 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbXEAPlA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 11:41:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HiuTE-000583-92; Tue, 01 May 2007 11:40:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7DC3320FBAE; Tue,  1 May 2007 11:40:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070501153626.GA21182@pe.Belkin>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45950>

Chris Shoemaker <c.shoemaker@cox.net> wrote:
> On Tue, May 01, 2007 at 11:22:28AM -0400, Shawn O. Pearce wrote:
> > And if every svn:externals URL included the
> > exact version of the other project to include, aren't svn:externals
> > then more-or-less like the subproject link support, except they
> > also include the URL?
> 
> Just to clarify, my point was just that Andy's setup seems to assume
> that the externals don't specify a revision.  If they do, maybe
> git-svn can map the externals into subprojects.  Is this what
> you're thinking?

Yes.  ;-)

-- 
Shawn.
