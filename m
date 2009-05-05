From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: EGit is moving to eclipse.org
Date: Tue, 5 May 2009 11:21:12 -0700
Message-ID: <20090505182112.GF30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 20:21:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1PGa-0003uj-T7
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 20:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbZEESVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 14:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbZEESVN
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 14:21:13 -0400
Received: from george.spearce.org ([209.20.77.23]:35504 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbZEESVM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 14:21:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2B25C3819F; Tue,  5 May 2009 18:21:12 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118308>

The EGit project has applied to join the Eclipse Foundation,
and recently obtained approval[1] to become a subproject of the
Technology top-level project.

Consequently, in the near-ish future, we'll be moving at least some
aspects of the EGit project onto eclipse.org.  This is a first step
towards making the EGit team provider available as part of the base
platform downloads, like the CVS team provider is today.

We're still trying to sort out everything, because eclipse.org only
offers CVS and SVN code repositories... and we have a 1,601 commit
history in Git that we'd like to preserve.  But we're starting
to move.

Thanks to Robin for doing the bulk of the initial drafts on the
project proposal, without his effort we wouldn't have gotten
this far.


[1] http://www.eclipse.org/newsportal/article.php?id=55&group=eclipse.egit#55

-- 
Shawn.
