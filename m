From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Sun, 25 Sep 2005 00:52:54 -0700
Message-ID: <7vzmq1twh5.fsf@assigned-by-dhcp.cox.net>
References: <ud5mznc1x.fsf@peter-b.co.uk>
	<Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
	<Pine.LNX.4.58.0509231737140.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 09:53:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJRJw-0002Kp-09
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 09:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVIYHw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 03:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVIYHw6
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 03:52:58 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:5302 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751235AbVIYHw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 03:52:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050925075254.LMIC776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Sep 2005 03:52:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509231737140.3308@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 23 Sep 2005 17:43:20 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9261>

Linus Torvalds <torvalds@osdl.org> writes:

> The GNU diff sources are hard enough to read that I don't think we want to 
> try to merge the unified diff generation from there.

I was talking with GNU diff maintainer and his impression was
that CVS folks may have done enough libification -- I'll find
time to look at CVS code and see how much damage we are talking
about.
