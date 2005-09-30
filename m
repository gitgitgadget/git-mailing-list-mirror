From: Junio C Hamano <junkio@cox.net>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 18:54:55 -0700
Message-ID: <7vwtkzb9qo.fsf@assigned-by-dhcp.cox.net>
References: <200509292317.j8TNHC7S022247@inti.inf.utfsm.cl>
	<Pine.LNX.4.64.0509291742170.3378@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 03:55:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELA72-00072q-T6
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 03:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVI3By5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 21:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVI3By5
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 21:54:57 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:27789 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932370AbVI3By4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 21:54:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050930015450.CJTD2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 21:54:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0509291742170.3378@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 29 Sep 2005 17:47:58 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9532>

Linus Torvalds <torvalds@osdl.org> writes:

> I put my git repo on 
>
> 	kernel.org:/pub/software/editors/uemacs/uemacs.git
>
> but it will take a moment to mirror out. 

Wouldn't underneath pub/scm/ be more appropriate and gitweb
friendly?

> The thing is, it's not a wonderful editor. It's small, and good enough, 
> but I really wished somebody wrote something that handled UTF-8, for 
> example.

Hmph.  I vaguely recall in my distant past when I was still in
school, I did my own Japanization of microEmacs.  I wonder if
yours share the same root -- I do not have the source of my
version anymore so I have no way checking which ancient version
I mucked with.
