From: Junio C Hamano <junkio@cox.net>
Subject: Re: Users of git-check-files?
Date: Tue, 02 Aug 2005 23:17:56 -0700
Message-ID: <7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508021942500.3341@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 08:19:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0CbF-0001eI-F7
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 08:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVHCGTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 02:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVHCGS7
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 02:18:59 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:63157 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262089AbVHCGSB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 02:18:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050803061759.YCVN7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 02:17:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508021942500.3341@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 2 Aug 2005 19:43:51 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> It has no point any more, all the tools check the file status on their 
> own, and yes, the thing should probably be removed.

How about git-rev-tree?  Does anybody care?
