From: Junio C Hamano <junkio@cox.net>
Subject: Re: bad git pull
Date: Thu, 15 Dec 2005 15:42:06 -0800
Message-ID: <7vzmn2kjw1.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 00:43:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En2jk-0007T8-Ht
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 00:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVLOXmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 18:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVLOXmJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 18:42:09 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:25729 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751196AbVLOXmI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 18:42:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215234043.OHKZ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Dec 2005 18:40:43 -0500
To: Don Zickus <dzickus@gmail.com>
In-Reply-To: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com> (Don
	Zickus's message of "Thu, 15 Dec 2005 18:37:47 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13721>

Don Zickus <dzickus@gmail.com> writes:

> I notice if I create a branch (and switch to it) in the linux kernel
> off of say version 2.6.14, then later do a git pull, things get ugly. 
> It seems like all the upstream changes are being merged into the
> 2.6.14 branch (instead of the latest kernel tag).
>
> Is this a user error because the tool is still fragile?

I do not understand the question.

The user wanted all the good developments from the mainline into
the fork he created starting at 2.6.14, and the tool did what
was asked.  Why would you want to forbid that from happening,
and what did you want to happen instead?
