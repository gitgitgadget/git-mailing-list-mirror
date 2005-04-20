From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Git hangs while executing commit-tree
Date: Wed, 20 Apr 2005 23:35:14 +0200
Message-ID: <20050420213513.GG19112@pasky.ji.cz>
References: <200504202228.35652.rhys@rhyshardwick.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 23:32:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOMnB-0000xX-4B
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 23:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVDTVff (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 17:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVDTVff
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 17:35:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43486 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261820AbVDTVfR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 17:35:17 -0400
Received: (qmail 5438 invoked by uid 2001); 20 Apr 2005 21:35:14 -0000
To: Rhys Hardwick <rhys@rhyshardwick.co.uk>
Content-Disposition: inline
In-Reply-To: <200504202228.35652.rhys@rhyshardwick.co.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 20, 2005 at 11:28:35PM CEST, I got a letter
where Rhys Hardwick <rhys@rhyshardwick.co.uk> told me that...
> Hey,

Hi,

> rhys@metatron:~/repo/tmp.repo$ commit-tree 
> c80156fafbac377ab35beb076090c8320f874f91
> Committing initial tree c80156fafbac377ab35beb076090c8320f874f91
>  
> 
> 
> At this point, the command seems to be just waiting.  I have had it waiting 
> for around 2 hours now!  I have tried removing ~/repo/tmp.repo and starting 
> over, with exactly the same results.

just type in your commit message and press ctrl-D now. ;-)

If you can't get along by peeking at the source when you get stuck, etc,
you might prefer using git-pasky (http://pasky.or.cz/~pasky/dev/git/),
which will guide you nicely.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
