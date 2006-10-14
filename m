From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and u-boot broken.
Date: Sat, 14 Oct 2006 14:09:20 -0700
Message-ID: <20061014210920.GD29149@localdomain>
References: <00f701c6ef92$88b84840$1267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 14 23:09:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYqlS-0006HU-NV
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 23:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422859AbWJNVJX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 17:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422860AbWJNVJX
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 17:09:23 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38294 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1422859AbWJNVJX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Oct 2006 17:09:23 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B634D7DC08D;
	Sat, 14 Oct 2006 14:09:20 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 14 Oct 2006 14:09:20 -0700
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Content-Disposition: inline
In-Reply-To: <00f701c6ef92$88b84840$1267a8c0@Jocke>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28890>

Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > > Also, which version of git-svn are you running?  Also, which 
> > > version of
> > > Subversion (client library, and server (if possible) are 
> > you running?
> > 
> > git 1.4.2.3
> > subversion 1.3.2-r1
> > 
> > I will try upgrading to newer subverison.
> 
> subversion 1.4.0 didn't help
> 
> PS.
> 
> I can't find the dcommit command in git-cvs, has it been removed?
> if so, then the docs need an update.

You mean git-svn, right?  No, 'dcommit' has not been removed and I have
no plans to remove it.

-- 
Eric Wong
