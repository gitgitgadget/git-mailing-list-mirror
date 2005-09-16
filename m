From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Build a shared / renamed / "stable" version of the library?
Date: Fri, 16 Sep 2005 13:06:16 -0700
Message-ID: <7vll1whj5z.fsf@assigned-by-dhcp.cox.net>
References: <pan.2005.09.16.12.37.14.736570@smurf.noris.de>
	<7vmzmcj1eo.fsf@assigned-by-dhcp.cox.net>
	<432B2172.8090803@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 22:07:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGMTW-00053h-Iw
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 22:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVIPUGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 16:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbVIPUGU
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 16:06:20 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:25842 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751248AbVIPUGT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 16:06:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916200617.RKSP7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 16:06:17 -0400
To: cel@citi.umich.edu
In-Reply-To: <432B2172.8090803@citi.umich.edu> (Chuck Lever's message of "Fri,
	16 Sep 2005 15:48:02 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8725>

Chuck Lever <cel@citi.umich.edu> writes:

> well, i kept the "run-once" mentality.  if that's something you'd like 
> to go away, i can do that too, at some later point.

I did not mean to pressure you or suggest doing it in this
round.

I should have said "this will become easier to fix when Chuck is
done...".
