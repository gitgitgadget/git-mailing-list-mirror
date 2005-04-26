From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-add and update-cache add fails
Date: Tue, 26 Apr 2005 21:02:01 +0200
Message-ID: <20050426190201.GD13224@pasky.ji.cz>
References: <200504261735.47008.rhys@rhyshardwick.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 20:58:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQVFE-00059u-Gg
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 20:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVDZTCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 15:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVDZTCS
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 15:02:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2702 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261743AbVDZTCF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 15:02:05 -0400
Received: (qmail 17085 invoked by uid 2001); 26 Apr 2005 19:02:01 -0000
To: Rhys Hardwick <rhys@rhyshardwick.co.uk>
Content-Disposition: inline
In-Reply-To: <200504261735.47008.rhys@rhyshardwick.co.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 06:35:46PM CEST, I got a letter
where Rhys Hardwick <rhys@rhyshardwick.co.uk> told me that...
> Here is the error I get:
> 
> rhys@metatron:~/repo/learning.repo$ cg-add w1p4d1.c
> fatal: Unable to add w1p4d1.c to database
> rhys@metatron:~/repo/learning.repo$ update-cache --add w1p4d1.c
> fatal: Unable to add w1p4d1.c to database
> 
> All the files under the .git folder appear to be owned by me, and are 
> read-writable.  The disk is not full.  

Could you please show output of ls -l w1p4d1.c, done in the same
directory?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
