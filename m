From: Petr Baudis <pasky@suse.cz>
Subject: Re: Local cg-pull fails
Date: Sat, 23 Jul 2005 01:22:19 +0200
Message-ID: <20050722232218.GO11916@pasky.ji.cz>
References: <20050714111224.B31383@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 01:28:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw6vz-0003Pm-GG
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 01:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVGVXYf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 19:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVGVXWq
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 19:22:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62217 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262219AbVGVXWa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 19:22:30 -0400
Received: (qmail 14108 invoked by uid 2001); 22 Jul 2005 23:22:19 -0000
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050714111224.B31383@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 14, 2005 at 12:12:25PM CEST, I got a letter
where Russell King <rmk@arm.linux.org.uk> told me that...
> Last time this was discussed, someone suggested -f, which solved the
> problem.  Can we please modify the cg-pull script to use -f ?

Thanks, done.

> Secondly, can I suggest that cogito developers consider the above
> usage scenario and construct a regression test for it to ensure that
> future breakages of this nature are caught.  For me, cogito has been
> extremely fragile, and I don't think the above usage is unreasonable.

Done.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
