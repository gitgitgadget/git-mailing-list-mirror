From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-cache path restriction fix.
Date: Wed, 25 May 2005 12:14:15 -0700
Message-ID: <7vpsvfktiw.fsf@assigned-by-dhcp.cox.net>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org>
	<7vekbwru6x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241814220.2307@ppc970.osdl.org>
	<7v3bscqdlr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505242002340.2307@ppc970.osdl.org>
	<20050525090616.GB27025@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 21:15:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db1JP-0001e3-69
	for gcvg-git@gmane.org; Wed, 25 May 2005 21:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVEYTOU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 15:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVEYTOU
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 15:14:20 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:6564 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261484AbVEYTOR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 15:14:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525191415.FINO23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 15:14:15 -0400
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050525090616.GB27025@elte.hu> (Ingo Molnar's message of
 "Wed, 25 May 2005 11:06:16 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "IM" == Ingo Molnar <mingo@elte.hu> writes:

IM> ... But if someone has a strong math 
IM> background (Junio?) then the "1 < x < 5" syntax could be the natural 
IM> thing he got used to.

I was trained by somebody with a strong math background, but I
suspect he insisted that ordering not from math reasons.  The
reason given to me was "visual ordering".

I suck at math myself.  I even get confused when people do

    return !!some_function();

