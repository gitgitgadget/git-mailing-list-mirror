From: Junio C Hamano <junkio@cox.net>
Subject: Re: Users of git-check-files?
Date: Thu, 04 Aug 2005 13:59:29 -0700
Message-ID: <7vwtn1wh8u.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508021942500.3341@g5.osdl.org>
	<7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508030808530.3341@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Aug 04 23:04:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0mtW-00053G-Ec
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 23:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVHDVEM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 17:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVHDVCF
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 17:02:05 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:3743 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262688AbVHDU7d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 16:59:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050804205930.DUTG1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 Aug 2005 16:59:30 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 2 Aug 2005, Junio C Hamano wrote:
>> 
>> How about git-rev-tree?  Does anybody care?
>
> Yeah, probably not. git-rev-list does so much more than git-rev-tree ever 
> did.

I will keep git-rev-list; used in Jeff's git-changes-script and
some parts of Cogito as well.
