From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-svn name
Date: Sun, 26 Mar 2006 12:10:46 +0200
Message-ID: <20060326101046.GE18185@pasky.or.cz>
References: <20060326030425.GA6306@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Gerrit Pape <pape@smarden.org>,
	Chris Wright <chrisw@redhat.com>
X-From: git-owner@vger.kernel.org Sun Mar 26 12:10:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNSCl-0008M1-DT
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 12:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWCZKKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 05:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWCZKKg
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 05:10:36 -0500
Received: from w241.dkm.cz ([62.24.88.241]:42173 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751233AbWCZKKg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 05:10:36 -0500
Received: (qmail 7511 invoked by uid 2001); 26 Mar 2006 12:10:46 +0200
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20060326030425.GA6306@hand.yhbt.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18032>

Dear diary, on Sun, Mar 26, 2006 at 05:04:25AM CEST, I got a letter
where Eric Wong <normalperson@yhbt.net> said that...
> Would distro package maintainers also be willing to add my git-svn
> script to their git-svn binary packages when a new release of git is
> made, too?  It's quite different from git-svnimport (see
> contrib/git-svn/git-svn.txt for details).

I think the primary purpose of the packages separation are dependencies
- not to make the git package depend on svn and such. So I guess the
packagers won't have a problem adding your script to the git-svn package
(concerning SuSE, I won't at least).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
