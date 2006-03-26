From: Eric Wong <normalperson@yhbt.net>
Subject: git-svn name
Date: Sat, 25 Mar 2006 19:04:25 -0800
Message-ID: <20060326030425.GA6306@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, Chris Wright <chrisw@redhat.com>
X-From: git-owner@vger.kernel.org Sun Mar 26 05:04:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNLYg-00028V-6h
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 05:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWCZDE0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 22:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWCZDE0
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 22:04:26 -0500
Received: from hand.yhbt.net ([66.150.188.102]:18831 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751450AbWCZDE0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 22:04:26 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 874612DC033; Sat, 25 Mar 2006 19:04:25 -0800 (PST)
To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18023>

I told somebody about my 'git-svn' program, and of course they asked
where they could read about it.   Since I don't have a website for it,
I Googled for 'git-svn' in hopes that it'd lead me to
contrib/git-svn/git-svn.txt on gitweb.

To my surprise, I found that git-svn was already packaged for several
major distributions.  Of course, it turns out that those binary packages
are actually of git-svnimport.  Oops, maybe I should've checked before
naming my own creation git-svn :x

Of course, I still think git-svn is a good name because it describes
what the program does in as little text as possible.  If anybody has any
suggestions that don't require too much typing while keeping the name
meaningful, feel free to suggest them.

Would distro package maintainers also be willing to add my git-svn
script to their git-svn binary packages when a new release of git is
made, too?  It's quite different from git-svnimport (see
contrib/git-svn/git-svn.txt for details).

-- 
Eric Wong
