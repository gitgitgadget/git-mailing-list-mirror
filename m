From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Publishing Question: First time Pushing to nonexsiting directory
Date: Mon, 19 Feb 2007 21:10:12 +0100
Message-ID: <20070219201012.GL786@cip.informatik.uni-erlangen.de>
References: <20070219073526.GA26531@cip.informatik.uni-erlangen.de> <20070219081010.GC30030@spearce.org> <20070219194423.GJ786@cip.informatik.uni-erlangen.de> <20070219200332.GA27565@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 19 21:10:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJEq4-0000sF-0J
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 21:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbXBSUKP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 15:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbXBSUKP
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 15:10:15 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:36893 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932536AbXBSUKO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Feb 2007 15:10:14 -0500
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id B9C053F382; Mon, 19 Feb 2007 21:10:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070219200332.GA27565@spearce.org>
User-Agent: Mutt/1.5.11-2006-07-11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40145>

Hello Shawn,

> >         * refs/remotes/origin/master: storing branch 'master' of 131.188.30.59:/home/cip/adm/sithglan/work/repositories/private/astro
> Good, the tracking branch was automatically created.

I see.

> This just says that by default, `git pull` will merge the master
> branch of remote origin when you are on branch master.

Thanks. I added the lines and it doesn't give me the warning anylonger:

        (thinkpad) [~/work/astro] git pull
        Already up-to-date.

> Nope.  It has to do with the fact that you are running 1.5.0 on your
> thinkpad and are missing the branch.master.merge entry noted above.

I see. Thanks for the awareness training.

        Thomas
