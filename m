From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [ANNOUNCE] Gct-0.1, a GUI enabled Git commit tool
Date: Wed, 20 Jul 2005 15:23:01 +0200
Message-ID: <20050720132301.GF1817@c165.ib.student.liu.se>
References: <914f22914f26.914f26914f22@liu.se> <20050719235810.GF2255@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 20 15:24:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvEXd-0004hw-6n
	for gcvg-git@gmane.org; Wed, 20 Jul 2005 15:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVGTNXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jul 2005 09:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVGTNXL
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jul 2005 09:23:11 -0400
Received: from [85.8.31.11] ([85.8.31.11]:47853 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S261206AbVGTNXK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2005 09:23:10 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id E6A7F40FD; Wed, 20 Jul 2005 15:24:49 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1DvEXN-00068m-00; Wed, 20 Jul 2005 15:23:01 +0200
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050719235810.GF2255@pasky.ji.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 20, 2005 at 01:58:11AM +0200, Petr Baudis wrote:
> Dear diary, on Fri, Jul 15, 2005 at 02:46:42AM CEST, I got a letter
> where Fredrik Kuivinen <freku045@student.liu.se> told me that...
> > Hi,
> 
> Hello from a lazy reader who didn't actually try it,
> 
> > Gct v0.1 has been released and can be downloaded from
> > http://www.cyd.liu.se/~freku045/gct/gct-0.1.tar.gz
> > 
> > What follows is an excerpt from the README in the tarball:
> > 
> > Introduction
> > ------------
> > 
> > Git Commit Tool or gct is a simple GUI enabled Git commit tool. It
> > allows the user to select which files should be committed, write
> > commit messages and perform the commit. It also has some support for
> > controlling the synchronisation between the Git cache and the working
> > directory.
> 
> do you have any screenshots please? From the description it appears it
> is actually not any more powerful than cg-commit. Does it let you see
> the diff, actually prune the changes to be committed and such?

I have uploaded a screenshot now, it is available at
http://www.cyd.liu.se/~freku045/gct/

I haven't used cg-commit, but from a quick reading of the code it
seems that the functionality is similar to Gct. You do see the diffs
in Gct but it is currently not possible to do a more fine grained
selection of what to commit (that is, finer than selecting which files
to commit). Selection of individual hunks is on the todo list though.

- Fredrik Kuivinen
