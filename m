From: supadhyay <supadhyay@imany.com>
Subject: Re: how to clone/checkout branch/tag vesion from GIT repository
Date: Fri, 11 May 2012 05:45:19 -0700 (PDT)
Message-ID: <1336740319206-7550370.post@n2.nabble.com>
References: <1336657187852-7546744.post@n2.nabble.com> <20120510135605.GA1495@sigill.intra.peff.net> <49A2AA38871E7B41841AA7D659D626A62E2098A2@njexch01.imany.com> <20120510143911.GB14711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 14:45:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSpDp-0003Ai-LR
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 14:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758942Ab2EKMpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 08:45:21 -0400
Received: from sam.nabble.com ([216.139.236.26]:59767 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318Ab2EKMpU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 08:45:20 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <supadhyay@imany.com>)
	id 1SSpDj-0007Am-7T
	for git@vger.kernel.org; Fri, 11 May 2012 05:45:19 -0700
In-Reply-To: <20120510143911.GB14711@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197671>

Hi Jeff,

Thanks for your reply.

branch - br6-1-0 is already exists on remote. I have my few data which are
associated on this branch and I want to get that specific data from br6-1-0.

I did cvs2git and its working fine without any issue. 

Also I can see the  list of branches when I run "git branch -r"  on my
GITserver through "git" user. But after did this migration I do clone from
git to gitolite on the same server (to manage with user functionality). Now,
after cloning to gitolite if I run "git branch -r" it shows only master.

I follow belwo step
1- cvs 2 git  >> I can see list of branches here 
2- git 2 gitolite  >> I can not see any branch except master.

Thanks,
Suchi

--
View this message in context: http://git.661346.n2.nabble.com/how-to-clone-checkout-branch-tag-vesion-from-GIT-repository-tp7546744p7550370.html
Sent from the git mailing list archive at Nabble.com.
