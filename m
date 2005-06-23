From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/3] Rebasing for "individual developer" usage
Date: Thu, 23 Jun 2005 16:21:36 -0700
Message-ID: <7v4qbofym7.fsf_-_@assigned-by-dhcp.cox.net>
References: <1119284365.3926.15.camel@localhost.localdomain>
	<7vbr61j631.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506211452110.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Darrin Thompson <darrint@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 01:16:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlauo-0003GV-SI
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 01:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVFWXVl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 19:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVFWXVl
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 19:21:41 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:13481 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262629AbVFWXVi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 19:21:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050623232136.GNFN8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Jun 2005 19:21:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506211452110.2353@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 21 Jun 2005 15:09:13 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Something like this...
LT> What do you think?

I'll be sending these three patches as my answer to that question.

    [PATCH 1/3] git-commit-script: get commit message from an existing one.
    [PATCH 2/3] git-cherry: find commits not merged upstream.
    [PATCH 3/3] git-rebase-script: rebase local commits to new upstream head.

