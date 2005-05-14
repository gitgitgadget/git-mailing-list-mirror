From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH cogito] "cg-whatsnew" command
Date: Sat, 14 May 2005 13:09:41 +0200
Message-ID: <20050514110941.GB3905@pasky.ji.cz>
References: <tnx64xm5b2b.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 13:10:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWuWc-0001WA-Vw
	for gcvg-git@gmane.org; Sat, 14 May 2005 13:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVENLJo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 07:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbVENLJo
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 07:09:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29333 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262736AbVENLJm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 07:09:42 -0400
Received: (qmail 8087 invoked by uid 2001); 14 May 2005 11:09:41 -0000
To: Catalin Marinas <catalin.marinas@arm.com>
Content-Disposition: inline
In-Reply-To: <tnx64xm5b2b.fsf@arm.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 12:58:04PM CEST, I got a letter
where Catalin Marinas <catalin.marinas@arm.com> told me that...
> This patch adds a simple command that shows the unmerged changes on a
> branch. I find it quite useful to be able to see the diff or the log
> before merging (gnuarch has something similar with "missing").

I'd prefer this to be functionality builtin to cg-log and cg-mkpatch.
Perhaps some

	cg-log -m $branch2 [$branch1]

to show stuff in branch2 not yet merged to branch1.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
