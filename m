From: Junio C Hamano <junkio@cox.net>
Subject: Re: Users of git-check-files?
Date: Wed, 03 Aug 2005 10:02:28 -0700
Message-ID: <7voe8fdkd7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508021942500.3341@g5.osdl.org>
	<7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508030808530.3341@g5.osdl.org>
	<7vr7dbhvci.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508030913060.3341@g5.osdl.org>
	<7vk6j3f044.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508030944210.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 19:04:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0Mdh-0004B9-LR
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 19:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVHCRCh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 13:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVHCRCg
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 13:02:36 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:38838 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262347AbVHCRCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 13:02:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050803170230.ILOU16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 13:02:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508030944210.3258@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 3 Aug 2005 09:45:12 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Are you sure you have a good git version on master? I've never seen 
> anything like that, and I push all the time..

I have been esuspecting that it happens only because I rewind
and rebase "pu", which you never do.  The thing is, even though
I rewind "pu" all the time, it happens only occasionally.
