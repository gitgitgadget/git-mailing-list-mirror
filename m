From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui problem with version number.
Date: Sun, 29 Jul 2007 03:10:30 -0400
Message-ID: <20070729071030.GL20052@spearce.org>
References: <86odhzpg2l.fsf@lola.quinscape.zz> <20070727044634.GG20052@spearce.org> <85y7h25sg6.fsf@lola.goethe.zz> <20070727053627.GI20052@spearce.org> <85odhy5rm6.fsf@lola.goethe.zz> <20070727054815.GJ20052@spearce.org> <85ejiu5r9r.fsf@lola.goethe.zz> <86k5smnvhw.fsf@lola.quinscape.zz> <86lkd2mcsu.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 29 09:10:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF2vH-0008P9-BX
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 09:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782AbXG2HKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 03:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756773AbXG2HKg
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 03:10:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33375 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbXG2HKf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 03:10:35 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IF2v8-000328-V1; Sun, 29 Jul 2007 03:10:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C794320FBAE; Sun, 29 Jul 2007 03:10:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <86lkd2mcsu.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54086>

David Kastrup <dak@gnu.org> wrote:
> David Kastrup <dak@gnu.org> writes:
> 
> > Now that is funny.  I am pretty sure (or rather _have_ been pretty
> > sure) that I cloned the respective repositories with the same command.
> > Yet now both are up-to-date according to git-pull (and have identical
> > .config contents), and the first compiles version git version
> > 1.5.3.rc2.41.gb47b1 while the second compiles version
> > 1.5.3.rc3.7.gd58e-dirty.  Both have been cloned from git.git, the
> 
> A combination of rebasing and pushing made the difference go away and
> made git-gui work again.  Nevertheless, it would be a good idea not to
> balk at the dirty version strings.

Did you not see me already state in this thread that its already
been fixed?  Latest git-gui already has the problem dealt with,
and that latest version will be included in git 1.5.3 when it ships.

Nevertheless, thanks for the problem report.

-- 
Shawn.
