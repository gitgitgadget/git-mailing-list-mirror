From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/3] Leftover bits after 12-series
Date: Sun, 29 May 2005 16:41:25 -0700
Message-ID: <7vmzqdiore.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
	<7vis11n69l.fsf@assigned-by-dhcp.cox.net>
	<7v3bs5k8d1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 01:39:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcXN3-0000E8-6g
	for gcvg-git@gmane.org; Mon, 30 May 2005 01:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVE2Xl3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 19:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVE2Xl3
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 19:41:29 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:5868 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261402AbVE2Xl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 19:41:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529234124.TTDR23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 19:41:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v3bs5k8d1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 29 May 2005 14:52:42 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> I'm taking a look at the resulting tree to see if there are
JCH> fixes and cleanups that I still think should be merged.  I'll
JCH> feed them afresh to you later, if there are any, after rebasing
JCH> the patch to the tip of your tree.

I'll be submitting a set of cleanup and bugfix patches.  The
first one is a real bugfix.  The latter two are cleanups.

    [PATCH 1/3] diff-helper: Fix R/C score parsing under -z flag.
    [PATCH 2/3] diff: consolidate various calls into diffcore.
    [PATCH 3/3] diff: code clean-up.


