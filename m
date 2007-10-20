From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: gitk patch collection pull request
Date: Fri, 19 Oct 2007 23:10:48 -0400
Message-ID: <20071020031048.GQ14735@spearce.org>
References: <20071019052823.GI14735@spearce.org> <18200.36704.936554.220173@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 05:11:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij4jy-0004n8-3F
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 05:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936619AbXJTDKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 23:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936561AbXJTDKw
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 23:10:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41845 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936446AbXJTDKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 23:10:51 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ij4jU-0003CW-VR; Fri, 19 Oct 2007 23:10:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1D4A120FBAE; Fri, 19 Oct 2007 23:10:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <18200.36704.936554.220173@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61778>

Paul Mackerras <paulus@samba.org> wrote:
> Shawn O. Pearce writes:
> > The following changes since commit 719c2b9d926bf2be4879015e3620d27d32f007b6:
> >   Paul Mackerras (1):
> >         gitk: Fix bug causing undefined variable error when cherry-picking
> > 
> > are available in the git repository at:
> > 
> >   git://repo.or.cz:/git/spearce.git gitk
...
> > Jonathan del Strother (2):
> >       gitk: Added support for OS X mouse wheel
> >       Fixing gitk indentation
> 
> This one is bogus.  Firstly, it doesn't have "gitk:" at the start of
> the headline (and "Fixing" should be "Fix").  Secondly, the actual
> change itself is bogus.  It changes an initial tab to 8 spaces on each
> of 4 lines.  I like it the way it is - and if he wanted to change it,
> he should have changed it throughout the file, not just on 4 lines.
> So that change is rejected.
> 
> The other changes are OK.  If you could re-do your tree without
> 0d6df4de (and possible change "Added" to "Add" in e1b5683c while
> you're at it), I'll do the pull.

Done.  I also added this one from Michele:

  From: Michele Ballabio <barra_cuda@katamail.com>
  Subject: [PATCH-resent] gitk: fix in procedure drawcommits

-- 
Shawn.
