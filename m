From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not show empty diff in diff-cache uncached.
Date: Sun, 29 May 2005 14:52:42 -0700
Message-ID: <7v3bs5k8d1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
	<7vis11n69l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 23:51:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcVfw-0000bw-LK
	for gcvg-git@gmane.org; Sun, 29 May 2005 23:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVE2Vwv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 17:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVE2Vwv
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 17:52:51 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:50072 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261455AbVE2Vwo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 17:52:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529215242.HXXN22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 17:52:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vis11n69l.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 29 May 2005 13:09:42 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> Let me make sure that we are on the same page.

Linus,

    now I've examined what are and what aren't merged in your
tree, I think I know the answer to that question.  The set you
picked look sensible to me.

I'm taking a look at the resulting tree to see if there are
fixes and cleanups that I still think should be merged.  I'll
feed them afresh to you later, if there are any, after rebasing
the patch to the tip of your tree.

Please disregard the patches you have already discarded so far;
this request-to-discard includes -O and -B enhancements.

