From: Petr Baudis <pasky@suse.cz>
Subject: Re: Why is there no git-update-cache --modified (aka I give up)
Date: Tue, 12 Jul 2005 09:26:29 +0200
Message-ID: <20050712072629.GA6363@pasky.ji.cz>
References: <20050712055218.GA18192@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 09:30:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsFDf-0006J0-G4
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 09:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVGLH3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 03:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVGLH1o
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 03:27:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18838 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261244AbVGLH0b (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 03:26:31 -0400
Received: (qmail 6774 invoked by uid 2001); 12 Jul 2005 07:26:29 -0000
To: Marc Singer <elf@buici.com>
Content-Disposition: inline
In-Reply-To: <20050712055218.GA18192@buici.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Jul 12, 2005 at 07:52:18AM CEST, I got a letter
where Marc Singer <elf@buici.com> told me that...
>   # git-diff-cache HEAD
> 
> is really nice.  But, do I really have to invoke git-update-cache with
> every modified file?  I could write a script to cul the filenames from
> git-diff-cache, but I'm having a hard time believing that that is how
> others are preparing their commits.

It is. :-) It's only that they have cool scripts to do it, e.g.
cg-commit. (You have to enumerate the files explicitly for
git-commit-script as well, IIRC.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
