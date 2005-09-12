From: Petr Baudis <pasky@suse.cz>
Subject: Re: Post 0.99.7 preperation patches
Date: Mon, 12 Sep 2005 03:26:39 +0200
Message-ID: <20050912012639.GL15630@pasky.or.cz>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7virxbtder.fsf@assigned-by-dhcp.cox.net> <7virxalhqi.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 03:26:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEd5o-0000RI-4T
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 03:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVILB0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 21:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVILB0l
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 21:26:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54958 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751120AbVILB0l (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 21:26:41 -0400
Received: (qmail 3901 invoked by uid 2001); 12 Sep 2005 03:26:39 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virxalhqi.fsf_-_@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8358>

Dear diary, on Fri, Sep 09, 2005 at 11:20:53AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Junio C Hamano <junkio@cox.net> writes:
> 
> > The "master" branch post 0.99.6 already has the renamed tools
> > with backward compatibility symlinks.  I'll be sending a
> > patch to address an issue raised by some people separately to
> > see what the list thinks, and also will attempt to send out a
> > patch for the Pasky and Catalin heads later this week.
> 
> I've prepared these and will be sending them out separately to
> you two, hoping they would help you prepare for post 0.99.7
> changes.  Note that 0.99.6 does not know about these new names,
> the current "master" branch knows about both new and old names,
> so will 0.99.7, and in 0.99.8 the old names will be removed, if
> things go as planned.
> 
> Here is a small script that I used before auditing what it did
> to your trees by running 'git diff' on its result.

Thanks for the notification. I will do an auxiliary release right
after 0.99.7 is released.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
