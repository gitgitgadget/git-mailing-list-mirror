From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui problem with version number.
Date: Fri, 27 Jul 2007 01:48:15 -0400
Message-ID: <20070727054815.GJ20052@spearce.org>
References: <86odhzpg2l.fsf@lola.quinscape.zz> <20070727044634.GG20052@spearce.org> <85y7h25sg6.fsf@lola.goethe.zz> <20070727053627.GI20052@spearce.org> <85odhy5rm6.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:48:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEIgr-0006Ya-5h
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 07:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760475AbXG0FsU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 01:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760290AbXG0FsU
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 01:48:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53584 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759520AbXG0FsT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 01:48:19 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IEIgS-0007UY-DG; Fri, 27 Jul 2007 01:48:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BD93520FBAE; Fri, 27 Jul 2007 01:48:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <85odhy5rm6.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53896>

David Kastrup <dak@gnu.org> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Anyway, you can setup a build with the most recent 'stable
> > development' version of git-gui:
> >
> >   git checkout -b with-new-gitgui
> >   git pull -s subtree git://repo.or.cz/git-gui.git
> 
> Ok.  Would the necessity for this depend on the Tcl version?

I thought all versions of Tcl did not understand the 'creative'
git version strings.  So I'm surprised to hear it works on one
system but not on another, even though you have the same version
of git and git-gui.

-- 
Shawn.
