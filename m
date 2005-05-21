From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half...
Date: Sat, 21 May 2005 11:10:05 -0700
Message-ID: <7vzmuoh2ma.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
	<7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505211016140.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:10:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZYPb-0003JE-DN
	for gcvg-git@gmane.org; Sat, 21 May 2005 20:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVEUSKM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 14:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVEUSKM
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 14:10:12 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:36591 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261761AbVEUSKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 14:10:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521181006.LFIB7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 14:10:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505211016140.2206@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 21 May 2005 10:25:06 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I love how I can just say "oh, keep in mind that we might
LT> want to.." and 24 hours later you did it.

Nah, it's more like 40 hours, but yes I am here to serve your
wishes ;-).

LT> I'm also somewhat surprised by the fact that it even seems
LT> to be usable on the kernel tree:

Surprised?  Correctness-wise and/or performance-wise?

