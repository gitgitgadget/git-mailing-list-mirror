From: Junio C Hamano <junkio@cox.net>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 20:19:50 -0800
Message-ID: <7vslsllz17.fsf@totally-fudged-out-message-id>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	<7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
	<7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vek465cev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
	<43AA75D1.7040009@op5.se>
	<Pine.LNX.4.63.0512221220220.7112@wbgn013.biozentrum.uni-wuerzburg.de>
	<43AA9BE6.7000601@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 23 05:20:16 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpePc-0006tJ-0u
	for gcvg-git@gmane.org; Fri, 23 Dec 2005 05:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbVLWETx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 23:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbVLWETx
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 23:19:53 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:65200 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030407AbVLWETw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 23:19:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051223041850.XAFS20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Dec 2005 23:18:50 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13983>

Andreas Ericsson <ae@op5.se> writes:

> Ahh. Sorry. We use this method a lot, really, but always only for 
> running gitk and archaeology tools to check newly pushed changes, so the 
> write-shared repo is only write-shared for remote users, and the local 
> one never does a commit.

Do you need a working tree to run gitk?
